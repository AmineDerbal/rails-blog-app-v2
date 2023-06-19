require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  test 'visiting the index' do
    user = users(:one)
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
    posts_links = []
    all('.post-content').each do |post|
      within post do
        post_link = find('a')
        post_link_text = post_link.text
        post_link_href = post_link['href']
        posts_links << { href: post_link_href, text: post_link_text }
      end
    end
    posts_links.each do |post_link|
      click_link(post_link[:text])
      # Assert the resulting page or URL
      assert_current_path post_link[:href]
      visit user_posts_url(user)
    end
  end

  test 'visiting the show page' do
    user = users(:one)
    post = user.posts.first
    visit user_post_url(user, post)

    # Expectation: I can see the post title.
    assert_text post.title

    # Expectation: I can see who wrote the post.
    assert_text(/#{post.author.name}/)

    # Expectation: I can see how many comments it has
    assert_text "Comments: #{post.comments.count}"

    # Expectation: I can see how many likes it has
    assert_text "Likes: #{post.likes.count}"

    # Expectation: I can see the post body.
    assert_text post.text

    post.comments.each do |comment|
      # Expectation: I can see the username of each commentor.
      assert_text comment.author.name
      # Expectation: I can see the comment each commentor left.
      assert_text comment.text
    end
  end
end
