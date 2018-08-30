ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '465',
  :authentication => :plain,
  :user_name      => 'example@example.com',
  :password       => 'yourpassword',
  :domain         => 'yourdomain@example.com',
  :ssl            => true
}
