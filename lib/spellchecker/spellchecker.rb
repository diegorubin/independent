class Spellchecker

  CHECK_API = '/check/%s'
  CHECK_TEXT_API = '/check_text'
  ADD_WORD_API = '/add'

  def check(word)
    @text = false
    @service ||= Spellchecker.connection
    response = @service.get do |req|
      req.url CHECK_API % [CGI.escape(word)] 
    end
    load_response response
  end

  def check_text(text)
    @text = true
    @service ||= Spellchecker.connection
    response = @service.post do |req|
      req.url CHECK_TEXT_API
      req.body = text
    end
    load_response response
  end

  def add(word, author)
    @service ||= Spellchecker.connection
    response = @service.post do |req|
      req.url ADD_WORD_API
      req.body = {word: word, author: author}
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

  def wrongs
    @wrongs
  end

  def to_json
    @text ? to_json_text : to_json_word
  end

  private
  def to_json_word
    {
      word: word,
      suggestion: suggestion,
      candidates: candidates,
      wrong: wrong?
    }
  end

  def to_json_text
    {
      original: original,
      wrongs: wrongs,
      wrong: wrong?
    }
  end

  def self.connection
    Faraday.new(url: Figaro.env.spellchecker_entrypoint) do |faraday|
      faraday.request :url_encoded
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def load_response(response)
    body = response.body
    @text ? load_response_for_text(body) : load_response_for_word(body)
  end

  def load_response_for_word(body)
    @suggestion = body['suggestion']
    @candidates = body['candidates']
    @wrong = body['wrong'] == 'true'
  end

  def load_response_for_text(body)
    @wrong = body['wrongs'].size > 0
    @wrongs = body['wrongs']
  end

end

