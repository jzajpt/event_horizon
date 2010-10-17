# encoding: utf-8

require 'active_support/concern'

module EventHorizon

  module MongoidSupport

    module Document

      extend ActiveSupport::Concern

      included do
        references_many :events, :as => :document, :class_name => "::Event"
      end

    end

  end

end
