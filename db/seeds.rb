# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#---
# Excerpted from "Agile Web Development with Rails 5",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails5 for more book information.
#---
# encoding: utf-8
Product.delete_all
Product.create!(title: 'Rails, Angular, Postgres, and Bootstrap',
  description:
    %{<p>
      <em>Powerful, Effective, and Ef jnf  iebjd kje
      </p>},
  image_url: 'dcbang.jpg',    
  price: 45.00,
  permalink: '1-a-a-a')
# . . .
Product.create!(title: 'Seven Mobile Apps in Seven Weeks',
  description:
    %{<p>
      <em>Native Apps, Multipl e Pl at forms</em>
      </p>},
  image_url: '7apps.jpg',
  price: 26.00,
  permalink: '2-a-a-a')
# . . .

Product.create!(title: 'Ruby Performance Optimization',
  description:
    %{<p>
      <em>Why Ruby Is to Fiebwf kjbwfx It</em> 
      </p>},
  image_url: 'adrpo.jpg',
  price: 46.00,
  permalink: 'as-s-d')