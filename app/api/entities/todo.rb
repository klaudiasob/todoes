# frozen_string_literal: true

module Entities
  class Todo < Grape::Entity
    format_with(:iso_timestamp, &:iso8601)

    expose :uuid
    expose :title
    expose :description
    expose :finished

    with_options(format_with: :iso_timestamp) do
      expose :created_at
    end
  end
end
