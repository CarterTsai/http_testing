require 'net/http'
require 'net/https'
require 'json'
require "addressable/uri"
require "yaml"

module MHTTP
    def MHTTP.post(uri, data, header=nil)
        req = Net::HTTP.new(uri.host, uri.port)

        if uri.class.to_s === 'URI::HTTPS' 
            req.use_ssl = (uri.scheme = 'https')
            req.verify_mode = OpenSSL::SSL::VERIFY_NONE 
        end
        params = Addressable::URI.new
        params.query_values = data
        
        if header != nil
            cookie = header
            headers = {
                'Cookie' => cookie
            }
        end
        
        res = req.post2(uri.path, params.query, headers)
        if MHTTP.is_json(res.body)
            return res, JSON.parse(res.body)
        else
            return res, ""
        end
    end

    def MHTTP.get(url, path, params, header=nil)
        _url = url.to_s + path.to_s
        puts _url
        uri = URI.parse(_url)
        http = Net::HTTP.start(uri.host, uri.port)

        if header != nil
            cookie = header.split('; ')[0]
            headers = {
                'Cookie' => cookie
            }
        end

        res = http.send_request('GET', uri.request_uri, URI.encode_www_form(params) ,headers)
        if MHTTP.is_json(res.body)
            return res, JSON.parse(res.body)
        else
            return res, ""
        end
    end
    def MHTTP.is_json(data)
        return JSON.parse data
    rescue
        false
    end
end

module MCONFIG
    @filepath = ""
    def MCONFIG.load(filepath)
        @filepath = filepath
        return YAML.load_file(filepath)
    end
    def MCONFIG.write(yaml_data)
        File.open(@filepath.to_s, 'w') {|f| f.write yaml_data.to_yaml}
    end
end
