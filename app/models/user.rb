# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  uid                    :string(255)
#  provider               :string(255)
#  image                  :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  apply_simple_captcha
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :events, :as => :eventable, :dependent => :destroy
  has_many :subscribes
  has_many :categories, through: :subscribes
  has_attached_file :image, :styles => { :original => "50x50>" }, :default_url => "/avatar.gif"

  #validates_attachment_presence :image
  #validates_attachment_size :image, :less_than => 5.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :uid, :image, :provider, :captcha, :captcha_key


end
