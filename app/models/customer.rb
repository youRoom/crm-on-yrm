class Customer

  @@group = "r5"
  attr_accessor :name, :account, :url

  def self.all(page, client)
    url = "http://#{@@group}.youroom.local:3000/?search_query=%23crm&format=json"
    url << "&page=#{page}" if page

    resp = client.get(url)
    JSON.parse(resp.body)
  end

  def self.find(id, client)
    resp = client.get("http://#{@@group}.youroom.local:3000/entries/#{id}.json")
    JSON.parse(resp.body)
  end

  def self.create(attr, client)
    content = <<-EOF
社名: #{attr["name"]}
担当者: #{attr["account"]}
URL: #{attr["url"]}
#crm
    EOF
    params = { :entry => { :content => content, :attachment_attributes => { :attachment_type => "crm", :data => attr } } }
    single_hash = Hash[URI.decode(params.to_query).split('&').map{ |item| item.split('=')}]
    resp = client.post("http://#{@@group}.youroom.local:3000/entries.json", single_hash)
    [resp.code == "201", resp]
  end
end
