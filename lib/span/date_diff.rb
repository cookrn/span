require 'date'

module Span
  class DateDiff
    attr_reader \
      :end_date,
      :start_date

    def self.compute( *args , &block )
      new( *args , &block ).to_hash
    end

    def initialize( end_date_input , start_date_input )
      end_date   = end_date_input.to_date
      start_date = start_date_input.to_date

      if start_date > end_date
        @end_date   = start_date
        @start_date = end_date
      else
        @end_date   = end_date
        @start_date = start_date
      end
    end

    def build_diff_hash
      check_from = start_date

      [ :years , :months , :weeks , :days ].reduce Hash.new do | memo , part |
        check_from , num_of_part , part_singular =
          send \
            :"diff_#{ part }",
            check_from,
            part

        memo[ part_singular ] = num_of_part
        memo
      end
    end

    def default_diff( check_from , part , part_singular )
      num_of_part      = 0
      part_next_method = :"next_#{ part_singular }"

      loop do
        check = check_from.send part_next_method

        break if check > end_date

        check_from = check
        num_of_part += 1
      end

      [ check_from , num_of_part , part_singular ]
    end

    def diff_days( *args )
      default_diff *args , :day
    end

    def diff_months( check_from , * )
      num_of_part = 0
      part_singular = :month
      part_next_method = :"next_#{ part_singular }"

      loop do
        check = check_from.send part_next_method

        if check > end_date
          if start_date.day != check_from.day
            day   = start_date.strftime '%d'
            month = check_from.strftime '%m'
            year  = check_from.strftime '%Y'

            date_to_try =
              begin
                Date.parse "#{ day }/#{ month }/#{ year }"
              rescue ArgumentError
                false
              end

            check_from =
              if date_to_try
                date_to_try
              else
                next_month = check_from.next_month.strftime '%m'
                Date.parse( "01/#{ next_month }/#{ year }" ).prev_day
              end
          end

          break
        end

        check_from = check
        num_of_part += 1
      end

      [ check_from , num_of_part , part_singular ]
    end

    def diff_weeks( check_from , * )
      num_of_part = 0
      part_singular = :week
      part_next_method = :next_day

      loop do
        check = check_from.send part_next_method
        6.times { check = check.send part_next_method }

        break if check > end_date

        check_from = check
        num_of_part += 1
      end

      [ check_from , num_of_part , part_singular ]
    end

    def diff_years( *args )
      default_diff *args , :year
    end

    def to_hash
      @_hash ||= build_diff_hash
    end
  end
end

