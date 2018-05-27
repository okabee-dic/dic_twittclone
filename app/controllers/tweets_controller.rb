class TweetsController < ApplicationController
  def index
    @contents = Tweet.all.order('id DESC')
  end
  
  def new
    if params[:back]
      @tweet = Tweet.new(tweet_params)
    else
      @tweet = Tweet.new
    end
  end
  
  def confirm
    @tweet = Tweet.new(tweet_params)
    render :new if @tweet.invalid?
  end
  
  def create
    @tweet = Tweet.new(tweet_params)
    
    if @tweet.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to tweets_path, notice: "ツイートしました！"
    else
    
      render "new"
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    
    redirect_to tweets_path, notice: "ブログを削除しました！"
  end
  
  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
  
end
