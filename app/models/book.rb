require 'elasticsearch/model'

class Book < ApplicationRecord
  include Books::Searchable
  before_create -> { self.uuid = SecureRandom.uuid }
  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  validates :uuid, { presence: true }
  validates :title, { presence: true, length: { maximum: 30 } }
  validates :page_size, { presence: true }

  def to_param
    uuid
  end
end
