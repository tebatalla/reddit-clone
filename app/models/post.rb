# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  author_id  :integer          not null
#  title      :string           not null
#  url        :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :author_id, :title, presence: true
  validates :subs, presence: { message: "must be at least one" }

  has_many :votes, as: :votable

  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs,
    class_name: :PostSub,
    foreign_key: :post_id,
    primary_key: :id,
    dependent: :destroy,
    inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many(
    :comments,
    class_name: :Comment,
    foreign_key: :post_id,
    primary_key: :id
  )

  def comments_by_parent_id
    Hash.new() { |h, k| h[k] = [] }.tap do |comments|
      self.comments.includes(:author).each do |comment|
        comments[comment.parent_comment_id] << comment
      end
    end
  end
end
