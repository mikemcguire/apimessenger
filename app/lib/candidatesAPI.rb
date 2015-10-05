class CandidatesAPI
  include HTTParty
  base_uri "www.kimonolabs.com"
  attr_accessor :name, :donor, :total
  def self.candidates()
    response = get("/api/678t04gk?apikey={@key}")
    if response.success?
      self.new(response["name"], response["donor"], response["total"])
    else
      # this just raises the net/http response that was raised
      raise response.response
    end
  end
end