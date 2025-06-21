#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Homepage
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
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

# App1 path for health check
sudo mkdir -p /var/www/html/app1
sudo tee /var/www/html/app1/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Saanvika's World - App1!</title>
</head>
<body>
    <h1>This is App1 - Saanvika's World!</h1>
</body>
</html>
EOF