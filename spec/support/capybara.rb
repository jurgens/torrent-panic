def basic_auth(user, password)
  encoded_login = ["#{user}:#{password}"].pack("m*")
  page.driver.header 'Authorization', "Basic #{encoded_login}"
end
