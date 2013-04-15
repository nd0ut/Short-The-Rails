class UrlsController < ApplicationController
  before_filter :authenticate_user!, :except => [:short, :unshort]

  def index
    @urls = current_user.urls.map!

    @urls.each do |url|
      url = { :id => url.id,
              :original => url.url,
              :shorted => root_url + url.code }
    end

    respond_to do |format|
      format.html
      format.json { render :json => @urls }
    end
  end

  def destroy
    if current_user.urls.where(id: params[:id]).exists?
      current_user.urls.find(params[:id]).destroy
      render :json => { :status => 'success'}
    else
      render :json => { :status => 'error', :discription => 'you are cheater!'}
    end

  end

	def short
    if user_signed_in?
      @url = Url.create :url => params[:url].strip, :user_id => current_user.id
    else
      @url = Url.create :url => params[:url].strip
    end

    if @url.errors[:url].any?
      render :json => { :error => @url.errors[:url].first }
    else
      render :json => { :url => @url.url,
                        :shorted_url => root_url + @url.code }
    end
  end

  def unshort
    if params[:code].nil? || params[:code].blank?
      render :json => { :error => 'Empty code' }
      return
    end

    @url = Url.where(code: params[:code]).first

    if @url.nil?
      render :json => { :error => 'Wrong code'}
    else
      if request.post?
        render :json => { :url => @url.url,
                          :shorted_url => root_url + @url.code}
      else
        redirect_to @url.url
      end
    end

  end
end
