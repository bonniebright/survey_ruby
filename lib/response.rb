class Response < ActiveRecord::Base
  belongs_to :respondent
  belongs_to :choice
end
