require_relative './sudoku'

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    # Your code here
    sudoku_validator = Sudoku.new(@puzzle_string)
     if sudoku_validator.is_valid
       if sudoku_validator.complete 
         return 'Sudoku is valid.'
      else
         return 'Sudoku is valid but incomplete.'
      end
      else
         return 'Sudoku is invalid.'
      end
  end
end


=begin
  Test tests work!
=end