class AlbumsController < ApplicationController
  before_action :require_login, except: [:index, :show]

  def new
    @album = Album.new
    @album.band_id = params[:band_id]
    render :new
  end

  def index
    #show all the bands in db.
    render :index
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to albums_url
    else
      flash[:album_errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to albums_url
    else
      flash[:album_errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy unless album.nil?
    redirect_to albums_url
  end

  def show
    @album = Album.find(params[:id])
    #show all the albums in the db.
  end


private
  def album_params
    params.require(:album).permit(:title, :band_id, :album_type, :release_date)
  end

end
