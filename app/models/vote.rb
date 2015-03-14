# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  voter_id     :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  validates :value, :votable_id, :votable_type, :voter_id, presence: true
  validates :value, inclusion: { in: [1, -1] }
  validates :voter_id, uniqueness: { scope: [:votable_type, :votable_id] }

  belongs_to :votable, polymorphic: true

  belongs_to(
   :user,
   class_name: :User,
   foreign_key: :voter_id,
   primary_key: :id
   )



end
