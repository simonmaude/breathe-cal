OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '819799125663-sd5t7f7a1i0ho6qk0p187d9usbs53i9t.apps.googleusercontent.com', 'lMHNvX_MEw33l83d_MyqKaj7',
    {client_options: {ss1: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
