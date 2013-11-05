class TracksController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
      @tracks = Track.find(params[:id])
  end

  def create
    @track = current_user.tracks.build(track_params)
    if @track.save
      flash[:success] = "New Track created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @track.destroy
    redirect_to root_url
  end

  private

    def track_params
      params.require(:track).permit(:name)
    end

    def correct_user
      @track = current_user.tracks.find_by(id: params[:id])
      redirect_to root_url if @track.nil?
    end
end