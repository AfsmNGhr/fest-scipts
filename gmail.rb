# coding: utf-8
require 'net/ping'
require 'gmail'
require 'fest'
require 'yaml'

if Net::Ping::TCP.new('www.gmail.com', 'http').ping?

  Gmail.new("login", "password") do |gmail|

    @fest = Fest.new
    @labels = {"INBOX" => "Входящие", "Search job" => "Поиск работы",
               "Music" => "Музыка", "Advertising" => "Реклама",
               "Education" => "Обучение", "Interesting" => "Интер+есное",
               "IT" => "Ай ти"}

    def check_counts_letters(gmail)
      counts = {}
      @labels.each do |k,v|
        h = {k => gmail.mailbox(k).count(:unread)}
        counts.merge!(h)
      end
      return counts
    end

    def read_old_counts_letters
      return {} unless File.exist?(".gmail.yml")
      old_counts = YAML::load(File.open(".gmail.yml"))
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
        text = @fest.pluralform(count, ['сообщение',
                                        'сообщения',
                                        'сообщений'])
        count = "Одн+о" if count == 1

        if k == "INBOX"
          @fest.say("У вас #{count} #{text}")
        else
          @fest.say("#{count} #{text} в разделе #{@labels[k]}")
        end
      end
    end

    counts = check_counts_letters(gmail)
    old_counts = read_old_counts_letters
    check_new_counts_letters(counts, old_counts)
    save_counts_letters(counts)
    gmail.logout

  end

end
