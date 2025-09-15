json.extract! @practice, :id, :name, :question, :answer, :sample_database_id
if @with_sample_data
  # ER diagram URL
  json.er_diagram_url @er_diagram_url

  # Sample table records
  json.sample_table_data @sample_table_data
end
