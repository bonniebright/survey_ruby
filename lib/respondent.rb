class Respondent < ActiveRecord::Base
  has_many :responses
  has_many :choices, through: :responses
end
