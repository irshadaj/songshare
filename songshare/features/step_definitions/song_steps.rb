def search_song(name)
  form = Site.home.navbar.search_form
  form.query_field.set name

  form.search_button.click
end

When("I visit the top tracks page") do
  visit '/top_tracks'
end

When(/^I search for a song$/) do
  search_song('The Greatest Show On Earth')
end

Then(/^I see a list of my top tracks$/) do
  expect(Site.home.top_tracks).to have_tracks
end

Then(/^I do not see a list of my top tracks$/) do
  expect(Site.home).not_to have_top_tracks
end

Then(/^I see a list of matching songs$/) do
  expect(Site.song_results).to have_songs
end

Then(/^I see players for each song$/) do
  Site.song_results.songs.each do |song|
    expect(song).to have_player
  end
end

Then(/^I see I am on the first page$/) do
  expect(Site.song_results.paginations).not_to include(have_prev)
end

Then(/^I do not see the search bar$/) do
  expect(Site.home.navbar).not_to have_search_form
end
