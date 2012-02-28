#   Copyright (c) 2010-2011, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.

require 'spec_helper'

describe ActsAsTaggableOn::Tag do

  describe 'self#extract_from_params' do

    it 'removes the hashtag mark and excedent commas' do
      tags = "#quetzal, #ale, #flor,"
      result = ActsAsTaggableOn::Tag.extract_from_params(tags)
      result.should == "quetzal,ale,flor"
    end

    it 'should change multiword tags to underscored tags' do
      tags = "#quetzal, #ale, #flor, #New York,"
      result = ActsAsTaggableOn::Tag.extract_from_params(tags)
      result.should == "quetzal,ale,flor,New_York"
    end
  end
end
