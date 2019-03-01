@students = []

def students_shovel
  
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  # return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}".center(50)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist.".center(50)
    exit #quit program
  end
end

def load_a_file
  # clear students array before opening a new file
  @students = []
  puts "What file do you want to load?"
  @user_file = STDIN.gets.chomp
end

def load_students(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country, superpower = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, country: country.to_sym, superpower: superpower.to_sym}
  end
  file.close
end

def save_students
  # open the file for writing
  puts "What filename do you want to save it as"
  save_file = STDIN.gets.chomp
  file = File.open("#{save_file}", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country], student[:superpower]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def input_students
    puts "To finish, just type enter til end"
    puts "Please enter the name of the student"
    # get input from user
    name = STDIN.gets.chop
    # gives default value if empty name
    name = "I have no name" if name.empty?
    puts "Which cohort?"
    cohort = STDIN.gets.delete("\n")
    # gives default value if empty cohort
    cohort = "I do not exist" if cohort.empty?
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
end

def search_by_letter
  # Search data for name beginning with:
  puts "What letter do you want to search"
  letter = STDIN.gets.chomp
  match = @students.select do |student|
    student[:name][0].include?(letter.upcase)
  end
  match.each_with_index do |student, index|
    puts "-------------------------------".center(50)
    puts "#{index + 1}. #{student[:name]}"
    puts "-------------------------------".center(50)
  end
end

def search_by_length
  # search for students less than 12 letters
  match = []
  @students.each do |student|
    puts student[:name] if student[:name].length < 12
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "--------------------------------".center(50)
end

def list_by_cohort
  puts 'What Cohort do you want to search for'
  search_cohort = STDIN.gets.chomp.to_sym
  @students.each do |student|
    puts student[:name] if student[:cohort] == search_cohort
  end
end

def print_students_list
  # prints all students in the array
  numbers = 0
  until @students.length == numbers
    puts "#{@students[numbers][:name]} Country: #{@students[numbers][:country].to_s}, Power: #{@students[numbers][:superpower].to_s} (#{@students[numbers][:cohort].to_s} cohort)"
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
  end
end

def print_menu
  puts "1. Input the students".center(50, ('-'))
  puts "2. Show the students".center(50, ('-'))
  puts "3. Save the list to a csv".center(50, ('-'))
  puts "4. Load the list from a csv".center(50, ('-'))
  puts "5. Search for students beginning with letter".center(50, ('-'))
  puts "6. Students less than 12 characters".center(50, ('-'))
  puts "7. List students by cohort".center(50, '-')
  puts "9. Exit".center(50, ('-')) # because we will be adding more items
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
  when "5"
    search_by_letter
  when "6"
    search_by_length
  when "7"
    list_by_cohort
  when "9"
    exit
  else
    puts "I don't know what you mean, try again".center(50)
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