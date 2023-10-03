class User < ApplicationRecord
    before_validation :ensure_session_token
    #SPIRE

    def generate_unique_session_token
        curr_session_token = generate_unique_session_token
        while User.exists?(session_token: curr_session_token)
            curr_session_token = generate_unique_session_token
        end
        self.session_token = curr_session_token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token
    end

    def generate_unique_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    attr_reader :password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        self.save!
    end

    def is_password?(password)
        po = BCrypt::Password.new(self.password_digest)
        po.is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end
end