# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  body       :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_reviews_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#
class Review < ApplicationRecord
  belongs_to :movie
  # has_many :comment2s
end
