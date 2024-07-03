require_relative "test_helper"

class PagyTestSequel < Minitest::Test

	def setup	

		unless DB.table_exists?(:items)
			
			DB.create_table :items do
		  		primary_key :id
		  		String :name, unique: true, null: false
		  		DateTime :created_at
			end

			items = DB[:items]

			1.upto 100 do |i|
				items.insert(name: i.to_s, created_at: DateTime.now + i * 10)
			end
		end		
	end

	# to avoid sql injection attacks:
	# https://github.com/jeremyevans/sequel/blob/master/doc/security.rdoc#label-SQL+Injection

	def test_limit_and_offset
		assert_equal "SELECT * FROM `items` WHERE (`name` = '1') LIMIT 10 OFFSET 10", get_data_set.where(name: '1').limit(10).offset(10).sql
	end

	def test_filter_where_with_hash_syntax
		assert_equal "SELECT * FROM `items` WHERE (`name` = 'test')", get_data_set.where(name: "test").sql
	end

	def test_with_unfiltered # removes where and having clauses
		user_input = 1
		assert_equal "SELECT * FROM `items`", get_data_set.where{id > user_input}.unfiltered.sql
	end

	def test_with_unorder				
		assert_equal "SELECT * FROM `items`", get_data_set.order(:id, :name).unordered.sql
	end	

	def test_with_placeholders_1
		user_input = 1
		assert_equal 99, get_data_set.where{id > user_input}.count
	end

	def test_with_placeholders_2
		user_input = 1
		assert_equal 99, get_data_set.where{id > user_input}.count
	end


	def test_with_greater_than		
		assert_equal "SELECT * FROM `items` WHERE ((`created_at` >= '2001-02-03 04:05:06.000000') AND (`id` > 1))", get_data_set.where{(created_at >= DateTime.new(2001,2,3,4,5,6)) & (id > 1)}.sql
	end

	def test_with_placeholder_fragments
		skip
	end

	def test_with_time_concatenated_to_id
		skip
	end

	def get_data_set
		DB[:items]
	end

end