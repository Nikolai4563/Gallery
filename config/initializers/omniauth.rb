OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '186220808211054', '201699276765aafe1b5dd0c925bb2cd7'
end