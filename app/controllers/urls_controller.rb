class UrlsController < ApplicationController
	def short
    if params[:url].nil? || params[:url].blank?
      render :json => { :error => 'Empty url' }
      return
    end

		@url = Url.new :url => params[:url]
		@url.save

		render :json => { :url => @url.url,
                      :shorted_url => root_url + @url.code}
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
