class User < ApplicationRecord
  has_many :orders

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format:{
    with: VALID_EMAIL_REGEX
  }

  has_secure_password

  after_destroy :ensure_an_admin_remains

  after_commit :send_welcome_mail, on: [:create]

  before_destroy :ensure_not_super_admin

  before_update :ensure_not_super_admin

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end

    def send_welcome_mail
      UserMailer.welcome(id).deliver_now
    end

    def ensure_not_super_admin
      raise Error.new "Can't alter admin user." if email_was == 'admin@depot.com'
    end
end