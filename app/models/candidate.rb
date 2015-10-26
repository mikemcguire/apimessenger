class Candidate < ActiveRecord::Base
	validates :first_name,
		uniqueness: true,
		presence: true
	validates :last_name,
		uniqueness: true,
		presence: true
   	validates :donor,
   		presence: true,
   		length: { minimum: 2}
	validates :total,
		presence: true
	def self.get_remote 
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

end
