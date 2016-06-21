require_relative "../test_helper"

ActiveRecord::Base.establish_connection adapter: "postgresql", database: "ahoy_test"

ActiveRecord::Migration.create_table :ahoy_events, force: true do |t|
  t.text :properties
end

Ahoy.send(:remove_const, :Event) if defined?(Ahoy::Event)

class Ahoy::Event < ActiveRecord::Base
  include Ahoy::Properties

  self.table_name = "ahoy_events"

  serialize :properties, JSON
end

class PostgresqlTextTest < Minitest::Test
  include PropertiesTest
end