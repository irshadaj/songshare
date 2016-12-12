class FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :retrieve_friends, only: :index

  def create
    friend = User.find_by_uid(params[:name])

    unless friend
      return redirect_to redirect_path, alert: "'#{params[:name]}' is not registered with Songshare"
    end

    befriend(friend)
    redirect_to redirect_path
  end

  def confirm
    friend = User.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless friend

    befriend(friend)
    redirect_to redirect_path
  end

  def destroy
    ids = [current_user.id, params[:id]]
    friendships = Friendship.where(user_id: ids, friend_id: ids)

    if friendships.exists?
      friendships.delete_all
      flash[:notice] = 'Successfully removed friend.'
    else
      flash[:alert] = 'You are not friends with this person.'
    end

    redirect_to redirect_path
  end

  private

  def befriend(friend)
    friendship = Friendship.new(user: current_user, friend: friend)

    if friendship.save
      if friendship.confirmed?
        flash[:notice] = 'You have befriended #{friend.display_name}'
      else
        flash[:notice] = 'You have sent a friend request to #{friend.display_name}'
      end
    else
      flash[:alert] = friendship.errors.full_messages.first
    end
  end

  def redirect_path
    params[:redirect_to] || root_path
  end

  def retrieve_friends
    friends = current_user.friends
    inverse_friends = current_user.inverse_friends

    @friends = friends.select { |f| f.in?(inverse_friends) }
    @incoming = inverse_friends.reject { |f| f.in?(friends) }
    @pending = friends.reject { |f| f.in?(inverse_friends) }
  end
end
