# encoding: utf-8

module EventHorizon

  module OrmSupport

    def self.load_event_class
      require 'event_horizon/mongoid_support/event' if defined?(::Mongoid)
    end

    def self.document_class
      if defined?(::Mongoid)
        require 'event_horizon/mongoid_support/document'
        EventHorizon::MongoidSupport::Document
      end
    end

  end

end