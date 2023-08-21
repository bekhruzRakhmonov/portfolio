require 'net/http'

class PagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def welcome
  end

  def about
    uri = URI("#{base_uri}/users/bekhruzRakhmonov")
    res = Net::HTTP.get_response(uri)
    string_data = res.body if res.is_a?(Net::HTTPSuccess)
    json_data =  JSON.parse string_data
    @image = json_data[0]["image"]
    @about = json_data[0]["about"]
  end

  def work
    uri = URI("#{base_uri}/projects")
    res = Net::HTTP.get_response(uri)
    string_data = res.body if res.is_a?(Net::HTTPSuccess)
    projects = JSON.parse string_data
    @data = OpenStruct.new(projects: projects)
    # projects.each do |project| 
    #   project["images"].each do |image|
    #     puts image["url"]
    #   end
    # end
  end

  def contact

  end

  def send_contact
    name = "*Name*: `#{contact_params["name"]}`\n"
    email = "*Email*: `#{contact_params["email"]}`\n"
    message = "*Message*: `#{contact_params["message"]}`"

    bot_token = Rails.application.credentials.dig(:telegram, :bot_token)
    chat_id = Rails.application.credentials.dig(:telegram, :chat_id)
    
    uri = URI("https://api.telegram.org/bot#{bot_token}/sendMessage")
    
    req = Net::HTTP::Post.new(uri)
    req.body = {
      text: name << email << message,
      chat_id: chat_id,
      parse_mode: "MARKDOWN"
    }.to_json
    req.content_type = 'application/json'
    
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
    
    if res.code == '200'
        
    end
  end

  private 
  def contact_params
    params.permit(:name, :email, :message)
  end
end
