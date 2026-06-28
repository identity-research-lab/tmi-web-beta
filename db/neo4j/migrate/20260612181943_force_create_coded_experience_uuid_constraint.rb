class ForceCreateCodedExperienceUuidConstraint < ActiveGraph::Migrations::Base
  def up
#    add_constraint :CodedExperience, :uuid, force: true
  end

  def down
    drop_constraint :CodedExperience, :uuid
  end
end
