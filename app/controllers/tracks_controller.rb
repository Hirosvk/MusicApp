class TracksController < ApplicationController
  before_action :require_login, only: [:index, :show]

  def index
  end

  def new
    @track = Track.new
    @track.album_id = params[:album_id]
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash[:track_errors] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
    track = Track.find(params[:id])
    track.destroy unless track.nil?
    redirect_to albums_url
  end


  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to albums_url
    else
      flash[:track_errors] = @track.errors.full_messages
      render :edit
    end
  end

  def show
  end

private
  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :track_number, :lyrics)
  end

end
