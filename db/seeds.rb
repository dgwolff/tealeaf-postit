# Users
5.times do
  name = Faker::Name.first_name
  password = "password"
  User.create!(username: name,
               password: password,
               password_confirmation: password)
end

# Categories
5.times do
  name = Faker::Hacker.adjective
  Category.create!(name: name)
end


# Posts
users = User.all
users.each do |user|
  5.times do
    url = Faker::Internet.url
    title = Faker::Company.catch_phrase
    description = Faker::Company.bs
    created_at = Faker::Date.backward(14)
    category_ids = Category.pluck(:id).sample(1)
    user.posts.create!(url: url,
                       title: title,
                       description: description,
                       created_at: created_at,
                       category_ids: category_ids)
  end
end

# Comments

# Post Votes

# Comment Votes
