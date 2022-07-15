# SudokuSection is each serie of 9 numbers, it can be row, column or subgroup

class SudokuSection
    attr_accessor :numbers
  
    def initialize(numbers)
      @numbers = numbers
    end
    
    def to_string
      numbers.to_s
    end

    def valid?
      (0..8).each do |index|
        item = numbers[index]
        next if item == '0'
        return false if item_invalid?(item)
      end
      true
    end
    
  
    private
  
    def item_invalid?(item)
      item_count = numbers.count(item)
      item_count != 1
    end
  end