require 'jumpstart_auth'
require 'bitly'
require 'klout'

class MicroBlogger
  attr_reader :client

  def initialize
    puts "Initializing MicroBlogger"
    @client = JumpstartAuth.twitter
    Klout.api_key = 'xu9ztgnacmjx3bu82warbr3h'
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Error: longer than 140 characters!"
    end
  end

  def run
    puts "Welcome to the JSL Twitter Client!"
    command = ""
    while command != "q"
      printf "enter command: "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
        when 'q' then puts "Goodbye!"
        when 't' then tweet(parts[1..-1].join(" "))
        when 'dm' then dm(parts[1], parts[2..-1].join(" "))
        when 'all' then spam_my_followers(parts[1..-1].join(" "))
        when 'elt' then everyones_last_tweet
        when 's' then shorten(parts[1])
        when 'turl' then tweet(parts[1..-2].join(" ") + " " + shorten(parts[-1]))
        else
          puts "Sorry, I don't know how to #{command}"
      end
    end
  end

  def dm(target, message)
    screen_names = followers_list    
    puts "Trying to send #{target} this direct message: "
    puts message
    if screen_name.include?(target)
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "Error: #{target} is not a follower."
    end
  end

  def followers_list
    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name } 
    screen_names
  end

  def spam_my_followers(message)
    screen_names = followers_list
    screen_names.each do |i|
      message = "d @#{i} #{message}"
      tweet(message)
    end
  end

  def everyones_last_tweet
    # Try using hashes to sort by name
    friends = @client.friends
    friends.each do |friend|
      ts = @client.user(friend).status.created_at
      puts "#{@client.user(friend).screen_name} said this on #{ts.strftime("%A, %b %d")}..."
      puts "#{@client.user(friend).status.text}"
      puts ""
    end
  end

  def shorten(original_url)
    Bitly.use_api_version_3
    bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
    puts "Shortening this URL: #{original_url}"
    return bitly.shorten(original_url).short_url
  end

  def klout_score
    friends = @client.friends.collect{|f| @client.user(f).screen_name}
    friends.each do |friend|
      identity = Klout::Identity.find_by_screen_name(friend)
      user = Klout::User.new(identity.id)
      klout = user.score.score
      puts "#{friend} has a klout of #{klout}"
      puts ""
    end
  end
end

blogger = MicroBlogger.new
blogger.run
blogger.klout_score
