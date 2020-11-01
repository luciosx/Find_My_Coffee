class Api::V1::StoresController < ApplicationController
    before_action :set_store, only: [:show]#sempre o metodo show é chamado, o set_store é chamado antes

    #metodo que lista as stores mais amadas
    def index
        @stores = Store.within(params[:longitude].to_f, params[:latitude].to_f, 2000)
        .sort_by { |store| store.ratings_average } #ordena as stores por melhor avaliação
        .reverse
    end

    def show
    end

    private
    #busca de store
    def set_store
        @store = Store.find_by!(google_place_id: params[:id])
    end
end
