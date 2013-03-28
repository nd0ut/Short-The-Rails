class UrlsController < ApplicationController
	def short
		@url = Url.create :url => params[:url].strip

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
