class AddFieldsToServices < ActiveRecord::Migration
  def change
    add_column :services, :name, :text
    add_column :services, :description, :text
  end
end
