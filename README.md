# README

# GeoLocation API Documentation

# Requirement

Testing Task - Ruby API - Geolocation with external integration
Need to write a simple API backed by any kind of database. The application should be able to store
geolocation data in the database, based on IP address or URL. You can use https://ipstack.com/ as a
service provider for geolocation data. The API should be able to add, delete or provide geolocation data on
the base of ip address or URL.
## **Application specification:**
It should be a RESTful API

Keep it mind that the geolocation module should be written in the way that in the future it should be easy to
change the service provider.

It is preferable that the API operates using JSON (for both input and output). Ideally it should follow JSON
API standard.

The solution should also include base specs/tests coverage. If you don’t have enough time, write complete
specs for selected endpoint or module.

As a bonus you can make all endpoints secure, not available to public.


How to submit: Create a public Git repository and share the link with us
Notes:

Pay special attention to handling errors and edge cases. We will test the behavior of the system under
various “unfortunate” conditions.

We will run the application on our local machines for testing purposes. This implies that the solution should

provide a quick and easy way to get the system up and running, including test data (hint: you can add
Docker support so we can run it easily)


## **Prerequisites**
To run this application, you need the following:
- **Ruby**: 3.2.2
- **PostgreSQL**: Ensure PostgreSQL is installed and running.
- **Docker**: For containerized deployment.

## **Docker Setup**
### **Install Docker:**
- Download and install Docker from Docker's official website for your operating system (Windows, Mac, or Linux).

### **Install Docker Compose:**
- Docker Compose is included with Docker Desktop for Windows and Mac. For Linux, follow these instructions to install Docker Compose separately.

## **Setup the Application**
### **Clone the Repository:**
git clone https://github.com/swathipasham/GeoLocationApiAssignment.git

### Build Docker Image:**
docker-compose build

### Setup the Database:**
- For Development Environment:

docker-compose run web rails db:create

docker-compose run web rails db:migrate

- For Test Environment:

docker-compose run web rails db:create RAILS_ENV=test

docker-compose run web rails db:migrate RAILS_ENV=test

### Add Environment Variables:**
- Set IPSTACK_API_KEY and API_TOKEN for authorization in your environment variables.

### Start the Application:**

docker-compose up

### Running Tests**
- To run the test suite:

  docker-compose run web rspec


### Geolocation API**
This RESTful API manages geolocation data based on IP address or URL.

### Features

- Create Geolocation: Create geolocation by fetching data from the ser ice provider based on a given IP address or URL.
- Fetch Geolocation by ID: Retrieve geolocation data using a specific Geolocation ID.
- Destroy Geolocation Record: Delete a geolocation record by its ID.
- API Key Authentication: Endpoints are protected with API key authentication.
- Input Validation: Validations are in place for IP addresses and URLs.
- JSON API Serialization: Responses are serialized in JSON API format.
- Error Handling: Proper error handling for API requests.
- Test Coverage: Includes tests for all endpoints.

### API Endpoints Details**

# GeoLocation API Documentation

## **API Endpoints**

### **Create Geolocation**
- **Endpoint:** `POST /api/v1/geolocations`
- **Description:** Creates a new geolocation record based on IP address or URL.
- **Headers:**
  - `Authorization: Bearer <API_TOKEN>`
  - `Content-Type: application/json`
- **Parameters:**
  - `ip_address` (string, optional): The IP address for which to fetch geolocation data.
  - `url` (string, optional): The URL for which to fetch geolocation data.
- **Responses:**
  - **Success:** 
    - **Status:** `201 Created`
    - **Body:**
      ```json
      {
        "city": "Glenmont",
        "country": "United States",
        "region": "Ohio",
        ...
      }
      ```
  - **Errors:**
    - **Status:** `401 Unauthorized`
      - **Body:**
        ```json
        {
          "error": "Unauthorized"
        }
        ```
    - **Status:** `422 Unprocessable Entity`
      - **Body:**
        ```json
        {
          "error": "Invalid IP address or URL"
        }
        ```

### **Show Geolocation**
- **Endpoint:** `GET /api/v1/geolocations/:id`
- **Description:** Retrieves geolocation data for a specific geolocation ID.
- **Headers:**
  - `Authorization: Bearer <API_TOKEN>`
- **Parameters:**
  - `id` (string): The ID of the geolocation record.
- **Responses:**
  - **Success:** 
    - **Status:** `200 OK`
    - **Body:**
      ```json
      {
        "city": "Glenmont",
        "country": "United States",
        "region": "Ohio",
        ...
      }
      ```
  - **Errors:**
    - **Status:** `404 Not Found`

### **Delete Geolocation**
- **Endpoint:** `DELETE /api/v1/geolocations/:id`
- **Description:** Deletes a specific geolocation record.
- **Headers:**
  - `Authorization: Bearer <API_TOKEN>`
- **Parameters:**
  - `id` (string): The ID of the geolocation record.
- **Responses:**
  - **Success:** 
    - **Status:** `200 OK`
    - **Body:**
      ```json
      {
        "content": "Successfully Deleted location."
      }
      ```
  - **Errors:**
    - **Status:** `404 Not Found`

### TODO
- JWT Authentication: Implement JSON Web Token (JWT) authentication for secure access.
- Caching: Implement caching to improve performance.
- Rack-Attack: Integrate Rack-Attack for rate limiting and protection against abusive requests.
