class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types
  has_many :orders

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    published.where("ends_at > ? or starts_at > ?", Time.now, Time.now)
  end

  def self.published
  	where.not(publish_at: nil)
  end

  def self.my_events(user_id)
    where(user_id: user_id)
  end

end
