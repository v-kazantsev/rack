require 'rack'
class App
  def call(env)
    status =200
    headers = {'Content-Type' => "text/html"}
    body = []
    format_pattern = ""
    unknown_format = ""
    format = env["QUERY_STRING"].split( /%2C|=/)
    format.each do |f|
      case f
      when "format"
      when "year"
        format_pattern << "%Y-"
      when "month"
        format_pattern << "%m-"
      when "day"
        format_pattern << "%d-"
      when "hour"
        format_pattern << "%H-"
      when "minute"
        format_pattern << "%M-"
      when "second"
        format_pattern << "%S"
      else
        unknown_format << f << ","
      end
    end
    unless unknown_format.empty?
      unknown_format.chomp(",")
      status = 400
      format_pattern = ""
      body << "Unknown time format: [" << unknown_format << "]\n"
    else
      if format_pattern.any?
        format_pattern.chomp("-")
        time = Time.now
        time = time.strftime(format_pattern)
        body << time
      end
    end
    [ status, headers, body ]
  end
end
