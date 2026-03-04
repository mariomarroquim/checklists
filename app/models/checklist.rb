class Checklist < ApplicationRecord
  has_paper_trail ignore: %i[ visits reports ]

  belongs_to :user

  validates :title, :visits, :reports, presence: true

  validates :title, uniqueness: { scope: :user_id, case_sensitive: false }, allow_blank: true

  normalizes :title, with: ->(title) { title.strip.squish }

  # Return a human-readable slug for the checklist, combining the title with the ID.
  def slug
    "#{title.parameterize}-#{id}"
  end

  # Return the items in the checklist, splitting the content by newlines.
  def items
    return if content.blank?

    @items ||= content.tr("\r", "\n").tr("\n\n", "\n").split("\n").map do |line|
      item = line.strip.squish
      item.present? ? item : nil
    end.compact.uniq
  end

  def should_be_hidden?
    published_at.blank? || (reports > visits / 2)
  end
end
