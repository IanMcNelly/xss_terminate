# This model excepts HTML sanitization on the name
class Person < ActiveRecord::Base
  has_many :entries
  xss_terminate :name, :if => false
end
