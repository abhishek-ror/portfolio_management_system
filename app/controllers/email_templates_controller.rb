class EmailTemplatesController < ApplicationController
  before_action :set_email_template, only: [:show, :edit, :update, :destroy, :preview, :send_email]

  def index
    @email_templates = EmailTemplate.all
  end

  def show
    @contacts = Contact.all
  end

  def new
    @email_template = EmailTemplate.new
  end

  def create
    @email_template = EmailTemplate.new(email_template_params)
    
    if @email_template.save
      redirect_to email_templates_path, notice: 'Email template was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @email_template.update(email_template_params)
      redirect_to email_templates_path, notice: 'Email template was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @email_template.destroy
    redirect_to email_templates_path, notice: 'Email template was successfully deleted.'
  end

  def preview
    @contact = Contact.find(params[:contact_id])
    @rendered = @email_template.render_for_contact(@contact)
    
    respond_to do |format|
      format.html
      format.json { render json: @rendered }
    end
  end

  def send_email
    @contact = Contact.find(params[:contact_id])
    @rendered = @email_template.render_for_contact(@contact)
    
    redirect_to contacts_path, notice: "Email '#{@rendered[:subject]}' sent to #{@contact.name} (#{@contact.email})"
  end

  private

  def set_email_template
    @email_template = EmailTemplate.find(params[:id])
  end

  def email_template_params
    params.require(:email_template).permit(:subject, :body)
  end
end
