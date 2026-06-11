class ForceCreateSurveyResponseUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :SurveyResponse, :uuid, force: true
  end

  def down
    drop_constraint :SurveyResponse, :uuid
  end
end
