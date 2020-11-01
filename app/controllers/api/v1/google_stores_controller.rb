class Api::V1::GoogleStoresController < ApplicationController
    def index
        #chamada ao service
        places = GetGoogleCoffeeListService.new(params[:latitude], params[:longitude]).call
        render json: places
    end

    def show
        render json: GetGoogleCoffeeDetailsService.new(params[:id]).call
    end
end
