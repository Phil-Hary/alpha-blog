class CategoriesAddTimestamps < ActiveRecord::Migration[6.0]
  def change
		add_timestamps(:categories)
  end
end
