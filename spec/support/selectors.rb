# frozen_string_literal: true
# spec/support/selectors.rb
# source : http://stackoverflow.com/questions/14957981/capybara-click-link-with-href-match
module Selectors
  # find(:href, 'google.com')
  Capybara.add_selector(:href) do
    xpath { |href| XPath.descendant[XPath.attr(:href).contains(href)] }
  end
end
