require 'delegate'

module HttpHeaders
  class AcceptLanguage < DelegateClass(Array)
    VERSION = '0.2.2'
  end
end
