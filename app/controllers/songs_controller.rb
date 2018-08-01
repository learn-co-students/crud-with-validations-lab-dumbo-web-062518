class SongsController < ApplicationController
	def index
		@songs = Song.all
	end

	def show
		@song = set_song
	end

	def new
		@song = Song.new
	end

	def edit
		@song = set_song
	end

	def create
		@song = Song.create(song_params)
		if @song.valid?
			redirect_to song_path(@song)
		else 
			render :new
		end	
	end

	def update
		@song = set_song
		if @song.update(song_params)
			redirect_to song_path(@song)
		else 
			render :edit
		end
	end

	def destroy
		# binding.pry
		@song = set_song
		@song.destroy
		redirect_to songs_url
	end
		

	private

	def set_song
		Song.find(params[:id])
	end

	def song_params
		params.require(:song).permit(:title, :released, :release_year, :genre, :artist_name)
	end
end
