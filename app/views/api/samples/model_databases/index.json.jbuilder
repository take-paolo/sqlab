json.array! @model_databases.each_with_index.to_a do |model_database, i|
  json.extract! model_database, :id, :name
  json.er_diagram @er_diagrams[i]
  json.tables do
    json.array! model_database.model_tables, :id, :name
  end
end
