BHM::Admin::AttrAccessibleScoping.disable do
  # Initial users
  user = User.create!({
   :login                 => "admin",
   :password              => "tedxperth",
   :password_confirmation => "tedxperth",
   :email                 => "test@example.com",
   :display_name          => "TEDxPerth Team"
  })
  user.has_role! :admin
  # Initial Pages
  Page.create!({
    :title   => "Wecome to TEDxPerth",
    :content => "Welcome!",
    :format  => "markdown",
    :key     => "home"
  })
end