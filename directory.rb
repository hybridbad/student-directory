require 'csv'
@students = []

def successful_message
  puts "Operation successful"
end

def try_load_students
  filename = ARGV.shift || "students.csv"
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit #quit program
  end
end

def load_a_file
  @students = [] # clear students array before opening a new file
  puts "What file do you want to load?"
  @user_file = STDIN.gets.chomp
end

  # File.open(filename, 'r') do |file| # code block opens file then block end closes
  #   file.each_line do |line|
  #     name, cohort, country, superpower = line.chomp.split(',')
  #     @students << {name: name, cohort: cohort.to_sym, country: country.to_sym, superpower: superpower.to_sym}
  #   end
  # end

def load_students(filename)
  CSV.foreach(filename) do |row|
    name, cohort, country, superpower = row
    @students << {name: name, cohort: cohort.to_sym, 
      country: country.to_sym, superpower: superpower.to_sym}
  end
end

def save_students
  # open the file for writing
  puts "What filename do you want to save it as"
  save_file = STDIN.gets.chomp
  CSV.open(save_file, 'wb'){ |csv| @students.each { |student| csv << student.values }}
  successful_message
end

def input_students
    puts "To finish, just type enter til end"
    puts "Please enter the name of the student"
    name = STDIN.gets.chop  # get input from user
    name = "I have no name" if name.empty? # gives default value if empty name
    puts "Which cohort?"
    cohort = STDIN.gets.delete("\n")
    # gives default value if empty cohort
    cohort = "I do not exist" if cohort.empty? # gives default value if empty cohort
  # while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: cohort.to_sym, country: :UK, superpower: :Evil}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
  end
  successful_message
end

def search_by_letter
  # Search data for name beginning with letter
  puts "What letter do you want to search"
  letter = STDIN.gets.chomp
  @students.each { |student| puts student[:name] if student[:name][0].include?(letter.upcase) }
  successful_message
end

def search_by_length
  # search for students less than 12 letters
  @students.each { |student| puts student[:name] if student[:name].length < 12 }
  successful_message
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "--------------------------------".center(50)
end

def list_by_cohort
  # Ask for search param then pass into each as a condition
  puts 'What Cohort do you want to search for'
  search_cohort = STDIN.gets.chomp.to_sym
  @students.each { |student| puts student[:name] if student[:cohort] == search_cohort }
  successful_message
end

def print_students_list
  # prints all students in the array
  numbers = 0
  until @students.length == numbers
    puts "#{@students[numbers][:name]} | Country: #{@students[numbers][:country].to_s}, Power: #{@students[numbers][:superpower].to_s} (#{@students[numbers][:cohort].to_s} cohort)"
    numbers += 1
  end
  # "#{@students[:name]}, Country: #{@students[:country]}, Superpower: #{@students[:superpower]} : (#{@students[:cohort]} cohort)"
  # stop = false
  # until stop == true do 
  #   @students.each_with_index do |student, index|
  #     puts "#{index + 1}. #{student[:name]}, Country: #{student[:country]}, Superpower: #{student[:superpower]} : (#{student[:cohort]} cohort)"
  #   end
  #   stop = true
  # end 
  successful_message
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
  puts "--------------------------------".center(50)
end


def show_students
  # Only shows list if number of students is 1 or more
  if @students.count >= 1
    print_header
    print_students_list
    print_footer
  else
    puts "Theres no students in the list!"
  end
  successful_message
end

def print_source_code
  # reads currently executed ruby file ($0) and prints source code
  puts $><<IO.read($0)
  successful_message
end

def print_menu
  puts "1. Input the students".center(50, ('-'))
  puts "2. Show the students".center(50, ('-'))
  puts "3. Save the list to a csv".center(50, ('-'))
  puts "4. Load the list from a csv".center(50, ('-'))
  puts "5. Search for students beginning with letter".center(50, ('-'))
  puts "6. Students less than 12 characters".center(50, ('-'))
  puts "7. List students by cohort".center(50, '-')
  puts "8. Print my lovely source code".center(50, '-')
  puts "9. Exit".center(50, ('-')) 
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
    load_a_file
    load_students(@user_file)
    puts "Loaded #{@students.count} from #{@user_file}" if File.exists?(@user_file)
  when "5"
    search_by_letter
  when "6"
    search_by_length
  when "7"
    list_by_cohort
  when "8"
    print_source_code
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