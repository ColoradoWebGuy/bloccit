class AdvertisementController < ApplicationController

  def index
    # show all advertisements here
    @advertisements = Advertisement.all
  end

  def show
    # show a particular Advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def new
    @advertisement = Advertisement.new
  end

  def create
    # Call Advertisement.new to create a new instance of Advertisement
    @advertisement = Advertisement.new
    @advertisement.title = params[:advertisement][:title]
    @advertisement.copy = params[:advertisement][:copy]
    @advertisement.price = params[:advertisement][:price]

    # If save is a success, Redirecting to @advertisement will direct the
    #  user to the advertisement show view.
    if @advertisement.save
      flash[:notice] = "Advertisement was saved."
      redirect_to @advertisement
    else
      flash[:error] = "There was an error saving the advertisement. Please try again."
      render :new
    end
  end

end
