What experiments (spikes) do I need to run?

# Set up a sample set of preset prompts for customers to help the User identify sales opportunities.

Example prompts could be:
- What kind of [`product/service name`] might [`company name`] need?
- What industry is [`company name`] in?
- Write me a brief introductory sales email to sell [`company name`] [`product/service name`].
- Find me 10 companies like [`company name`] in my territory.

## Goal:
- Test this against 100 leads.
- Explore GPT's strong points.
- Explore our own strong points (e.g., we know what printing education companies need).
- Test GPT's knowledge against our assumptions.
- Produce findings showing pros/cons, where to use GPT, and where to use other options.

## Processes

### Plan for Updating Company Data:

Clearbit (or other) will need to be called on company data from time to time.

1. Schedule periodic updates: Refresh company data on a regular basis, such as once a month or based on a configurable time interval.
2. Update local database tables: When the company data is refreshed, update the relevant local database tables to store the most recent information.
3. Implement update triggers based on rules:
   - Rule 1: If the company data has not been refreshed in the last 60 days, trigger an update.
   - Rule 2: If a user clicks on a company for view (or performs another action that suggests new company data is needed), trigger an update if the data is outdated.

By following this plan, you can ensure that your company data remains up-to-date and relevant for sales opportunities and other business needs.


### Basic Prompt List:

These are the prompts from users based on their desired outcome.

- What kind of [`product/service name`] might [`company name`] need?
- What industry is [`company name`] in?
- What are the key challenges faced by [`company name`] that our [`product/service name`] can address?
- Who are the primary competitors of [`company name`] and how can our [`product/service name`] differentiate us from them?
- What is the estimated annual revenue of [`company name`], and how can our [`product/service name`] help them increase it?
- Identify the decision-makers at [`company name`] who would be most interested in our [`product/service name`].
- Provide a list of potential upselling or cross-selling opportunities for [`company name`] based on their current usage of our [product/service name].
- Write me a brief introductory sales email to sell [`company name`] [`product/service name`].
- Find me 10 companies like [`company name`] in my territory.

### Advanced Prompt List:
- These are the prompts that we will execute against GPT using the basic prompts as input.

## New Tables:
- **Product/Service List**: List associated with each tenant.

## Questions:
- Where will we get the products and service data?
- How will we get the industry data?
  - _Use the Clearbit API to get the industry data._
  - What else can we get from Clearbit?
  - What alternatives to Clearbit are there?

## APIs/Data

### Clearbit

Clearbit's main offerings include:

- Enrichment API provides detailed information about companies and people using their domain name or email address. The data can include company size, industry, location, social media profiles, and more.
- Prospector API helps businesses find new leads and contacts by providing a list of potential customers based on specific search criteria such as job title, company size, and industry.
- Reveal API allows companies to identify anonymous website visitors by providing company information based on the visitor's IP address.
- Discovery API enables businesses to search and filter through Clearbit's entire database of companies to find new prospects and leads.

### Clearbit alternatives

- FullContact: Contact & company data enrichment
- Hunter: Email discovery & verification
- ZoomInfo: Contact & company data platform
- InsideView: Sales & marketing intelligence
- Datanyze: Technology-focused sales intelligence
- LeadIQ: Lead generation & prospecting

### Clearbit Enrichment API

Enrichment API provides detailed information about companies and people using their domain name or email address. The data can include company size, industry, location, social media profiles, and more.

**Alternative**: Linked In

```json
{
  "method": "GET",
  "url": "https://person.clearbit.com/v2/companies/find",
  "params": {
    "domain": "realnorthsydneycompany.com"
  }
}
```

```json
{
  "name": "Real North Sydney Company",
  "domain": "realnorthsydneycompany.com",
  "description": "Real North Sydney Company specializes in cloud-based software solutions.",
  "industry": "Information Technology",
  "location": "North Sydney, Australia",
  "size": "medium",
  "employees": 150,
  "phone": "+61 2 1234 5678",
  "email": "info@realnorthsydneycompany.com",
  "website": "https://www.realnorthsydneycompany.com",
  "social_accounts": {
    "linkedin": "https://www.linkedin.com/company/real-north-sydney-company",
    "twitter": "https://twitter.com/RealNSydneyCo",
    "facebook": "https://www.facebook.com/RealNorthSydneyCompany"
  }
}
```

### Prospector API

- Prospector API helps businesses find new leads and contacts by providing a list of potential customers based on specific search criteria such as job title, company size, and industry.

**Alternative**: Linked In

```json
{
  "method": "GET",
  "url": "https://prospector.clearbit.com/v1/people/search",
  "params": {
    "domain": "qlik.com",
    "location": "North Sydney, Australia"
  }
}
```

```json
{
  "results": [
    {
      "name": {
        "givenName": "Jane",
        "familyName": "Doe"
      },
      "title": "Sales Manager",
      "email": "jane.doe@qlik.com",
      "location": "North Sydney, Australia",
      "linkedin": "https://www.linkedin.com/in/jane-doe",
      "twitter": "https://twitter.com/janedoe"
    },
    {
      "name": {
        "givenName": "John",
        "familyName": "Smith"
      },
      "title": "Senior Software Engineer",
      "email": "john.smith@qlik.com",
      "location": "North Sydney, Australia",
      "linkedin": "https://www.linkedin.com/in/john-smith",
      "twitter": "https://twitter.com/johnsmith"
    }
  ]
}
```

### Clearbit Discovery API Mock

Discovery API enables businesses to search and filter through Clearbit's entire database of companies to find new prospects and leads.

**Alternative**: Google Maps

**Request:**

```json
{
  "method": "GET",
  "url": "https://discovery.clearbit.com/v1/companies/search",
  "params": {
    "location": "North Sydney, Australia",
    "company_size": "medium",
    "sort": "relevance"
  }
}
```

**Response:**

```json
{
  "results": [
    {
      "name": "Cochlear Limited",
      "domain": "cochlear.com",
      "description": "Cochlear is a global leader in implantable hearing solutions.",
      "industry": "Medical Devices",
      "phone": "+61 2 9428 6555",
      "email": "info@cochlear.com",
      "website": "https://www.cochlear.com",
      "social_accounts": {
        "linkedin": "https://www.linkedin.com/company/cochlear",
        "twitter": "https://twitter.com/CochlearGlobal",
        "facebook": "https://www.facebook.com/Cochlear"
      }
    },
    {
      "name": "Nextgen Group",
      "domain": "nextgengroup.com.au",
      "description": "Nextgen Group provides data center and connectivity solutions.",
      "industry": "Telecommunications",
      "phone": "+61 2 9965 7000",
      "email": "info@nextgengroup.com.au",
      "website": "https://www.nextgengroup.com.au",
      "social_accounts": {
        "linkedin": "https://www.linkedin.com/company/nextgen-group",
        "twitter": "https://twitter.com/nextgennetworks"
      }
    },
    {
      "name": "Marketing Eye",
      "domain": "marketingeye.com.au",
      "description": "Marketing Eye is a marketing consultancy providing integrated solutions.",
      "industry": "Marketing and Advertising",
      "phone": "1300 300 080",
      "email": "info@marketingeye.com.au",
      "website": "https://www.marketingeye.com.au",
      "social_accounts": {
        "linkedin": "https://www.linkedin.com/company/marketing-eye",
        "twitter": "https://twitter.com/MarketingEyeAUS",
        "facebook": "https://www.facebook.com/MarketingEye"
      }
    }
  ]
}
```

## Task 2: Extract a list of action points

1. Determine the source of product and service data.
2. Investigate Clearbit's capabilities and limitations.
3. Identify alternative sources of data.
4. Conduct a test of the preset prompts against 100 leads.
5. Evaluate GPT's performance against our own knowledge.
6. Produce a report with findings, including pros/cons of using GPT and other options.

MBE is a third-party provider of shipping, printing, and marketing solutions.
AlphaGraphics is a franchised print and marketing service provider.



