require 'spec_helper'

describe "ey whoami" do
  context "logged in" do
    given "integration"

    it "outputs the currently logged in user" do
      ey %w[whoami]
      @out.should include("User Name (test@test.test)")
    end
  end

  context "not logged in" do
    given "integration without an eyrc file"

    it "prompts for authentication before outputting the logged in user" do
      ey(%w[whoami], :hide_err => true) do |input|
        input.puts("test@test.test")
        input.puts("test")
      end

      @out.should include("We need to fetch your API token; please log in.")
      @out.should include("Email:")
      @out.should include("Password:")

      @out.should include("User Name (test@test.test)")
    end
  end
end
