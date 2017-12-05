![https://circleci.com/gh/levibostian/danger-ios_version_change/tree/master.png](https://circleci.com/gh/levibostian/danger-ios_version_change/tree/master.png)


### ios_version_change

Asserts the version string has been changed in your iOS XCode project.
This is done by checking the git diff of your project's Info.plist file.
The plugin will either call Danger's fail method or do nothing if the version string was changed.

  ios_version_change.assert_version_changed("ProjectName/Info.plist")

<blockquote>Assert the version string changed for your iOS project
  <pre># Calls Danger `fail` if the version string not updated or nothing if it has changed.</pre>
</blockquote>





#### Methods

`assert_version_changed_diff` - Ignore. Pass the git diff string here to see if the version string has been updated. Use `ios_version_change.assert_version_changed("ProjectName/Info.plist")` instead as it's more convenient sending the path to the Info.plist file.

`assert_version_changed` - Asserts the version string has been changed in your iOS XCode project.

  ios_version_change.assert_version_changed("ProjectName/Info.plist")




### Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
