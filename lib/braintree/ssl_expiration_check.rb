module Braintree
  module SSLExpirationCheck # :nodoc:
    class << self
      attr_reader :ssl_expiration_dates_checked
    end

    def self.check_dates # :nodoc:
      {
        "QA" => qa_expiration_date,
        "Sandbox" => sandbox_expiration_date
      }.each do |host, expiration_date|
        if Date.today + (3 * 30) > expiration_date
          Configuration.logger.warn "[Braintree] The SSL Certificate for the #{host} environment will expire on #{expiration_date}. Please check for an updated client library."
        end
      end
      @ssl_expiration_dates_checked = true
    end


    def self.sandbox_expiration_date # :nodoc:
      Date.new(2010, 12, 1)
    end

    def self.qa_expiration_date # :nodoc:
      Date.new(2010, 12, 1)
    end
  end
end