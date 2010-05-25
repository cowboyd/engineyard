require 'spec_helper'

describe "ey environments" do
  it_should_behave_like "an integration test"

  before(:all) do
    api_scenario "one app, two environments"
  end

  it "lists the environments your app is in" do
    ey "environments"
    @out.should =~ /giblets/
    @out.should =~ /ham/
  end

  it "reports failure to find a git repo when not in one" do
    api_git_remote('dontcare')
    Dir.chdir("/tmp") do
      ey "environments", :hide_err => true, :expect_failure => true
      @err.should =~ /fatal: No git remotes found in .*\/tmp/
      @out.should_not =~ /no application configured/
    end
  end

end
