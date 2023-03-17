class SpicesController < ApplicationController
    wrap_parameters format: []
    def index
        spices = Spice.all
        render json: spices, except: [:created_at, :updated_at]
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, except: [:created_at, :updated_at], status: :created
    end

    def update
        spice = Spice.find_by(id: params[:id])
        if spice
            spice.update(spice_params)
            render json: spice, except: [:created_at, :updated_at], status: :ok
        else
            render json: {error: "Couldn't find spice"}, status: :not_found
        end
    end

    def destroy
        spice = Spice.find_by(id: params[:id])
        if spice
            spice.destroy
            head :no_content
        else
            render json: {error: "Couldn't find Spice"}, status: :not_found
        end
    end

    private

    def spice_params
        params.permit(:title, :description, :image, :notes, :rating)
    end
end
