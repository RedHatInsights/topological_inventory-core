require "password_concern"

class Authentication < ActiveRecord::Base
  include PasswordConcern
  encrypt_column :password

  belongs_to :resource, :polymorphic => true
end
