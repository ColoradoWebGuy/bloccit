require 'rails_helper'
include RandomData

RSpec.describe AdvertisementController, type: :controller do

  let(:my_advertisement) {
    Advertisement.create!(
      title: "2016 Never Summer Heritage Snowboard",
      copy: "Pre-Order Now, and get it before the Winter Season!",
      price: 569
    )
  }

  #************ Test to see if index page is displayed correctly ************
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_advertisement] to @advertisements" do
       get :index
       expect(assigns(:advertisements)).to eq([my_advertisement])
    end
  end

  #************ Test for showing a unique advertisement ************
  describe "GET #show" do
    it "returns http success" do
      # we pass {id: my_advertisement.id} to show as a parameter
      get :show, {id: my_advertisement.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      # we expect the response to return the show view using the
      #   render_template matcher
      get :show, {id: my_advertisement.id}
      expect(response).to render_template :show
    end
    it "assigns my_advertisement to @advertisement" do
      get :show, {id: my_advertisement.id}
      # we expect the advertisement to equal my_advertisement because we call show with
      #   the id of my_advertisement. We are testing that the post returned to us,
      #   is the post we asked for.
      expect(assigns(:advertisement)).to eq(my_advertisement)
    end
  end

  #************ Test for adding a new advertisement ************
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  #**** Test for making sure the new post is added to the DB ****
  describe "POST create" do
      it "increases the number of Ads by 1" do
        expect{
          post :create, advertisement: {
            title: RandomData.random_sentence,
            copy: RandomData.random_paragraph,
            price: RandomData.random_number
          }
        }.to change(Advertisement,:count).by(1)
      end
  end

end
