class CandidatesAPI
  include HTTParty
  base_uri "www.kimonolabs.com"
  def self.candidates()
    response = get( URI.encode("https://www.kimonolabs.com/api/#{ENV['kimono_api']}?apikey=#{ENV['kimono_key']}") )
    if response.success?
      return response["results"]["candidates"]
    else
      # this just raises the net/http response that was raised
      raise response.response
    end
  end
end