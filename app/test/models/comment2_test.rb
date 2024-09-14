# == Schema Information
#
# Table name: comment2s
#
#  id          :bigint           not null, primary key
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  movie_id    :bigint           not null
#  reviewer_id :bigint           not null
#
# Indexes
#
#  index_comment2s_on_movie_id     (movie_id)
#  index_comment2s_on_reviewer_id  (reviewer_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (reviewer_id => reviewers.id)
#
require "test_helper"

class Comment2Test < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
