require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == %w[admin admin]
  # ActiveSupport::SecurityUtils.secure_compare
end