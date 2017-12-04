require File.expand_path("../spec_helper", __FILE__)

module Danger
  describe Danger::DangerIosVersionChange do
    it "should be a plugin" do
      expect(Danger::DangerIosVersionChange.new(nil)).to be_a Danger::Plugin
    end

    #
    # You should test your custom attributes and methods here
    #
    describe "with Dangerfile" do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.ios_version_change
      end

      # Some examples for writing tests
      # You should replace these with your own.

      it "Cannot find Info.plist file" do
        @my_plugin.assert_version_changed("Foo/Bar/Info.plist")
        expect(@dangerfile.status_report[:errors]).to eq(["Info.plist at path Foo/Bar/Info.plist does not exist."])
      end

      it "Fails from an empty git diff message" do
        @my_plugin.assert_version_changed_diff("")
        expect(@dangerfile.status_report[:errors]).to eq(["You did not change the iOS version."])
      end

      it "Successfully detects version changed" do
        diff = File.read("spec/ChangedVersionCodeGitDiff.txt")
        @my_plugin.assert_version_changed_diff(diff)
        expect(@dangerfile.status_report[:errors]).to eq([])
      end

      it "Runs into end of git diff. This should never happen, but I need to test the built in error handling." do
        diff = File.read("spec/RunIntoEndOfFileGitDiff.txt")
        @my_plugin.assert_version_changed_diff(diff)
        expect(@dangerfile.status_report[:errors]).to eq(["You did not change the iOS version."])
      end

      it "Version code was not changed." do
        diff = File.read("spec/NotChangedVersionCodeGitDiff.txt")
        @my_plugin.assert_version_changed_diff(diff)
        expect(@dangerfile.status_report[:errors]).to eq(["You did not change the iOS version."])
      end
    end
  end
end
