require 'rails_helper'
include RandomData
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:other_user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: "helloworld", role: :member) }
  let (:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
  let(:my_vote) { Vote.create!(value: 1) }

   context "guest" do
     describe "POST up_vote" do
       it "redirects the user to the sign in view" do
         post :up_vote, post_id: my_post.id
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe "POST down_vote" do
       it "redirects the user to the sign in view" do
         delete :down_vote, post_id: my_post.id
         expect(response).to redirect_to(new_session_path)
       end
     end
   end

   context "signed in user" do
     before do
       create_session(my_user)
       request.env["HTTP_REFERER"] = topic_post_path(my_topic, my_post)
     end

     describe "POST up_vote" do
       it "the users first vote increases number of post votes by one" do
         votes = my_post.votes.count
         post :up_vote, post_id: my_post.id
         expect(my_post.votes.count).to eq(votes + 1)
       end

       it "the users second vote does not increase the number of votes" do
         post :up_vote, post_id: my_post.id
         votes = my_post.votes.count
         post :up_vote, post_id: my_post.id
         expect(my_post.votes.count).to eq(votes)
       end

       it "increases the sum of post votes by one" do
         points = my_post.points
         post :up_vote, post_id: my_post.id
         expect(my_post.points).to eq(points + 1)
       end

       it ":back redirects to posts show page" do
         request.env["HTTP_REFERER"] = topic_post_path(my_topic, my_post)
         post :up_vote, post_id: my_post.id
         expect(response).to redirect_to([my_topic, my_post])
       end

       it ":back redirects to posts topic show" do
         request.env["HTTP_REFERER"] = topic_path(my_topic)
         post :up_vote, post_id: my_post.id
         expect(response).to redirect_to(my_topic)
       end
     end
   end
end
