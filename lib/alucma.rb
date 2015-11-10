require 'net/http'
require 'json'
require 'alucma/http'
require 'alucma/client'

class ALUCMA
  def self.init(hash)
    if !hash.class == "Hash"
      return { :error => "Invalid input. Input must be a hash." }
    end

    if !hash[:client_id] || !hash[:client_secret]
      return { :error => "Missing parameters. Must Client ID and Client Secret" }
    end

    url = "http://api.foundry.att.net:9001/oauth/client_credential/accesstoken?grant_type=client_credentials"
    headers = { "Content-Type" => "application/x-www-form-urlencoded" }
    payload = "client_id=#{hash[:client_id]}&client_secret=#{hash[:client_secret]}"

    resp = Http.post(url,headers,payload)
    auth = JSON.parse(resp) || {}
    if auth["status"] == "approved"
      return Client.new(auth)
    else
      return { :error => "OAuth not approved." }
    end
  end
end

