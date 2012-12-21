class UserMailer < Devise::Mailer

  def cancelled_confirmation(record)
    devise_mail(record, :cancelled_confirmation)
  end
  
  def activation_confirmation(record)
    devise_mail(record, :activation_confirmation)
  end

end
