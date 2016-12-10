json.current_page @admin_appointments.current_page
json.total_pages @admin_appointments.total_pages
json.admin_appointments @admin_appointments, partial: 'admin_appointments/admin_appointment', as: :admin_appointment