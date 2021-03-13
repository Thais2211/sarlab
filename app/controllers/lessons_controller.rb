class LessonsController < ApplicationController
  before_action :set_lessom, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lessom = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lessom = Lesson.new(lessom_params)

    respond_to do |format|
      if @lessom.save
        format.html { redirect_to @lessom, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lessom }
      else
        format.html { render :new }
        format.json { render json: @lessom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lessom.update(lessom_params)
        format.html { redirect_to @lessom, notice: 'Lesson was successfully updated.' }
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
    byebug
    lesson = Lesson.new(date_start: params[:date_start], date_end: params[:date_end], laboratory_id: params[:laboratory_id], professor_id: params[:professor_id], 
                          day1: params[:day1], hour1_start: params[:hour1_start], hour1_end: params[:hour1_end])
    
    if params[:day2].present?
      lesson.day2 = params[:day2]
      lesson.hour2_start = params[:hour2_start]
      lesson.hour2_end = params[:hour2_end]
    end
    if params[:day3].present?
      lesson.day3 = params[:day3]
      lesson.hour3_start = params[:hour3_start]
      lesson.hour3_end = params[:hour3_end]
    end
    
    lesson.save!
    #criar reservas para aulas
    #pegar o dia da semana e somar mais 7
    #dom = 0
    data_inicial = params[:date_start].to_date
    data_final = params[:date_end].to_date
    data = data_inicial
    [0..7]

    redirect_to type_reservations_path, notice:'Aula cadastrada com sucesso'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessom
      @lessom = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessom_params
      params.require(:lessom).permit(:date_start, :date_end, :laboratory_id, :professor_id, :day1, :hour1_start, :hour1_end, :day2, :hour2_start, :hour2_end, :day3, :hour3_start, :hour3_end)
    end
end
