# encoding: utf-8

require 'active_support/concern'
require 'event_horizon/events'
require 'event_horizon/orm_support'
require 'event_horizon/helpers'


module EventHorizon

  extend ActiveSupport::Concern

  include Events

end
