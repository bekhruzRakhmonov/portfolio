class ApplicationController < ActionController::Base
    def base_uri
        @base_uri ||= ENV["API_URI"]
    end
end
