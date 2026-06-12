class ForceCreateReflectionUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Reflection, :uuid, force: true
  end

  def down
    drop_constraint :Reflection, :uuid
  end
end
