class Photo < ApplicationRecord
    belongs_to :user #:required => false
    has_many :comments
    has_many :likes
    
    has_many :fans, :through => :likes, :source => :user
end
