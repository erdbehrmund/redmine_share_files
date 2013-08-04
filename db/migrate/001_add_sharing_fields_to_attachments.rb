class AddSharingFieldsToAttachments < ActiveRecord::Migration
  add_column :attachments, :sharing_state, :integer, :null => false, :default => 0

end