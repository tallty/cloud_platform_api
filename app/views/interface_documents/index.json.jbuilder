json.current_page @interface_documents.current_page
json.total_pages @interface_documents.total_pages
# json.interface_documents @interface_documents, partial: 'interface_documents/interface_document', as: :interface_document
json.interface_sorts @interface_sorts
json.interface_documents @interface_documents.each do |interface_document|
	json.(interface_document, :id, :title, :description, :site, :total_frequency, :total_rank, :created_at, :updated_at)
	json.is_using interface_document.is_using(@user) if @user
end  
json.interface_document_sort InterfaceDocument.index_output(@interface_documents, @interface_sorts, @user)