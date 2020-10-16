Rails.application.routes.draw do
  get 'index/index'
  root 'index#Index'

  post 'upload_file', to: 'index#upload_file'
end
