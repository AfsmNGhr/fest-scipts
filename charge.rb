# coding: utf-8
require 'fest'

charge = `cat /sys/class/power_supply/BAT0/capacity`.to_i
status = `cat /sys/class/power_supply/BAT0/status`.chomp!
arr = ["процент", "процента", "процентов"]
critical = "Критический заряд батареи."

@fest = Fest.new
procent = @fest.pluralform(charge, arr)
text = "Заряд батареи #{charge} #{procent}"

if status == "Discharging" && charge > 10 && charge < 50
  @fest.say(text)
elsif status == "Discharging" && charge < 10
  @fest.say(critical)
end

exit
