class MyValidator < ActiveModel::Validator
  def validate(record)
    # binding.pry
    unless record.release_year <= Date.current.year
      record.errors[:release_year] << "The release year has to be in the past"
    end
  end
end


class Song < ActiveRecord::Base
  include ActiveModel::Validations
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :released, presence: true
  validates_with MyValidator
  validates :artist_name, presence: true
end
