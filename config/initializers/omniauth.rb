OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
    #provider :google_oauth2, '1055989244914-0p80h2cf6bbemstj59b9f1uf248la77h.apps.googleusercontent.com', 'J09H9sH9CMoFLqgyPov5-udi',
    provider :google_oauth2, '956271863410-gor5funl3ro57pkkbntm1jhepsqbspqj.apps.googleusercontent.com', 'KGhajDb7f6pmyS_9OuNevcGg',
    {client_options: {ss1: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
