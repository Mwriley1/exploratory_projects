#Word Processor v. 1.0

#Methods Start------

def display_main_menu
  puts <<-MSG

  Welcome to Michael's Ruby Word Processor!

  Please select an option below.

  (S)tart a New Document
  (O)pen an Existing Document
  (D)elete a Document
  (Q)uit

  MSG
end

def display_open_file_menu
  puts <<-MSG

  Please select an option below.

  (E)dit an existing document
  (A)dd onto an existing document
  (R)eturn to the main menu

  MSG
end

def display_invalid_selection
  puts 'That is not a valid option.  Please select again.'  
end

def modify_file(file)
  loop do
    line = gets.chomp
    if line.include?('^^')
      break
    else
      file << line + "\n"
    end
  end
end

def new_or_update_file(file_name)
  File.open(file_name, 'a+') do |file|
    puts file.read
    modify_file(file)
  end
end

#Methods End------

#Main Program Start------

loop do
  display_main_menu
  user_answer = gets.chomp

  case user_answer.upcase
  when 'S'
    puts 'Please enter a name for the document.'
    file_name = gets.chomp + '.txt'
    puts "\n#{file_name} is now created. Enter '^^' to stop editing and return to the main menu at any time.\n\n"
    new_or_update_file(file_name)
  when 'O'
    loop do
      display_open_file_menu
      user_answer_open = gets.chomp

      case user_answer_open.upcase
      when 'E'
        break
      when 'A'
        puts 'Please enter the name of the document you wish to edit.'
        file_name = gets.chomp + '.txt'
        puts "\n#{file_name} is now ready to edit. Enter '^^' to stop editing and return to the main menu at any time.\n\n"
        new_or_update_file(file_name)
      when 'R'
        break
      else
        display_invalid_selection
      end
    end

  when 'D'
    puts 'Please enter the document name to be deleted.'
    file_name = gets.chomp + '.txt'
    puts "Are you sure you would like to delete #{file_name}?"
    if gets.chomp.upcase == 'Y'
      File.delete(file_name)
    end
  when 'Q'
    break
  else
    display_invalid_selection
  end
end

#Main Program End------