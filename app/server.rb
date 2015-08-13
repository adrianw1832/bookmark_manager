require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'
require_relative 'helpers/app_helper'
require_relative 'controllers/base'
require_relative 'controllers/init'

include BookmarkManager::Models

module BookmarkManager
  class MyApp < Sinatra::Base
    use Routes::Links
    use Routes::Mainpage
    use Routes::PasswordReset
    use Routes::RequestPasswordReset
    use Routes::Signin
    use Routes::Signup
    use Routes::Tags
  end
end
