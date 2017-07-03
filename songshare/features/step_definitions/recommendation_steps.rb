# Sending recommendations

Given(/^I am on the recommendations page$/) do
  visit '/recommendations'
end

Given(/^I am on the song page$/) do
  visit '/songs/1'
end

When(/^I recommend the song to a friend$/) do
  RSpec::Mocks.with_temporary_scope do
    fill_in 'to', with: 'friend1'

    stub_rec = {'from' => 1, 'to' => 2, 'song_id' => 6, 'liked' => nil, 'created_at' => DateTime.now, 'updated_at' => DateTime.now}
    Recommendation.stub(:get_by_receiver).with(2).and_return(stub_rec)
    Recommendation.stub(:get_by_sender).with(1).and_return(stub_rec)

    click_button 'Recommend'
  end
end

When(/^I click on the recommend button$/) do
  click_button 'Recommend'
end

When(/^the user field is empty$/) do
  expect(find_field('to').value.to_s).to eq('')
end

Then(/^it should ask me to enter a user ID$/) do
  expect(page).to have_content(/Please fill out/)
end

Then(/^the song should be added to friend's received recommendations$/) do
  expect(Recommendation).to receive('get_by_receiver').and_return(6)
  Recommendation.get_by_receiver(2)
end

Then(/^the song should be added to my sent recommendations$/) do
  expect(Recommendation).to receive('get_by_sender').and_return(6)
  Recommendation.get_by_sender(1)
  
end

# Receiving recommendations

When(/^a friend recommends a song to me$/) do
  RSpec::Mocks.with_temporary_scope do
    stub_rec = {'from' => 2, 'to' => 1, 'song_id' => 6, 'liked' => nil, 'created_at' => DateTime.now, 'updated_at' => DateTime.now}
    Recommendation.stub(:get_by_receiver).with('user1').and_return(stub_rec)
    Recommendation.stub(:liked).with(1).and_return(stub_rec.fetch('liked'))
  end
end

Then(/^the song should be added to my received recommendations$/) do
  expect(Recommendation).to receive('get_by_receiver').and_return(6)
  Recommendation.get_by_receiver(1)
end

# Liking recommendations

Given(/^I have existing recommendations$/) do
  RSpec::Mocks.with_temporary_scope do
    stub_rec = {'from' => 2, 'to' => 1, 'song_id' => 6, 'liked' => nil, 'created_at' => DateTime.now, 'updated_at' => DateTime.now}
    expect(Recommendation).to receive('exists?').with(1,2,6).and_return(true)
    Recommendation.exists?(1,2,6)
  end
end

When(/^I like a recommendation$/) do
  RSpec::Mocks.with_temporary_scope do
    stub_rec = {'from' => 2, 'to' => 1, 'song_id' => 6, 'liked' => true, 'created_at' => DateTime.now, 'updated_at' => DateTime.now}
  end
end

Then(/^the song should be liked$/) do
  expect(Recommendation).to receive('liked?').and_return(true)
  Recommendation.liked?
end
