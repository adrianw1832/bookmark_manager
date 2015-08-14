require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'
require_relative 'helpers/app_helper'
require_relative 'controllers/base'

Dir[__dir__ + '/controllers/*.rb'].each(&method(:require))

include BookmarkManager::Models

module BookmarkManager
  class MyApp < Sinatra::Base
    use Routes::Mainpage
    use Routes::Links
    use Routes::Tags
    use Routes::Users::Signup
    use Routes::Users::PasswordReset
    use Routes::Users::RequestPasswordReset
    use Routes::Sessions::Signin
  end
end
