class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.create(url: params[:url], title: params[:title])
    tag_list = params[:tags].split
    tag_list.each { |tag| link.tags << Tag.create(name: tag) }
    if current_user
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
