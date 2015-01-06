# coding: utf-8
require 'fest'

if `xbacklight`.to_i == 0
  @statuses = `transmission-remote -l | awk '{ print $5 }'`.split("\n")
  @statuses -= [@statuses[0], @statuses[-1]]
  counts = 0

  @statuses.each do |status|
    counts += 1 if status == 'Done'
  end

  system('systemctl poweroff') if counts == @statuses.size
else
  @fest = Fest.new
  @fest.say('Загр+узка завершена')
end
