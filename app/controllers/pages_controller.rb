class PagesController < ApplicationController
  include MyUtility
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    param_set
    @count	= Page.notnil().includes(:story).search(params[:q]).result.count()
    @search	= Page.notnil().includes(:story).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @pages	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')

    params[:q] ||= {}
    
    reference_text_assign(params, "pc_name_name", "pc_name_form")
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "generate_no", "generate_no_form")
    reference_number_assign(params, "battle_no", "battle_no_form")
    reference_number_assign(params, "story_id", "story_id_form")
    reference_number_assign(params, "page_no", "page_no_form")
    reference_number_assign(params, "party_num", "party_num_form")
    reference_number_assign(params, "enemy_num", "enemy_num_form")
    reference_number_assign(params, "battle_result", "battle_result_form")
    
    @pc_name_form = params["pc_name_form"]
    @result_no_form = params["result_no_form"]
    @generate_no_form = params["generate_no_form"]
    @battle_no_form = params["battle_no_form"]
    @story_id_form = params["story_id_form"]
    @page_no_form = params["page_no_form"]
    @party_num_form = params["party_num_form"]
    @enemy_num_form = params["enemy_num_form"]
    @battle_result_form = params["battle_result_form"]
  end
  # GET /pages/1
  #def show
  #end

  # GET /pages/new
  #def new
  #  @page = Page.new
  #end

  # GET /pages/1/edit
  #def edit
  #end

  # POST /pages
  #def create
  #  @page = Page.new(page_params)

  #  if @page.save
  #    redirect_to @page, notice: 'Page was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /pages/1
  #def update
  #  if @page.update(page_params)
  #    redirect_to @page, notice: 'Page was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /pages/1
  #def destroy
  #  @page.destroy
  #  redirect_to pages_url, notice: 'Page was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:result_no, :generate_no, :battle_no, :story_id, :page_no, :party_num, :enemy_num, :battle_result)
    end
end
