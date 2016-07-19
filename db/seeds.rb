# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 10.times do
#     Post.create title: Faker::Hipster.sentence,
#                 body: "#{Faker::Hacker.say_something_smart} #{Faker::Hipster.paragraph}"
# end

unless Category.count > 0
  ["Writing", "React.js", "Javascript", "Ruby", "Gaming", "Rails", "Electron", "Fighting", "Books", "Redbull"].each do |cat|
      Category.create title: cat
  end
end

unless Tag.count > 0
  30.times {Tag.create(title: Faker::Hacker.adjective)}
end