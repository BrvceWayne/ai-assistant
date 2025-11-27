RubyLLM.configure do |config|
  config.openai_api_key = ENV['GITHUB_TOKEN']
  config.openai_api_base = "https://models.inference.ai.azure.com"
  # config.max_tokens = 300
  # config.timeout = 60
end
