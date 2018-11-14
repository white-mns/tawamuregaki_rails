class PartiesController < ApplicationController
  include MyUtility
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    param_set
    @count	= Party.notnil().includes(:pc_name).search(params[:q]).result.count()
    @search	= Party.notnil().includes(:pc_name).page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @parties	= @search.result.per(50)
  end

  def param_set
    @last_result = Name.maximum('result_no')

    params[:q] ||= {}
    
    reference_text_assign(params, "pc_name_nickname", "pc_name_form")
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "generate_no", "generate_no_form")
    reference_number_assign(params, "battle_no", "battle_no_form")
    reference_number_assign(params, "e_no", "e_no_form")
    reference_number_assign(params, "party_order", "party_order_form")
    
    @pc_name_form = params["pc_name_form"]
    @result_no_form = params["result_no_form"]
    @generate_no_form = params["generate_no_form"]
    @battle_no_form = params["battle_no_form"]
    @e_no_form = params["e_no_form"]
    @party_order_form = params["party_order_form"]
  end
  # GET /parties/1
  #def show
  #end

  # GET /parties/new
  #def new
  #  @party = Party.new
  #end

  # GET /parties/1/edit
  #def edit
  #end

  # POST /parties
  #def create
  #  @party = Party.new(party_params)

  #  if @party.save
  #    redirect_to @party, notice: 'Party was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /parties/1
  #def update
  #  if @party.update(party_params)
  #    redirect_to @party, notice: 'Party was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /parties/1
  #def destroy
  #  @party.destroy
  #  redirect_to parties_url, notice: 'Party was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:result_no, :generate_no, :battle_no, :e_no, :party_order)
    end
end
