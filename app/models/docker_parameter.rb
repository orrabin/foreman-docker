class DockerParameter < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name
  include Parameterizable::ByIdName

  attr_accessible :name, :value, :_destroy, :type, :id, :reference_id

  validates_lengths_from_database

  include Authorizable
  validates :name, :presence => true, :no_whitespace => true

  scoped_search :on => :name, :complete_value => true

  default_scope -> { order("docker_parameters.name") }

  before_validation :strip_whitespaces

  def strip_whitespaces
    self.name = self.name.strip unless name.blank?
    self.value.strip! unless value.blank?
  end
end
