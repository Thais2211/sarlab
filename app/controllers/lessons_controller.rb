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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessom
      @lessom = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessom_params
      params.require(:lessom).permit(:date_start, :date_end, :laboratory_id, :day1, :hour1, :day2, :hour2, :day3, :hour3)
    end
end
