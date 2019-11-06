class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'username', password: 'secret'
  protect_from_forgery unless: -> { request.format.json? }
end
