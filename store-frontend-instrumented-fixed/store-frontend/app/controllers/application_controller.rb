class ApplicationController < ActionController::Base
  def append_info_to_payload(payload)
    super

    case
    when payload[:status] == 200
      payload[:level] = "INFO"
    when payload[:status] == 302
      payload[:level] = "WARN"
    else
      payload[:level] = "ERROR"
    end
  end
end
