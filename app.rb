require "sinatra"
require "sinatra/reloader" if development?
require "pg"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
  )
database = PG.connect({ dbname: "photo_gallery"})

get "/" do
  gallery_result = database.exec_params("SELECT name FROM galleries") 
  @gallery_names = gallery_result.map do |gallery|
    gallery["name"]
  end 

  erb :home
end

get "/galleries/:id" do
  id = params[:id]
  name_result = database.exec_params("SELECT name FROM galleries WHERE id = $1", [id])
  @name = name_result.first["name"]
  @images = []
  erb :galleries
end














