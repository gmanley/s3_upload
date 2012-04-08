# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:user_activation, :reset_password, :remember_me, :brute_force_protection]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  # -- core --
  # What controller action to call for non-authenticated users. You can also
  # override the 'not_authenticated' method of course.
  # Default: `:not_authenticated`
  #
  # config.not_authenticated_action =


  # When a non logged in user tries to enter a page that requires login, save
  # the URL he wanted to reach, and send him there after login, using 'redirect_back_or_to'.
  # Default: `true`
  #
  # config.save_return_to_url =


  # Set domain option for cookies; Useful for remember_me submodule.
  # Default: `nil`
  #
  # config.cookie_domain =

  # --- user config ---
  config.user_config do |user|
    # -- core --
    # downcase the username before trying to authenticate, default is false
    # Default: `false`
    #
    user.downcase_username_before_authenticating = true


    # encryption algorithm name. See 'encryption_algorithm=' for available options.
    # Default: `:bcrypt`
    #
    # user.encryption_algorithm =


    # make this configuration inheritable for subclasses. Useful for ActiveRecord's STI.
    # Default: `false`
    #
    # user.subclasses_inherit_config =


    # -- user_activation --
    # how many seconds before the activation code expires. nil for never expires.
    # Default: `nil`
    #
    user.activation_token_expiration_period = 7.days


    # your mailer class. Required.
    # Default: `nil`
    #
    user.user_activation_mailer = UserMailer


    # do you want to prevent or allow users that did not activate by email to login?
    # Default: `true`
    #
    # user.prevent_non_active_users_to_login =


    # -- reset_password --
    # mailer class. Needed.
    # Default: `nil`
    #
    user.reset_password_mailer = UserMailer


    # how many seconds before the reset request expires. nil for never expires.
    # Default: `nil`
    #
    user.reset_password_expiration_period = 1.day


    # hammering protection, how long to wait before allowing another email to be sent.
    # Default: `5 * 60`
    #
    user.reset_password_time_between_emails = 10.minutes


    # -- brute_force_protection --
    # How many failed logins allowed.
    # Default: `50`
    #
    user.consecutive_login_retries_amount_limit = 10


    # How long the user should be banned. in seconds. 0 for permanent.
    # Default: `60 * 60`
    #
    user.login_lock_time_period = 2.hours
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
