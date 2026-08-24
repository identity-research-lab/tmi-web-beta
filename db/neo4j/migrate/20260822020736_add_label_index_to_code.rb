class AddLabelIndexToCode < ActiveGraph::Migrations::Base
  def up
    add_index(:Code, :name)
  end

  def down
    raise ActiveGraph::IrreversibleMigration
  end
end
