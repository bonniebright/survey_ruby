class CreateRespondentsResponsesQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :survey_id
      t.timestamps
    end
    create_table :choices do |t|
      t.string :description
      t.integer :question_id
      t.timestamps
    end
    create_table :responses do |t|
      t.string :response
      t.belongs_to :respondent
      t.belongs_to :choice
      t.timestamps
    end
    create_table :respondents do |t|
      t.timestamps
   end
  end
end
