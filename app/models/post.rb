class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  enum :status, {
    draft: 0,
    published: 1
  }

  scope :published, -> { where(status: :published) }
  scope :drafts, -> { where(status: :draft) }
end
