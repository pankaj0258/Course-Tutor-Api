# Course & Tutor API

A Ruby on Rails REST API for managing courses and tutors.

## Problem Statement

* A course can have many tutors.
* A tutor can teach only one course.

### APIs

| Method | Endpoint          | Description                  |
| ------ | ----------------- | ---------------------------- |
| POST   | `/api/v1/courses` | Create a course with tutors  |
| GET    | `/api/v1/courses` | List all courses with tutors |

## Tech Stack

* Ruby on Rails
* PostgreSQL
* RSpec
* FactoryBot
* Shoulda Matchers

## Architecture

```text
Controller
    ↓
Service Object
    ↓
Transaction
    ↓
Models
    ↓
PostgreSQL
```

* **Service Object** keeps course/tutor creation logic separate from the controller.
* **Transaction** ensures course and tutors are created atomically.
* **Serializer** controls the API response format.
* `includes(:tutors)` prevents N+1 queries.

## Example Request

### Create Course

```json
{
  "course": {
    "name": "Ruby on Rails",
    "description": "Advanced Rails course",
    "status": "active"
  },
  "tutors": [
    {
      "name": "John Doe",
      "email": "john@example.com",
      "experience_years": 5
    }
  ]
}
```

### Response

```json
{
  "id": 1,
  "name": "Ruby on Rails",
  "description": "Advanced Rails course",
  "status": "active",
  "tutors": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "experience_years": 5
    }
  ]
}
```

## Validations

* Course name and description are required.
* Course name is unique.
* Tutor name and email are required.
* Tutor email is unique.
* Tutor experience must be `>= 0`.
* Course status must be `active` or `inactive`.
* Database constraints are used for data integrity.

## Testing

Run all tests:

```bash
bundle exec rspec
```

## Setup

```bash
bundle install
bin/rails db:create
bin/rails db:migrate
bin/rails server
```

API will be available at:

```text
http://localhost:3000
```
