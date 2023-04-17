# frozen_string_literal: true

RSpec.describe Ps::Companygpt::Commands::CompanyReader do
  subject { reader }

  let(:reader) { described_class.new(company_csv, company_json, domain_file) }
  let(:domain_file) { 'docs/data/bing-find-domains/company-domains.json' }

  let(:company_csv_au) { 'docs/data/PS_Companies_AU.csv' }
  let(:company_json_au) { 'docs/data/as_json/companies-au.json' }

  let(:company_csv_us) { 'docs/data/PS_Companies_US.csv' }
  let(:company_json_us) { 'docs/data/as_json/companies-us.json' }

  let(:company_csv) { company_csv_au }
  let(:company_json) { company_json_au }

  it 'prints the JSON data' do
    subject.csv_to_json

    expect(subject.csv_to_json).to be_a(String)
  end

  it 'writes the JSON data to a file' do
    subject.csv_to_json_file
    expect(subject.csv_to_json).to be_a(String)
  end

  it 'get domain names' do
    puts subject.domain_names
  end

  context 'when getting companies' do
    let(:json) { reader.csv_to_json }

    it 'print the companies' do
      hash_array = JSON.parse(json, symbolize_names: true)
      companies = reader.extract_companies(hash_array)
      # puts JSON.pretty_generate(companies)
      # puts reader.format_companies(companies)
      puts reader.format_companies(companies.select { |company| !company[:domain].nil? })
    end

    it 'lookup company domains' do
      # reader = Ps::Companygpt::Commands::CompanyReader.new
      # hash_array = JSON.parse(subject.csv_to_json(company_csv), symbolize_names: true)
      # companies = reader.extract_companies(hash_array)
    end
  end

  it 'grab US and AU companies' do
    reader = described_class.new(company_csv_au, company_json_au, domain_file)
    json_au = reader.csv_to_json

    reader = described_class.new(company_csv_us, company_json_us, domain_file)
    json_us = reader.csv_to_json

    au_companies = reader.extract_companies(JSON.parse(json_au, symbolize_names: true)).select { |company| !company[:domain].nil? }
    us_companies = reader.extract_companies(JSON.parse(json_us, symbolize_names: true)).select { |company| !company[:domain].nil? }

    puts "AU Companies: #{au_companies.count}"
    puts "US Companies: #{us_companies.count}"
  end

  it 'grab US and AU companies #v2' do
    # def self.company_data(domain_file, company_csv_au, company_json_au, company_csv_us, company_json_us)

    companies = described_class.company_data(domain_file, company_csv_au, company_json_au, company_csv_us, company_json_us)

    puts companies
    puts "Companies: #{companies.count}"
  end
end
