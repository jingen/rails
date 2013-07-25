class CreateIssuesProjects < ActiveRecord::Migration
  def change
    create_table :issues_projects, :id => false do |t|
      t.references :issue, :null => false
      t.references :project, :null => false
    end

    add_index(:issues_projects, [:issue_id, :project_id], :unique => true)
  end
end
