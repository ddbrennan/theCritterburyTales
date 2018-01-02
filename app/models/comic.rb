class Comic < ApplicationRecord
  belongs_to :tag
  has_many :comments
  accepts_nested_attributes_for :tag, reject_if: proc { |attributes| attributes['name'].blank? }

  def previous
    Comic.where(["id < ?", self.id]).last
  end

  def next
     Comic.where(["id > ?", self.id]).first
  end

  def self.search(query)
    if !query.to_s.empty?
      self.all.select {|comic| comic.tag.name.downcase == query.downcase}
    else
      self.all
    end
  end

  def rating
    if self.comments.count > 0
      "#{calc_rating}%"
    else
      "Not Yet Rated"
    end
  end

  def calc_rating
    total = self.comments.count
    good = self.comments.select {|comment| comment.like}.count
    ((good.to_f/total)*100).round(2)
  end

  def self.highest_rated
    self.all.max_by {|comic| comic.rating.to_i}
  end

  def self.lowest_rated
    self.all.min_by {|comic| comic.rating.to_i}
  end

  def self.most_hated
    self.all.max_by do |comic|
      comic.comments.select {|comment| !comment.like}.count
    end
  end

  def self.most_loved
    self.all.max_by do |comic|
      comic.comments.select {|comment| comment.like}.count
    end
  end

end
