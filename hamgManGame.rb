def drawMan(t)
  top = ["_______________________", "| _____________________|", "| |          |", "| |          |", "| |          |"]
  bottom = ["| |", "| |_________________________", "|___________________________|"]
  middle = ['| |', '| |', "| |", '| |', '| |', '| |', "| |", '| |', '| |', '| |']

  head = ["| |         _|_", '| |        /. .\   ', '| |        \___/   ']
  headRest = ["| |", "| |", "| |", "| |", "| |", "| |", "| |", "| |"]

  body = ["| |          |", "| |          |", "| |          |", "| |          |"]
  bodyOne = ["| |          |", '| |         /|    ', '| |        / |    ', '| |       /  |    ', "| |          |"]
  bodyTwo = ["| |          |", '| |         /|\    ', '| |        / | \   ', '| |       /  |  \  ', "| |          |"]
  bodyEmpty = ["| |", "| |", "| |", "| |", "| |"]

  feetOne = ['| |         /     ', '| |        /      ', '| |       /       ']
  feetTwo = ['| |         / \    ', '| |        /   \   ', '| |       /     \  ']
  feetEmpty = ["| |", "| |", "| |"]

  if t == 0
    puts top.join("\n")
    puts middle.join("\n")
    puts bottom.join("\n")

  elsif t == 1
    puts top.join("\n")
    puts head.join("\n")
    puts headRest.join("\n")
    puts bottom.join("\n")

  elsif t == 2
    puts top.join("\n")
    puts head.join("\n")
    puts body.join("\n")
    puts feetEmpty.join("\n")
    puts bottom.join("\n")

  elsif t == 3
    puts top.join("\n")
    puts head.join("\n")
    puts bodyOne.join("\n")
    puts feetEmpty.join("\n")
    puts bottom.join("\n")

  elsif t == 4
    puts top.join("\n")
    puts head.join("\n")
    puts bodyTwo.join("\n")
    puts feetEmpty.join("\n")
    puts bottom.join("\n")

  elsif t == 5
    puts top.join("\n")
    puts head.join("\n")
    puts bodyTwo.join("\n")
    puts feetOne.join("\n")
    puts bottom.join("\n")

  elsif t == 6
    puts top.join("\n")
    puts head.join("\n")
    puts bodyTwo.join("\n")
    puts feetTwo.join("\n")
    puts bottom.join("\n")
  end
end

=begin
"_______________________"
"| _____________________|"
"| |          |"
"| |          |"
"| |          |"
"| |         _|_"
'| |        /. .\   '
'| |        \___/   '
"| |          |"
'| |         /|\    '
'| |        / | \   '
'| |       /  |  \  '
"| |          |"
'| |         / \    '
'| |        /   \   '
'| |       /     \  '
"| |"
"| |_________________________"
"|___________________________|"
=end

def check_letter(word, guess)
  position = []
  word = word.downcase
  wordArray = word.split("")
  wordArray.each_with_index do |checkLetter, index|
    if checkLetter == guess
      position.push index
    end
  end
  position
end

def display_result(word, gArray)
  blanks = []
  split = word.split("")
  split.each do |nothing|
    #investigate the ruby times method.
    #use split.length
    blanks.push "_"
    nothing
  end
  gArray.each do |test|
    locations = check_letter(word, test)
    locations.each do |place|
      blanks[place] = test
    end
  end
  blanks
end

#-------------------

f  = File.new("EnglishDictionary.txt", "r")
dic = f.read.split("\n")
f.close

word = dic.sample

word = word.downcase
length = word.length

gArray = []
wrong = 0
turns = -1
start = false

# Begin - Instructions
puts "\e[H\e[2J"

puts "Hello and welcome to the game hang man!!!"

puts "I will pick a RANDOM word from the English Dictionary and you'll have to guess what it is by picking letters."

puts "However, guess wisely because if you guess six letters that are not in the word, your hang man will be hanged."

puts "At any point in the game you can guess what the word is, if you get it right the game will end and you will win, but if you get it wrong a part of the mans body will be added to the drawing."

puts "Lets begin. Hit enter to continue..."
# End - Instructions

# Begin - Ready or Not
ready = gets.chomp
while true
  if ready == ""
    start = true
    break
  else
    puts ""
    puts "Please hit enter..."
    ready = gets.chomp
  end
end
# End - Ready or Not

#---------------------------------------
#---------------------------------------

# Begin - Playing


while start
  lose = false

  # Begin - What Letter Would you Like to Guess with Drawing and Etc.
  puts "\e[H\e[2J"
  puts "The word I chose is " + length.to_s + " letters long."
  drawMan(wrong)
  puts " "
  puts "You have already guessed the folowing letters: " + gArray.join(", ")
  display = display_result(word, gArray)
  puts display.join(", ")
  puts " "
  puts "What letter would you like to guess?"
  guess = gets.chomp
  # End - What Letter Would you Like to Guess with Drawing and Etc.

  if guess == word
    which = "guess"
    start == false
  end
  break if guess == word

  done = true

  # Begin - Check for two letters
  if guess.length != 1 && start == true && done == true
    bad = true
    while bad
      puts "\e[H\e[2J"
      puts "The word I chose is " + length.to_s + " letters long."
      drawMan(wrong)
      puts " "
      puts "You have already guessed the folowing letters: " + gArray.join(", ")
      display = display_result(word, gArray)
      puts display.join(", ")
      puts " "
      puts "Please remember to only guess one letter. What letter would you like to guess"
      guess = gets.chomp
      if guess.length == 1
        bad = false
      end
      if guess == word
        bad = false
        which = "guess"
        start = false
        done = true
      end
    end
  end
  # End - Check for two letters

  gArray.push guess

  # Begin - Check# if they have guessed all the letters in the word
  guessed = false
  d = display_result(word, gArray)
  e = d.join("")
  if e.to_s == word
    start = false
    which = "letters"
  end
  # End - Check if they have guessed all the letters in the word

  a = check_letter(word, guess)
  if a.empty? == true
    wrong = wrong + 1
  end

  # Begin - Check if they lost
  if wrong == 6
    start = false
    which = "lost"
  end
  # End - Check if they lost


end

# End - Playing


if which == "lost"
  puts "\e[H\e[2J"
  puts ""
  puts "You LOST!!!!!"
  puts ""
  puts "The word was '" + word.to_s + "'"
  drawMan(wrong)
elsif which == "letters"
  puts "\e[H\e[2J"
  puts "You have guessed all the correct letters."
  puts "The word was '" + word.to_s + "'"
  puts "You Win!!!!"

  puts drawMan(wrong)
elsif which == "guess"
  puts "\e[H\e[2J"
  puts "You have guessed the correct word."
  puts "The word was '" + word.to_s + "'"
  puts "You Win!!!!"

  puts drawMan(wrong)
end
