require 'rails_helper'

RSpec.describe DateTimeHelper do
  it 'converts timestamps to human friendly strings' do
    test_date = Time.new(2019,3,19,21,29,0,-600)
    converted = helper.format_date(test_date)
    expect(converted).to eq('March 19, 2019 at 9:29 pm')
  end

  it 'converts timestamps from same day to relative durations' do
    test_date = Time.now - 2160
    converted = helper.format_date(test_date)
    expect(converted).to eq('36 Minutes ago')

    test_date = Time.now - 12960
    converted = helper.format_date(test_date)
    expect(converted).to eq('3 Hours and 36 Minutes ago')
  end
end
