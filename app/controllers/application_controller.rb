class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token # Добавим чтобы баловаться пост запросами
end
