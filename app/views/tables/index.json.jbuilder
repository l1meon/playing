json.array!(@tables) do |table|
  json.extract! table, :id, :name, :max_users, :bet
  json.url table_url(table, format: :json)
end
