class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy, :play_game, :clear_players, :check_players]
  include GameEngine

  def play_game
    if check_players
      add_user_to_game(current_user.email, params[:number])
      @tb = TableGame.create(table_id: @table.id, user_id: current_user.id)
      redirect_to @table
    else
      redirect_to @table, notice: 'Full'
    end
    if @users == 3
      repartize_users(@users.count)
    end
  end

  def display_winners
    winners_array
  end

  def clear_players
    if @table.connected_players == 3
      @table.update_attribute(:connected_players, @table.connected_players = 0)
      $redis.del('users')
      redirect_to @table, notice: 'Free room'
    end
  end

  def check_players
    if @table.connected_players < 3
      @table.update_attribute(:connected_players, @table.connected_players += 1)
    end
  end

  def index
    @tables = Table.where('connected_players < ?', 3)

  end

  # GET /tables/1
  # GET /tables/1.json
  def show
  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables
  # POST /tables.json
  def create
    @table = Table.new(table_params)

    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: 'Table was successfully created.' }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1
  # PATCH/PUT /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to @table, notice: 'Table was successfully updated.' }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1
  # DELETE /tables/1.json
  def destroy
    @table.destroy
    respond_to do |format|
      format.html { redirect_to tables_url, notice: 'Table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def table_params
      params.require(:table).permit(:name, :max_users, :bet, :connected_players)
    end
end
