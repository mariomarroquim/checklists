# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.create!(name: genre_name)
#   end

unless User.exists?
  user = User.create!(email_address: "example@gmail.com") do |it|
    it.password = "password"
    it.password_confirmation = "password"
  end

  Checklist.create!(title: "First checklist", content: "First item\nSecond item\nThird item", user:) do |it|
    it.published_at = Time.current
  end
end
