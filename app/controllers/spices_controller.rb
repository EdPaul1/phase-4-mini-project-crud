
class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /spices
    def index
      spices = Spice.all
      render json: spices
    end
  
    # POST /spices
    def create
      spice = Spice.create(spice_params)
      render json: spice, status: :created
    end

    # GET /spices/:id
    def show
        spice = Spice.find(params[:id])
        render json: spice
      end

    # PATCH /spices/:id
    def update
      spice = Spice.find_by(id: params[:id])
      if spice.update(spice_params)
        render json: spice
      else
        render json: { error: 'Failed to update spice' }, status: :unprocessable_entity
      end
    end
  
    # DELETE /spices/:id
    def destroy
      spice = Spice.find_by(id: params[:id])
      spice.destroy
      head :no_content
    end
  
    private
  
    def spice_params
      params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
      end
  end
  
