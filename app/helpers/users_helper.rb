module UsersHelper
    
    def format_basic_time(datetime)
        format("%.2f", ((datetime.hour * 60) + datetime.min) /60.0) 
    end
    def format_basic_time2(datetime)
        format("%.2f", ((datetime.hour * 60) + datetime.min) /60.0 + 1.0)
    end
end
