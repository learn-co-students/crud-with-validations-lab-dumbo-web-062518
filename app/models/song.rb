class Song < ActiveRecord::Base
  # validates :title, presence: true, uniqueness: true
  # validates :title, uniqueness: { scope: :release_year,
  #   message: "cannot be repeated by the same artist in the same year" }
  # validates :artist_name, presence: true
  # # validates :genre, presence: true
  # validate :if_release_year?
  #
  #
  # def if_release_year?
  #   if self.released && self.release_year == nil
  #     errors.add(:release_year, 'Needs a release year')
  #   elsif self.release_year != nil && self.release_year > DateTime.now.year
  #     errors.add(:release_year, 'Release year cannot be in the future.')
  #   end
  # end

 #  validates :title, presence: true
 #   validates :title, uniqueness: {
 #   scope: [:release_year, :artist_name],
 #   message: "cannot be repeated by the same artist in the same year"
 # }
 #   validates :released, inclusion: {in: [true, false]}
 #   validates :artist_name, presence: true
 #
 #   with_options if: :released? do |song|
 #     song.validates :release_year, presence: true
 #     song.validates :release_year, numericality: {
 #       less_than_or_equal_to: Date.today.year
 #     }
 #   end
 #   def released?
 #     self.released
 #   end

 validates :title, presence: true
   validates :title, uniqueness: {
     scope: [:release_year, :artist_name],
     message: "cannot be repeated by the same artist in the same year"
   }

   validates :released, inclusion: { in: [true, false] }
   validates :artist_name, presence: true

   with_options if: :released? do |song|
     song.validates :release_year, presence: true
     song.validates :release_year, numericality: {
       less_than_or_equal_to: Date.today.year
     }
   end

   def released?
     released
   end

end
