class Checklist < ApplicationRecord
  has_paper_trail ignore: %i[ visits reports ]

  belongs_to :user

  validates :title, :slug, :content, :visits, :reports, presence: true

  validates :title, uniqueness: { scope: :user_id, case_sensitive: false }, allow_blank: true

  validates :slug, uniqueness: true, allow_blank: true

  normalizes :title, with: ->(title) { title.strip.squish }

  before_validation do |it|
    if it.slug.blank? && it.title.present?
      it.slug = "#{it.title.parameterize}-#{SecureRandom.urlsafe_base64(5).downcase}"
    end
  end

  # Return the items in the checklist, splitting the content by newlines.
  def items
    @items ||= content.tr("\r", "\n").tr("\n\n", "\n").split("\n").map do |line|
      item = line.strip.squish
      item.present? ? item : nil
    end.compact.uniq
  end

  def should_be_hidden?
    reports > visits / 2
  end
end
