require 'minitest/autorun'
require 'minitest/pride'
require './lib/open_mic'
require './lib/user'
require './lib/joke'

class OpenMicTest < Minitest::Test
  def test_it_exists
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    assert_instance_of OpenMic, open_mic
  end

  def test_it_has_attributes
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    assert_equal 'Comedy Works', open_mic.location
    assert_equal '11-20-18', open_mic.date
  end

  def test_it_starts_with_no_performers
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    assert_equal [], open_mic.performers
  end

  def test_it_can_add_performers
    sal = User.new("Sal")
    ali = User.new("Ali")
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    open_mic.welcome(sal)
    open_mic.welcome(ali)
    assert_equal [sal, ali], open_mic.performers
  end

  def test_repeated_jokes_returns_false_when_no_jokes_are_duplicated
    joke_1 = Joke.new(1, "Why did the strawberry cross the road?", "Because his mother was in a jam.")
    joke_2 = Joke.new(2, "How do you keep a lion from charging?", "Take away its credit cards.")
    sal = User.new("Sal")
    sal.learn(joke_1)
    sal.learn(joke_2)
    ali = User.new("Ali")
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    open_mic.welcome(sal)
    open_mic.welcome(ali)
    assert_equal false, open_mic.repeated_jokes?
  end
  
  def test_repeated_jokes_returns_true_when_a_joke_is_duplicated
    joke_1 = Joke.new(1, "Why did the strawberry cross the road?", "Because his mother was in a jam.")
    joke_2 = Joke.new(2, "How do you keep a lion from charging?", "Take away its credit cards.")
    sal = User.new("Sal")
    sal.learn(joke_1)
    sal.learn(joke_2)
    ali = User.new("Ali")
    sal.tell(ali, joke_1)
    open_mic = OpenMic.new({location: "Comedy Works", date: "11-20-18"})
    open_mic.welcome(sal)
    open_mic.welcome(ali)
    assert_equal true, open_mic.repeated_jokes?
  end
end
