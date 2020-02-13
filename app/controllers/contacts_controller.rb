class ContactsController < ApplicationController
   
   #GET request to /contact-us
   #Show new contact form
    def new
        @contact = Contact.new
    end
   
   #POST request to /contacts
    def create
        #Mass assignment of form fields into empty contact object
        @contact = Contact.new(contact_params)
        #Save contact object to db
        if @contact.save
            #Store form fields via paramaters hash, into variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            #Plug variables into ContactMailer email method and send
            ContactMailer.contact_email(name, email, body).deliver
            #Store success message in flash hash for display in contact#new
            flash[:success] = "Message sent."
            redirect_to new_contact_path
        else
            #If contact object doesn't save, 
            #store errors in flash hash,
            #redirect to contact#new anyways and display flash message
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        
        end
    end
    
    private
        #To collect data from forms, use strong params and whitelist our
        #form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end