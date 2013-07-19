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

