json.merge! @practice.attributes
json.sample_table_ids @practice.sample_tables.pluck(:uid)
