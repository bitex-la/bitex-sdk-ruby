module Bitex
  module Resources
    # Experimental endpoint: This endpoint may not be supported in further releases of the API. If your integration relies on it,
    # please contact us at developers@bitex.la explaining your use case, in order to provide you with better support.
    module Compliance
      autoload :AllowanceSeed, 'bitex/resources/private/compliance/allowance_seed'
      autoload :ArgentinaInvoicingDetailSeed, 'bitex/resources/private/compliance/argentina_invoicing_detail_seed'
      autoload :ChileInvoicingDetailSeed, 'bitex/resources/private/compliance/chile_invoicing_detail_seed'
      autoload :DomicileSeed, 'bitex/resources/private/compliance/domicile_seed'
      autoload :EmailSeed, 'bitex/resources/private/compliance/email_seed'
      autoload :IdentificationSeed, 'bitex/resources/private/compliance/identification_seed'
      autoload :NaturalDocketSeed, 'bitex/resources/private/compliance/natural_docket_seed'
      autoload :NoteSeed, 'bitex/resources/private/compliance/note_seed'
      autoload :PhoneSeed, 'bitex/resources/private/compliance/phone_seed'
    end
  end
end
