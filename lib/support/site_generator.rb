class SiteGenerator

  attr_accessor :rendered_path

  def initialize(rendered_path)
    @rendered_path = rendered_path
  end

  def build_index
    FileUtils.mkdir_p(rendered_path)
    html = File.read("app/views/index.html.erb")
    template = ERB.new(html)
    result = template.result(binding)

    File.write("#{rendered_path}/index.html", result)
  end

  def build_artists_index
    @artists = Artist.all

    FileUtils.mkdir_p("#{rendered_path}/artists")
    html = File.read("app/views/artists/index.html.erb")
    template = ERB.new(html)
    result = template.result(binding)
    File.write("#{rendered_path}/artists/index.html", result)
  end

  def build_genres_index
    @genres = Genre.all

    html = File.read("app/views/genres/index.html.erb")
    template = ERB.new(html)
    result = template.result(binding) 
    FileUtils.mkdir_p("#{rendered_path}/genres")
    File.write("#{rendered_path}/genres/index.html", result)
  end

  def build_songs_index
    @songs = Song.all
    
    FileUtils.mkdir_p("#{rendered_path}/songs")
    html = File.read("app/views/songs/index.html.erb")
    template = ERB.new(html)
    result = template.result(binding)
    File.write("#{rendered_path}/songs/index.html", result)
  end

  def build_artist_page
    FileUtils.mkdir_p("#{rendered_path}/artists")
    html = File.read("app/views/artists/show.html.erb")
    template = ERB.new(html)

    Artist.all.each do |artist|
      @artist = artist   
      result = template.result(binding)
      File.write("#{rendered_path}/artists/#{artist.to_slug}.html", result)
    end
  end

  def build_genre_page
    FileUtils.mkdir_p("#{rendered_path}/genres")
    html = File.read("app/views/genres/show.html.erb")
    template = ERB.new(html)
    Genre.all.each do |genre|  
      @genre = genre
      result = template.result(binding)
      File.write("#{rendered_path}/genres/#{genre.to_slug}.html", result)
    end
  end

  def build_song_page
    FileUtils.mkdir_p("#{rendered_path}/songs")
    html = File.read("app/views/songs/show.html.erb")
    template = ERB.new(html)
    Song.all.each do |song|
      @song = song
      result = template.result(binding)
      File.write("#{rendered_path}/songs/#{song.to_slug}.html", result)
    end
  end

end
