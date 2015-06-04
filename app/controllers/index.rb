enable :sessions

get '/' do
  @post = Post.all

  erb :'index'
end

get '/post/comment' do
  erb :"/comments/new"
end

get '/post/:id' do
  @post = Post.find(params[:id])
  @user = User.new
  session[:post_id] = @post.id
  erb :'posts/post'
end

get "/user" do
  @user = User.new
  # user = User.find_by(email: params[:email])
  # session[:id] = user.id
  # session[:email] = user.email
  erb :'signinsignup'
end

get '/login' do
erb :"/posts/login"
end

post '/login' do
  if User.authenticate(params[:email], params[:password]) != nil
    user = User.find_by(email: params[:email])
    session[:id] = user.id
    session[:email] = user.email
    redirect to("/login/#{user.id}")
  else
    redirect to('/')
  end
end

get '/login/:id' do
  if session[:id] != nil
@user = User.find_or_create_by(params["user"])
    erb :"/profile"
  else
    redirect to('/')
  end
end

post "/user/new" do

  @user = User.create(params[:user])
  session[:id] = @user.id
  session[:email] = @user.email
redirect to "/user/#{@user.id}"
end

get "/user/:id" do
  @user = User.find(params[:id])
erb :'profile'
end

get '/logout' do
  session.clear
  redirect to('/')
end

get '/posts/new' do
  @post = Post.new
  erb :"/posts/new"

end

post "/post/new" do
  @post = Post.find_or_create_by(params["post"])
  redirect to "/post/#{@post.id}"
end

post '/post/comment' do
  @post = Post.find_by(id: session[:post_id])
  post_id = @post.id

  @user = User.find_by(id: session[:id])
  user_id = @user.id

  comment = params[:comment][:body]

  Comment.create(user_id: user_id, post_id: post_id, body: comment)
  redirect to "/post/#{@post.id}"
end
