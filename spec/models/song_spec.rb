require_relative '../spec_helper'

describe 'Song' do
  before do
    @song = Song.create(name: "Forever More")
    @rude = Song.create(name: "Rude")
  end

  after do
    clean_database
  end

  it 'has a name' do
    expect(Song.where(name: "Forever More").first).to eq(@song)
  end

  it "has a slugified name" do
    expect(@song.to_slug).to eq("forever-more")
    expect(@rude.to_slug).to eq("rude")
  end

  it 'has a genre' do
    genre = Genre.create(name: "Rock")
    @song.genre = genre
    @song.save

    expect(Song.find_by(name: "Forever More").genre).to eq(genre)
  end

  it 'can have an artist' do
    artist = Artist.create(name: "Prince")
    @song.artist = artist
    @song.save

    expect(Song.where(name: "Forever More").first.artist).to eq(artist)
  end

  it 'can be created with an artist as an attribute' do
    artist = Artist.create(name: "The Beatles")
    song = Song.create(name: "Yellow Submarine", artist: artist)

    expect(Song.where(name: "Yellow Submarine").first.artist).to eq(artist)
  end

  it 'can build genres' do
    genre = @song.build_genre(name: "Rap")
    @song.save

    expect(Song.where(name: "Forever More").first.genre).to eq(genre)
    expect(Genre.where(name: "Rap").first.songs).to include(@song)
  end
end