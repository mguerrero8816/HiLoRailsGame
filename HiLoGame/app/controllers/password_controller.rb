class PasswordController < ApplicationController
  def check
    @uid = params[:uid]
    @pass = params[:pass]
    #need to assign returned results from checks to variables in order to avoid short circuiting in an if && statement
    @verify_uid = check_uid
    @verify_pass = check_pass
    #verify if both inputs meet the sites requirements
    if @verify_uid && @verify_pass
      @check_results = 'Credentials are Acceptable'
      cookies[:uid] = @uid
      session[:pass] = @pass
      render 'accept.html.erb'
    else
      @check_results = 'Try Again'
      render 'check.html.erb'
    end
  end

  #Purpose: determine if UID passed from the browser follows all requirements and displays the failure reason to the browser
  #Signature: nothing -> true/false
  def check_uid
    if @uid.length < 6
      @uid_failure_one = 'User ID must be longer than 5 characters'
    end
    if @uid.include?('#') || @uid.include?('!') || @uid.include?('$')
      @uid_failure_two = "User ID cannot contain '#', '$', or '!'"
    end
    @uid.length > 5 && !@uid.include?('#') && !@uid.include?('!') && !@uid.include?('$')
  end

  def check_pass
    if @pass.length < 6
      @pass_failure_one = 'Password must be longer than 5 characters'
    end
    if !@pass.include?('#') && !@pass.include?('!') && !@pass.include?('$')
      @pass_failure_two = "Password must contain '#', '$', or '!'"
    end
    @pass.length > 5 && (@pass.include?('#') || @pass.include?('!') || @pass.include?('$'))
  end
end
