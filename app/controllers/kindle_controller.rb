class KindleController < ApplicationController

  def new
    render layout: false
  end

  def create
    k = KindleBook.new(params[:resource], params[:slug])
    k.generate!
    k.send_to_email(params[:email])
    render json: {message: ''}
  end

end

