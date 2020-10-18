require 'faraday'
require 'json'

class IndexController < ApplicationController
  def index; end

  def upload_file
    if Rails.env == 'production'
      captcha = params[:captcha]

      unless helpers.valid_captcha(captcha)
        render json: {message: 'Uzupełnij poprawnie captche. '}, status: 401 and return
      end
    end

    code = params[:code]
    render json: { message: 'Uzupełnij kod.' }, status: 411 and return if code.blank?

    render json: { message: 'Kod jest za długi.' }, status: 413 and return if code.length > 2500

    slug = (0...8).map { (rand(65..90)).chr }.join
    css_file = File.new("public/stylesheets/#{slug}.css", 'w')
    css_file.puts(code)
    css_file.close

    render json: { message: slug }, status: 201 and nil
  end
end
