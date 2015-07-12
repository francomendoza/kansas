class LibrariesController < ApplicationController

  def index
    # first = Library.first
    # array = []
    # Library.all.each do |lib|
    #   if array.length < 8 
    #   array << Math.sqrt((lib.latitude-first.latitude)**2+(lib.longitude-first.longitude)**2)
    # else
      
    # end
    @libraries = Library.limit(8)
  end
end
