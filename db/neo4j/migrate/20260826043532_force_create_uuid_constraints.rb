class ForceCreateUuidConstraints < ActiveGraph::Migrations::Base
  def up
    add_constraint :Category, :uuid #, force: true
    add_constraint :Code, :uuid #, force: true
    add_constraint :Dimension, :uuid #, force: true
    add_constraint :Event, :uuid #, force: true
    add_constraint :Memo, :uuid #, force: true
    add_constraint :Persoona, :uuid #, force: true
    add_constraint :Project, :uuid #, force: true
    add_constraint :Researcher, :uuid #, force: true
    add_constraint :SurveyItem, :uuid #, force: true
    add_constraint :SurveyResponse, :uuid #, force: true
    add_constraint :Theme, :uuid #, force: true
  end

  def down
    drop_constraint :Category, :uuid
    drop_constraint :Code, :uuid
    drop_constraint :Dimension, :uuid
    drop_constraint :Event, :uuid
    drop_constraint :Memo, :uuid
    drop_constraint :Persoona, :uuid
    drop_constraint :Project, :uuid
    drop_constraint :Researcher, :uuid
    drop_constraint :SurveyItem, :uuid
    drop_constraint :SurveyResponse, :uuid
    drop_constraint :Theme, :uuid
  end
end
