require "selenium-webdriver"
require "test/unit"
require "./mailer"
require 'time'
$testFileLogPath = "log/test.txt"

class TestRateMyAgent < Test::Unit::TestCase
    class << self
        def startup
            @testFileLogPath = "log/test.txt"
            @mailer = Mailer.new
            if File.exist?($testFileLogPath)
                File.delete($testFileLogPath)
            end
    
            File.new($testFileLogPath, "a")
        end

        def shutdown
            puts 'runs only once at end'
        end
        
    end

    def setup
        @driver = Selenium::WebDriver.for:firefox
        @driver.manage.timeouts.implicit_wait = 30
        @wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
    end

    def test_homepage
        status = "Success"
       begin
        @driver.navigate.to "https://www.rate-my-agent.com"
        getMatchBttn = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/div/div[2]/div[1]/form/a')
        assert_equal("Get Matched Now", getMatchBttn.text)
       rescue => e
        status = "Error: #{e.message}"
        @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_homepage", e.message)
       ensure
        result = "#{Time.now.utc.iso8601} - Test case: test_homepage: Status - #{status}"
        logger(result)
        @driver.close()
       end
       
    end

    def test_get_matched_now
        status = "Success"
        begin
            @driver.navigate.to "https://www.rate-my-agent.com"
            getMatchBttn = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/div/div[2]/div[1]/form/a')
            getMatchBttn.click
            step1 = @driver.find_element(:id, 'step1')
            assert_equal(true, step1.displayed?)
            assert_equal("https://www.rate-my-agent.com/quiz?cta=take-quiz-home", @driver.current_url)
        rescue => e
            status = "Error: #{e.message}"
            @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_get_matched_now", e.message)
        ensure
            result = "#{Time.now.utc.iso8601} - Test case: test_get_matched_now: Status - #{status}"
            logger(result)
            @driver.close()
        end
    end

    def test_search_for_agent
        status = "Success"
        begin
            @driver.navigate.to "https://www.rate-my-agent.com"
            searchBtn = @driver.find_element(:xpath, "/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/span/button")
            @driver.find_element(:xpath, "/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/input").send_keys "Karl"
            searchBtn.click
    
            
            assert_equal("https://www.rate-my-agent.com/search?utf8=%E2%9C%93&term=Karl", @driver.current_url)
            assert_equal(15, @driver.find_elements(:class, "card-agent-container").length)
        rescue => e
            status = "Error: #{e.message}"
            @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_search_for_agent", e.message)
        ensure
            result = "#{Time.now.utc.iso8601} - Test case: test_search_for_agent: Status - #{status}"
            logger(result)
            @driver.close()
        end
    end

    private

        def logger(message)
            testFile = File.open($testFileLogPath, 'a')
            testFile.write( "#{message}\n")
            testFile.close
        end


end