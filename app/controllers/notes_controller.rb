class NotesController < ApplicationController
  before_action :require_login, except: [:index, :show]


  def index
    @notes = Note.where(track_id: params[:track_id])
    render :index
  end

  def new
    @note = Note.new
    render :new
  end

  def create
    @note = Note.new(note_params)
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id

    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(@note.track_id)
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to track_url(params[:track_id])
  end

private
  def note_params
    params.require(:note).permit(:body)
  end

end
