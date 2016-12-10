FactoryGirl.define do
  factory :appointment do
    user nil
    interface_document nil
    aasm_state "MyString"
    start_time "2016-12-10"
    end_time "2016-12-10"
  end
end
