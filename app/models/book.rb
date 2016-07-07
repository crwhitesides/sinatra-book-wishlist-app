class Book < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :author

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end