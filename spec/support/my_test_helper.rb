module MyTestHelperMacro
  
  def get_dutch_month(month)
    # Set dutch month names
    months = Array.new
    months[1] = 'januari'
    months[2] = 'februari'
    months[3] = 'maart'
    months[4] = 'april'
    months[5] = 'mei'
    months[6] = 'juni'
    months[7] = 'juli'
    months[8] = 'augustus'
    months[9] = 'september'
    months[10] = 'oktober'
    months[11] = 'november'
    months[12] = 'december'
    
    month = months[month]
  end
end