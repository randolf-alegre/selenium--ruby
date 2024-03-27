require "mail"

class Mailer
    @sender = "no-reply@example.com"
    def initialize
        options = { address: '127.0.0.1', port: 1025, domain: '127.0.0.1' }
        Mail.defaults do
            delivery_method :smtp, options
        end
    end
    

    def send (recipient, subject, message)
        Mail.deliver do
            to recipient
            from @sender
            subject subject
            body `Error Message: \n #{message}`
          end
    end
end