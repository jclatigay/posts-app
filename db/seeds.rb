# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(email: "admin@example.com", password: "asdasd", password_confirmation: "asdasd", role: "admin")
User.create!(email: "moderator@example.com", password: "asdasd", password_confirmation: "asdasd", role: "moderator")
User.create!(email: "user@example.com", password: "asdasd", password_confirmation: "asdasd", role: "user")

Post.create!(title: "First Post", content: "This is the first post", user: User.find_by(email: "admin@example.com"), status: "published")
Post.create!(title: "Second Post", content: "This is the second post", user: User.find_by(email: "moderator@example.com"), status: "draft")
Post.create!(title: "Third Post", content: "This is the third post", user: User.find_by(email: "user@example.com"), status: "draft")
