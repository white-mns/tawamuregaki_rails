class PagesController < ApplicationController
  include MyUtility
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    param_set
    @count	= Page.notnil().includes(:story, [party_members: :pc_name], [enemy_members: [:enemy, :suffix]]).search(params[:q]).result.count()
    @search	= Page.notnil().includes(:story, [party_members: :pc_name], [enemy_members: [:enemy, :suffix]]).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @pages	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')

    params[:q] ||= {}
    
    reference_text_assign(params, "party_members_pc_name_nickname", "pc_name_form")
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "generate_no", "generate_no_form")
    reference_number_assign(params, "battle_no", "battle_no_form")
    reference_number_assign(params, "story_id", "story_id_form")
    reference_number_assign(params, "page_no", "page_no_form")
    reference_number_assign(params, "party_num", "party_num_form")
    reference_number_assign(params, "enemy_num", "enemy_num_form")
    reference_number_assign(params, "battle_result", "battle_result_form")
    reference_text_assign(params, "enemy_members_enemy_name", "enemy_form")
   
    if !params["is_form"] then
        params["is_win"] = "on"
        params["is_draw"] = "on"
        params["is_lose"] = "on"
    end
    params[:q]["battle_result_eq_any"] ||= []
    if params["is_win"] == "on"  then params[:q]["battle_result_eq_any"].push(1) end
    if params["is_draw"] == "on" then params[:q]["battle_result_eq_any"].push(0) end
    if params["is_lose"] == "on" then params[:q]["battle_result_eq_any"].push(-1) end

    @pc_name_form = params["pc_name_form"]
    @result_no_form = params["result_no_form"]
    @generate_no_form = params["generate_no_form"]
    @battle_no_form = params["battle_no_form"]
    @story_id_form = params["story_id_form"]
    @page_no_form = params["page_no_form"]
    @party_num_form = params["party_num_form"]
    @enemy_num_form = params["enemy_num_form"]
    @battle_result_form = params["battle_result_form"]
    @enemy_num_form = params["enemy_num_form"]

    @enemy_form = params["enemy_form"]
    @is_win = params["is_win"]
    @is_draw = params["is_draw"]
    @is_lose = params["is_lose"]

    @show_battle_result = params["show_battle_result"]
    @show_battle_no = params["show_battle_no"]
    @show_enemy = params["show_enemy"]
    @show_num = params["show_num"]
    @base_first    = (!params["is_form"]) ? "1" : "0"
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
