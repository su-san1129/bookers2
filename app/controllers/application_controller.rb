class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
    books_path # ログイン後に遷移するpathを設定
  end
end