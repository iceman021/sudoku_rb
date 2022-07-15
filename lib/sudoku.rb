require 'matrix'
require_relative './sudoku_segment'

class Sudoku
  attr_reader :sudoku_string

  ROW_SEPARATOR = '|'
  COLUMN_SEPARATOR = '-'
  BOX_INDEXES =
  [
    { row_begin: 0, col_begin: 0 },
    { row_begin: 0, col_begin: 3 },
    { row_begin: 0, col_begin: 6 },
    { row_begin: 3, col_begin: 0 },
    { row_begin: 3, col_begin: 3 },
    { row_begin: 3, col_begin: 6 },
    { row_begin: 6, col_begin: 0 },
    { row_begin: 6, col_begin: 3 },
    { row_begin: 6, col_begin: 6 }
  ]

  def initialize(sudoku_string)
    @sudoku_string = sudoku_string
  end

  def complete
    !sudoku_string.include?('0')
  end

  def is_valid
    valid_sections?(rows) && valid_sections?(columns) && valid_sections?(sub_groups)
  end

  def rows
    @rows ||= (0..8).each_with_object([]) do |index, rows_arr|
      rows_arr << SudokuSection.new(matrix.row(index).to_a)
    end
  end

  def columns
    @columns ||= (0..8).each_with_object([]) do |index, columns_arr|
      columns_arr << SudokuSection.new(matrix.column(index).to_a)
    end
  end

  def sub_groups
    @sub_groups ||= BOX_INDEXES.each_with_object([]) do |group, sub_groups|
      sub_matrix = matrix.minor(group[:row_begin],3,group[:col_begin],3)
      sub_groups << SudokuSection.new(sub_matrix.to_a.flatten)
    end
  end

  private

  def matrix
    @matrix ||=  begin
      rows = sudoku_string_rows.each_with_object([]) do |row, acc|
        acc << create_matrix_row(row)
      end

      Matrix.rows(rows)
    end
  end

  def sudoku_string_rows
    @data ||= begin
                s = sudoku_string.split("\n")
                s.reject { |h| h.include?(COLUMN_SEPARATOR) }
              end
  end

  def create_matrix_row(row_string)
    no_separators = row_string.delete!(ROW_SEPARATOR)
    no_separators.split(//).reject { |h| h == " " }
  end

  def valid_sections?(sections)
    sections.all?(&:valid?)
  end
end