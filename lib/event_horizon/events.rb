# encoding: utf-8

require 'active_support/concern'
require File.join(File.dirname(__FILE__), "../../app/models/event")

module EventHorizon

  module Events

    extend ActiveSupport::Concern

    module ClassMethods

      def on_event(*params)
        if params.first.is_a?(Hash)
          params = params.first
          event, callback = params.keys.first, params.values.first
        else
          event, callback = params.first, params.last
        end
        @event_callbacks ||= {}
        @event_callbacks[event] ||= []
        @event_callbacks[event] << callback
      end

      def event_callbacks_for(event)
        @event_callbacks && @event_callbacks[event]
      end

    end

    module InstanceMethods

      # Since Mongoid doesn't have polymorphic association support define
      # events associations this way...
      def events
        type = self._type || self.class.name
        Event.where(:document_id => self.id, :document_type => type)
      end

      def fire!(event, options = {})
        self.call_event_callbacks_for(event)
        self.create_event(event, options)
      end

      protected

      def create_event(event, options = {})
        params = options.except(:by, :user, :parent)
        params.reverse_merge! :name => self.to_s

        class_name = self._type || self.class.name
        user       = options[:by] || options[:user]

        ::Event.create(:event_type    => event.to_s,
                       :user_id       => user && user.id,
                       :document_id   => self.id,
                       :document_type => class_name,
                       :params        => params)
      end

      def call_event_callbacks_for(event)
        if callbacks = self.class.event_callbacks_for(event)
          callbacks.each { |method| self.send method }
        end
      end

    end

  end

end
