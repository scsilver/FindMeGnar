json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :user, :content, :time
  json.url tweet_url(tweet, format: :json)
end
