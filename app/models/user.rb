class User < ApplicationRecord
  # has_secure_password 會自動附帶3個驗證：
  #檢查密碼是否存在, 密碼長度必須是不是大於 72 bytes, 確認密碼填寫是否正確 (using a XXX_confirmation attribute)
  has_secure_password
end
