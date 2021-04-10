# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(name: "Sample category")

User.create(email: "user@test.com", password: Rails.application.credentials[:passwords][:user])
Admin.create(email: "admin@test.com", password: Rails.application.credentials[:passwords][:admin])
