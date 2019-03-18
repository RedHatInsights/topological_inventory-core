require "manageiq/password/password_mixin"

class Authentication < ApplicationRecord
  include ManageIQ::Password::PasswordMixin
  encrypt_column :password

  belongs_to :tenant
  belongs_to :resource, :polymorphic => true

  acts_as_tenant(:tenant)
end
