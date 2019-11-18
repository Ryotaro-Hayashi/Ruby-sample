class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    # usersカラムに論理値をとるadmin属性を追加し、デフォルトでは管理者になれないようにする。
    add_column :users, :admin, :boolean, default: false
  end
end
