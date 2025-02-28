# frozen_string_literal: true

require 'spec_helper'

fixture_path = 'spec/fixtures'

# this reads a binary database dump file, which is in structure like a CSV file
# but contains control characters delimiting the rows and columns, and also
# contains a comment section which is commented our by a leading # character

describe 'be_able_to' do
  it 'loads_binary_file_with_comments' do
    options = {col_sep: "\cA", row_sep: "\cB", comment_regexp: /^#/}
    data = SmarterCSV.process("#{fixture_path}/binary.csv", options)
    expect(data.flatten.size).to eq 8

    data.each do |item|
      # all keys should be symbols
      item.each_key do |key|
        expect(key.class).to eq Symbol
      end
      expect(item[:timestamp]).to eq 1_381_388_409
      expect(item[:item_id].class).to eq Fixnum
      expect(item[:name].size).to be > 0
    end
  end
end
