class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.order(id: :desc)
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    message_arr = []
    @tweet = Tweet.new(tweet_params)


    message_arr = @tweet.message.split
    message_arr.each_with_index do |word, index|
      if word[0] == "#"
        if Tag.pluck(:phrase).include?(word)
          tag = Tag.find_by(phrase: word)
        else
          tag = Tag.create(phrase: word)
        end
        tweet_tag = TweetTag.creat(tweet_id: @tweet.id, tag_id: @tag.id)
        message_arr[index] = " <href='/tag_tweets?id=#{tag.id}'>#{word}>"
        @tweet.update(message: message_arr.join (" "))
      end
    end
 end

     respond_to do |format|
      if @tweet.save
        # format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.html { redirect_to root_path(id: current_user.id), notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
      def set_tweet
        @tweet = Tweet.find(params[:id])
      end

    # Never trust parameters from the scary internet, only allow the white list through.
      def tweet_params
        params.require(:tweet).permit(:message, :user_id)
      end
    end

