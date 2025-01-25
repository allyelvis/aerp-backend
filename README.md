#aerp-backend

AERP (Advanced ERP System) Backend is a robust REST API server designed to handle user management, product management, and more for the AERP platform. This backend is built using Node.js, Express, and MongoDB, providing a scalable and flexible solution for ERP functionalities.


---

Table of Contents

1. Features


2. Tech Stack


3. Installation


4. Usage


5. API Endpoints


6. Collaborator Guide


7. Contribution Guidelines


8. License




---

Features

User Management:

User registration and login.

JWT-based authentication.


Product Management:

CRUD operations for products.


Database:

MongoDB for data persistence.


Environment Configurations:

Secure and flexible .env management.




---

Tech Stack

Backend Framework: Node.js, Express

Database: MongoDB, Mongoose

Authentication: JSON Web Tokens (JWT), bcryptjs

Others: dotenv, cors, body-parser



---

Installation

Follow these steps to set up the project locally:

1. Clone the Repository:

git clone https://github.com/allyelvis/aerp-backend.git
cd aerp-backend


2. Install Dependencies:

npm install


3. Set Up Environment Variables: Create a .env file in the root directory and add the following:

PORT=5000
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret


4. Run the Server:

npm start


5. Use Nodemon for Development:

npm run dev




---

Usage

Once the server is running, you can access the API at:

http://localhost:5000


---

API Endpoints

User Endpoints

POST /api/users/register: Register a new user.

POST /api/users/login: Log in a user.


Product Endpoints

GET /api/products: Fetch all products.

POST /api/products: Add a new product.

PUT /api/products/:id: Update a product.

DELETE /api/products/:id: Delete a product.



---

Collaborator Guide

Project Structure

aerp-backend/
├── api/
│   ├── config/         # Database configuration
│   ├── controllers/    # Route logic and business operations
│   ├── middleware/     # Middleware (e.g., authentication)
│   ├── models/         # MongoDB models
│   ├── routes/         # Route definitions
├── server.js           # Main entry point
├── package.json        # Node.js dependencies and scripts
├── README.md           # Documentation
├── .env                # Environment variables

Adding a New Feature

1. Plan:

Discuss the feature in the GitHub issues or the team communication channel.

Get approval before proceeding.



2. Branch Workflow:

Always work on a new branch named as follows:

feature/<feature-name>

Example:

feature/add-user-role



3. Code Standards:

Follow the existing coding style and conventions.

Write clear and concise commit messages:

git commit -m "Add user role functionality"



4. Testing:

Test your changes thoroughly before pushing the branch.

Include unit tests if applicable.



5. Pull Requests:

Submit a pull request (PR) to the main branch.

Provide a clear description of the changes.

Ensure all checks pass before requesting a review.





---

Contribution Guidelines

We welcome contributions to improve the AERP Backend!

How to Contribute

1. Fork the repository and create a new branch.


2. Follow the Collaborator Guide.


3. Submit a pull request with a detailed description.



Code of Conduct

Be respectful, inclusive, and constructive in all interactions. For more details, please refer to our Code of Conduct.


---

License

This project is licensed under the MIT License.


---

Questions or Issues?

For any questions, feedback, or issues, please open an issue.

Happy coding!

