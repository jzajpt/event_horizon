# encoding: utf-8

require 'active_support/concern'
require 'mongoid/timestamps'


class Event

  include ::Mongoid::Document
  include ::Mongoid::Timestamps


  store_in :events

  # Document keys

  field :event_type
  field :params,          :type => Hash
  field :document_id#,     :type => ObjectID
  field :document_type

  index :created_at

  # Associations

  referenced_in :user


  # Public methods

  def document
    self.document_type.constantize.find(self.document_id)
  rescue ::Mongoid::Errors::DocumentNotFound
    nil
  end

  def day
    created_at.to_date
  end

  def same?(other)
    return unless other
    self.event_type == other.event_type &&
      self.user_id == other.user_id &&
      self.document_id == other.document_id
  end

end

