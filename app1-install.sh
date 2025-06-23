#!/bin/bash

# Optional: Exit on error
set -e

# Update and install Apache
sudo dnf update -y
sudo dnf install -y httpd

# Enable and start Apache
sudo systemctl enable httpd
sudo systemctl start httpd

# Create index.html in the root web directory
echo '<h1>Hello! This is Abinash, learning Terraform now.</h1>' | sudo tee /var/www/html/index.html

# Create app1 directory and index.html
sudo mkdir -p /var/www/html/app1
cat <<'EOF' | sudo tee /var/www/html/app1/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Saanvika's World!</title>
    <style>
        body {
            background-color: #ffe4ec;
            font-family: Arial, sans-serif;
            color: #333;
            padding: 40px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            color: #d72660;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to Saanvika's World!</h1>
        <p>
            This is a special place where we celebrate the journey of our little star, Saanvika. Here, you’ll find her stories, milestones, and precious moments captured in photos.
        </p>
        <p>
            As Saanvika grows, laughs, and explores the world, we want to cherish and share every step of her adventure. From her first smile to her latest discoveries, this website is a diary of love, joy, and unforgettable memories.
        </p>
        <p>
            Thank you for joining us as we watch Saanvika’s story unfold. We hope you enjoy being a part of her journey as much as we do!
        </p>
    </div>
</body>
</html>
EOF

# Fetch EC2 instance metadata (IMDSv2)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | sudo tee /var/www/html/app1/metadata.html