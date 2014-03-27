require 'spec_helper'

describe Response do
  it {should belong_to :respondent}
  it {should belong_to :choice}
end
