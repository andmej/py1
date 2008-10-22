class UsersController < ApplicationController

  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    
    #@users=User.find(:all)
    
    @user = User.new(params[:user])   
    

    if User.count == 0
       @user.is_admin = true
    end
    
    #############################
    #me imagino que es algo así #
    #		       	    	#
    #if @users.empty?		#
    #   @user.is_admin = true	#
    #end	       	 	#
    #				#
    #############################

    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists

    respond_to do |format|
      format.html # show.html.erb
    end
  end


end
