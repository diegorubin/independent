class KindleController < ApplicationController

  def new
  end

  def create
    k = KindleBook.new(params[:resource], params[:slug])
    k.generate!
    render json: {message: ''}
  end

end

