# coding: utf-8
require 'gmail'
require 'fest'
require 'yaml'

Gmail.new("login", "password") do |gmail|

  @fest = Fest.new
  @labels = {"INBOX" => "Входящие", "Search job" => "Поиск работы",
             "Music" => "Музыка", "Advertising" => "Реклама",
             "Education" => "Обучение", "Interesting" => "Интересное"}

  def check_letters(gmail)
    counts = {}
    @labels.each do |k,v|
      h = {k => gmail.mailbox(k).count(:unread)}
      counts.merge!(h)
    end
    return counts
  end

  def read_counts_letters
    unless File.exist?(".gmail.yml")
      return {}
    end
    old_counts = YAML::load(File.open(".gmail.yml"))
    return old_counts
  end

  def save_counts_letters(counts)
    system("touch .gmail.yml") if File.exist?(".gmail.yml")
    File.open(".gmail.yml", "w") do |f|
      f.write counts.to_yaml
    end
  end

  def check_new_counts_letters(counts, old_counts)
    counts.each do |k, v|
      if old_counts.empty? || v < old_counts[k]
        count = v
      else
        count = v - old_counts[k]
      end
      say_new_counts(k, count)
    end
  end

  def say_new_counts(k, count)
    unless count == 0
      text = pluralform(count)
      count = "Одн+о" if count == 1
      all = "У вас #{count} #{text}"
      part = "#{count} #{text} в разделе #{@labels[k]}"

      if k == "INBOX"
        @fest.say(all)
      else
        @fest.say(part)
      end
    end
  end

  def pluralform(count)
    n = count % 100
    m = n % 10
    msg = ['сообщение',
           'сообщения',
           'сообщений']

    if n > 10 && n < 20
      return msg[2]
    elsif m > 1 && m < 5
      return msg[1]
    elsif m == 1
      return msg[0]
    else
      return msg[2]
    end
  end

  counts = check_letters(gmail)
  old_counts = read_counts_letters
  check_new_counts_letters(counts, old_counts)
  save_counts_letters(counts)
  gmail.logout

end
