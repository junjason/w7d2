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
            redirect_to band_url(@band)
        else
            render :new
        end
    end

    def show
        render :show
    end

    def edit
        render :edit
    end

    def update
        if @band && @band.update(band_params)
            redirect_to band_url(@band)
        else
            render json: @band.errors.full_messages, status:422
        end
    end

    def destroy
        if @band && @band.destroy
            redirect_to bands_url
        else
            render json: {'error': 'Band doesnt exist'}, status:404
        end
    end

    private
    def band_params
        params.require(:band).permit(:name)
    end
end
