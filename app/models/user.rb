class User < ActiveRecord::Base
  has_secure_password

  has_one :admin
  has_one :author

  has_many :addresses, as: :addressable

  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'receiver_id'
  mount_uploader :image, ImageUploader


  # validates :email, presence: true
  # validates :password, length: { in: 6..20 }

  def address
    self.try(:addresses).first
  end
end
