class EnemiesController < ApplicationController
  include MyUtility
  before_action :set_enemy, only: [:show, :edit, :update, :destroy]

  # GET /enemies
  def index
    param_set
    @count	= Enemy.notnil().includes(:enemy, :suffix).search(params[:q]).result.count()
    @search	= Enemy.notnil().includes(:enemy, :suffix).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @enemies	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')

    params[:q] = {}
    
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "generate_no", "generate_no_form")
    reference_number_assign(params, "battle_no", "battle_no_form")
    reference_text_assign(params, "enemy_id", "enemy_form")
    reference_text_assign(params, "suffix_id", "suffix_form")
    
    @result_no_form = params["result_no_form"]
    @generate_no_form = params["generate_no_form"]
    @battle_no_form = params["battle_no_form"]
    @enemy_form = params["enemy_form"]
    @suffix_form = params["suffix_form"]
  end
  # GET /enemies/1
  #def show
  #end

  # GET /enemies/new
  #def new
  #  @enemy = Enemy.new
  #end

  # GET /enemies/1/edit
  #def edit
  #end

  # POST /enemies
  #def create
  #  @enemy = Enemy.new(enemy_params)

  #  if @enemy.save
  #    redirect_to @enemy, notice: 'Enemy was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /enemies/1
  #def update
  #  if @enemy.update(enemy_params)
  #    redirect_to @enemy, notice: 'Enemy was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /enemies/1
  #def destroy
  #  @enemy.destroy
  #  redirect_to enemies_url, notice: 'Enemy was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enemy
      @enemy = Enemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enemy_params
      params.require(:enemy).permit(:result_no, :generate_no, :battle_no, :enemy_id, :suffix_id)
    end
end
