class CreateCommentHierarchies < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_hierarchies do |t|

      t.timestamps
    end
  end
end
