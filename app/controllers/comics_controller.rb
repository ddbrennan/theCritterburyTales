class ComicsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_first_last

  def new
    @comic = Comic.new
    @tag = @comic.build_tag
  end

  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      upload(@comic)
      redirect_to @comic
    else
      flash[:errors] = @comic.errors.full_messages
    end
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def index
    @comics = Comic.search(params[:q])
  end

  def edit
    @comic = Comic.find(params[:id])
  end

  def update
    @comic = Comic.find(params[:id])
    @comic.update(comic_params)
    redirect_to @comic
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.delete
    redirect_to comics_path
  end

  private

  def comic_params
    params.require(:comic).permit(:title, :alt, :tag_id, :tag_attributes => [:name])
  end

  def upload(comic)
    uploaded_io = params[:comic][:image]
    File.open(Rails.root.join('app/assets', 'images', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    comic.update(path: uploaded_io.original_filename)
  end

  def set_first_last
    @first = Comic.first
    @last = Comic.last
  end

end
