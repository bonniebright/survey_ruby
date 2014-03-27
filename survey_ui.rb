require 'active_record'
require './lib/question'
require './lib/respondent'
require './lib/choice'
require './lib/response'
require './lib/survey'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "\nWelcome to the survey menu"
  puts "----------------------"
  puts "\nPress 's' if you are a survey creator"
  puts "Press 'r' if you are a respondent"
  puts "Press 'x' to exit"
  user_input = gets.chomp
  case user_input
  when 's'
    creator_menu
  when 'r'
    respondent_menu
  when 'x'
    puts "Good-bye"
    exit
  end
end

def creator_menu
  choice = nil
  until choice == 'x'
    puts "\nSURVEY CREATOR MENU"
    puts "=================="
    puts "\nPress 'c' to create a new survey"
    puts "Press 'e' to edit a survey"
    puts "Press 'r' to look at survey results"
    puts "Press 'x' to exit to main menu"
    user_input = gets.chomp
    case user_input
    when 'c'
      survey_create_menu
    when 'e'
      survey_edit_menu
    when 'r'
      survey_results_menu
    when 'x'
      welcome
    end
  end
end

def respondent_menu
puts "◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗"
puts "Welcome to SURVEY TRON!!!"
puts "◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗◖(◣☩◢)◗"
puts "\n\n If it's your first time taking a survey with us, press 'c' to create your user id"
puts "If you already have an id, press 'l' to login, or 'x' to exit"
user_input = gets.chomp
case user_input
  when 'c'
    add_respondent
  when 'l'
    find_respondent
  when 'x'
    puts "Goodbye!!"
  else
    puts "Not a valid option!"
    respondent_menu
  end
end

def find_respondent
  puts "Please enter your respondent id"
  user_input = gets.chomp
  @respondent = Respondent.find_by(:id => user_input)
  take_survey
end

def add_respondent
  @respondent = Respondent.create
  puts "Your id is #{@respondent.id}! Thank you!"
  take_survey
end

def take_survey
find_survey
  @survey.questions.each do |question|
    puts question.name
      question.choices.each do |choice|
        puts choice.description
      end
    user_input = gets.chomp
    Response.create(:response => user_input, :respondent_id => @respondent.id, :choice_id => Choice.find_by(:description => user_input).id )
  end
  respondent_menu
end

def add_questions
  puts "Enter your question:"
  user_input = gets.chomp
  @question = Question.create(:name => user_input, :survey_id => @survey.id)
  puts "\nPlease enter an answer for your question"
  choice_input = gets.chomp
  @choice = Choice.create(:description => choice_input, :question_id => @question.id)
  puts "Would you like to add another choice to this question? y/n"
  user_input = gets.chomp
  case user_input
  when 'y'
    add_choice
  when 'n'
    creator_menu
  else
    puts "Invalid input"
  end
end

def survey_create_menu
  puts "\nPlease enter the name of your survey:"
  name_input = gets.chomp
  @survey = Survey.create(:name => name_input)
  add_questions
end

def survey_results_menu
  find_survey

  @survey.questions.each do |question|
    puts "#{question.name}"
    question.choices.each do |choice|
      percent = choice.percentage(question)
      puts "#{choice.description} - #{percent}"
    end
  end
end




def add_choice
  puts "\nPlease enter an answer:"
  answer_input = gets.chomp
  @choice = Choice.create(:description => answer_input, :question_id => @question.id)
  puts "Would you like to add another choice to this question? y/n"
  user_input = gets.chomp
  case user_input
  when 'y'
    add_choice
  when 'n'
    puts "\nWould you like to add another question to your survey? y/n"
    question_input = gets.chomp
    if  question_input == 'y'
      add_questions
    else
      creator_menu
    end
  else
    puts "Invalid input"
  end
end

def list_survey
  Survey.all.each do |survey|
    puts "#{survey.name}"
  end
end

def find_survey
  list_survey
  print "Type the name of the survey you want to select: "
  user_input = gets.chomp
  @survey = Survey.find_by name: user_input
end

def survey_edit_menu
find_survey
add_questions
end


welcome
