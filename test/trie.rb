require_relative '../trie.rb'
require 'test/unit'

class TrieTest < Test::Unit::TestCase
  def setup
    @words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    @values = [[1,2,3,4], [4,3,2,1], [1,2,4,8], [8,4,2,1], [5,6,7,8,9], [9,8,7,6], [16,32,24,48], [20,30,40,50]]
    @word_trie = Trie.new(@words)
    @values_trie = Trie.new(@values)
  end

  def test_haspath
    @words.each { |word| assert_instance_of(Trie::TrieNode, @word_trie.has_path(word)) }
    assert_false(@word_trie.has_path("eleven"))
    assert_false(@word_trie.has_path("fourr"))
    assert_false(@word_trie.has_path("seve"))
    @values.each { |value| assert_instance_of(Trie::TrieNode, @values_trie.has_path(value)) }
    assert_false(@values_trie.has_path([1,3,4]))
    assert_false(@values_trie.has_path([4,3,2]))
    assert_false(@values_trie.has_path([34,23]))
    assert_false(@values_trie.has_path([1,2,4,8,16]))
  end

  def test_hasprefix
    @words.each { |word| assert_true(@word_trie.has_prefix(word[0, rand(word.length)]))}
    @values.each { |value| assert_true(@values_trie.has_prefix(value[0, rand(value.length)]))}
    assert_false(@word_trie.has_prefix("ther"))
    assert_false(@word_trie.has_prefix("for"))
    assert_false(@word_trie.has_prefix("sixx"))
    assert_false(@values_trie.has_prefix([1,2,3,4,5]))
    assert_false(@values_trie.has_prefix([1,2,3,5]))
    assert_false(@values_trie.has_prefix([1,2,8]))
    assert_false(@values_trie.has_prefix([23]))
  end
end
