require 'sequel'
require 'logger'


DB = Sequel.connect(adapter: 'sqlite', user: 'root', password: 'password', host: 'localhost', port: "3306",
                      database: 'pagy_test', max_connections: 10, loggers: [Logger.new($stdout)])

## For IRB
# sequel mysql2://root:password@localhost/northwind_spp

# to run minitest
require "minitest/autorun"

# colorize minitest output
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

