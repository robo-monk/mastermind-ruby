module Screen
  def self.clear
    print "\e[2J\e[f"
  end
  def self.get_live_input
    break_out = false
    while !break_out do
      case $stdin.getch
      when "\r" then break_out=true
      when "\c?"  then exit
      when "\e"   # ANSI escape sequence
        case $stdin.getch
        when '['  # CSI
          case $stdin.getch
          when 'A' then yield 'up'
          when 'B' then yield 'down'
          when 'C' then yield 'right'
          when 'D' then yield 'left'
          end
        end
      end
    end
  end
end