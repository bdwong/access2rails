class SwitchboardItem < ActiveRecord::Base
  attr_accessible :switchboard_id, :item_number, :item_text, :command, :argument

  validates :switchboard_id, :presence => true
  validates :switchboard_id, :uniqueness => true
  validates :switchboard_id, :numericality => { :only_integer => true }
  validates :item_number, :numericality => { :only_integer => true }
  validates :item_text, :length => { :maximum => 255 }
  validates :command, :numericality => { :only_integer => true }
  validates :argument, :length => { :maximum => 50 }

  include ROXML

  xml_accessor :switchboard_id, :from => "SwitchboardID"
  xml_accessor :item_number
  xml_accessor :item_text
  xml_accessor :command
  xml_accessor :argument
end