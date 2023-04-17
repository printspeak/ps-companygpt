# frozen_string_literal: true

RSpec.describe Ps::Companygpt::Commands::ClearbitEnrichment do
  subject { described_class.new(companies) }

  let(:domain_file) { 'docs/data/bing-find-domains/company-domains.json' }

  let(:company_csv_au) { 'docs/data/PS_Companies_AU.csv' }
  let(:company_json_au) { 'docs/data/as_json/companies-au.json' }

  let(:company_csv_us) { 'docs/data/PS_Companies_US.csv' }
  let(:company_json_us) { 'docs/data/as_json/companies-us.json' }

  let(:companies) { Ps::Companygpt::Commands::CompanyReader.company_data(domain_file, company_csv_au, company_json_au, company_csv_us, company_json_us) }


  fit 'print companies' do
    rich_companies = subject.enrich
    subject.write(rich_companies, 'docs/data/clearbit-enrichment/enriched-companies.json')
  end
end
