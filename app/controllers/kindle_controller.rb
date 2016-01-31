class KindleController < ApplicationController

  def new
    @resource = params[:resource]
    @slug = params[:slug]
    @location = params[:location]

    render layout: false
  end

  def create
    k = KindleBook.new(params[:resource], params[:slug])
    k.generate!

    if params[:email].blank?
      flash[:kindle] = I18n.t('kindle.message.email_blank')
    else
      k.send_book_to(params[:email])
    end

    redirect_to params[:location]

  end

end

