@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    #add the student has to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    # get another name rom the user
    name = gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

def print
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
  puts "--------------------------------"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # because we will be adding more items
end

def show_students
  print_header
  print
  print_footer
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    print_menu
    # 2. read the input and save it to a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu