require 'sinatra/base'

class App < Sinatra::Base
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    'Hello App!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
