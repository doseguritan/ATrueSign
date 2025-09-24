class HomeController < ApplicationController
  def index
    render json: { message: "Welcome to TrueSign API", request_from: request.host }, status: :ok
  end
end
