class MicropostsController < ApplicationController
  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end


  def destroy
    Micropost.find_by_id(params[:id]).destroy
    flash[:success] = " Micropost destroyed."
    redirect_to root_path
  end


  private

    def correct_user
      @micropost = Micropost.find_by_id(params[:id])
      redirect_to root_path unless current_user?(@micropost.user)
    end

end