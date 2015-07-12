class Library < ActiveRecord::Base
  require 'open-uri'
  geocoded_by :complete_address
  after_validation :geocode

# provide string to geocoder gem to find lat/lon
  def complete_address
    [street_address, city, zipcode].join(', ')
  end

# scrape site for address and put in database, this was put into a rake task
  def self.parse_data
    html = Nokogiri::HTML(open("http://www.publiclibraries.com/kansas.htm"))
    html.css('#libraries tr').each_with_index do |row, index|
      # data should likely be cleaned up a bit prior to inputting to database
      unless index == 0 #excludes column headers
        self.create(name: row.children[1].text, street_address: row.children[2].text, city: row.children[0].text, zipcode: row.children[3].text, number: row.children[4].text)
        sleep(0.5)
      end
    end
  end

# class method to create json from all rows
  def self.jsonify
    self.all.map do |library|
      {
        id: library.id,
        name: library.name,
        address: library.street_address,
        city: library.city,
        zipcode: library.zipcode,
        lat: library.latitude,
        long: library.longitude
      }
    end.to_json
  end

end
