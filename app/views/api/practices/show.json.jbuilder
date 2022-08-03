json.extract! @practice, :id, :name, :question, :answer, :sample_database_id, :display_er_diagram
json.sample_table_ids @practice.sample_tables.pluck(:uid)
