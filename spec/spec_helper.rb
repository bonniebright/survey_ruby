require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'question'
require 'respondent'
require 'response'
require 'survey'
require 'choice'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])
