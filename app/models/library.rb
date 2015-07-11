class Library < ActiveRecord::Base
  require 'open-uri'

  def self.parse_data
    html = Nokogiri::HTML(open("http://www.publiclibraries.com/kansas.htm"))
    html.css('#libraries tr').each_with_index do |row, index|
      # data should likely be cleaned up a bit prior to inputting to database
      unless index == 0 #excludes column headers
        self.create(name: row.children[1].text, street_address: row.children[2].text, city: row.children[0].text, zipcode: row.children[3].text, number: row.children[4].text)
      end
    end
  end

end
