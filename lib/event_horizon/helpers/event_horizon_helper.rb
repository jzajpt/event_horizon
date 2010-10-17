# encoding: utf-8

module EventHorizonHelper

  def relativize_date(date)
    ago = 7.days.ago.to_date
    key = case date
          when Date.today; :today
          when Date.yesterday; :yesterday
          when ago..Date.today; [:days, date.wday]
          end
    if key.is_a? Array
      day = I18n.t("date.day_names")[key.last]
      "#{day}, #{I18n.l(date, :format => :short)}"
    elsif key
      key && I18n.t("helpers.relativize_date.#{key}")
    else
      I18n.l(date, :format => :short)
    end
  end

  def event_description(event)
    scope          = "#{event.document_type.tableize.singularize}.#{event.event_type}"
    interpolations = event_interpolations(event)
    I18n.t("helpers.event_description.#{scope}", interpolations).html_safe
  end

  def event_interpolations(event)
    interpolations = event.params.inject({}) { |h, (k, v)| h[k.to_sym] = v; h }
    interpolations[:user] = event.user.to_s
    if interpolations[:name] && event.document.present?
      method = :"link_to_#{event.document_type.downcase}"
      interpolations[:name] = send(method, event.document) if respond_to?(method)
    end
    interpolations
  rescue Mongoid::Errors::DocumentNotFound
    interpolations
  end

end
