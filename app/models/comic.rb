class Comic < ApplicationRecord
  belongs_to :tag
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

end
