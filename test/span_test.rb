require 'test_helper'

describe Span do
  [
    [
      '06/01/2014', # January 6th
      '31/01/2012', # January 31st
      {
        :year  => 1,
        :month => 11,
        :week  => 0,
        :day   => 6
      }
    ],
    [
      '06/01/2014', # January 6th
      '22/02/2013', # February 22nd
      {
        :year  => 0,
        :month => 10,
        :week  => 2,
        :day   => 1
      }
    ],
    [
      '06/01/2014', # January 6th
      '24/02/2013', # February 24th
      {
        :year  => 0,
        :month => 10,
        :week  => 1,
        :day   => 6
      }
    ],
    [
      '07/01/2014', # January 7th
      '11/05/2013', # May 11th
      {
        :year  => 0,
        :month => 7,
        :week  => 3,
        :day   => 6
      }
    ],
    [
      '26/03/2013', # March 25th
      '01/01/2012', # January 1st
      {
        :year  => 1,
        :month => 2,
        :week  => 3,
        :day   => 4
      }
    ],
    [
      '27/01/1963', # January 27th
      '14/01/2014', # January 14th
      {
        :year  => 50,
        :month => 11,
        :week  => 2,
        :day   => 4
      }
    ],
    [
      '27/01/1963', # January 27th
      '27/02/1963', # February 27th
      {
        :year  => 0,
        :month => 1,
        :week  => 0,
        :day   => 0
      }
    ]
  ].each do | example |
    it "diff #{ example[ 0 ] } #{ example[ 1 ] }" do
      check_date = Date.parse example[ 0 ]
      birth_date = Date.parse example[ 1 ]
      expected   = example[ 2 ]

      computed =
        Span.compute \
          check_date,
          birth_date

      computed.delete_if do | key , _ |
        !expected.keys.include?( key )
      end

      computed.must_equal expected
    end
  end
end
