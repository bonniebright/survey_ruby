class Survey < ActiveRecord::Base
 has_many :questions
 has_many :choices, through: :questions
 has_many :responses, through: :choices
 has_many :respondents, through: :responses
end
