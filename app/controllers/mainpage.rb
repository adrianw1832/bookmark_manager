module BookmarkManager
  module Routes
    class Mainpage < Base
      get '/' do
        redirect '/links'
      end
    end
  end
end
