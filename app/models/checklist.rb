class Checklist < ApplicationRecord
  belongs_to :user

  validates :title, :content, presence: true

  validates :title, uniqueness: { scope: :user_id, case_sensitive: false }

  normalizes :title, with: ->(title) { title.strip.squish }

  # Return the items in the checklist, splitting the content by newlines.
  def items
    @items ||= content.tr("\r", "\n").tr("\n\n", "\n").split("\n").map do |line|
      item = line.strip.squish
      item.present? ? item : nil
    end.compact.uniq
  end
end
