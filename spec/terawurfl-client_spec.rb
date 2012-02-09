require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TerawurflClient" do
  it "has a version" do
    TerawurflClient::VERSION.should be
  end

  describe "Config" do
    it "should get and set an API URL" do
      TerawurflClient::Config.api_url = "http://example.com"
      TerawurflClient::Config.api_url.should eq("http://example.com")
    end
  end

  describe "Device" do
    let (:ua) { "Opera/9.80 (J2ME/MIDP; Opera Mini/4.2.18151/26.984; U; en) Presto/2.8.119 Version/10.54" }

    before(:each) do
      TerawurflClient::Config.api_url = "http://fake-wurfl.com/webservice.php"
    end

    it "should accept a user agent" do
      TerawurflClient::Device.new(ua).user_agent.should eq(ua)
    end

    it "should fail without a user agent" do
      expect { TerawurflClient::Device.new }.to raise_error(ArgumentError)
    end

    it "should fail with a user agent that is not a string" do
      expect { TerawurflClient::Device.new(nil) }.to raise_error(ArgumentError)
    end

    it "should get capabilities" do
      TerawurflClient::Device.new(ua).capabilities.should_not be_empty
    end

    it "should return a given capability" do
      TerawurflClient::Device.new(ua).capabilities[:is_wireless_device].should be_true
    end

    it "should return nil for an unknown capability" do
      TerawurflClient::Device.new(ua).capabilities[:is_nyancat].should be_nil
    end

    it "should raise an error if no API URL is configured" do
      TerawurflClient::Config.api_url = nil
      expect { TerawurflClient::Device.new(ua).capabilities }.to raise_error(TerawurflClient::ConnectionError)
    end

    it "should raise an error if the HTTP response is not success" do
      TerawurflClient::Config.api_url = "http://broken.fake-wurfl.com/webservice.php"
      expect { TerawurflClient::Device.new(ua).capabilities }.to raise_error(TerawurflClient::ConnectionError)
    end

    it "should raise an error if invalid input is received" do
      TerawurflClient::Config.api_url = "http://invalid.fake-wurfl.com/webservice.php"
      expect { TerawurflClient::Device.new(ua).capabilities }.to raise_error(TerawurflClient::InvalidResponseData)
    end
  end

  context "mocking" do
    it "should be turned off by default" do
      TerawurflClient.mock?.should be_false
    end

    it "should be turned on after mock!" do
      TerawurflClient.mock!.should be_true
      TerawurflClient.mock?.should be_true
    end

    it "should be turned off after unmock!" do
      TerawurflClient.unmock!.should be_true
      TerawurflClient.mock?.should be_false
    end

    describe "Device::Mock" do
      before(:all) do
        TerawurflClient.mock!
      end

      it "should return empty capabilities by default" do
        TerawurflClient::Device.new("NyanCat/1.0").capabilities.should eq({})
      end

      it "should return mocked capabilities for a device" do
        TerawurflClient::Device.mock("NyanCat/1.0", { :colors => "many" })
        TerawurflClient::Device.new("NyanCat/1.0").capabilities[:colors].should eq("many")
      end

      it "should remove mocked capabilities for a device" do
        TerawurflClient::Device.mock("NyanCat/1.0", { :colors => "many" })
        TerawurflClient::Device.unmock("NyanCat/1.0")
        TerawurflClient::Device.new("NyanCat/1.0").capabilities[:colors].should be_nil
      end

      it "should not return mocked capabilities for other devices" do
        TerawurflClient::Device.mock("NyanCat/1.0", { :colors => "many" })
        TerawurflClient::Device.new("NyanDog/1.0").capabilities[:colors].should be_nil
      end

      it "should not require an API URL in mocking mode" do
        TerawurflClient::Config.api_url = nil
        expect { TerawurflClient::Device.new("NyanDog/1.0").capabilities }.to_not raise_error
      end
    end
  end
end
