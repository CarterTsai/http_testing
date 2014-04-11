require 'net/http'
require 'json'

module MHTTP
    def MHTTP.post(url, data)
        res = Net::HTTP.post_form(url, data)
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
