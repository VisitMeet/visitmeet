# frozen_string_literal: true
# code   : spec/support/selectors.rb
# source : http://stackoverflow.com/questions/14957981/capybara-click-link-with-href-match
# usage  : find(:href, 'google.com')
# used   : spec/config/oauth_spec.rb
# used   : spec/features/users/sign_in_spec.rb
# used   : spec/features/users/user_show_spec.rb
# used   : spec/features/welcome/home_page_spec.rb
module Selectors
  Capybara.add_selector(:href) do
    xpath { |href| XPath.descendant[XPath.attr(:href).contains(href)] }
  end
end
