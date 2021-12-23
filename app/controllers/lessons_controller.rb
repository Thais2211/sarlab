class LessonsController < ApplicationController
  before_action :set_lessom, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @q = Lesson.ransack(params[:q])
    @lessons = @q.result
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @anexos = Anexo.where(lesson_id: @lessom.id)
    @user = User.where(id: @lessom.users_id).first
  end

  # GET /lessons/1/edit
  def edit
    @anexos = Anexo.where(lesson_id: @lessom.id)
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lessom.update(lessom_params)
        schedule = Schedule.find_by_lesson_id @lessom.id
        date_start = DateTime.new(@lessom.data.year, @lessom.data.month, @lessom.data.day, @lessom.start_time.hour, @lessom.start_time.min, 0).advance(hours: 3)
        date_end = DateTime.new(@lessom.data.year, @lessom.data.month, @lessom.data.day, @lessom.end_time.hour, @lessom.end_time.min, 0).advance(hours: 3)
      
        schedule.update(start: date_start, end: date_end, laboratory_id: @lessom.laboratory_id) if schedule.present?

        format.html { redirect_to @lessom, notice: 'Aula e agendamento atualizadados' }
        format.json { render :show, status: :ok, location: @lessom }
      else
        format.html { render :edit }
        format.json { render json: @lessom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lessom.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_lesson
    lesson = Lesson.new(data: params[:data], laboratory_id: params[:laboratory_id], disciplina_id: params[:disciplina_id], 
                          start_time: params[:start_time], end_time: params[:end_time])
    
    if lesson.save
      date_start = DateTime.new(lesson.data.year, lesson.data.month, lesson.data.day, lesson.start_time.hour, lesson.start_time.min, 0).advance(hours: 3)
      date_end = DateTime.new(lesson.data.year, lesson.data.month, lesson.data.day, lesson.end_time.hour, lesson.end_time.min, 0).advance(hours: 3)
      
      Schedule.criarAgendamento date_start, date_end, lesson.laboratory_id, current_user.id, lesson.id
    end

    render json:lesson

    # #criar reservas para aulas
    # #pegar o dia da semana e somar mais 7
    # data_inicial = params[:date_start].to_date
    # data_final = params[:date_end].to_date
    # data = data_inicial
    # #reservas do dia 1    
    # while data.wday != Lesson.week_day(lesson.day1) do
    #   data = data + 1.day
    # end
    # while data <= data_final do
    #   date_start = DateTime.new(data.year, data.month, data.day, lesson.hour1_start.hour, lesson.hour1_start.min, 0)
    #   date_end = DateTime.new(data.year, data.month, data.day, lesson.hour1_end.hour, lesson.hour1_end.min, 0)
    #   #reserva = Shedules.create(start: date_start, end: date_end, laboratory_id: lesson.laboratory_id, typeReservation_id:1 )
      
    #   Schedule.criarAgendamento date_start, date_end, lesson.laboratory_id, current_user.id
    #   data = data + 7.day
    # end

    #redirect_to lessons_path, notice:'Aula cadastrada com sucesso'
  end

  def review
    lesson = Lesson.find params[:id]
    
    lesson.update(review: !lesson.review, users_id: current_user.id)

    render json: lesson
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessom
      @lessom = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessom_params
      params.require(:lesson).permit(:data, :start_time, :end_time, :laboratory_id, :disciplina_id)
    end
end
