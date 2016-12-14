json.current_page @admin_appointment_items.current_page
json.total_pages @admin_appointment_items.total_pages
json.admin_appointment_items @admin_appointment_items, partial: 'admin/appointment_items/admin_appointment_item', as: :admin_appointment_item