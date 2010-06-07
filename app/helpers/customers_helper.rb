module CustomersHelper

  def entry_url(entry, group)
    "http://#{group}.youroom.local:3000/entries/#{entry['id']}"
  end
end
