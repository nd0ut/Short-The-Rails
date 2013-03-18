class UrlsController < ApplicationController
	def short
    if params[:url].nil?
      render :json => { :error => 'Empty url' }
      return
    end

		@url = Url.new :url => params[:url]
		@url.save

		render :json => { :url => @url.url,
                      :shorted_url => root_url + @url.code}
  end

  def unshort
    @url = Url.find_by_code(params[:code])

    if @url.nil?
      render :json => { :error => 'Wrong code'}
    else
      render :json => { :url => @url.url,
                        :shorted_url => root_url + @url.code}
    end

  end
end
