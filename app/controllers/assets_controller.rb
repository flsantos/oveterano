class AssetsController < ApplicationController
  before_filter :validate
  
  def show
    asset = Asset.find(params[:id])
    redirect_to :controller => "inicio" unless logged_in?
    
    # do security check here
    send_file asset.data.path, :type => asset.data_content_type
  end
  
  private
  
  def validate
    redirect_to "/" if not logged_in?
  end
  
end
