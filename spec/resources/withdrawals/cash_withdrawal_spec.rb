require 'spec_helper'

describe Bitex::Resources::Withdrawals::CashWithdrawal do
  describe '.all' do
    context 'without filters', vcr: { cassette_name: 'cash_withdrawals/all/without_filters' } do
      subject(:withdrawals) { client.cash_withdrawals.all }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject(:sample) { withdrawals.sample }

        it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

        its(:type) { is_expected.to eq('cash_withdrawals') }

        its(:id) { is_expected.to be_a(String) }

        its(:amount) { is_expected.to be_a(BigDecimal) }
        its(:gross_amount) { is_expected.to be_a(BigDecimal) }
        its(:cost) { is_expected.to be_a(BigDecimal) }
        its(:fee) { is_expected.to be_a(BigDecimal) }
        its(:net_amount) { is_expected.to be_a(BigDecimal) }
        its(:country) { is_expected.to be_a(String) }
        its(:payment_method) { is_expected.to be_a(Symbol) }
        its(:fiat_code) { is_expected.to be_a(Symbol) }
        its(:label) { is_expected.to be_a(String) }
        its(:created_at) { is_expected.to be_a(Time) }

        its(:'relationships.attributes.keys') { is_expected.to contain_exactly(*%w[withdrawal_instruction funding_receipt]) }

        context 'about included resources' do
          its(:withdrawal_instruction) { is_expected.to be_a(Bitex::Resources::Withdrawals::WithdrawalInstruction) }
          its(:funding_receipt) { is_expected.to be_a(Bitex::Resources::Withdrawals::InvoicingFundingReceipt) }
        end

        its(:'attributes.keys') do
          is_expected.to contain_exactly(
            *%w[type fiat_code amount id status gross_amount cost fee net_amount country payment_method label created_at]
          )
        end
      end
    end

    context 'with filters', vcr: { cassette_name: 'cash_withdrawals/all/with_filters' } do
      subject(:withdrawals) { client.cash_withdrawals.all(from: str_date) }

      let(:str_date) { '2018-01-01' }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      it 'retrieves from specified date' do
        expect(withdrawals.all? { |withdrawal| withdrawal.created_at >= str_date.to_time }).to be_truthy
      end
    end
  end

  describe '.find', vcr: { cassette_name: 'cash_withdrawals/find' } do
    subject { client.cash_withdrawals.find('28787') }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

    its(:id) { is_expected.to eq('28787') }
  end

  describe '.create', vcr: { cassette_name: 'cash_withdrawals/create' } do
    subject { client.cash_withdrawals.create(withdrawal_instruction: withdrawal_instruction, amount: amount, fiat_code: fiat_code, otp: otp) }

    let(:withdrawal_instruction) { client.withdrawal_instructions.new(id: '299') }
    let(:amount) { 150 }
    let(:fiat_code) { :ars }
    let(:otp)  { '062346' }

    it { is_expected.to be_a(Bitex::Resources::Withdrawals::CashWithdrawal) }

    its(:amount) { is_expected.to eq(amount) }
    its(:fiat_code) { is_expected.to eq(fiat_code) }
  end
end
