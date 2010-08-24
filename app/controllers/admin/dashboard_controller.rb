class Admin::DashboardController < AdminController
  
  def index
    hide_sidebar!
  end

end
