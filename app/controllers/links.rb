class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    if current_user
      link = Link.create(url: params[:url], title: params[:title])
      tag_list = params[:tags].split
      tag_list.each { |tag| link.tags << Tag.create(name: tag) }
      @current_user.links << link
      @current_user.save
    else
      flash[:notice] = 'Please sign up or sign in first!'
    end
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/new'
  end
end
