# Inbox Web App Automation
Inbox Web Automation project using Ruby+Cucumber+Capybara tools
## Getting Started
Install any Ruby editor/IDE:
RubyMine: https://www.jetbrains.com/ruby/download/#section=windows (free 30 day trial available)  
Aptana Studio: http://www.aptana.com/products/studio3/download.html (free)  
Komodo IDE: https://www.activestate.com/komodo-ide/downloads/ide (free 21 day trial)  
Netbeans: https://netbeans.org/downloads/ (as plugin)
VSCode: https://code.visualstudio.com/

Ruby download link: https://www.ruby-lang.org/en/downloads/  
Ruby Version Manager (rvm) link: https://rvm.io/rvm/install

## Prerequisites
* Install bundler: `gem install bundler`
* Update bundler: `bundle update --bundler`
* Run install bundler: `bundle install`
* Setup latest Chrome: `https://www.google.com/chrome/`

## Project structure
```
Inbox-automation
|   config
|    |    test_data.yml
|    |    .........  
|   features
|    |   pages
|    |   step_definitions
|    |   support
|    |   feature files
|    report
|    |   report.json
|    |   screenshot.jpg
|    tmp
|    |   downloads
|    |   |   export.csv
|    |   |   .....
|    Gemfile
|    .gitignore
```

## Running
### Command line

To run tests:
```bash
cucumber PLATFORM=valid BROWSER=chrome --format --pretty --expand --format json -o report.json
```
To run by tags add:
```bash
--tags @tag
```
#### Currently supported browsers:
* Chrome
* Mozilla Firefox
