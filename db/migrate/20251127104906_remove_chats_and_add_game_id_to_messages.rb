class RemoveChatsAndAddGameIdToMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :chat_id, :bigint
    add_reference :messages, :game, foreign_key: true
    drop_table :chats
  end
end
