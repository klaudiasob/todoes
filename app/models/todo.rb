# frozen_string_literal: true

class Todo < ApplicationRecord
  belongs_to :user, optional: false

  validates :title, presence: true
end
