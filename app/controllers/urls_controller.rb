class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.create(url_params)
    if @url.save
      redirect_to root_path
    else
      render :new, notice: "Something went wrong, try again!"
    end
  end

  def show
    @url = Url.find_by(slug: params[:slug])
    if @url
      redirect_to @url.original_url
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
