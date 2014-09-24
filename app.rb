require "sinatra"
require "sinatra/reloader" if development?
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
  )

class Gallery < ActiveRecord::Base
end

class Image < ActiveRecord::Base
end

get "/" do
  @galleries = Gallery.all 
  erb :home
end

get "/galleries/:id" do
  id = params[:id]
  @galleries = Gallery.find(id)
  @name = Gallery.name

  @images = Image.where(gallery_id: id)
  erb :galleries
end














