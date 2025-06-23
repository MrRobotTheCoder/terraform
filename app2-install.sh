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

# Create app2 directory and index.html
sudo mkdir -p /var/www/html/app2
cat <<'EOF' | sudo tee /var/www/html/app2/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Our Journey Begins - Saanvika's Blog</title>
    <style>
        body {
            background-color: #f9f6f2;
            font-family: Georgia, 'Times New Roman', Times, serif;
            color: #444;
            padding: 40px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 30px;
        }
        h1 {
            color: #d72660;
        }
        p {
            line-height: 1.7;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Our Journey Begins</h1>
        <p>
            As parents, we are filled with immense joy and gratitude as we embark on this beautiful journey with our precious daughter, Saanvika. Every moment with her is a treasure—her first smile, her curious gaze, her laughter that fills our home with happiness. We created this website to capture and preserve these priceless memories, so that we, along with our family and friends, can relive them for years to come.
        </p>
        <p>
            Through this space, we hope to document Saanvika’s milestones, her funny stories, and the love and warmth she brings into our lives every single day. From her first steps to her growing adventures, we want to share the magic of her childhood and the lessons she teaches us along the way.
        </p>
        <p>
            We invite you to join us in celebrating Saanvika’s journey. Your blessings, love, and support mean the world to us. Together, let’s cherish these moments and create a tapestry of memories that Saanvika can look back on with pride and joy.
        </p>
    </div>
</body>
</html>
EOF

# Fetch EC2 instance metadata (IMDSv2)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | sudo tee /var/www/html/app2/metadata.html