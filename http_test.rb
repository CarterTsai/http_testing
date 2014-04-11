require './lib'
require "test/unit"

class Test_Azure_Api < Test::Unit::TestCase
    def setup
        @url = URI("http://localhost:1337") 
        @username = '123123123';
        @password = '12313123'
    end

    def test_get
        @res, @json = MHTTP.get(@url, 'arg1'=>'', 'arg2'=>'')
        assert_equal(nil, @json['status'])
    end
    
    def test_post
        @url = URI("http://localhost:1337/api/test")
        @res, @json = MHTTP.post(@url, 'arg1'=>'', 'arg2'=>'')
        puts @res.body
        assert_equal("ok", @json['status'])
    end    
end
