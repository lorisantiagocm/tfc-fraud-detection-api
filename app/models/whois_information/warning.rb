class WhoisInformation::Warning
  attr_reader :type, :data

  def initialize(type:, data:)
    @type = type
    @data = data
  end

  def to_string
    formatted_data = if @data.is_a?(DateTime) || @data.is_a?(Time) || @data.is_a?(Date) || @data.is_a?(ActiveSupport::TimeWithZone)
                      I18n.l(@data, format: :general_dates)
    else
                      @data
    end

    I18n.t("errors.messages.#{@type}", data: formatted_data)
  end
end
