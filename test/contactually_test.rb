require "test_helper"
require "contactually"
require "rest_client"
require "minitest/mock"

describe "Contactually API method calls samples" do

  before do
    @api_key      = "i8d6k1y1hjbrbh6qochplf3vkxtapqul"
    @contactually = Contactually::API.new(@api_key)

    #Fake Response
    FakeResponse = Struct.new(:body_str)
    @response    = FakeResponse.new("{}")
    @mock        = MiniTest::Mock.new
    @mock.expect :body_str, @response.body_str
  end

  it "can call a contact" do
    @contactually.get_contacts
  end

end

describe "Method Builder" do
  before do
    @api_key      = "i8d6k1y1hjbrbh6qochplf3vkxtapqul"
    @contactually = Contactually::API.new(@api_key)
  end

  it "should return a http_method and contactually method" do
    assert @contactually.send(:get_methods, :post_contacts) == ["post", "contacts"]
  end

  it "should build a uri with no id" do
    test_method = "contacts"
    test_uri = "https://www.contactually.com/api/v1/#{test_method}.json?api_key=#{@api_key}"
    assert @contactually.send(:build_uri, "contacts") == test_uri
  end

  it "should build a uri with id" do
    test_method = "contacts"
    args_hash   = { id: 1 }
    test_uri = "https://www.contactually.com/api/v1/#{test_method}/#{args_hash[:id]}.json?api_key=#{@api_key}"
    assert @contactually.send(:build_uri, "contacts", args_hash) == test_uri
  end

end
