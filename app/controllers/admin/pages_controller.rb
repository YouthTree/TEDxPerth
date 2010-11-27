class Admin::PagesController < Admin::BaseController
  use_controller_exts :slugged_resource, :almost_happy
end
