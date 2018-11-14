class StoryDataController < ApplicationController
  include MyUtility
  before_action :set_story_datum, only: [:show, :edit, :update, :destroy]

  # GET /story_data
  def index
    param_set
    @count	= StoryDatum.search(params[:q]).result.count()
    @search	= StoryDatum.page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @story_data	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')

    params[:q] ||= {}
    
    reference_number_assign(params, "story_no", "story_no_form")
    reference_number_assign(params, "title", "title_form")
    reference_number_assign(params, "max_page", "max_page_form")
    
    @pc_name_form = params["pc_name_form"]
    @story_no_form = params["story_no_form"]
    @title_form = params["title_form"]
    @max_page_form = params["max_page_form"]
  end
  # GET /story_data/1
  #def show
  #end

  # GET /story_data/new
  #def new
  #  @story_datum = StoryDatum.new
  #end

  # GET /story_data/1/edit
  #def edit
  #end

  # POST /story_data
  #def create
  #  @story_datum = StoryDatum.new(story_datum_params)

  #  if @story_datum.save
  #    redirect_to @story_datum, notice: 'Story datum was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /story_data/1
  #def update
  #  if @story_datum.update(story_datum_params)
  #    redirect_to @story_datum, notice: 'Story datum was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /story_data/1
  #def destroy
  #  @story_datum.destroy
  #  redirect_to story_data_url, notice: 'Story datum was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_datum
      @story_datum = StoryDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_datum_params
      params.require(:story_datum).permit(:story_no, :title, :max_page)
    end
end
