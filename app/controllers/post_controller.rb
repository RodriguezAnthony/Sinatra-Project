class PostController < ApplicationController

    get '/posts' do
        redirect_if_not_logged_in
        @posts = current_user.posts
        erb :'/posts/index'
    end

    get '/posts/feed' do 
        redirect_if_not_logged_in
        @feed = Post.all
        erb :'/posts/feed'
    end

    get '/posts/new' do
        erb :'/posts/new'
    end

    post '/posts' do 
        post = current_user.posts.build(params['post'])
        post.save
            redirect "/posts/#{post.id}"
    end

    get '/posts/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        erb :'posts/show'
    end

    get '/posts/:id/edit' do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        erb :'posts/edit'
    end

    patch '/posts/:id' do
        redirect_if_not_logged_in
        redirect_if_not_authorized
        
        if @post.update(params["post"])
            redirect "/posts/#{@post.id}"
        else
            redirect "/posts/#{@post.id}/edit"
        end
    end

    delete "/posts/:id" do
        redirect_if_not_logged_in
        redirect_if_not_authorized

        @post.destroy

        redirect "/posts"
    end

    private
    def redirect_if_not_authorized
        @post = Post.find_by_id(params[:id])
        if @post.user_id != session["user_id"]
            redirect "/posts"
        end
    end

end