class BandsController < ApplicationController
    before_action :set_band, only: [:show, :edit, :update, :destroy]


    def set_band
        @band = Band.find(params[:id])
    end

    def index
        @bands = Band.all.order(:id)
        render :index
    end

    def new
        render :new
    end

    def create
        @band = Band.new(band_params)
        if @band.save
        

    end

    def show

    end

    def edit

    end

    def update

    end

    def destroy

    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end
