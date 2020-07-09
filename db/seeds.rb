# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Challenge.destroy_all
Feed.destroy_all
Score.destroy_all
User.destroy_all

User.create ({username: 'System', password: '12345612asd;f4412387', email: 'system@system.com', img: 'https://www.vippng.com/png/detail/202-2026524_person-icon-default-user-icon-png.png' })
User.create ({username: 'StupendousOne', password: '123', email: 'stup1@email.com', img: 'https://www.vippng.com/png/detail/202-2026524_person-icon-default-user-icon-png.png'})
User.create ({username: 'CodeGod', password: '123', email: 'CG@email.com', img: 'https://www.vippng.com/png/detail/202-2026524_person-icon-default-user-icon-png.png'})

25.times do 
    User.create ({username: Faker::Internet.username, password: '123', email: Faker::Internet.email, img: 'https://www.vippng.com/png/detail/202-2026524_person-icon-default-user-icon-png.png'})
end

random_users = User.all[3..(User.all.length-1)]

Challenge.create({
    name: "Challenge 1", 
    desc:"Write a function called plusFive that takes in a number and returns that number plus 5",
    answer:"10",
    test_info:"plusFive(5)",
    line_par: 3,
    speed_par: 1,
    result_type: 'int'
})

Challenge.create({
    name: "Challenge 2", 
    desc:"Write a function named swapLetters that takes in a string and returns the string with the first and last letters swapped",
    answer:"eookiC",
    test_info:"swapLetters('Cookie')",
    line_par: 5,
    speed_par: 1,
    result_type: 'string'
})

Challenge.create({
    name: "Challenge 3", 
    desc:"Write a function named evens that takes in an array of numbers and returns and array of all the even numbers",
    answer:"[10,6,8,4,2]",
    test_info:"evens([10,3,5,6,8,4,1,5,9,11,2])",
    line_par: 3,
    speed_par: 1,
    result_type: 'array'
})

Challenge.create({
    name: "Challenge 4", 
    desc:"Write a function named spaceToComma that takes in a string of words and returns a string with the spaces replaced by commas",
    answer:"So,many,commas",
    test_info:"spaceToComma('So many commas')",
    line_par: 3,
    speed_par: 1,
    result_type: 'string'
})

Challenge.all.each { |c| 
    random_users.each { |u|
        if(rand(1..10) > 5)
            lscore = rand(5000..15000)
            sscore = rand(5000..15000)
            tscore = lscore + sscore
            Score.create({user_id: u.id, challenge_id: c.id, line_score: lscore, speed_score: sscore, completed: true})
            Feed.create({user_id: u.id, feed_text: "#{u.username} has completed #{c.name} with a total score of #{tscore}"})
        end
    }
}
