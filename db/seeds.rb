BHM::Admin::AttrAccessibleScoping.disable do
  # Initial Roles
  Role.create! :name => "admin"
  Role.create! :name => "organizer"
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
    :title         => "Welcome to TEDxPerth",
    :content       => "Welcome!",
    :format        => "markdown",
    :key           => "home",
    :show_in_menu  => true,
    :menu_title    => "Home",
    :menu_subtitle => "Our next event & more!",
    :published_at  => Time.now
  })
end