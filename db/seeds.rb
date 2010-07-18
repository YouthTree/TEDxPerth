BHM::Admin::AttrAccessibleScoping.disable do
  user = User.create!({
   :login                 => "admin",
   :password              => "monkey",
   :password_confirmation => "monkey",
   :email                 => "test@example.com",
   :display_name          => "TEDxPerth Team"
  })
  user.has_role! :admin
end