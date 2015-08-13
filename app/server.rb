require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'
require_relative 'controllers/init'
require_relative 'helpers/app_helper'

class BookmarkManager < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }
  set :public_folder, proc { File.join(root, '../..', 'public') }
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  use Rack::MethodOverride

  include ApplicationHelpers

  configure do
    register Sinatra::Partial
    set :partial_template_engine, :erb
  end
end
