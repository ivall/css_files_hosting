require 'faraday'
require 'json'

class IndexController < ApplicationController
  def index; end

  def upload_file
    captcha = params[:captcha]

    if captcha.blank?
      render json: { message: 'Uzupełnij captche.' }, status: 411
      return
    end

    response = Faraday.post('https://www.google.com/recaptcha/api/siteverify', secret: ENV['zxu_recaptcha_privatekey'], response: captcha)
    data = JSON.parse(response.body)
    unless data['success']
      render json: { message: 'Uzupełnij captche poprawnie.' }, status: 401
      return
    end

    code = params[:code]
    if code.blank?
      render json: { message: 'Uzupełnij kod.' }, status: 411
      return
    end

    if code.length > 2500
      render json: { message: 'Kod jest za długi.' }, status: 413
      return
    end

    slug = (0...8).map { (rand(65..90)).chr }.join
    css_file = File.new("public/stylesheets/#{slug}.css", "w")
    css_file.puts(code)
    css_file.close

    render json: { message: slug }, status: 200
  end
end
