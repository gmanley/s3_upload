class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  USERNAME_PATTERN = /\A[[:graph:]]+\Z/ # Can only contain visible characters
  EMAIL_PATTERN = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

  authenticates_with_sorcery!

  validates :username, presence: true,
                       uniqueness: {case_sensitive: false},
                       format: {with: USERNAME_PATTERN}

  validates :email, presence: true,
                    uniqueness: {case_sensitive: false},
                    format: {with: EMAIL_PATTERN}

  validates :password, presence: true,
                       confirmation: true,
                       if: :password_validation_required?


  slug :username


  has_many :albums

  def remember_me
    remember_me_token.present?
  end


  protected
  def password_validation_required?
    # Password validation is required if this is a new record or
    # this is an existing user and either of the password fields are not blank.
    !persisted? || persisted? && (!password.blank? || !password_confirmation.blank?)
  end
end