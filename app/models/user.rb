class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts
  has_many :comments

  def self.authenticate(email, password)
    if self.where(email: email)[0] == self.where(password: password)[0]
      return self.where(email: email)
    else
      return nil
    end
  end
end
