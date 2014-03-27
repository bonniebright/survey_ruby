
class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :responses
  has_many :respondents, through: :responses

def percentage(question)
  percentage = (self.responses.count.to_f / question.responses.count.to_f) * 100
end

end
