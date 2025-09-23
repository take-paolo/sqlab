json.array! @sample_databases do |sample_database|
  json.extract! sample_database, :id, :name

  # Sample table list
  json.tables sample_database.available_tables do |table|
    json.extract! table, :id, :name
  end
end
