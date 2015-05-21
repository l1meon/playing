json.array!(@games) do |game|
  json.extract! game, :id, :user_id, :win_size, :table_id
  json.url game_url(game, format: :json)
end
