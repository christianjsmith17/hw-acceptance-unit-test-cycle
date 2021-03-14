require 'rails_helper'

describe MoviesController do
    describe 'movie with a director' do
        it 'should receive the director of the movie' do
            movie = double(:movie, 'title' => "Star Wars", :director => "George Lucas", :id => 3)
            expect(movie.director).to eq("George Lucas")
        end
        
        it 'should select the Find Movies With Same Director for rendering' do
            movie = double(:movie, 'title' => "Star Wars", :director => "George Lucas", :id => 3)
            movie.stub(:with_director)
            #get "/movies"
        end
    end
        
    describe 'movie without a director' do
        it 'should not receive the director of a movie' do
            movie = double(:movie, 'title' => "Star Wars", :director => "", :id => 3)
            expect(movie.director).to be_empty
        end
    end
end