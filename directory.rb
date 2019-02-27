@students = []

def try_load_students
  filename = ARGV.first # first argument from the commandline
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quit program
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    #add the student has to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

def print_students_list
    @students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
end

def search_by_letter
  # Search data for name beginning with:
  puts "What letter do you want to search"
  letter = STDIN.gets.chomp
  match = @students.select do |student|
    student[:name][0].include?(letter.upcase)
  end
  match.each_with_index do |student, index|
    puts "-------------------------------"
    puts "#{index + 1}. #{student[:name]}"
    puts "-------------------------------"
  end
end

def search_by_length
  # search for students less than 12 letters
  match = []
  @students.each do |student|
    if student[:name].length < 12
      match << student[:name]
    end
  end
  puts "--------------------------------"
  match.each do |student|
    puts student
  end
  puts "--------------------------------"
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
  puts "--------------------------------"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Search for students beginning with letter"
  puts "6. Search for students with name shorter than 12 characters"
  puts "9. Exit" # because we will be adding more items
end

def show_students
  # Only shows list if number of students is 1 or more
  if @students.count >= 1
    print_header
    print_students_list
    print_footer
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "5"
    search_by_letter
  when "6"
    search_by_length
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu