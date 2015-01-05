# coding: utf-8
require 'fest'

if `xbacklight`.to_i == 0
  system("systemctl poweroff")
else
  text = "Загр+узка завершена"
  @fest = Fest.new
  @fest.say(text)
end
