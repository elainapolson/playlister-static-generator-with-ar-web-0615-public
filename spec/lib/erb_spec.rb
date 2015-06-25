require "spec_helper"

describe "ERB Templates" do
  let(:abs_path) { "#{Dir.pwd}/app/views" }

  it "artists page lists genres directly from its associations" do
    artist_page_content = File.read("#{abs_path}/artists/show.html.erb")
    expect(artist_page_content).to include("@artist.genres")
    expect(artist_page_content).to include("genre.to_slug")
  end

  it "genres page lists artists directly from its associations" do
    artist_page_content = File.read("#{abs_path}/genres/show.html.erb")
    expect(artist_page_content).to include("@genre.artists")
    expect(artist_page_content).to include("artist.to_slug")
  end
end