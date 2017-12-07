if github.branch_for_base == "master"
  diff = git.diff_for_file("lib/ios_version_change/gem_version.rb")
  if !diff
    fail 'You did not update the gem version.'
  end
end
