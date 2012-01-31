require 'yajl'
require 'active_support/core_ext/hash/indifferent_access'
require 'net/http'

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'terawurfl-client/version'
require 'terawurfl-client/config'
require 'terawurfl-client/device'

class TerawurflClient::ConnectionError < StandardError; end;
class TerawurflClient::InvalidResponseData < StandardError; end;
