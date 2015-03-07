class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    video_base = Video.by_source('youtube')
    if !params[:category].blank?
      videos = video_base.by_category(params[:category])
    elsif request.env['PATH_INFO'].include?('selected')
      videos = video_base.selected
    else
      videos = video_base.all
    end
    params[:sort] = 'date' if !params[:sort]
    if params[:sort] == 'pop'
      videos = videos.order_by_hits
    elsif params[:sort] == 'rating'
      videos = videos.order_by_rating
    else
      videos = videos.order_by_date
    end
    @videos = videos.paginate(:page => params[:page], :per_page => 20)
  end

  def best
    @random_videos = Video.random_best_before(2013,7).first(4)

    @monthly_videos = Video.best_by_month.reverse.paginate(:page => params[:page], :per_page => 4)
  end

  def admin
    base_videos = Video.by_source('youtube')
    if params[:sort] == 'pop'
      videos = base_videos.order_by_hits
    elsif params[:sort] == 'duration'
      videos = base_videos.order_by_duration
    elsif params[:sort] == 'date'
      videos = base_videos.order_by_date
    elsif params[:sort] == 'selected'
      videos = base_videos.selected.order_by_date
    elsif params[:sort] == 'rating'
      videos = base_videos.order_by_rating
    elsif params[:sort] == 'id'
      videos = base_videos.order_by_id
    elsif params[:month] && params[:year]
      videos = base_videos.best_of_the_month(params[:year].to_i, params[:month].to_i)
    else
      videos = base_videos.order_by_date
    end
    @videos = videos.paginate(:page => params[:page])
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.selected = true
    @video.created_at = Date.today

    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to admin_videos_path, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to admin_videos_path, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:url, :title, :img_url, :source_id, :source, :category, :selected)
    end
end
