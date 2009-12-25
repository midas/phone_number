class <%= class_name %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table %>, :raw_<%= field %>, :string, :limit => 35
  end

  def self.down
    remove_column :<%= table %>, :raw_<%= field %>
  end
end