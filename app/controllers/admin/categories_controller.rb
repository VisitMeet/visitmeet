# frozen_string_literal: true
# code: app/controllers/admin/categories_controller.rb
# test: spec/controllers/categories_controller_spec.rb
#
# see SECURITY UPGRADE NOTE in app/controllers/application_controller.rb
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
module Admin
  # admin administers categories
  class CategoriesController < Admin::ApplicationController
    include ActionController::Helpers
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.all.paginate(10, params[:page])
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
