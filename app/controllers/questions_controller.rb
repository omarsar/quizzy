class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @question = Question.all.sample
    
    @true_answer = @question.answer
    @preliminary_choices = Answer.all.sample(4).map do |a| 
      if a.body != @true_answer
        a.body
      end 
    end

    @multiple_choices = @preliminary_choices.sample(3) << @true_answer
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    #@answer = @question.answers.create(:body => "#{@question.answer}")

    respond_to do |format|
      if @question.save
        @question.answers.create(:body => "#{@question.answer}")
        format.html { redirect_to root_path, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check
    @question = Question.find(params[:id])
    
    respond_to do |format|
      if @question.answer == params["selected_answer"]
        format.html { redirect_to root_path, notice: 'Correct Answer :)' }
      else
        format.html { redirect_to root_path, alert: 'Wrong Answer :(' }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:body, :answer)
    end
end
