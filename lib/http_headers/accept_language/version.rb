require 'delegate'

module HttpHeaders
  class AcceptLanguage < DelegateClass(Array)
    VERSION = '0.2.1'
  end
end
