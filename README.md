# Project Name: Loan Application Management

## Description

A server application designed to manage the loan application process, providing users with a multi-step form to fill out the required details. The application uses Ruby on Rails for the backend and is designed to allow progressive completion and saving of data within a complex form.

## Features

- **Multi-step Form:** Users complete a loan application form split into multiple steps, where each section corresponds to a specific set of information (e.g., loan type, address, financial details).
- **Form Progress:** The application tracks the user's progress as they complete the form, saving completed steps and redirecting the user to the appropriate step.
- **Create and Update Loans:** Users can create new loans or update existing loan information, with appropriate validations for each field.
- **Error Handling:** The app returns error messages when invalid data is entered, such as incorrect loan amount or missing required fields, ensuring a smooth user experience.

## Technologies Used

- **Ruby on Rails:** Backend framework to handle API requests, database management, and form processing.
- **ActiveModel Serializers:** For serializing loan data into JSON format for API responses.
- **RSpec:** Testing framework to ensure functionality works as expected with unit tests and request tests.

## Installation

To set up the project locally, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone <repository_url>
   cd mortgages
   bundle install
   rails db:create
   rails db:migrate
   rails db:seed
   rails server
   ```

2. **Install dependencies::**

   ```bash
    bundle install
   ```

3. **Install dependencies::**

   ```bash
    rails db:create
    rails db:migrate
    rails db:seed # Optional, if you want to seed initial data
   ```

4. **Start the Rails server:**

   ```bash
    rails server
   ```

Your application will be accessible at http://localhost:3000.
