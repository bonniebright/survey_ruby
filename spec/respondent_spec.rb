require 'spec_helper'

describe Respondent do
  it {should have_many :responses}
  it {should have_many :choices}
end
