json.current_page @admins.current_page
json.total_pages @admins.total_pages
json.admins @admins, partial: "admin/manager_accounts/admin_manager_account", as: :admin