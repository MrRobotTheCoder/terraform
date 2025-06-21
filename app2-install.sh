#!/bin/bash
sudo dnf update -y
sudo dnf install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Blog page
sudo mkdir -p /var/www/html/blog
sudo tee /var/www/html/blog/first-entry.html > /dev/null <<'EOF'
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

# App2 path for health check
sudo mkdir -p /var/www/html/app2
sudo tee /var/www/html/app2/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Saanvika's World - App2!</title>
</head>
<body>
    <h1>This is App2 - Saanvika's Blog!</h1>
</body>
</html>
EOF