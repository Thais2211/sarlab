class TypeReservationsController < ApplicationController
  before_action :set_type_reservatiom, only: [:show, :edit, :update, :destroy]

  # GET /type_reservations
  # GET /type_reservations.json
  def index
    @type_reservations = TypeReservation.all
  end

  def novo_tipo
    tipo = TypeReservation.new(description: params[:description])
    tipo.save!

    redirect_to type_reservations_path, notice:'Tipo de reserva cadastrado com sucesso'
  end

  def atualizar_tipo
    tipo = TypeReservation.find params[:id]
    tipo.update(description: params[:description])

    redirect_to type_reservations_path, notice:'Tipo de reserva atualizado com sucesso'
  end

  # DELETE /type_reservations/1
  # DELETE /type_reservations/1.json
  def destroy
    @type_reservatiom.destroy
    respond_to do |format|
      format.html { redirect_to type_reservations_url, notice: 'Type reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_reservatiom
      @type_reservatiom = TypeReservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def type_reservatiom_params
      params.require(:type_reservatiom).permit(:description)
    end
end
