require 'rails_helper'
include RandomData

RSpec.describe PostsController, type: :controller do

  let (:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  #************ Test to see if index page is displayed correctly ************
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_post] to @posts" do
       get :index
       expect(assigns(:posts)).to eq([my_post])
    end
  end

  #************ Test for showing a unique post ************
  describe "GET show" do
    it "returns http success" do
      # we pass {id: my_post.id} to show as a parameter
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      # we expect the response to return the show view using the
      #   render_template matcher
      get :show, {id: my_post.id}
      expect(response).to render_template :show
    end

    it "assigns my_post to @post" do
      get :show, {id: my_post.id}
      # we expect the post to equal my_post because we call show with
      #   the id of my_post. We are testing that the post returned to us,
      #   is the post we asked for.
      expect(assigns(:post)).to eq(my_post)
    end
  end

  #************ Test for adding a new post ************
  describe "GET new" do
    #checks for a successful page load on 'new'
    it "returns http success" do
      get :new # a new and unsaved Post object is created
      expect(response).to have_http_status(:success)
    end

    #
    it "renders the #new view" do
      get :new
      # render_template method to verify that the correct
      # template (view) is rendered.
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      # expect the @post instance variable to be initialized
      # by PostsController#new
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  #**** Test for making sure the new post is added to the DB ****
  describe "POST create" do
    it "increases the number of Post by 1" do
      # The newly created object is persisted to the database..
      # We expect that after PostsController#create is called
      #   with the parameters, the count of Post instances
      #   in the database will increase by one.
      expect{
        post :create, post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
        }
      }.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      # we expect the newly created post to be assigned to @post
      post :create, post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
      }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      # we expect to be redirected to the newly created post.
      post :create, post: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
      }
      expect(response).to redirect_to Post.last
    end
  end

  #**** Test for making sure the edit action is working ****
  describe "GET edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_post.id}
      # expect the edit view to render when a post is edited.
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: my_post.id}
      # test that edit assigns the correct post to be updated to @post
      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  #**** Test for making sure the edit action is updating the DB ****
  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_post.id, post: {title: new_title, body: new_body}

      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end

  #********* Test to allow users to delete posts *********
  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, {id: my_post.id}
      # We assign the size of the array to count, and we expect
      #   count to equal zero.
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      # we expect to be redirected to the posts index view after a
      #   post has been deleted.
      expect(response).to redirect_to posts_path
    end
  end


end # End of RSpec.describe PostsController
