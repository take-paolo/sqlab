json.array! @works do |work|
  json.merge! work.attributes
end
