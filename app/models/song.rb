class Song < ActiveRecord::Base
  validate :valid_title?
  validates :released, inclusion: { in: [true, false] }
  validate :valid_release_year?
  validates :artist_name, presence: true

  def valid_title?
    if self.title
      if self.release_year
        if Song.where("release_year = #{self.release_year}").any? { |song| song.title.downcase == self.title.downcase }
          errors.add(:title, "already exists for this year.")
        end
      end
    else
      errors.add(:title, "cannot be blank.")
    end
  end

  def valid_release_year?
    if self.released == true
      if !self.release_year
        errors.add(:release_year, "required if song is released.")
      end
    end
    if self.release_year
      time = Time.now
      if self.release_year > time.year
        errors.add(:release_year, "cannot be set in the future.")
      end
    end
  end
end
