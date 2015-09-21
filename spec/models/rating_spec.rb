require 'rails_helper'
include RandomData

RSpec.describe Rating, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:rating) { Rating.create!(severity: "PG") }

  it { should belong_to :rateable }

  describe "rateable" do
     it "allows the same rating to be associated with a different topic and post" do
       topic.rating = rating
       post.rating = rating

       expect(topic.rating).to eql(post.rating)
     end
   end
end
