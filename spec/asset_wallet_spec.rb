require 'spec_helper'

describe Bitex::AssetWallet do
  let(:client) { Bitex::Client.new(api_key: key, sandbox: true) }
  let(:resource_name) { described_class.name.demodulize.underscore.pluralize }
  let(:read_level_key) { 'read_level_key' }
  let(:write_level_key) { 'write_level_key' }

  shared_examples_for 'Asset Wallet' do
    it { is_expected.to be_a(described_class) }

    its(:'attributes.keys') { is_expected.to contain_exactly(*%w[type id balance available currency address auto_sell_address]) }
    its(:type) { is_expected.to eq(resource_name) }
  end

  describe '.all' do
    subject { client.asset_wallets.all }

    context 'with unauthorized key', vcr: { cassette_name: 'asset_wallets/all/unauthorized' } do
      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key', vcr: { cassette_name: 'asset_wallets/all/authorized' } do
      let(:key) { read_level_key }

      it { is_expected.to be_a(JsonApiClient::ResultSet) }

      context 'taking a sample' do
        subject { super().sample }

        it_behaves_like 'Asset Wallet'
      end
    end
  end

  describe '.find' do
    subject { client.asset_wallets.find(id: id) }

    context 'with unauthorized key', vcr: { cassette_name: 'asset_wallets/find/unauthorized' } do
      let(:id) { 1 }

      it_behaves_like 'Not enough permissions'
    end

    context 'with any level key' do
      let(:key) { read_level_key }

      context 'with non-existent id', vcr: { cassette_name: 'asset_wallets/find/non_existent_id' } do
        it_behaves_like 'Not Found'
      end

      context 'with existent id', vcr: { cassette_name: 'asset_wallets/find/authorized' } do
        let(:id) { 1 }

        it_behaves_like 'Asset Wallet'
      end
    end
  end
end