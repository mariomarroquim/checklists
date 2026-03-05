class Checklist < ApplicationRecord
  has_paper_trail ignore: %i[ visits reports ]

  belongs_to :user

  validates :title, :visits, :reports, presence: true

  validates :title, uniqueness: { scope: :user_id, case_sensitive: false }, allow_blank: true

  normalizes :title, with: ->(title) { title.strip.squish }

  # Returns a human-readable slug for the checklist, combining the title with the ID.
  def slug
    @slug ||= "#{title.parameterize}-#{id}"
  end

  # Returns the items in the checklist by splitting content by newlines.
  def items
    return if content.blank?

    @items ||= content.tr("\r", "\n").tr("\n\n", "\n").split("\n").map do |line|
      item = line.strip.squish
      item.present? ? item : nil
    end.compact.uniq
  end

  # Checks if the checklist should be hidden based on its status and reports to visits ratio.
  def should_be_hidden?
    published_at.blank? || (reports > visits / 2)
  end
end
