class AddNullFalseToShouts < ActiveRecord::Migration[6.0]
  def change
    change_column_null :shouts, :content_type, false
    change_column_null :shouts, :content_id, false
  end
end
