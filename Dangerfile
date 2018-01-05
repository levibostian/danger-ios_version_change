if github.branch_for_base != "development" && github.pr_author != "levibostian"
  fail "Sorry, wrong branch. Create a PR into the `development` branch instead."
end

if github.branch_for_base == "production" && github.branch_for_head != "development"
  fail "You must merge from the `development` branch into `production`."
end

if github.branch_for_base == "production"
  if !git.diff_for_file("lib/ios_version_change/gem_version.rb")
    fail 'You did not update the plugion version in lib/ios_version_change/gem_version.rb'
  end
end
