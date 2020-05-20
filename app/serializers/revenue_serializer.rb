class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue
  set_id 'nil?'
end
