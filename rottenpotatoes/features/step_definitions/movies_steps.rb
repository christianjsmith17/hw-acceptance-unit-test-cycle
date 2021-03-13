
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /I should see movies with the following ratings: (.*)/ do |rating_list|
  # Make sure that only movies with selected ratings are shown
  rating_list = rating_list.split(', ')
  Movie.all.each do |movie|
    step %{I should #{(rating_list.include? movie.rating) ? '' : 'not '}see "#{movie.title}"}
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  expect(page).to have_text("Details about " + movie)
  expect(page).to have_text("Director: " + director)
end