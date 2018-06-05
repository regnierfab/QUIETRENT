class User < ApplicationRecord
# Added by Koudoku.
  has_one :subscription

  extend FriendlyId
  friendly_id :denomination, use: :slugged
  acts_as_token_authenticatable
  after_create :welcome_to_user
  has_many :evaluations, dependent: :destroy
  has_attachment :import
  has_attachment :import_sinistralite
  has_many :locataires, dependent: :destroy
  has_many :sinistres,  through: :locataires
  has_many :fiabilites
  has_many :resolutions
  has_many :comparaisons
  validates :email, uniqueness: true
  validates :denomination, presence: true, uniqueness: { case_sensitive: false }
  validates :lastname, presence: true
  validates :firstname, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

 def should_generate_new_friendly_id?
   slug.blank? || denomination_changed?
 end


   def calculate_fiabilite_global # every update of each locataire
     if self.locataires.size > 0
       a = []
       self.locataires.each { |loc| a << loc.fiabilite_pers }
       results = a.reduce(:+) / a.size.to_f
       results_round = results.round(2)
       self.fiabilite_parc = results_round
       self.save
       return self.fiabilite_parc
     end
   end

   def self.reset_token
     a = User.all
       a.each do |user|
       user.authentication_token = nil
       user.save!
     end
   end


  def self.save_fiabilite
    a = User.all
    a.each do |user|
      f = Fiabilite.new
      f.fiabilite_parc = user.fiabilite_parc
      f.user = user
      f.date_fiabilite = Date.today
      f.save
    end
  end

  def self.up_down(id)
    diff = User.find(id).fiabilite_parc - User.find(id).fiabilites.first.fiabilite_parc
    if diff > 0
      return "<span class='span-hausse'>+#{diff} <i class='fa fa-sort-asc' aria-hidden='true'></i></span>".html_safe
    elsif diff < 0
      return "<span class='span-baisse'>-#{diff} <i class='fa fa-sort-desc' aria-hidden='true'></i></span>".html_safe
    else
      return "<span class='span-neutre'>=</span>".html_safe
    end
  end

  def self.hausse_baisse_locataires(id)
    i = User.find(id).locataires.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).count
    if i > 0
      return "<span class='span-hausse'>+#{i}</span>".html_safe
    else
      return "<span class='span-neutre'>=</span>".html_safe
    end
  end

  def self.hausse_sinistres(id)
    i = User.find(id).sinistres.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).count
    if i > 0
      return "<span class='span-hausse'>+#{i}</span>".html_safe
    elsif i < 0
      return "<span class='span-baisse'>-#{i}</span>".html_safe
    else
      return "<span class='span-neutre'>=</span>".html_safe
    end
  end


private

  def welcome_to_user
    WelcomeToUser.new(self).call
    if self.role != "Locataire"
      UserMailer.welcome(self).deliver_now
    end
  end
end
