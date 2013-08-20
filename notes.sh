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
has_and_belongs_to_many :projects
has_and_belongs_to_many :issues

class CreateIssuesProjects < ActiveRecord::Migration
  def change
    create_table :issues_projects, :id => false do |t|
      t.references :issue, :null => false
      t.references :project, :null => false
    end

    add_index(:issues_projects, [:issue_id, :project_id], :unique => true)
  end
end

rails g controller timeline index
rails g model timeline content timelineable_type timelineable_id:integer
:in Timeline, belongs_to :timelineable, polymorphic: true

Timeline.destroy_all

after_create :add_to_timeline
#only create not update, after_save: both create and update
before_save :strip_spaces_from_tags
private

def add_to_timeline
	Timeline.create!({ content: "An issue was created!", timelineable_id: id, timelineable_type: self.class.to_s })
end
def strip_spaces_from_tags
	self.tags.gsub! ", ", ","
end

rails g migration add_tags_to_issues tags
def issue_params
      params.require(:issue).permit(:title, :description, :no_followers, :tags)
end

i18n:
config/application.rb
:config.i18n.default_locale = :zh
locales/zh.yml (download from github)

:  <li><a href="/timeline/index"><%=t "nav.timeline"%></a></li>
: t => translate

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
http://localhost:3000/issues/locale=en

http://localhost:3000/en/issues

@issue => issue_path(id: @issue.id)

<%=l @issue.created_at, format: :short%>

config/environment/development.rb:
  config.assets.debug = false

root: Gemfile

test, development, production, 

gem "haml-rails"

bundle install (not only Gemfile but specified in Gemfile.lock)
bundle update (Gemfile)

rails g mailer issue_mailer

:config environment/development.rb
  config.action_mailer.perform_deliveries = true 
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    # :domain => 'baci.lindsaar.net',
    :user_name => "jelinmscs@gmail.com",
    :password => "83681600lje.",
    :authentication => :plain,
    :enable_starttls_auto => true
  }

guides.rubyonrails.org/action_mailer_basics.html

Useful references:
1) Ruby on Rails guides
2) Railscasts
3) Ruby Toolbox
4) Net.tutsplus
5) Reddit.com/r/rails
6) StackOverflow

Useful gem
1)Authentication: Devise Sorcery
2)File uploads: Carrierwave
3)PDF generation: PDFkit, Prawn
4)Deployment: Capistrano, Heroku
5)Fulltext search: Sunspot, Thinking Sphinx
6)SOAP webservices: Savon


rails g mongoid:config
(Rails.env)




