<% %> (evaluate Ruby code), <% -%> (evaluate Ruby code, suppress the trailing newline) and <%- -%> (evaluate Ruby code, suppress the trailing newline and leading space)

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
    or
    issue = Issue.new ({title: "My first issue", description: "My first issue description", no_followers:0 })
    issue.save
    issue.save!
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
#no_followers = 1
Issue.find_by_title("NYU")
Issue.find_all_by_no_followers(1)
Issue.where "title = ?" , "NYU"
# where title = 'NYU'
Issue.where("title = ?" , "NYU").where("no_followers = ?", 3)
# be chained

Issue.where("title = ?" , "NYU").where("no_followers = ?", 1)
Issue.where("title = ?" , "NYU").where("no_followers = ?", 2)

<th>Title <%=link_to "sort", issues_path(sort: "title") %></th>
# /issues?sort="title"
# in issue_controller, index method, 
#@issues = Issue
#@issues = Issue.order(params[:sort]) if params[:sort]
#@issues = @issues.all
#active_record_querying.html

:create def validate(record)
:in issue.rb validate_with Yesnovalidator
:in issue.rb
	validates_presence_of :title
	validates_uniqueness_of :title, message: "should be unique, sir."
	validates_length_of :description, minimum: 10, maximum: 12
	validates_numericality_of :no_followers, allow_blank: true
custom validation

validates_with Yesnovalidator
app/validator/yesnovalidator.rb

if you use the Rails form helpers to generate your forms, when a validation error occurs on a field, it will generate an extra <div> around the entry.

rails g scaffold project name description:text
rake db:migrate
rails g migration add_project_id_to_issues project_id:integer
rake db:migrate
: in issue.rb; belongs_to :project
: in project.rb; has_many :issues
rake db:rollback
(rake db:migrate RAILS_ENV=development)
(
  def change
    add_column :issues, :project_id, :integer, :default => 1
  end
)
rake db:migrate
Issue.pluck :project_id

@project.issues.each
@issue.project

has_many :issues, through: :join_model
has_many :project, through: :join_model

class JoinModel < ActiveRecord::Base
    belongs_to :project
    belongs_to :issue
end
has_one :issue #@project.issue (only one)

### same with joinmodel
has_and_belongs_to_many :projects
has_and_belongs_to_many :issues

# extra table for many to many relation
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

### timelineable_type, timelineable_id
###
    rails g migration AddNameToSubscribers name:string
    rails generate migration RemovePartNumberFromProducts part_number:string
    rake db:migrate
### 
###class CreateTimelines < ActiveRecord::Migration
###  def change
###    create_table :timelines, :id =>false do |t|
###      t.string :content
###      t.string :timelineable_type
###      t.integer :timelineable_id
### To make this work, you need to declare both a foreign key column and a type column in the model that declares the polymorphic interface
###
###      t.timestamps
###    end
###  end
###end

rake db:migrate
:in Timeline, belongs_to :timelineable, polymorphic: true
#class Timeline < ActiveRecord::Base
    #belongs_to :timelineable, polymorphic: true
#end


#Timeline.destroy_all
##callbacks: 
after_create :add_to_timeline
#after_save :add_to_timeline
#only create not update, after_save: both create and update

before_save :strip_spaces_from_tags

private

def add_to_timeline
    Timeline.create!({ content: "An issue was created!", timelineable_id: id, timelineable_type: self.class.to_s })
end

usage: <%=link_to timeline.timelinable.title, timeline.timelineable %>

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
+ t => translate
+ in zh.yml(config/locales/zh.yml)
 nav:
    timeline: 时间表
    issues:
        list: 列表
        new: 新建

# configuring for I18n
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
in routes.rb:
scope "/:locale" do
    get "timeline/index"
    resources :projects
    resources :issues
end
# changes need to be made
# issue is equivalent to issue_path
# <%= link_to 'Show', issue %>   -----   <%= link_to 'Show', issue_path(id: issue.id) %>
# <%= link_to 'Edit', edit_issue_path(issue) %> ------  <%= link_to 'Edit', edit_issue_path(id: issue.id) %>
# <%= link_to 'Destroy', issue, confirm: 'Are you sure?', method: :delete %> ------ <%= link_to 'Destroy', issue_path(id: issue.id), confirm: 'Are you sure?', method: :delete %>

@issue => issue_path(id: @issue.id)

<%=l @issue.created_at, format: :short%>
(l is short for "localize")

config/environment/development.rb:
  config.assets.debug = false
#reboot rails server, done
# change default extension
# config.sass.preferred_syntax = :sass
# gem 'coffee-rails', comment out it and supress createing coffee extension

root: Gemfile

test, development, production, 

gem "haml-rails"

bundle install (not only Gemfile but specified in Gemfile.lock)
bundle update (Gemfile)

#change a Rails App to production
rails server -e production
RAILS_ENV=production ./script/server

rails g mailer issue_mailer
#app/mailers/issue_mailer
###
#class IssueMailer < ActionMailer::Base
#  default from: "rails@issues.com"
#
#  def issue_created(issue)
#  	@issue = issue
#  	mail subject: "A new issue was created", to: "linjingen@hotmail.com"
#  end
#end
###
#app/views/issue_mailer/issue_created.html.erb
#app/views/issue_mailer/issue_created.text.erb
###
#An issue has been created!
#
#Hi, how are you? We just wanted you to
#know a new issue has been created.
#
#<%= @issue.title %>
#
#<%=@issue.description%>
#
#Number of followers:
#<%=@issue.no_followers%>
###
#in method
#in issues_controller.rb, create method
###
#IssueMailer.issue_created(@issue).deliver
###

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
  # boot the server(rails server)

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


#mongo:
rails g mongoid:config
(Rails.env)
When you want to create the indexes in the database, use the provided rake task.
# not neccessary
$ rake db:mongoid:create_indexes
Category.all.each do |test|
  puts test.inspect
end

User.all.each do |user| puts user.inspect end;0 
user = User.new(email: "jingen.lin.jl@gmail.com", lastname:"lin", firstname:"jingen", password:"password")
user.save
user.save! (will raise an error if there is an invalid record)

User.ceate(email: "jingen.lin.jl@gmail.com", lastname:"lin", firstname:"jingen", password:"password")

# View:
layout:
in the contoller, using the layout method
layout :user

class IssuesController < ApplicationController
  layout "issue_layout" #views/layouts/issue_layout.html.erb
  layout :products_layout
 
  def show
    @product = Product.find(params[:id])
  end
 
private
  def products_layout
      @current_user.special? ? "special" : "products"
  end

content_for
in the template, index.html.erb, it can be anywhere (content for, %-
<%- content_for :nav do %>
  <p>I'm a nav</p>
<%- end %>

in layout
    <%= yield :nav %> # if there are two or more nav content, they'll be served one by one

view helper
<% render 'search' %>
there is a template '_search.html.erb' in the views/issues/_search.html.erb

1) form_tag
<%= form_tag "/search", method: :get do %> # /search : action, default is issues/, method, default is "post"
    <p>
        <%= text_field_tag :title, nil, size: 30%, placeholder: "Issue title" > #  <input id="title" name="title" type="text" > value is nil
    </p>

    <ul>
        <li><%=check_box_tag :followers, 1 , true%> 1 followers</li># checkbox
        <li><%=check_box_tag :followers, 2 %> 2 followers</li> 
        <li><%=check_box_tag :followers, 3 %> 3+ followers</li>
    </ul>

    <p>
        <%= date_select :created_at_start, nil %>
        &rarr;
        <%= date_select :created_at_end, nil %>
    </p>
    
<%-end%>

# text_field_tag(name, value = nil, options = {})
# check_box_tag(name, value = "1", checked = false, options = {})
# date_select(object_name, method, options = {}, html_options = {})
# submit_tag(value = "Save changes", options = {})

image_tag("icon")
# => <img alt="Icon" src="/assets/icon" />
javascript_include_tag "xmlhr"
# => <script src="/assets/xmlhr.js?1284139606"></script>
stylesheet_link_tag "style"
# => <link href="/assets/style.css" media="screen" rel="stylesheet" />

api.rubyonrails.org/classes/ActionView/Helpers/

respond_to do |format|
    format.html
    format.json { render xml: @issues }
    format.xml { render xml: @issues }
    format.rss # index.rss.builder
    format.csv # index.css.erb
end

index.rss.builder :

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
    xml.channel do
        xml.title "Our issues"
        xml.description "Latest issues, come and get there!"
        xml.link issues_url

        @issues.each do |issue|
            xml.item do
                xml.title issue.title
                xml.pubDate issue.created_at.to_s(:rfc822)
                xml.description issue.description
            end
        end
    end
end

<%= auto_discovery_link_tag(:rss, issues_path(:rss)) %> #rss icon

index.csv.erb :

<%- @issues.each do |issue| %>
<%=issue.title%>,<%=issue.created_at.to_s(:rfc822)%>,<%=issue.description%> 
<%- end %>

