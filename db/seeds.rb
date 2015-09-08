include RandomData

 # Create Posts
 50.times do
 # #1
   Post.create!(
 # #2
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end

 # add a unique post
 Post.find_or_create_by(title: 'An Interesting New Title', body: "The body of a unique post.")

 posts = Post.all

 # Create Comments
 # #3
 100.times do
   Comment.create!(
 # #4
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end

 # add a unique comment
 Comment.find_or_create_by(post: posts[51], body: "A comment on the unique post.")

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
