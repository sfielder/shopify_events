
Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%m/%d/%Y %I:%M ") + time.strftime("%p").downcase }