class User < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates :email, format:{
    with: VALID_EMAIL_REGEX
  }

  has_secure_password

  after_destroy :ensure_an_admin_remains

  after_save :send_welcome_mail

  before_destroy do
    errors.add(:base, 'Cannot delete admin user')
    throw :abort if email == 'admin@depot.com'
  end

  before_update do
    errors.add(:base, 'Cannot update admin user')
    throw :abort if email == 'admin@depot.com'
  end

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
end