## Features
* Devise integration
  * preventing users sign in if a certain attribute is met. e.g. archived_at column is not nil
  * editng config/locales/devise.en.yml
* An admin user with admin powers. E.g. creating users, editing users, creating projects
* Font awesome gem
* Simple form gem  
* Using global error rescuing i.e. `rescue_from Pundit::NotAuthorizedError` this is located in ApplicationController
* nested attributes
* refactoring css into meaningful class names e.g. changing `btn btn-primary` to `a.edit`
### Testing features
* testing features with capybara
* factory girl replacing fixtures
* Stubbing in controller tests
  * `allow(controller).to receive(:current_user).and_return user`
