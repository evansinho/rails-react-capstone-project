module ControllerSpecHelper
  def authenticated_header(user)
    token = JsonWebToken.encode(user_id: user.id)
    { 'Authorization': "Bearer #{token}" }
  end
end
