class ApplicationController < ActionController::API
    def index
        render json: {}, status: 200
    end
end
