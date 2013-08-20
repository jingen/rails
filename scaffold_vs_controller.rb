rails g scaffold mycourses
     invoke  mongoid
      create    app/models/mycourse.rb
      invoke    test_unit
      create      test/models/mycourse_test.rb
      create      test/fixtures/mycourses.yml
#      invoke  resource_route
#       route    resources :mycourses
      invoke  scaffold_controller
      create    app/controllers/mycourses_controller.rb
      invoke    erb
      create      app/views/mycourses
#      create      app/views/mycourses/index.html.erb
#      create      app/views/mycourses/edit.html.erb
#      create      app/views/mycourses/show.html.erb
#      create      app/views/mycourses/new.html.erb
#      create      app/views/mycourses/_form.html.erb
      invoke    test_unit
      create      test/controllers/mycourses_controller_test.rb
      invoke    helper
      create      app/helpers/mycourses_helper.rb
      invoke      test_unit
      create        test/helpers/mycourses_helper_test.rb
#      invoke    jbuilder
#      create      app/views/mycourses/index.json.jbuilder
#      create      app/views/mycourses/show.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/mycourses.js.coffee
      invoke    scss
      create      app/assets/stylesheets/mycourses.css.scss
#      invoke  scss
#      create    app/assets/stylesheets/scaffolds.css.scss

rails g controller mycontents
      create  app/controllers/mycontents_controller.rb
      invoke  erb
      create    app/views/mycontents
      invoke  test_unit
      create    test/controllers/mycontents_controller_test.rb
      invoke  helper
      create    app/helpers/mycontents_helper.rb
      invoke    test_unit
      create      test/helpers/mycontents_helper_test.rb
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/mycontents.js.coffee
      invoke    scss
      create      app/assets/stylesheets/mycontents.css.scss

rails g model mycontent
      invoke  mongoid
      create    app/models/mycontent.rb
      invoke    test_unit
      create      test/models/mycontent_test.rb
      create      test/fixtures/mycontents.yml
