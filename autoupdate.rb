# coding: utf-8
require 'net/ping'
require 'fest'

if Net::Ping::TCP.new('www.google.com', 'http').ping?
  @fest = Fest.new
  @fest.say('Внимание, запускаю обновление системы')
  @fest.say('Очистка системы')
  system('pacman -Rns $(pacman -Qtdq)')
end
