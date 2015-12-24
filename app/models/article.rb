class Article < ActiveRecord::Base
  belongs_to :blog
  belongs_to :author
end
