$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'fakeweb'
require 'terawurfl-client'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:get,
                     "http://fake-wurfl.com/webservice.php?format=json&ua=Opera%2F9.80+%28J2ME%2FMIDP%3B+Opera+Mini%2F4.2.18151%2F26.984%3B+U%3B+en%29+Presto%2F2.8.119+Version%2F10.54&search=",
                     :response => File.read("#{File.dirname(__FILE__)}/wurfl-response.txt"))

FakeWeb.register_uri(:get,
                     "http://invalid.fake-wurfl.com/webservice.php?format=json&ua=Opera%2F9.80+%28J2ME%2FMIDP%3B+Opera+Mini%2F4.2.18151%2F26.984%3B+U%3B+en%29+Presto%2F2.8.119+Version%2F10.54&search=",
                     :body => "This is not a JSON.")

FakeWeb.register_uri(:get,
                     "http://broken.fake-wurfl.com/webservice.php?format=json&ua=Opera%2F9.80+%28J2ME%2FMIDP%3B+Opera+Mini%2F4.2.18151%2F26.984%3B+U%3B+en%29+Presto%2F2.8.119+Version%2F10.54&search=",
                     :body => "This is the end of the Internet.",
                     :status => ["404", "Not Found"])
