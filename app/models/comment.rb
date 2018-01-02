class Comment < ApplicationRecord
  belongs_to :comic

  def color
    self.like ? "green" : "red"    
  end
end
