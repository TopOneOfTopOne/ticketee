# changing the default public folder to root directory
# so not everyone can access the uploaded filess
CarrierWave.configure do |config|
  config.root = Rails.root
end
