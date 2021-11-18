class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
    render json: @schedule
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_schedules
    #@agendamentos = Array.new
    @agendamentos = Schedule.where("start between ? and ?", Time.at(params[:start].to_i), Time.at(params[:end].to_i))
        
    render json: @agendamentos
  end

  def save_schedule
    schedule = Schedule.new(start: params[:start], end: params[:end], status: 'PENDENTE', laboratory_id: params[:laboratory_id], 
                equipament_id: params[:equipament_id], type_reservation_id: params[:type_reservation_id], user: current_user)
    if schedule.save!
      schedule.create_activity(:solicitou_reserva, owner: current_user, recipient: schedule , params: {responsavel: schedule.user_id})
      redirect_to schedules_path, notice:'Reserva cadastrada com sucesso'
    end
    #render json: schedule
    
  end

  def aprovar 
    @schedule = nil
    if params[:id].present?
      @schedule = Schedule.find params[:id]

      @schedule.status = 'APROVADO'

      #Se datas estiverem incorretas
      return render json: 'HORARIO_INICIO_MAIOR'.to_json, :status => 422 if Time.parse(params[:start]) >= Time.parse(params[:end])
      
    else
      return render json: 'AGENDAMENTO_NAO_ENCONTRADO'.to_json, :status => 422
    end

    if @schedule.save
      @schedule.update(admin_aproved: current_user.id)
      @schedule.create_activity(:aprovou_reserva, owner: current_user, recipient: @schedule)
      render json: @schedule
    else
      render json: @schedule.errors
    end

  end

  def reject 
    @schedule = nil
    if params[:id].present?
      @schedule = Schedule.find params[:id]

      @schedule.status = 'REJEITADO'
      
      if params[:motivo_reject].present?
        @schedule.reason_rejected = params[:motivo_reject]
      else
        return render json: 'MOTIVO_NOT_NULL'.to_json, status: 422
      end

      #Se datas estiverem incorretas
      return render json: 'HORARIO_INICIO_MAIOR'.to_json, :status => 422 if Time.parse(params[:start]) >= Time.parse(params[:end])
      
    else
      return render json: 'AGENDAMENTO_NAO_ENCONTRADO'.to_json, :status => 422
    end

    if @schedule.save
      @schedule.update(admin_rejected: current_user.id)
      @schedule.create_activity(:rejeitou_reserva, owner: current_user, recipient: @schedule , params: {motivo: @schedule.reason_rejected})
      render json: @schedule
    else
      render json: @schedule.errors
    end

  end

  def cancel 
    @schedule = nil
    if params[:id].present?
      @schedule = Schedule.find params[:id]

      @schedule.status = 'CANCELADO'
      
      if params[:motivo_cancel].present?
        @schedule.reason_cancel = params[:motivo_cancel]
      else
        return render json: 'MOTIVO_NOT_NULL'.to_json, status: 422
      end

      #Se datas estiverem incorretas
      return render json: 'HORARIO_INICIO_MAIOR'.to_json, :status => 422 if Time.parse(params[:start]) >= Time.parse(params[:end])
      
    else
      return render json: 'AGENDAMENTO_NAO_ENCONTRADO'.to_json, :status => 422
    end

    if @schedule.save
      @schedule.update(admin_cancel: current_user.id)
      @schedule.create_activity(:cancelou_reserva, owner: current_user, recipient: @schedule , params: {motivo: @schedule.reason_cancel})
      render json: @schedule
    else
      render json: @schedule.errors
    end

  end

  def activities
    agenda = Schedule.find params[:id]
    @activities = PublicActivity::Activity.where(recipient_id: agenda.id, recipient_type: "Schedule").order("created_at desc")
   
    render :partial => 'schedules/activities_agendamento'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:start, :end, :equipament_id, :laboratory_id, :user_id, :status, :typeReservation_id)
    end
end
