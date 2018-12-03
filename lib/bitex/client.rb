module Bitex
  # This client connects via API to Bitex resources.
  class Client
    include Resources
    include Compliance

    attr_reader :api_key

    def initialize(api_key: nil, sandbox: false)
      @api_key = api_key
      setup_environment(sandbox)
    end

    def setup_environment(sandbox)
      Public.site = "https://#{'sandbox.' if sandbox}bitex.la/api/"
    end

    [Orderbook, Ticker, Market, Transaction, Candle, Order, Ask, Bid, Trade, Buy, Sell, BuyingBot, SellingBot,
    CashDeposit, CoinDeposit, CashDepositInstruction, CashWallet, CoinWallet, WithdrawalInstruction, CashWithdrawal,
    CoinWithdrawal, Payment, Pos, ApiKey, AllowanceSeed, NaturalDocketSeed, IdentificationSeed, NoteSeed,
    DomicileSeed, EmailSeed, ArgentinaInvoicingDetailSeed, ChileInvoicingDetailSeed, PhoneSeed].each do |resource|
      accessor = resource.name.demodulize.underscore.downcase.pluralize

      define_method(accessor) do
        instance_variable_get("@#{accessor}") || instance_variable_set("@#{accessor}", resource.build(api_key: api_key))
      end
    end
  end
end
