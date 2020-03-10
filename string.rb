require_relative 'abstract/enumerable.rb'
require_relative 'abstract/jubilist.rb'

class String
  include Enumerable
  def each
    return to_enum(:each) unless block_given?
    each_char { |char| yield char }
  end

  include JubiList
end
