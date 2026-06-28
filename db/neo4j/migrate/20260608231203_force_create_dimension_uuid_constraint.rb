class ForceCreateDimensionUuidConstraint < ActiveGraph::Migrations::Base
  def up
#    add_constraint :Dimension, :uuid, force: true
  end

  def down
    drop_constraint :Dimension, :uuid
  end
end
