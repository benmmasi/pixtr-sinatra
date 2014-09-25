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

get "/galleries/new" do
  erb :new_gallery
end

post "/galleries" do
  new_gallery_name = params[:gallery][:name]
  Gallery.create(name: new_gallery_name)
  redirect("/")
end

get "/galleries/:id" do
  id = params[:id]
  @galleries = Gallery.find(id)
  @images = Image.where(gallery_id: id)
  erb :galleries
end

get "/galleries/:id/edit" do
  @gallery = Gallery.find(params[:id])
  erb :edit
end

patch "/galleries/:id" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.update(params[:id])
  redirect(to("/galleries/#{id}"))
  erb :edit
end

gets "galleries/:id/" do
  id = params[:id]o
  @gallery = Gallery.find(id)
  erb :galery
end










