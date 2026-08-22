class AddLabelIndexToCode < ActiveGraph::Migrations::Base
  def up
    add_index(:Code, :label)
  end

  def down
    raise ActiveGraph::IrreversibleMigration
  end
end
