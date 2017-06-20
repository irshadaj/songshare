# Sending recommendations

Given(/^I am on the recommendations page$/) do
  visit '/recommendations/recommendations'
end

Given(/^I am on the song page$/) do
  visit '/songs/1'
end

When(/^I recommend the song to a friend$/) do
  RSpec::Mocks.with_temporary_scope do
    fill_in 'UserId', with: 'friend1'

    stub_rec = {'from'=>'user1', 'to'=>'friend1', 'song'=>'spotify:track:6wpWRoG539IchhoMppYLSV', 'liked'=>nil, 'created_at'=>DateTime.now, 'updated_at'=>DateTime.now}
    Recommendation.stub(:get_by_receiver).with('friend1').and_return(stub_rec)
    Recommendation.stub(:get_by_sender).with('user1').and_return(stub_rec)

    click_button 'Recommend'
  end
end

When(/^I click on the recommend button$/) do
  click_button 'Recommend'
end

When(/^the user field is empty$/) do
  expect(find_field('UserId').value.to_s).to eq('')
end

Then(/^it should ask me to enter a user ID$/) do
  expect(page).to have_content(/Please fill out/)
end

Then(/^the song should be added to friend's received recommendations$/) do
  expect(Recommendation).to receive('get_by_receiver').and_return('spotify:track:6wpWRoG539IchhoMppYLSV')
  Recommendation.get_by_receiver('friend1')
end

Then(/^the song should be added to my sent recommendations$/) do
  expect(Recommendation).to receive('get_by_sender').and_return('spotify:track:6wpWRoG539IchhoMppYLSV')
  Recommendation.get_by_sender('user1')
end

# Receiving recommendations

When(/^a friend recommends a song to me$/) do
  RSpec::Mocks.with_temporary_scope do
    stub_rec = {'from'=>'friend1', 'to'=>'user1', 'song'=>'spotify:track:6wpWRoG539IchhoMppYLSV', 'liked'=>true, 'created_at'=>DateTime.now, 'updated_at'=>DateTime.now}
    Recommendation.stub(:get_by_receiver).with('user1').and_return(stub_rec)
    Recommendation.stub(:liked).with('user1').and_return(stub_rec.fetch('liked'))
  end
end

Then(/^the song should be added to my received recommendations$/) do
  expect(Recommendation).to receive('get_by_receiver').and_return('spotify:track:6wpWRoG539IchhoMppYLSV')
  Recommendation.get_by_receiver('user1')
end

# Managing recommendations

Given(/^I have existing recommendations$/) do
  expect(Recommendation.exists?).to be true
end

When(/^I like a recommendation$/) do
  click_button 'Like'
end

When(/^I dislike a recommendation$/) do
  click_button 'Dislike'
end

Then(/^the song should be liked$/) do
  expect(Recommendation.liked?).to be true
end

Then(/^the song should be disliked$/) do
  expect(Recommendation.liked?).to be false
end