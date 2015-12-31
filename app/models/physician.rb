class Physician < ActiveRecord::Base
	belongs_to :client
	belongs_to :location
	belongs_to :speciality
	has_many :liason_physicians
	has_many :liasons, through: :liason_physicians

	self.per_page = 10

	# Use with unscope
	default_scope do
		eager_load(:location, :speciality)
	end
	
	scope :by_location_and_speciality, ->(location_id, speciality_id) do
		# eager_load(:location, :speciality).where(location_id: location_id).where(speciality_id: speciality_id)
		Physician.by_location(location_id).by_speciality(speciality_id)
	end

	scope :by_location, ->(location_id) do
		where(location_id: location_id)
	end

	scope :by_speciality, ->(speciality_id) do
		where(speciality_id: speciality_id)
	end

	scope :by_involved, ->{ where(is_involved: true)	}

	scope :by_lead, ->{ where(is_lead: true) }

	def self.by_liason(liason_id)
		liason = Liason.where(id: liason_id).last
		liason.nil? ? [] : liason
	  (liason.physicians && Physician.by_location(1).by_speciality(1))
	end

	def full_name
		self.first_name << self.last_name << ', ' << self.qualification
	end
end

