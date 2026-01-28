# Book Three-Tier Application on AWS (Custom Infrastructure)

This repository demonstrates a production-style three-tier web application
(Frontend, Backend, and Database) deployed on AWS using a custom infrastructure
approach.

The project is intended for hands-on DevOps learning and real-world cloud
architecture understanding.

---

## Application Architecture

The application follows a classic three-tier architecture:

- Presentation Layer: React (Frontend)
- Application Layer: Node.js + Express (Backend API)
- Database Layer: MySQL (Amazon RDS)

---

## High-Level Architecture Flow

User  
|  
Frontend Load Balancer (Public)  
|  
React Frontend (Private EC2 with Nginx)  
|  
Backend Load Balancer (Public or Internal)  
|  
Node.js Backend (Private EC2)  
|  
Amazon RDS (MySQL in Private Subnets)

---

## Tech Stack

### Frontend
- React
- Nginx

### Backend
- Node.js
- Express
- PM2

### Database
- MySQL
- Amazon RDS

### Cloud & Networking
- AWS EC2
- Application Load Balancer
- VPC with Public and Private Subnets

---

## Repository Structure

Book_Three_Tier_Application_Custom_Infra  
├── Book_Application_Frontend-Backend_code  
│   ├── backend  
│   │   ├── index.js  
│   │   ├── package.json  
│   │   ├── package-lock.json  
│   │   └── test.sql  
│   └── client  
│       ├── build  
│       ├── public  
│       ├── src  
│       ├── entrypoint.sh  
│       ├── proxy.conf  
│       ├── package.json  
│       └── package-lock.json  

---

## Prerequisites

- AWS Account
- Amazon Linux EC2 instances
- Node.js
- Nginx
- MySQL client
- Basic AWS networking knowledge

---

## Infrastructure Setup (High-Level)

- Create a VPC with public and private subnets
- Create MySQL RDS in private subnets
- Launch Backend EC2 in a private subnet
- Launch Frontend EC2 in a private subnet
- Create Backend Load Balancer and Target Group
- Create Frontend Load Balancer and Target Group

Note: If reverse proxy is not used, load balancers must be internet-facing.

---

## Database Setup (Backend Server)

Clone the repository:

git clone https://github.com/bhawnavishwakarma007/Book_Three_Tier_Application_Custom_Infra.git  
cd Book_Application_Frontend-Backend_code/backend  

Create `.env` file:

DB_HOST=<your-rds-endpoint>  
DB_USERNAME=admin  
DB_PASSWORD=<your-password>  
PORT=3306  

Install MySQL client:

sudo yum install mariadb105-server -y  

Import database:

mysql -h <your-rds-endpoint> -u admin -p < test.sql  

---

## Backend Deployment

sudo dnf install -y nodejs  
npm install  
npm install dotenv  
npm install -g pm2  

pm2 start index.js --name book-backend  
pm2 startup  
pm2 save  

Backend should be reachable via the Backend Load Balancer DNS.

---

## Frontend Deployment

Clone the repository:

git clone https://github.com/bhawnavishwakarma007/Book_Three_Tier_Application_Custom_Infra.git  
cd Book_Application_Frontend-Backend_code/client  

Update backend API URL:

const API_BASE_URL = "http://<backend-load-balancer-dns>";

Install and build frontend:

sudo yum install nginx -y  
sudo systemctl enable --now nginx  

npm install  
npm run build  
sudo cp -r build/* /usr/share/nginx/html  

Frontend is accessible via the Frontend Load Balancer DNS.

---

## Reverse Proxy (Optional)

If backend is behind an internal load balancer, configure Nginx reverse proxy.

---

## Verification Checklist

- Backend API reachable
- Frontend UI loads
- Data fetched from MySQL RDS
- /api/books endpoint works
- No CORS or networking issues

---

## Author

Bhawna Vishwakarma  
DevOps & Cloud Engineering Student  

GitHub: https://github.com/bhawnavishwakarma007
