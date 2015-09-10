require 'rails_helper'
include RandomData

RSpec.describe QuestionsController, type: :controller do

  let (:my_question) { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: RandomData.random_boolean) }

  #************ Test to see if index page is displayed correctly ************
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_question] to @questions" do
       get :index
       expect(assigns(:questions)).to eq([my_question])
    end
  end

  #************ Test for adding a new question ************
  describe "GET new" do
    #checks for a successful page load on 'new'
    it "returns http success" do
      get :new # a new and unsaved Question object is created
      expect(response).to have_http_status(:success)
    end

    #
    it "renders the #new view" do
      get :new
      # render_template method to verify that the correct
      # template (view) is rendered.
      expect(response).to render_template :new
    end

    it "instantiates @question" do
      # expect the @question instance variable to be initialized
      # by QuestionsController#new
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end

  #**** Test for making sure the new question is added to the DB ****
  describe "Question create" do
    it "increases the number of Questions by 1" do
      # The newly created object is persisted to the database..
      # We expect that after QuestionsController#create is called
      #   with the parameters, the count of Question instances
      #   in the database will increase by one.
      expect{
        post :create, question: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph,
          resolved: RandomData.random_boolean
        }
      }.to change(Question,:count).by(1)
    end

    it "assigns the new question to @question" do
      # we expect the newly created question to be assigned to @question
      post :create, question: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: RandomData.random_boolean
      }
      expect(assigns(:question)).to eq Question.last
    end

    it "redirects to the new question" do
      # we expect to be redirected to the newly created question.
      post :create, question: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: RandomData.random_boolean
      }
      expect(response).to redirect_to Question.last
    end
  end

  #************ Test for showing a unique question ************
  describe "GET show" do
    it "returns http success" do
      # we pass {id: my_question.id} to show as a parameter
      get :show, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      # we expect the response to return the show view using the
      #   render_template matcher
      get :show, {id: my_question.id}
      expect(response).to render_template :show
    end

    it "assigns my_question to @question" do
      get :show, {id: my_question.id}
      # we expect the question to equal my_question because we call show with
      #   the id of my_question. We are testing that the question returned to us,
      #   is the question we asked for.
      expect(assigns(:question)).to eq(my_question)
    end
  end

  #**** Test for making sure the edit action is working ****
  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_question.id}
      # expect the edit view to render when a question is edited.
      expect(response).to render_template :edit
    end

    it "assigns question to be updated to @question" do
      get :edit, {id: my_question.id}
      # test that edit assigns the correct question to be updated to @question
      question_instance = assigns(:question)

      expect(question_instance.id).to eq my_question.id
      expect(question_instance.title).to eq my_question.title
      expect(question_instance.body).to eq my_question.body
    end
  end

  #**** Test for making sure the edit action is updating the DB ****
  describe "PUT update" do
    it "updates question with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_question.id, question: {title: new_title, body: new_body}

      updated_question = assigns(:question)
      expect(updated_question.id).to eq my_question.id
      expect(updated_question.title).to eq new_title
      expect(updated_question.body).to eq new_body
    end

    it "redirects to the updated question" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_question.id, question: {title: new_title, body: new_body}
      expect(response).to redirect_to my_question
    end
  end

  #********* Test to allow users to delete questions *********
  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, {id: my_question.id}
      # We assign the size of the array to count, and we expect
      #   count to equal zero.
      count = Question.where({id: my_question.id}).size
      expect(count).to eq 0
    end

    it "redirects to questions index" do
      delete :destroy, {id: my_question.id}
      # we expect to be redirected to the questions index view after a
      #   question has been deleted.
      expect(response).to redirect_to questions_path
    end
  end

end
