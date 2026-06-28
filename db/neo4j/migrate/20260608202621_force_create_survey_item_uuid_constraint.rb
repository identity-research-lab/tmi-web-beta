class ForceCreateSurveyItemUuidConstraint < ActiveGraph::Migrations::Base
  def up
#    add_constraint :SurveyItem, :uuid, force: true
  end

  def down
    drop_constraint :SurveyItem, :uuid
  end
end
