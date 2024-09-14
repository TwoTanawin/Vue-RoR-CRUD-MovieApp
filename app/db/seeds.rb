# db/seeds.rb

# Clear existing data
Reviewer.destroy_all
Comment.destroy_all
Movie.destroy_all

# Create sample movies
movies = Movie.create([
                        { title: 'Inception', description: 'A mind-bending thriller about dream invasion.' },
                        { title: 'The Matrix', description: 'A hacker learns about the true nature of reality.' },
                        { title: 'Interstellar', description: 'Exploration of space to save humanity.' },
                        { title: 'The Dark Knight', description: 'The rise of Batman against the Joker.' },
                        { title: 'Pulp Fiction', description: 'Interwoven stories of crime and redemption.' }
                      ])

# Create sample reviewers
reviewers = Reviewer.create([
                              { name: 'Alice Johnson', email: 'alice.johnson@example.com' },
                              { name: 'Bob Smith', email: 'bob.smith@example.com' },
                              { name: 'Charlie Brown', email: 'charlie.brown@example.com' },
                              { name: 'Diana Prince', email: 'diana.prince@example.com' },
                              { name: 'Edward Cullen', email: 'edward.cullen@example.com' }
                            ])

# # Create sample comments
# comments = Comment.create([
#                             { content: 'A mind-blowing experience with fantastic visuals.', movie: movies.first, reviewer: reviewers.first },
#                             { content: 'A classic that redefined the sci-fi genre.', movie: movies.second, reviewer: reviewers.second },
#                             { content: 'An emotional rollercoaster with stunning visuals.', movie: movies.third, reviewer: reviewers.third },
#                             { content: 'Heath Ledger’s performance is unforgettable.', movie: movies.fourth, reviewer: reviewers.fourth },
#                             { content: 'Quentin Tarantino’s storytelling at its finest.', movie: movies.fifth, reviewer: reviewers.fifth },
#                             { content: 'A gripping and suspenseful movie.', movie: movies.first, reviewer: reviewers.second },
#                             { content: 'The action scenes were top-notch.', movie: movies.second, reviewer: reviewers.third },
#                             { content: 'An epic journey with deep philosophical questions.', movie: movies.third, reviewer: reviewers.fourth },
#                             { content: 'Dark, intense, and thrilling.', movie: movies.fourth, reviewer: reviewers.first },
#                             { content: 'A brilliant mix of humor and drama.', movie: movies.fifth, reviewer: reviewers.second }
#                           ])
#
# puts "Seed data created successfully!"
