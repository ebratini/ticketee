CarrierWave.configure do |config|
  config.root = Rails.root
  config.storage = :file
  
  # TODO: add S3 creds to heroku env; uncomment when amazon S3 available
  # if Rails.env.production?
  #   config.storage = :fog
  #   config.fog_credentials = {
  #     provider: 'AWS',
  #     aws_access_key_id: ENV['S3_KEY'],
  #     aws_secret_access_key: ENV['S3_SECRET'],
  #     region: ENV['S3_REGION']
  #   }
  #   config.fog_directory = ENV['S3_BUCKET']
  # else
  #   config.storage = :file
  # end
end