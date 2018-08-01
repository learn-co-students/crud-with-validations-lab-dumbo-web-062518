class Song < ActiveRecord::Base
	validates :title, presence: true, uniqueness: { scope: [:release_year, :artist_name], message: "cannot be repeated by the same artist in the same year" }
	validates :release_year, presence: true, if: :released, numericality: { less_than_or_equal_to: Date.today.year}, if: :released
end
