Paperclip::Attachment.default_options.update({
  # :path => "images/:class/:id/:attachment/:style/img_:fingerprint",
  :path => '',
  :storage => :fog,
  :fog_credentials => {
    :provider           => 'Rackspace',
    :rackspace_username => ENV['RACKSPACE_USERNAME'],
    :rackspace_api_key => ENV['RACKSPACE_API_KEY'],
    :persistent => false,
    :rackspace_region    => :ord
  },
  :fog_directory => ENV['RACKSPACE_FOG_DIRECTORY'],
  :fog_public => true,
  :fog_host => ENV['RACKSPACE_FOG_HOST']
})

# RACKSPACE_CONFIG = {
#   'production' => {
#     path: '',
#     storage: :fog,
#     fog_credentials: {
#       provider: 'Rackspace',
#       rackspace_username: ENV['RACKSPACE_USERNAME'],
#       rackspace_api_key: ENV['RACKSPACE_API_KEY'],
#       persistent: false
#     },
#     fog_directory: 'static',
#     fog_public: true
#   },
# }
 
# Paperclip::Attachment.default_options.update(RACKSPACE_CONFIG[Rails.env])