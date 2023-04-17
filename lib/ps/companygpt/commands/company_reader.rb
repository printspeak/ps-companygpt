# frozen_string_literal: true

require 'csv'
require 'json'

module Ps
  module Companygpt
    module Commands
      # Read Company CSV file and convert to JSON
      class CompanyReader
        attr_reader :source_file, :target_file, :domain_file

        def initialize(source_file, target_file, domain_file)
          @source_file = source_file
          @target_file = target_file
          @domain_file = domain_file
        end

        def self.company_data(domain_file, company_csv_au, company_json_au, company_csv_us, company_json_us)
          reader_au = self.new(company_csv_au, company_json_au, domain_file)
          json_au = reader_au.csv_to_json

          reader_us = self.new(company_csv_us, company_json_us, domain_file)
          json_us = reader_us.csv_to_json

          au_companies = reader_us.extract_companies(JSON.parse(json_au, symbolize_names: true)).select { |company| !company[:domain].nil? }
          us_companies = reader_au.extract_companies(JSON.parse(json_us, symbolize_names: true)).select { |company| !company[:domain].nil? }
          au_companies + us_companies
        end

        def csv_to_json
          hash_array = []

          CSV.foreach(source_file, headers: true, header_converters: :symbol) do |row|
            hash_array << row.to_hash
          end

          JSON.pretty_generate(hash_array)
        end

        def csv_to_json_file
          File.write(target_file, csv_to_json)
        end

        def extract_companies(hash_array)
          companies_array = []

          hash_array.each do |data|
            address_hash = {
              name: data[:name],
              street1: data[:street1],
              street2: data[:street2],
              street3: data[:street3],
              suburb: data[:suburb],
              state: data[:state],
              postcode: data[:postcode]
            }

            address_hash[:domain] = find_domain_name(data[:name])
            companies_array << address_hash
          end

          companies_array
        end

        def format_companies(companies)
          companies.map { |company| format_company(company) }.join("\n")
        end

        def format_company(company)
          formatted_address = [
            company[:street1],
            company[:street2],
            company[:street3],
            company[:suburb],
            company[:state],
            company[:postcode]
          ].compact.join(', ')

          "Company: #{company[:name]}\nDomain: #{company[:domain]}\nAddress: #{formatted_address}\n"
        end

        def domain_names
          @domain_names ||= JSON.parse(File.read(domain_file))
        end

        def find_domain_name(company_name)
          domain_names.find { |domain| domain.fetch('company', nil) == company_name }&.fetch('domain', nil)
        end
      end
    end
  end
end
