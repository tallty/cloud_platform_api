json.current_page @appointment_items.current_page
json.total_pages @appointment_items.total_pages
json.appointment_items @appointment_items, partial: 'appointment_items/appointment_item', as: :appointment_item