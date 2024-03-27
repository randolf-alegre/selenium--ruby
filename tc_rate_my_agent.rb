require "selenium-webdriver"
require "test/unit"
require "./mailer"

class TestRateMyAgent < Test::Unit::TestCase

    def setup
        @mailer = Mailer.new
        @driver = Selenium::WebDriver.for:firefox
        @driver.manage.timeouts.implicit_wait = 30
        @wait = Selenium::WebDriver::Wait.new(:timeout => 30) # seconds
    end

    def test_homepage
       begin
        @driver.navigate.to "https://www.rate-my-agent.com"
        getMatchBttn = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/div/div[2]/div[1]/form/a')
        assert_equal("Get Matched Now", getMatchBttn.text)
       rescue => e
        @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_homepage", e.message)
       ensure
        @driver.close()
       end
       
    end

    def test_get_matched_now
        begin
            @driver.navigate.to "https://www.rate-my-agent.com"
            getMatchBttn = @driver.find_element(:xpath, '/html/body/div[2]/div/div[1]/div/div[2]/div[1]/form/a')
            getMatchBttn.click
            step1 = @driver.find_element(:id, 'step1')
            assert_equal(true, step1.displayed?)
            assert_equal("https://www.rate-my-agent.com/quiz?cta=take-quiz-home", @driver.current_url)
        rescue => e
            @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_get_matched_now", e.message)
        ensure
            @driver.close()
        end
    end

    def test_search_for_agent
        begin
            @driver.navigate.to "https://www.rate-my-agent.com"
            searchBtn = @driver.find_element(:xpath, "/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/span/button")
            @driver.find_element(:xpath, "/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/input").send_keys "Karl"
            searchBtn.click
    
            
            assert_equal("https://www.rate-my-agent.com/search?utf8=%E2%9C%93&term=Karl", @driver.current_url)
            assert_equal(15, @driver.find_elements(:class, "card-agent-container").length)
        rescue => e
            @mailer.send("alerts@rate-my-agent.com", "Test Case Failed: test_search_for_agent", e.message)
        ensure
            @driver.close()
        end
    end
end