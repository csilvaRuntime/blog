class ChangeArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :edit_count, :integer
  end
end
