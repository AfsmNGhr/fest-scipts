# coding: utf-8
require 'net/ping'

if Net::Ping::TCP.new('www.google.com', 'http').ping?

  festival = "$HOME/.bin/festival/"
  begin_update = "Внимание, запускаю обновление системы"
  clear = "Очистка системы"

  system("#{festival}say.sh '#{begin_update}'")
  system("#{festival}say.sh '#{clear}'")
  `pacman -Su`

end
