# frozen_string_literal: true

require 'clearbit'

module Ps
  module Companygpt
    module Commands
      # Read Company CSV file and convert to JSON
      class ClearbitEnrichment
        attr_reader :companies

        def initialize(companies)
          @companies = companies
          Clearbit.key = ENV['CLEARBIT_KEY']
        end

        def enrich
          enrich_companies = []
          companies.each do |company|

            begin
              domain = company[:domain]
              rich_company = company.clone
              rich_company[:rich] = Clearbit::Enrichment::Company.find(domain: domain, stream: true)
              enrich_companies << rich_company

              puts "Enriched #{domain}"
            rescue StandardError => e
              puts "Error: #{e.message}"
            end
          end

          enrich_companies
        end

        def write(rich_companies, target_file)

          File.write(target_file, JSON.pretty_generate(company))
          puts "Wrote #{rich_companies.count} files to #{target_file}"
        end
      end
    end
  end
end
