class ForceCreateEventUuidConstraint < ActiveGraph::Migrations::Base
  def up
#    add_constraint :Event, :uuid, force: true
  end

  def down
    drop_constraint :Event, :uuid
  end
end
