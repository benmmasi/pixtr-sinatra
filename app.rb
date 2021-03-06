require "sinatra"
require "sinatra/reloader" if development?
require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "photo_gallery"
  )

class Gallery < ActiveRecord::Base
  has_many :images
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
end

delete "/galleries/:id" do
  id = params[:id]
  gallery = Gallery.find(id)
  gallery.destroy
  redirect ("/")
end

get "/galleries/:id" do
  id  = params[:id]

  @gallery = Gallery.find(id)
  erb :gallery
end

get "/galleries/:id/image/new" do
  id = params[:id]
  @gallery = Gallery.find(id)
  erb :image_new
end

post "/galleries/:id/image/new" do
  @galleries = Gallery.find(params[:id])
  image = params[:image]
  @galleries.images.create(image)
  redirect(to("/galleries/#{@galleries.id}"))
end

delete "/galleries/:id/image" do
  id = params[:id]
  gallery = Gallery.find(id)
  image = gallery.image.find(id)
  image.destroy
  redirect("/galleries/:id")
end
