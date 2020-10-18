module IndexHelper

  def valid_captcha(captcha)
    if captcha.blank?
      return false
    end

    response = Faraday.post('https://www.google.com/recaptcha/api/siteverify', secret: ENV['zxu_recaptcha_privatekey'], response: captcha)
    data = JSON.parse(response.body)
    unless data['success']
      return false
    end

    true
  end

end
