# Ryanair
## Getting Started

### Installation

#### Install Ruby
Install Ruby 2.3.3 from https://www.ruby-lang.org/en/downloads/ or via RVM (https://rvm.io/)

#### Install PhantomJS
```
brew install phantomjs
```

#### Install Chromedriver
```
brew install chromedriver
```

#### Install Bundler
```
gem install bundler
```

#### Install Gems
```
bundle install
```

### Basic Guide

Run tests with poltergeist
```
bundle exec cucumber -p poltergeist -p dev user=[user] password=[password]
```

Run tests with chrome
```
bundle exec cucumber -p chrome -p dev user=[user] password=[password]
```

HTML Report
```
bundle exec cucumber -p html_report -p dev user=[user] password=[password]
```
