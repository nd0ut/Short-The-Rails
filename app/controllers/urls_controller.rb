class UrlsController < ApplicationController
  before_filter :authenticate_user!, :except => [:short, :unshort]

  def index
    @urls = Url.find_all_by_user_id(current_user.id)

    @urls.map! do |url|
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
    @url = Url.find(params[:id])
    @url.destroy

    render :json => { :status => 'success'}
  end

	def short
    @url = Url.create :url => params[:url].strip, :user_id => current_user.id

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

    @url = Url.find_by_code(params[:code])

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
