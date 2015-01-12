linodians
=========

[![Gem Version](https://img.shields.io/gem/v/linodians.svg)](https://rubygems.org/gems/linodians)
[![Dependency Status](https://img.shields.io/gemnasium/akerl/linodians.svg)](https://gemnasium.com/akerl/linodians)
[![Code Climate](https://img.shields.io/codeclimate/github/akerl/linodians.svg)](https://codeclimate.com/github/akerl/linodians)
[![Coverage Status](https://img.shields.io/coveralls/akerl/linodians.svg)](https://coveralls.io/r/akerl/linodians)
[![Build Status](https://img.shields.io/travis/akerl/linodians.svg)](https://travis-ci.org/akerl/linodians)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Library for viewing public Linode employee data

## Usage

First, create a Linodian object

```
require 'linodians'
employees = Linodians.new
```

You now have an array of all publically listed Linodians. The following attributes are provided:

* fullname: Full name as publicized
* username: Short name as publicized
* title: Their position

Any social sites are also parsed, if provided, including 'twitter', 'linkedin', and 'github'.

A `.photo` method is also provided that pulls their public photo.

For example, if you want to follow all the Linodians on Twitter, you can quickly grab all available Twitter profiles:

```
require 'linodians'
employees = Linodians.new
twitter_profiles = employees.map { |x| x[:twitter] }.compact
puts twitter_profiles
```
Say you want to follow any of them you don't already follow? You can combine the above with [sferik's awesome "t" CLI for Twitter](https://github.com/sferik/t):

```
linodian_accounts = twitter_profiles.map { |x| x.split('/').last }
currently_following = `t followings`.split
new_accounts = linodian_accounts.reject { |x| currently_following.include? x }
new_accounts.each { |x| system "t follow #{x}" }
```

Or you can find all the listed titles and how many people have each title:

```
require 'linodians'
employees = Linodians.new
titles = employees.map(&:title).each_with_object(Hash.new(0)) { |i, o| o[i] += 1 }
titles.sort_by(&:last).each { |title, count| puts "#{count} -- #{title}" }
```

## Installation

    gem install linodians

## License

linodians is released under the MIT License. See the bundled LICENSE file for details.

