#!/bin/bash

set -e

rm README.md; cat README_header.md > README.md; bundle exec danger plugins readme >> README.md; cat README_footer.md >> README.md
mkdir ~/.gem; printf "%s\n%s " "---" ":rubygems_api_key:" > ~/.gem/credentials; printf $RUBYGEMS_KEY >> ~/.gem/credentials;chmod 0600 ~/.gem/credentials
gem build danger-ios_version_change.gemspec; gem push danger-ios_version_change*.gem
