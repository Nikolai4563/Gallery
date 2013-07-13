class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  apply_simple_captcha
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy


  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :uid, :nickname, :image, :provider, :captcha, :captcha_key
  
end
