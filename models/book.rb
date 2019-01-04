class Book
  include HTTParty

  base_uri 'https://www.googleapis.com/books/v1/volumes'
  format :json

  def self.search(term)
    cleaned_up_term = term.gsub(/\s+/, '+')
    get('', query: { q: cleaned_up_term, startIndex: 0, maxResults: 40 })['items'] || []
  end
end

def img_tag(url)
  "<img src='#{url}'>"
end