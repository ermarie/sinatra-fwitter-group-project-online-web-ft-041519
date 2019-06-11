class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets' do
    if logged_in?
      @user = User.find_by(session[:user_id])
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params["content"] == ""
        redirect '/tweets/new'
      else
        tweet = Tweet.create(content: params["content"], user_id: session[:user_id])
        @user = User.find_by(id: tweet.user_id)
        @tweets = @user.tweets
        erb :'tweets/index'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
    #  binding.pry
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
    #  binding.pry
      if params["content"] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by(id: params[:id])
        @tweet.update(content: params["content"])
        erb :'tweets/show'
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id' do
    if logged_in?
      tweet = Tweet.find_by(id: params[:id])
      if tweet.user_id == current_user.id
        Tweet.destroy(params[:id])
        redirect '/tweets'
      else
      end
    else
      redirect '/login'
    end
  end

end
