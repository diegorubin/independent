class Spellchecker

  CHECK_API = '/check/%s'

  def initialize(word)
    @word = word
    @service ||= Spellchecker.connection
    response = @service.get do |req|
      req.url CHECK_API % [word] 
    end
    load_response response
  end

  def suggestion
    @suggestion
  end

  def wrong?
    @wrong
  end

  def candidates
    @candidates
  end

  def word
    @word
  end

  private

  def self.connection
    Faraday.new(url: Figaro.env.spellchecker_entrypoint) do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def load_response(response)
    body = response.body
    @suggestion = body['suggestion']
    @candidates = body['candidates']
    @wrong = body['wrong'] == 'true'
  end

end

