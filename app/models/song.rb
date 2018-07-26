class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :genre, presence: true
  validate :release_year_when_released
  validate :release_year_in_past
  validate :not_released_already

  def release_year_in_past
    if self.released && self.release_year.to_i > Time.now.year
      errors.add(:release_year, "foo")
    end
  end

  def release_year_when_released
    if self.released && self.release_year.blank?
      errors.add(:release_year, "baz")
    end
  end

  def not_released_already
    checker = Song.where(release_year: self.release_year)
    checker.each do |song|
      if self.title == song.title
        errors.add(:title, "bar")
      end
    end
  end
end
