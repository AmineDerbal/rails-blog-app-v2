require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit users_url

    assert_selector 'h2', text: 'The list of users'

    User.all.each do |user|
      # Expectation: I can see the username of all other users.
      assert_selector 'a', text: user.name
      # Expectation: I can see the profile picture for each user.
      assert_selector "img[src='#{user.photo}']"
      # Expectation: I can see the number of posts each user has written.
      assert_text "Number of posts: #{user.posts.count}"
    end


    # Expectation: when I click on a user, I am redirected to that user.
    all('.user-block').each do |user_block|
      within user_block do
        user_link = find('a')
        user_link_text = user_link.text
        user_link_href = user_link['href']

        click_link user_link_text

        # Assert the resulting page or URL
        assert_current_path user_link_href
      end
    end
  end

  test 'visiting the show page' do
    user = User.first
    visit user_url(user)

    # Expectation: I can see the profile picture for each user.
    assert_selector "img[src='#{user.photo}']"

    # Expectation: I can see the username of the user.
    assert_selector 'a', text: user.name

    # Expectation: I can see the number of posts of the user.
    assert_text "Number of posts: #{user.posts.count}"

    # Expectation: I can see the bio of the user
    assert_text 'p', exact: user.bio

    # Expectation: I can see the user's 3 first posts.
    user.posts.limit(3).each do |post|
      assert_text post.title
    end

    # Expectation: I can see the button that let me view all of the user's posts.
    assert_selector 'button', text: 'See all posts'

    # Expectation: when I click on a post, I am redirected to that post.
    all('.post-content').each do |post|
      within post do
        post_link = find('a')
        post_link_text = post_link.text
        post_link['href']

        click_link post_link_text
      end
      # Assert the resulting page or URL
      assert_current_path post_link_href
    end

    # Expectation: when I click on the button, I am redirected to the user's posts.
    click_button 'See all posts'
    assert_current_path user_posts_path(user)
  end
end
