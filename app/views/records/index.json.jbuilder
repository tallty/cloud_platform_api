json.current_page @records.current_page
json.total_pages @records.total_pages
json.records @records, partial: 'records/record', as: :record