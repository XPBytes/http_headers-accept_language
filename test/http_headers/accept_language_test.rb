require "test_helper"


module HttpHeaders
  class AcceptLanguageTest < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::HttpHeaders::AcceptLanguage::VERSION
    end

    def test_it_parses_empty
      AcceptLanguage.new('')
      pass 'did not break'
    end

    def test_it_parses_one
      list = AcceptLanguage.new('de-DE')
      assert_equal 1, list.length
      assert_equal 'DE', list.first.region
    end

    def test_it_parses_parameters
      list = AcceptLanguage.new('eo; foo=bar; q=0.5')
      assert_equal 1, list.length
      assert_equal 'bar', list.first[:foo]
      assert_equal 0.5, list.first.q
    end

    def test_it_parses_multiple_lines
      list = AcceptLanguage.new([
        'eo; q=0.1',
        'es-ES; foo=bar, es-MX; q=0.9'
      ])
      assert_equal 3, list.length
      assert_equal 'es-ES', list.first.locale
      assert_equal 'eo', list.last.language
      assert_equal 0.9, list[1].q
    end
  end
end
