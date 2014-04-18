require 'net/http'
require 'json'
require "addressable/uri"

module MHTTP
    def MHTTP.post(uri, data, header=nil)
        req = Net::HTTP.new(uri.host, uri.port)
        params = Addressable::URI.new
        params.query_values = data

        if header != nil
            cookie = header.split('; ')[0]
            puts cookie
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
    def MHTTP.get(url, params)
        url.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(url)
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
