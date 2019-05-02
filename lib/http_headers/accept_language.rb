require 'http_headers/accept_language/version'
require 'http_headers/utils'

module HttpHeaders
  class AcceptLanguage # < DelegateClass(Array) determined by version
    def initialize(value)
      __setobj__ HttpHeaders::Utils::List.new(value, entry_klazz: Entry)
    end

    class Entry

      DELIMITER = '-'

      attr_reader :locale, :region, :language

      def initialize(locale, index:, parameters:)
        self.locale = locale
        # TODO: support extlang correctly, maybe we don't even need this
        self.language, self.region = locale.split(DELIMITER)
        self.parameters = parameters
        self.index = index

        freeze
      end

      # noinspection RubyInstanceMethodNamingConvention
      def q
        parameters.fetch(:q) { 1.0 }.to_f
      end

      def <=>(other)
        quality = other.q <=> q
        return quality unless quality.zero?
        index <=> other.send(:index)
      end

      def [](parameter)
        parameters.fetch(String(parameter).to_sym)
      end

      def to_header
        to_s
      end

      def to_s
        [locale].concat(parameters.map { |k, v| "#{k}=#{v}" }).compact.reject(&:empty?).join('; ')
      end

      private

      attr_writer :locale, :region, :language
      attr_accessor :parameters, :index
    end
  end
end
