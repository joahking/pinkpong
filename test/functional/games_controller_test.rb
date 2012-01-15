require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @user = User.make!
    @game = Game.make!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end

  test "should create game" do
    sign_in @user
    assert_difference('Game.count') do
      post :create, :game => @game.attributes
    end
    assert_redirected_to game_path(assigns(:game))
  end

  test "create does not blow with invalid emails" do
    sign_in @user
    post :create, :game => { }, :loser_email => "invalid", :winner_email => "invalid", :winner_email => "invalid"
    assert_response :success
  end

  test "should show game" do
    get :show, :id => @game.to_param
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get :edit, :id => @game.to_param
    assert_response :success
  end

  test "should update game" do
    sign_in @user
    put :update, :id => @game.to_param, :game => @game.attributes
    assert_redirected_to game_path(assigns(:game))
  end

end
