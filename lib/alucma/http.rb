class Http
  def self.post(url, headers, payload=nil)
    begin
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host,uri.port)

      path = uri.path
      path = "#{path}?#{uri.query}" if uri.query

      req = Net::HTTP::Post.new(path)
      req.body = payload

      headers.each do |k,v|
        req[k] = v
      end

      res = http.request(req)

      if res.body
        return JSON.parse res.body
      else
        return { :error => true, :response => res.body }
      end
    rescue => e
      puts e.to_s
      return false
    end
  end
end
