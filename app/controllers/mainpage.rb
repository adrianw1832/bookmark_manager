class BookmarkManager < Sinatra::Base
  get '/' do
    redirect '/links'
  end
end
