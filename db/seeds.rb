# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by!(email_address: ENV.fetch("EMAIL_ADDRESS") { "example@gmail.com" }) do |it|
  it.password = "12345678"
  it.password_confirmation = "12345678"
end

Checklist.find_or_create_by!(title: "First checklist", content: "First item\nSecond item\nThird item", user:)
