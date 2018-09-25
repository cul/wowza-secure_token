# frozen_string_literal: true

require 'spec_helper'

describe Wowza::SecureToken::Params do
  let(:stream)        { 'application-name/_definst_/mp4:media/sample.mp4'      }
  let(:secret)        { 'mySharedSecret'                                       }
  let(:client_ip)     { '192.168.1.2'                                          }
  let(:start_time)    { 1_537_825_243                                          }
  let(:end_time)      { 1_537_827_043                                          }
  let(:play_start)    { 15_000                                                 }
  let(:play_duration) { 10_000                                                 }
  let(:prefix)        { 'myTokenPrefix'                                        }
  let(:custom_params) { { 'CustomParameter' => 'abcdef' }                      }
  let(:params) do
    { stream: stream, secret: secret, client_ip: client_ip, starttime: start_time,
      endtime: end_time, playstart: play_start, playduration: play_duration, prefix: prefix }.merge(custom_params)
  end

  describe '#to_token' do
    subject(:token) { described_class.new(params).to_token }

    let(:expected) do
      'application-name/_definst_/mp4:media/sample.mp4?192.168.1.2&mySharedSecret' +
        '&myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043' +
        '&myTokenPrefixplayduration=10000' +
        '&myTokenPrefixplaystart=15000' +
        '&myTokenPrefixstarttime=1537825243'
    end

    it { expect(token).to eql(expected) }
  end

  describe '#to_token_hash' do
    subject(:token_hash) { described_class.new(params).to_token_hash }

    let(:expected) { 'qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A=' }

    it { expect(token_hash).to eql(expected) }
  end

  describe '#to_url_with_token_hash' do
    subject(:url_with_token_hash) { described_class.new(params).to_url_with_token_hash(host, port, stream_type) }

    let(:host) { 'wowza.example.com' }
    let(:port) { 12_345 }

    context 'when stream_type is hls' do
      let(:stream_type) { 'hls' }

      it { expect(url_with_token_hash).to eql(
        'http://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4/playlist.m3u8?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000' +
        '&myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end

    context 'when stream_type is hls-ssl' do
      let(:stream_type) { 'hls-ssl' }

      it { expect(url_with_token_hash).to eql(
        'https://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4/playlist.m3u8?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000' +
        '&myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end

    context 'when stream_type is mpeg-dash' do
      let(:stream_type) { 'mpeg-dash' }

      it { expect(url_with_token_hash).to eql(
        'http://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4/manifest.mpd?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000&' +
        'myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end

    context 'when stream_type is mpeg-dash-ssl' do
      let(:stream_type) { 'mpeg-dash-ssl' }

      it { expect(url_with_token_hash).to eql(
        'https://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4/manifest.mpd?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000&' +
        'myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end

    context 'when stream_type is rtmp' do
      let(:stream_type) { 'rtmp' }

      it { expect(url_with_token_hash).to eql(
        'rtmp://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000' +
        '&myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end

    context 'when stream_type is rtmps' do
      let(:stream_type) { 'rtmps' }

      it { expect(url_with_token_hash).to eql(
        'rtmps://wowza.example.com:12345/application-name/' +
        '_definst_/mp4:media/sample.mp4?' +
        'myTokenPrefixCustomParameter=abcdef' +
        '&myTokenPrefixendtime=1537827043&myTokenPrefixplayduration=10000' +
        '&myTokenPrefixplaystart=15000&myTokenPrefixstarttime=1537825243' +
        '&myTokenPrefixhash=qDC6giAR_0OTOP5_LuzuaHfiZP1Nb3xulvf2Axr-R2A='
      ) }
    end
  end
end
