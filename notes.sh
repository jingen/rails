\curl -L https://get.rvm.io | bash -s stable --rails
rails new my_app
rails g controller hello world cowsay
bundle up
#start server: localhost:3000, s=server
rails s
#create model, g=generate
rails g model issue title:string description:text no_followers:integer
#run migration
rake db:migrate
#run console, load rails development environment
rails console
    Issue.all
    Issue.create({title: "My first issue", description: "My first issue description", no_followers:0 })

# using scaffold 
rails new new_issues
cd new_issues
rails g scaffold issue title description:text no_followers:integer
rake db:migrate
rails s

http://api.rubyonrails.org/classes/ActionView/Helpers.html

Issue.all
Issue.first
Issue.order("title")
Issue.order("title").first
Issue.order("title").last
Issue.order("title desc").last
Issue.order("title desc").limit 3
Issue.find(1)
Issue.find(10)
Issue.find_by_no_followers(1)
Issue.find_by_title("NYU")
Issue.find_all_by_no_followers(1)
Issue.where "title = ?" , "NYU"
Issue.where("title = ?" , "NYU").where("no_followers = ?", 3)
Issue.where("title = ?" , "NYU").where("no_followers = ?", 1)
Issue.where("title = ?" , "NYU").where("no_followers = ?", 2)

<th>Title <%=link_to "sort", issues_path(sort: "title") %></th>

app/validator/yesnovalidator.rb
:create def validate(record)
:in issue.rb validate_with Yesnovalidator
:in issue.rb
	validates_presence_of :title
	validates_uniqueness_of :title, message: "should be unique, sir."
	validates_length_of :description, minimum: 10, maximum: 12
	validates_numericality_of :no_followers, allow_blank: true

rails g scaffold project name description:text
rake db:migrate
rails g migration add_project_id_to_issues project_id:integer
rake db:migrate
: in issue.rb; belongs_to :project
: in project.rb; has_many :issues
rake db:rollback
rake db:migrate
Issue.pluck :project_id

has_many :issues
has_mang_and_belongs_to :projects
has_mang_and_belongs_to :issues

class CreateIssuesProjects < ActiveRecord::Migration
  def change
    create_table :issues_projects, :id => false do |t|
      t.references :issue, :null => false
      t.references :project, :null => false
    end

    add_index(:issues_projects, [:issue_id, :project_id], :unique => true)
  end
end

