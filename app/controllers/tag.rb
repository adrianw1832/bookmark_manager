class BookmarkManager < Sinatra::Base
  get '/tags/:name' do
    if current_user
      tag = Tag.first(name: params[:name])
      @current_user.links = tag ? tag.links : []
    end
    erb :'links/index'
  end
end
