require 'rails_helper'

RSpec.describe Answer, type: :model do

  let(:question) { Question.create!(body: "A New Quesion") }
  let(:answer) { Answer.create!(body: 'Answer Body', question: question) }

   describe "attributes" do
     it "should respond to body" do
       expect(answer).to respond_to(:body)
     end
   end

end
