
namespace :test_runner do
    desc "Run test for Rent My Agent"
    task :execute_test do
        ruby "tc_rate_my_agent.rb"
    end
end