require "#{Rails.root}/lib/candidatesAPI.rb" 
require 'logger'
class CandidatesController < ApplicationController
	#before_action :get_remote
	def get_remote 
		@list = CandidatesAPI.candidates()
		@list.each {|item|
      candidate = Candidate.find_or_initialize_by( id: item['index'] )
      
      name = item['name'].split(' ')
			attributes = {
				:first_name 	=> name[0],
        :last_name   => name[1] ,
				:donor 	=> item['donor'],
				:total 	=> item['total'],
				:id 	=> item['index']
			}
      candidate.update(attributes)
			candidate.save()
		}
	end

	def show
		render :json => @list.inspect
 	end

  # GET /candidates
  # GET /candidates.json
  def index
    @candidates = Candidate.all
    render :json => @candidates.to_json
  end

  # GET /candidates/1
  # GET /candidates/1.json

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
  def edit
  end


  # POST /candidates
  # POST /candidates.json
  def create

    @candidate = Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.json { render :show, status: :created, location: @candidate }
      else
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
  def destroy_all
    Candidate.destroy_all
    render puts "fart"
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit( :first_name, :last_name, :donor, :total )
    end
end
