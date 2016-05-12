# frozen_string_literal: true
# code: app/controllers/admin/products_controller.rb
# test: spec/controllers/admin/products_controller.rb
# See FAILING TESTS NOTE: spec/controllers/users_controller_spec.rb
#
# These are Functional Tests for Rail Controllers testing the various actions of a single controller.
# Controllers handle the incoming web requests to your application and eventually respond with a rendered view.
#
# See FAILING TESTS NOTE: spec/controllers/users_controller.rb
# the above note concerns the NoMethodError: undefined method `authenticate!' for nil:NilClass
#
module Admin
  # admins administer products
  class ProductsController < Admin::ApplicationController
    include ActionController::Helpers
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    # 20160501 UNCOMMENTED
    # 20160508 recommented
    # def index
    #  super
    #  @resources = User.all.paginate(10, params[:page])
    #
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end
    #
    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
