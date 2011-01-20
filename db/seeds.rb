# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Quest.create! :image_url => 'http://www.destinosdeviagem.com/wp-content/gallery/rio-janeiro/rio_de_janeiro_brazil.jpg',
              :twitter_screen_name => :photoque_st,
              :twitter_image_url => 'http://a1.twimg.com/profile_images/1146505937/photoquest-logo.png',
              :correct_answer => 'Rio de Janeiro',
              :incorrect_answer1 => 'Buenos Aires',
              :incorrect_answer2 => 'Santiago de Chile',
              :incorrect_answer3 => 'Quito',
              :incorrect_answer4 => 'Lima',
              :short_id => nil

Quest.create! :image_url => 'http://blog.decolar.com/wp-content/uploads/2010/12/Obelisco-Buenos-Aires.jpg',
              :twitter_screen_name => :photoque_st,
              :twitter_image_url => 'http://a1.twimg.com/profile_images/1146505937/photoquest-logo.png',
              :correct_answer => 'Buenos Aires',
              :incorrect_answer1 => 'Johannesburg',
              :incorrect_answer2 => 'Bogotá',
              :incorrect_answer3 => 'Asunción',
              :incorrect_answer4 => 'La Paz',
              :short_id => nil
