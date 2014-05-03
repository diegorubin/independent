def authenticate_user
  user = FactoryGirl.build(:user) 
  user.save

  sign_in user

  user
end

