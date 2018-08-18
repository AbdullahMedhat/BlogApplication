class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string     :title,              null: false, default: ''
      t.string     :description,        null: false, default: ''
      t.text       :content,            null: false, default: ''
      t.belongs_to :user,               null: false, index: true
      t.integer    :state,              default: 'drafted'
      t.timestamps
    end
  end
end
