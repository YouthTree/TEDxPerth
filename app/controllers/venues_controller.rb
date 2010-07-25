class VenuesController < ApplicationController
  
  def show
    @venue = Venue.find_using_slug!(params[:id])
    add_title_variables! :venue_name => @venue.to_s
  end
  
end
