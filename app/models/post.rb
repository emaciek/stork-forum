class Post
  include DataMapper::Resource
  
  property :id, 	Serial
  property :title, 	String, :index => true
  property :content, 	Text
  property :created_at, DateTime
end
