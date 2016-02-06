class RacerInfo
  include Mongoid::Document

  #document fields
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }
  field :fn,  type: String, as: :first_name
  field :ln,  type: String, as: :last_name
  field :g,   type: String, as: :gender
  field :yr,  type: Integer, as: :birth_year
  field :res, type: Address, as: :residence

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, inclusion: { in: %w(M F) }
  validates :birth_year, presence: true, numericality: { less_than: Date.current.year }

  embedded_in :parent, class_name: 'Racer', polymorphic: true


  ["city", "state"].each do |action|
    define_method("#{action}") do
    self.residence ? self.residence.send("#{action}") : nil
  end

  define_method("#{action}=") do |name|
    object=self.residence ||= Address.new
    object.send("#{action}=", name)
    self.residence=object
  end

end

end  