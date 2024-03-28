### Installation

* Install the latest stable ruby version.
* Run the following command to install all dependencies:
    1. Go to the root folder: Ruby folder
    2. Run the following command: 
        * bundle install

### PRE-REQUISITE! Setup MailCatcher for sending emails whenever test failed.

1. Run this command:  gem install mailcatcher
2. Type in your console: mailcatcher
3. Go to http://127.0.0.1:1080/
4. Send mail through smtp://127.0.0.1:1025


### Run the App

### For ONE TIME execution of test:

Run to your console:
* rake test_runner:execute_test


### Run using Cron Job

1. Paste this command to your console:
    * crontab -e
    * Press i to insert.
    * Update the file and add this:
        3 * * * * /bin/bash -l -c 'cd <FULL PATH OF THE PROJECT> && bundle exec rake test_runner:execute_test'
    * Press i again then type :wq! to save changes.


### DESIGN CHOICE
* I decided to use test case approach since it has something to do with automation of blackbox testing such as testing the useability of the website. 

### Potential shortcomings
* While implementation of the CronJob, it did not really work. I dont know why its not working and no logs where generated. If I have ample time to investigate and observe its behavior I might be able to find a solution.