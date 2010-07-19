require 'forgery'
require 'machinist/active_record'

Ngo.blueprint do
  name        { Forgery(:name).company_name }
  url         { "http://#{Forgery(:internet).domain_name}/" }
  description { Forgery(:lorem_ipsum).paragraph(:random => true) }
end

Page.blueprint do
  self.title   { Forgery(:lorem_ipsum).sentence(:random => true )}
  self.key     { "some-random-key-#{sn}" }
  self.format  { 'markdown' }
  self.content { Forgery(:lorem_ipsum).paragraphs(2 + rand(10), :random => true) } 
end

User.blueprint do
  login                 { Forgery(:internet).user_name }
  display_name          { Forgery(:name).full_name }
  email                 { Forgery(:internet).email_address }
  password              { 'password' }
  password_confirmation { 'password' }
end