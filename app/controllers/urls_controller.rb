class UrlsController < ApplicationController
  def index
    if params[:popularity]
      @urls = Url.sorted_by_popularity
    else
      @urls = Url.sorted_by_last_created
    end
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.create(url_params)
    if @url.save
      Resque.enqueue(TitleFetcher, @url)
      redirect_to root_path
    else
      render :new, notice: "Something went wrong, try again!"
    end
  end

  def show
    @url = Url.find_by(slug: params[:slug])
    if @url
      redirect_to @url.original_url
      @url.increase_popularity
    end
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end
end
