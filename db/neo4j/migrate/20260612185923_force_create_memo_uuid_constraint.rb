class ForceCreateMemoUuidConstraint < ActiveGraph::Migrations::Base
  def up
#    add_constraint :Memo, :uuid, force: true
  end

  def down
    drop_constraint :Memo, :uuid
  end
end
