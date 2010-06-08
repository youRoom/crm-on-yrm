module CustomersHelper

  def entry_url(entry, group)
    "#{Customer.base_url(group)}/entries/#{entry['id']}"
  end
end
