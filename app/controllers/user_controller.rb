class UsersController < ApplicationController
    #here ill have the signup,Log in,sign out

  get '/home' do
      erb :'users/home'
  end

  get '/signup' do
      erb :'registrations/signup'
  end
       
  post '/signup' do
		user = User.new(:username => params[:username], :password => params[:password])
		if user.save
            session["user_id"] = user.id
			redirect '/home'
		else
			redirect '/signup'
		end
	end

  get '/login' do
      erb :'sessions/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session['user_id'] = @user.id
        redirect to '/home'
      else
        redirect to '/login'
      end
  end

  get "/logout" do
		session.delete("user_id")
		redirect "/"
	end
       
end
   
   
   
   
   
   