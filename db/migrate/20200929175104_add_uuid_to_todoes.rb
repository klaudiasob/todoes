class AddUuidToTodoes < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :uuid, :uuid, default: "gen_random_uuid()", null: false
  end
end
