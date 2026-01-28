📚 Book Three-Tier Application on AWS (Custom Infrastructure)

This repository demonstrates a production-style 3-Tier Web Application deployed on AWS Cloud using a custom-built infrastructure approach.

The project is designed for hands-on DevOps learning, real-world cloud architecture understanding, and end-to-end deployment practice.

🧩 Application Architecture

The application follows a classic 3-Tier architecture:

Presentation Layer – React (Frontend)

Application Layer – Node.js + Express (Backend API)

Database Layer – MySQL (Amazon RDS)

📐 High-Level Architecture Flow
User
 |
Frontend Load Balancer (Public)
 |
React Frontend (Private EC2 + Nginx)
 |
Backend Load Balancer (Public / Internal)
 |
Node.js Backend (Private EC2)
 |
Amazon RDS (MySQL - Private Subnets)


✔ Backend and database run inside private subnets
✔ Load balancers handle traffic securely
✔ Designed using AWS networking best practices

🛠️ Tech Stack
Frontend

React

Nginx

Backend

Node.js

Express

PM2 (Process Manager)

Database

MySQL

Amazon RDS

Cloud & Networking

AWS EC2

Application Load Balancer (ALB)

VPC (Public & Private Subnets)

📂 Repository Structure
Book_Three_Tier_Application_Custom_Infra
│
├── Book_Application_Frontend-Backend_code
│   │
│   ├── backend
│   │   ├── index.js
│   │   ├── package.json
│   │   ├── package-lock.json
│   │   └── test.sql
│   │
│   └── client
│       ├── build
│       ├── public
│       ├── src
│       ├── entrypoint.sh
│       ├── proxy.conf
│       ├── package.json
│       └── package-lock.json

⚙️ Prerequisites

AWS Account

Amazon Linux EC2 instances

Node.js

Nginx

MySQL client

Basic AWS networking knowledge

🚀 Infrastructure Setup (High-Level)

Create VPC with public & private subnets

Create MySQL RDS in private subnets

Launch Backend EC2 in private subnet

Launch Frontend EC2 in private subnet

Create Backend Target Group & Load Balancer

Create Frontend Target Group & Load Balancer

⚠️ If reverse proxy is not used, load balancers must be internet-facing

🗄️ Database Setup (Backend Server)
Step 1: Clone Repository
git clone https://github.com/bhawnavishwakarma007/Book_Three_Tier_Application_Custom_Infra.git
cd Book_Application_Frontend-Backend_code/backend

Step 2: Create .env File
vi .env

DB_HOST=<your-rds-endpoint>
DB_USERNAME=admin
DB_PASSWORD=<your-password>
PORT=3306

Step 3: Install MySQL Client
sudo yum install mariadb105-server -y

Step 4: Import Database
mysql -h <your-rds-endpoint> -u admin -p < test.sql

🔧 Backend Deployment
sudo dnf install -y nodejs
npm install
npm install dotenv
npm install -g pm2

pm2 start index.js --name book-backend
pm2 startup
pm2 save


✅ Backend should be reachable using Backend Load Balancer DNS

🎨 Frontend Deployment
Step 1: Clone Repository
git clone https://github.com/bhawnavishwakarma007/Book_Three_Tier_Application_Custom_Infra.git
cd Book_Application_Frontend-Backend_code/client

Step 2: Update Backend API URL
vi src/pages/config.js

const API_BASE_URL = "http://<backend-load-balancer-dns>";

Step 3: Install & Build Frontend
sudo dnf install -y nodejs
sudo yum install nginx -y
sudo systemctl enable --now nginx

npm install
npm run build
sudo cp -r build/* /usr/share/nginx/html


🎉 Frontend is now accessible using Frontend Load Balancer DNS

🔁 Reverse Proxy (Optional – Internal Backend LB)

If backend is behind an internal load balancer, configure Nginx reverse proxy.

Update Frontend API Config
const API_BASE_URL = "/api";

Create Nginx Reverse Proxy Config
sudo vi /etc/nginx/conf.d/reverse-proxy.conf

server {
    listen 80;

    location /api/ {
        proxy_pass http://<backend-internal-lb>/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri /index.html;
    }
}

Reload Nginx
sudo nginx -t
sudo systemctl reload nginx

✅ Verification Checklist

Backend API reachable

Frontend UI loads

Data fetched from MySQL RDS

/api/books endpoint works

No CORS or networking issues

🎓 Learning Outcomes

AWS 3-Tier Architecture

Secure private networking

Load Balancer integration

React & Node.js deployment

Reverse proxy using Nginx

Real-world DevOps workflow

🙌 Author

Bhawna Vishwakarma
DevOps & Cloud Engineering Student

🔗 GitHub
https://github.com/bhawnavishwakarma007

⭐ If this project helped you, don’t forget to star the repository