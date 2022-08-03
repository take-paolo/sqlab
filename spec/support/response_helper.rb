module ResponseHelper
  def body
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ResponseHelper
end
