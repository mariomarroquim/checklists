class Checklist < ApplicationRecord
  belongs_to :user

  validates :title, :slug, :content, presence: true

  validates :title, uniqueness: { scope: :user_id, case_sensitive: false }

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
end
