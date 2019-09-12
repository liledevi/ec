class Admins::ApplicationController < ApplicationController
  before_action :authenticated_admin?
end

