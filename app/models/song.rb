class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :artist_name, presence: true
  validate :release_year_less_or_equal_to_current_year?
  validate :release_year_when_released_is_true?
  validate :artist_year_no_same_song?

  def release_year_less_or_equal_to_current_year?
    if self.release_year
      if self.release_year > Date.today.year
        errors.add(:release_year, "Invalid Year")
      end
    end
  end

  def release_year_when_released_is_true?
    if self.released && self.release_year == nil
      errors.add(:release_year, "Release Year Required If Album Was Released")
    end
  end

  def artist_year_no_same_song?
    same_song = nil
    same_song = Song.all.find do |song|
      (self.artist_name == song.artist_name) &&
      (self.release_year == song.release_year) &&
      (self.title == song.title)
    end
    if same_song != nil
      errors.add(:title, "Artist Cannot Release Same Song Twice In A Year")
    end
  end

end
