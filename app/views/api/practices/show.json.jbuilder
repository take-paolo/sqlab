json.extract! @practice, :id, :name, :question, :answer, :display_er_diagram
json.sample_database_id @practice.sample_database_uid
json.sample_table_ids @practice.sample_tables.pluck(:uid)
