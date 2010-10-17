# encoding: utf-8

require 'event_horizon/helpers/event_horizon_helper'

if defined?(ActionController)
  # In order to Rails recognize our helper (EventHorizonHelper), we
  # have to use separate path for it and then tell Rails about it.
  path = File.join(File.dirname(__FILE__), 'event_horizon/helpers')
  $LOAD_PATH << path
  ActionController::Base.helpers_path << path
end