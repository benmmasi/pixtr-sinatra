require "sinatra"
require "sinatra/reloader" if development?
require "pg"

database = PG.connect({ dbname: "photo_gallery"})

get "/" do
  @gallery_names = database.exec_params({ name: "photo_gallery" }) 
  @gallery_names.each do |name|
    @gallery_names << ["name"]
  end
  
  erb :home
end

get "/gallery/:name" do
  @name = params[:name]
  @images = GALLERIES[@name]
  erb :gallery
end













