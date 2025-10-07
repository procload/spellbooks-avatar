class CreateAvatars < ActiveRecord::Migration[8.0]
  def change
    create_table :avatars do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.string :klass, null: false
      t.text :traits
      t.text :image_data
      t.string :image_mime_type
      t.string :status, null: false, default: "pending"
      t.text :error_message

      t.timestamps
    end

    add_index :avatars, :status
    add_index :avatars, :created_at
  end
end
