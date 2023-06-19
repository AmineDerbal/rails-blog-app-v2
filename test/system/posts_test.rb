require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'visiting the index' do
    user = User.first
    visit user_posts_url(user)

    # Expectation: I can see the profile picture for each user.
    assert_selector "img[src='#{user.photo}']"

    # Expectation: I can see the username of the user.
    assert_text(/#{user.name}/)

    # Expectation: I can see the number of posts of the user.
    assert_text "Number of posts: #{user.posts.count}"

    user.posts.each do |post|
      # Expectation: I can see a post's title.
      assert_text post.title

      # Expectation: I can see some of the post's body
      assert_text(/#{post.text}/)
      # Expectation: I can see the first comments on a post
      assert_text post.comments.first.text
      # Expectation: I can see how many comments a post has
      assert_text "Comments: #{post.comments.count}"
      # Expectation: I can see how many likes a post has
      assert_text "Likes: #{post.likes.count}"
    end

    # Expectation: I can see a section for pagination if there are more posts than fit on the view.
    assert_selector 'button', text: 'Pagination'

    # Expectation: When I click on a post, it redirects me to that post's show page
    all('.post-content').each do |post|
      within post do
        post_link = find('a')
        post_link_text = post_link.text
        post_link['href']

        click_link post_link_text
      end
      assert_current_path post_link_href
      # Assert the resulting page or URL
    end
  end

  test 'visiting the show page' do
    user = User.first
    post = user.posts.first
    post ||= Post.create(title: 'Sample Post', text: 'Sample body', author_id: user.id, comments_counter: 0,
                         likes_counters: 0)
    visit user_post_url(user, post)

    # Expectation: I can see the post title.
    assert_text post.title

    # Expectation: I can see who wrote the post.
    assert_text(/#{post.author.name}/)


    # Expectation: I can see how many comments it has
    assert_text "Comments: #{post.comments.count}"

    # Expectation: I can see how many likes it has
    assert_text "Likes: #{post.likes.count}"

    # Expectation: I can see the username of each commentor.
    post.comments.each do |comment|
      assert_text comment.author.name
      assert_text comment.text
    end

    # Expectation: I can see the comment each commentor left.
  end
end