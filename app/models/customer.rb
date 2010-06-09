class Customer
  @@crm_hash_tag = "#crm"

  def self.all(page, client, group)
    url = "#{base_url(group)}/?search_query=#{URI.encode(@@crm_hash_tag)}&format=json"
    url << "&page=#{page}" if page

    resp = client.get(url)
    JSON.parse(resp.body)
  end

  def self.find(id, client, group)
    resp = client.get("#{base_url(group)}/entries/#{id}.json")
    new(JSON.parse(resp.body))
  end

  def self.create(attr, client, group)
    resp = client.post("#{base_url(group)}/entries.json", post_body_from_attr(attr))
    [resp.code == "201", new(JSON.parse(resp.body))]
  end

  def self.update(attr, client, group, entry_id)
    resp = client.put("#{base_url(group)}/entries/#{entry_id}.json", post_body_from_attr(attr))
    [resp.code == "201", new(JSON.parse(resp.body))]
  end

  def self.post_body_from_attr(attr)
    params = { :entry => { :content => entry_content(attr), :attachment_attributes => { :attachment_type => "crm", :data => attr } } }
    single_hash = Hash[URI.decode(params.to_query).split('&').map{ |item| item.split('=')}]
  end

  def self.entry_content(attr)
    content = <<-EOF
社名:#{attr["name"]}
担当者:#{attr["account"]}
TEL:#{attr["tel"]}
Mail:#{attr["mail"]}
URL:#{attr["url"]}
#{@@crm_hash_tag}
    EOF
  end

  def self.base_url(group)
    URI.parse("#{configatron.youroom.scheme}://#{group}.#{configatron.youroom.root_host}:#{configatron.youroom.port}").to_s
  end

  def initialize(json={})
    @body = json
  end

  ATTRS = %w(name account tel mail url text).freeze

  def entry
    @body["entry"]
  end

  def attachment
    entry && entry["attachment"]
  end

  def data
    attachment && attachment["data"]
  end

  def id
    entry && entry["id"]
  end

  ATTRS.each do |item|
    define_method(item) do
      self.data && self.data[item]
    end
  end
end
