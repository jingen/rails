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

