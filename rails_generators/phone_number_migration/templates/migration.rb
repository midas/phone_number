class <%= class_name %>
  def self.up
    add_column :<%= table %>, :raw_<%= field %>, :string, :limit => 35
  end

  def self.down
    remove_column :<%= table %>, :raw_<%= field %>
  end
end