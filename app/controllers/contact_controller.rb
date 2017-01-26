class ContactController < SiteController
  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:notice] = :flash.t(scope: [:site, :contacts, :create, :success]) 
    else
      flash[:alert] = :flash.t(scope: [:site, :contacts, :create, :alert]) 
    end
    render :index
  end

  private
  def contact_params
    params.require(:contact).permit([:name, :email, :body])
  end
end

