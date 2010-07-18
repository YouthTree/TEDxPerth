BHM::Admin::AttrAccessibleScoping.disable do
  user = User.create!({
   :login                 => "admin",
   :password              => "tedxperth",
   :password_confirmation => "tedxperth",
   :email                 => "test@example.com",
   :display_name          => "TEDxPerth Team"
  })
  user.has_role! :admin
end