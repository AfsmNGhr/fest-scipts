# coding: utf-8
require 'fest'

emacs = `ps -el | grep emacsclient | wc -l`.to_i
term = `ps -el | grep terminator | wc -l`.to_i

quotes = ['Я тоже не люблю делать что-то просто, если это можно сделать через заад-ницу.',
          'Жизнь движение', 'Небо над портом было цвета экрана телевизора, настроенного на пустой канал',
          'Совер шеная технология неотличима от магии', 'Как два бай т а переслать',
          'Нельзя украсть то, что должно быть бесплатным.', 'По р+ой бездействие эффект+ивней любых поступков.',
          'Да пребудет с тобой си ла', 'Будущее уже наступило. Просто оно еще неравномерно распределен+о']

if 0 < emacs || term
  @fest = Fest.new
  @fest.say(quotes.sample)
end
