class SpotsController < ApplicationController
  def search_hotel
    gon.application_id = ENV["RAKUTEN_APPLICATION_ID"]
      # binding.pry
    # if params[:keyword]
    #   @hotels = RakutenWebService::Travel::Hotel.search(keyword: 'ペット わんちゃん', largeClassCode: 'japan', middleClassCode: 'tokyo',smallClassCode: 'tokyo',detailClassCode:'F')
    # end

    # binding.pry
  end
end
