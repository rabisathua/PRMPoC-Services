module PhysicianFilter
  class All
    def self.physicians(location_id, speciality_id)
      Physician.by_location_and_speciality(location_id, speciality_id)
    end
  end
end