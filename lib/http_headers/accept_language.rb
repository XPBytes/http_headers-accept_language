require 'http_headers/utils'

module HttpHeaders
  class AcceptLanguage < Utils::List
    VERSION = "0.1.0"

    def initialize(value)
      super value, entry_klazz: AcceptLanguage::Entry
      sort!
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
        index <=> other.index
      end

      def [](parameter)
        parameters.fetch(String(parameter).to_sym)
      end

      def inspect
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
