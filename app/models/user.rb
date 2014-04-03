class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :openid_authenticatable

  def self.build_from_identity_url(identity_url)
    User.new(:identity_url => identity_url)
  end

  # Set email as a required field from the Open ID provider
  def self.openid_required_fields
    ["email", "http://axschema.org/contact/email"]
  end

  # Accept fields from Open ID provider
  def openid_fields=(fields)
    fields.each do |key, value|
      if value.is_a? Array
        value = value.first
      end
      case key.to_s
      when "email", "http://axschema.org/contact/email"
        self.email = value
      end
    end
    # If user already exists with that email, we just update that user instead
    if user = User.find_by_email(self.email)
      user.update_attribute(:identity_url, self.identity_url)
      # Overtake attributes from existing user, as we can't change self
      self.id = user.id
    else
      # If we are a new user ...
      if self.new_record?
        if self.email.present?
          # Create this user
          self.save!
        else
          # Don't allow this user to be created
          self.email = nil
        end
      end
    end
  end
end
