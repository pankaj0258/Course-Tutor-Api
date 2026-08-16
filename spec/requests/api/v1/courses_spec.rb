require "rails_helper"

RSpec.describe "Courses API", type: :request do
    describe "POST /api/v1/courses" do
        let(:params) do
        {
            course: {
            name: "Ruby on Rails",
            description: "Advanced Rails course",
            status: "active"
            },
            tutors: [
            {
                name: "Pankaj",
                email: "pankaj@example.com",
                experience_years: 8
            },
            {
                name: "Rahul",
                email: "rahul@example.com",
                experience_years: 5
            }
            ]
        }
        end

        it "creates a course with multiple tutors" do
            expect do
                post "/api/v1/courses", params: params
            end.to change(Course, :count).by(1)
                .and change(Tutor, :count).by(2)

            expect(response).to have_http_status(:created)

            body = response.parsed_body

            expect(body).to include(
                "name" => "Ruby on Rails",
                "description" => "Advanced Rails course",
                "status" => "active"
            )

            expect(body["tutors"].size).to eq(2)
        end

        it "returns validation errors when course name is missing" do
            invalid_params = params.deep_dup
            invalid_params[:course][:name] = ""

            expect do
                post "/api/v1/courses", params: invalid_params
            end.not_to change(Course, :count)

            expect(response).to have_http_status(:unprocessable_content)

            expect(response.parsed_body["errors"])
                .to include("Name can't be blank")
        end

        it "returns an error when course status is invalid" do
            expect do
                post "/api/v1/courses",
                    params: {
                    course: {
                        name: "Ruby on Rails",
                        description: "Advanced Rails course",
                        status: "invalid_status"
                    },
                    tutors: [
                        {
                        name: "John Doe",
                        email: "john@example.com",
                        experience_years: 5
                        }
                    ]
                    }
            end.not_to change(Course, :count)

            expect(response).to have_http_status(:unprocessable_content)

            body = JSON.parse(response.body)

            expect(body["errors"]).to include(
                "Status is not included in the list"
            )
        end

        it "rolls back course and tutors when a tutor is invalid" do
            invalid_params = params.deep_dup
            invalid_params[:tutors][1][:email] = ""

            expect do
                post "/api/v1/courses", params: invalid_params
            end.not_to change(Course, :count)

            expect(Tutor.count).to eq(0)

            expect(response).to have_http_status(:unprocessable_content)
        end
    end

    describe "GET /api/v1/courses" do
        context "when courses exist" do
            let!(:course) do
            create(
                :course,
                name: "Ruby on Rails",
                description: "Advanced Rails course",
                status: :active
            )
            end

            let!(:tutor) do
            create(
                :tutor,
                course: course,
                name: "Pankaj",
                email: "pankaj@example.com",
                experience_years: 8
            )
            end

            it "returns courses with their tutors" do
            get "/api/v1/courses"

            expect(response).to have_http_status(:ok)

            body = response.parsed_body

            expect(body.size).to eq(1)

            expect(body.first).to include(
                "id" => course.id,
                "name" => "Ruby on Rails",
                "description" => "Advanced Rails course",
                "status" => "active"
            )

            expect(body.first["tutors"]).to contain_exactly(
                {
                "id" => tutor.id,
                "name" => "Pankaj",
                "email" => "pankaj@example.com",
                "experience_years" => 8
                }
            )
            end
        end

        context "when no courses exist" do
            it "returns an empty array" do
            get "/api/v1/courses"

            expect(response).to have_http_status(:ok)
            expect(response.parsed_body).to eq([])
            end
        end
    end
end