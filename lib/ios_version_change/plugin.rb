require "git"

module Danger
  # Asserts the version string has been changed in your iOS XCode project.
  # This is done by checking the git diff of your project's Info.plist file.
  # The plugin will either call Danger's fail method or do nothing if the version string was changed.
  #
  # @example Assert the version string changed for your iOS project
  #    # Calls Danger `fail` if the version string not updated or nothing if it has changed.
  #   ios_version_change.assert_version_changed("ProjectName/Info.plist")
  #
  # @tags ios, xcode, ci, continuous integration
  class DangerIosVersionChange < Plugin
    # The instance name used in the Dangerfile
    # @return [String]
    #
    def self.instance_name
      "ios_version_change"
    end

    def initialize(dangerfile)
      super(dangerfile)
      raise unless dangerfile.env.scm.class == Danger::GitRepo

      @git = dangerfile.env.scm
    end

    # Ignore. Pass the git diff string here to see if the version string has been updated. Use `ios_version_change.assert_version_changed("ProjectName/Info.plist")` instead as it's more convenient sending the path to the Info.plist file.
    # @return [void]
    def assert_version_changed_diff(git_diff_string)
      git_diff_lines = git_diff_string.lines
      git_diff_string.each_line.each_with_index do |line, index|
        next unless line.include? "<key>CFBundleShortVersionString</key>"
        # we need to check the next 2 lines of the string to determine if it's a git diff change.
        if git_diff_lines.length >= (index + 3) && git_diff_lines[index + 1][0] == "-" && git_diff_lines[index + 2][0] == "+"
          return # rubocop:disable NonLocalExitFromIterator
        end
      end

      fail "You did not change the iOS version."
    end

    # Asserts the version string has been changed in your iOS XCode project.
    #
    # @example Assert the version string changed for your iOS project
    #    # Calls Danger `fail` if the version string not updated or nothing if it has changed.
    #   ios_version_change.assert_version_changed("ProjectName/Info.plist")
    #
    # @param [String] info_plist_file_path
    #        Path to Info.plist file for XCode project.
    # @return [void]
    def assert_version_changed(info_plist_file_path)
      unless File.file?(info_plist_file_path)
        fail "Info.plist at path " + info_plist_file_path + " does not exist."
        return # rubocop:disable UnreachableCode
      end

      git_diff_string = @git.diff[info_plist_file_path].patch
      assert_version_changed_diff(git_diff_string)
    end
  end
end
