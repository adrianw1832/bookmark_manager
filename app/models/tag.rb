module BookmarkManager
  module Models
    class Tag
      include DataMapper::Resource

      property :id, Serial
      property :name, String
      has n, :links, through: Resource
    end
  end
end
