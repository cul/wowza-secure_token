# frozen_string_literal: true

require 'digest'
require 'base64'

module Wowza
  # docs TBD
  module SecureToken
    require 'wowza/secure_token/version'
    # docs TBD
    class Params
      attr_accessor :params

      def initialize(params = {})
        @params = params
      end

      def to_token
        key_params = localize_params.sort
        key_params =
          key_params.map { |p| p[1].to_s == '' ? p[0] : "#{p[0]}=#{p[1]}" }
        query_string = key_params.join('&')
        path = extract_path(params[:url])
        "#{path}?#{query_string}"
      end

      def to_hash(digest_alg = Digest::SHA256)
        Base64.urlsafe_encode64(digest_alg.digest(to_token))
      end

      private

      def extract_path(url)
        path = File.dirname(URI(url).path)
        path.sub!(%r{^\/}, '')
        path
      end

      def localize_params(params = @params)
        params = params.clone
        client_ip = params.delete(:client_ip)
        secret = params.delete(:secret)
        prefix = params.delete(:prefix) || ''
        # not used in localization
        params.delete(:url)
        params = params.map { |p| ["#{prefix}#{p[0]}", p[1]] }.to_h
        params[client_ip] = nil
        params[secret] = nil
        params
      end
    end
  end
end
