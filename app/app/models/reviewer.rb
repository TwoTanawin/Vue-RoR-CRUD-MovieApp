# == Schema Information
#
# Table name: reviewers
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reviewer < ApplicationRecord
  has_many :comment2s
end
