Diaspora::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[gtb][#{Rails.env}] ",
  :sender_address => %{"notifier" <no-reply@joindiaspora.com>},
  :exception_recipients => %w{ nacho@tangosource.com federico@tangosource.com galensanford@gmail.com marco.gallardo@tangosource.com }
