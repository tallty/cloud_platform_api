json.extract! admin_interface_document, :id, :title, :description, :site, :total_frequency, :total_rank, :created_at, :updated_at,
 :hour_frequency, :day_frequency, :week_frequency, :month_frequency, :year_frequency, 
 :year_rank, :month_rank, :week_rank, :day_rank, :hour_rank
json.url admin_interface_document_url(admin_interface_document, format: :json)