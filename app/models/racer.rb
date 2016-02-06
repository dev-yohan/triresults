class Racer
  include Mongoid::Document
  
  before_create do |racer|
    racer.info.id = racer.id
  end

  embeds_one :info, class_name: 'RacerInfo', as: :parent, autobuild: true
  has_many :races, class_name: 'Entrant', foreign_key: 'racer.racer_id', dependent: :nullify, order: :"race.date".desc

  delegate :first_name, :first_name=, to: :info
  delegate :last_name, :last_name=, to: :info
  delegate :gender, :gender=, to: :info
  delegate :birth_year, :birth_year=, to: :info
  delegate :city, :city=, to: :info
  delegate :state, :state=, to: :info

end