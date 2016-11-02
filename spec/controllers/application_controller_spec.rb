# frozen_string_literal: true
# code: app/controllers/application_controller.rb
# test: spec/controllers_application_controller_spec.rb
# include Warden::Test::Helpers
include Devise::Test::ControllerHelpers

Warden.test_mode!
describe ApplicationController do
  after(:each) do
    Warden.test_reset!
  end

  # demonstration test that has no bearing on the app
  describe 'a test for the application controller' do
    it 'pertains only to an inapplicable testability' do
      # pending 'what to test, how to test it'
      expect(self.class).to eq RSpec::ExampleGroups::ApplicationController::ATestForTheApplicationController
      code = 'write the code we wish we had'
      untested_line = 'creating variables and then test them'
      code_long_sequence = code.split(//).sort.join.strip
      code_short_sequence = code.split(//).sort.join.strip.squeeze
      the_pending_line = "pending 'what to test, how to test it'"
      pending_line_sequence = the_pending_line.split(//).sort.join.strip
      short_pending_sequence = pending_line_sequence.split(//).sort.join.strip.squeeze
      shorter_pending_sequence = short_pending_sequence.gsub!(/',/, '')
      # here, i uncommented the next command to retrieve above variables
      # byebug var all
      expect(code_long_sequence).to eq 'acddeeeeehhhiiorsttwwww'
      expect(code_short_sequence).to eq 'acdehiorstw'
      expect(pending_line_sequence).to eq "'',adeeeghhiinnooopssttttttttww"
      expect(self.class).to eq RSpec::ExampleGroups::ApplicationController::ATestForTheApplicationController
      expect(short_pending_sequence.split(//).sort.join.strip).to eq 'adeghinopstw'
      expect(shorter_pending_sequence).to eq 'adeghinopstw'
      expect(code_long_sequence.length > code_short_sequence.length).to eq true
      expect(the_pending_line).to match(/what to test, how to test it/)
      expect(the_pending_line).to eq "pending 'what to test, how to test it'"
      expect(code).to eq 'write the code we wish we had'
      expect(code.split(//).sort.join.strip).to eq code_long_sequence
      expect(code.split(//).sort.join.strip.squeeze).to eq code_short_sequence
      expect(code_short_sequence).to eq code.split(//).sort.join.strip.squeeze
      expect(the_pending_line).to eq "pending 'what to test, how to test it'"
      expect(the_pending_line.split(//).sort.join.strip).to eq pending_line_sequence
      expect(pending_line_sequence.length > short_pending_sequence.length).to eq true

      sequence = untested_line.split(//).sort.join.strip
      expect(sequence).to eq 'creating variables and then test them'.split(//).sort.join.strip
    end

    it 'pass a math test' do
      expect(7 / 7).to be 1

      a = 7 / 7
      expect(a).to eq 1
    end
  end
end
