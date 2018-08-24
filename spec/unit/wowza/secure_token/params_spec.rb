# frozen_string_literal: true

require 'spec_helper'

describe Wowza::SecureToken::Params do
  let(:url)           { 'http://192.168.1.1:1935/vod/sample.mp4/playlist.m3u8' }
  let(:secret)        { 'mySharedSecret'                                       }
  let(:client_ip)     { '192.168.1.2'                                          }
  let(:start_time)    { 1_395_230_400                                          }
  let(:end_time)      { 1_500_000_000                                          }
  let(:prefix)        { 'myTokenPrefix'                                        }
  let(:custom_params) { { 'CustomParameter' => 'abcdef' }                      }
  let(:params) do
    { url: url, secret: secret, client_ip: client_ip, starttime: start_time,
      endtime: end_time, prefix: prefix }.merge(custom_params)
  end

  describe '#to_token' do
    subject { described_class.new(params).to_token }

    let(:expected) do
      'vod/sample.mp4?192.168.1.2&mySharedSecret'\
      '&myTokenPrefixCustomParameter=abcdef'\
      '&myTokenPrefixendtime=1500000000&myTokenPrefixstarttime=1395230400'
    end

    it { is_expected.to eql(expected) }
  end

  describe '#to_hash' do
    subject { described_class.new(params).to_hash }

    let(:expected) { 'TgJft5hsjKyC5Rem_EoUNP7xZvxbqVPhhd0GxIcA2oo=' }

    it { is_expected.to eql(expected) }
  end
end
