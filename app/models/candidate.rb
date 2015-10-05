class Candidate < ActiveRecord::Base

	validates :name,
		uniqueness: true,
		presence: true
   	validates :donor,
   		presence: true,
   		length: { minimum: 2}
	validates :total,
		presence: true

end
