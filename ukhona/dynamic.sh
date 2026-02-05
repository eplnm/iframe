#!/bin/bash

# scaffold-flask.sh - Creates a Flask app with modular HTML structure
# Usage: ./scaffold-flask.sh [project-name]

PROJECT_NAME="${1:-my-flask-app}"

echo "🏗️  Scaffolding Flask app: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{app/{templates,static/{ukhona/{html,css,js,img}}},docs}

# Create partials directory
mkdir -p "$PROJECT_NAME/app/static/ukhona/html"/{head,body,footer}

# Create Flask app.py
cat > "$PROJECT_NAME/app.py" << 'EOF'
from flask import Flask, render_template, send_from_directory
import os

app = Flask(__name__, 
            template_folder='app/templates',
            static_folder='app/static')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

# Serve static files from ukhona directory
@app.route('/ukhona/<path:filename>')
def ukhona_files(filename):
    return send_from_directory('app/static/ukhona', filename)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
EOF

# Create requirements.txt
cat > "$PROJECT_NAME/requirements.txt" << 'EOF'
Flask==3.0.0
gunicorn==21.2.0
python-dotenv==1.0.0
EOF

# Create .env
cat > "$PROJECT_NAME/.env" << 'EOF'
FLASK_APP=app.py
FLASK_ENV=development
SECRET_KEY=change-this-in-production
EOF

# Create .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
__pycache__/
*.py[cod]
*$py.class
*.so
.env
venv/
env/
.venv
instance/
.pytest_cache/
.coverage
htmlcov/
dist/
build/
*.egg-info/
.DS_Store
EOF

# Create base template
cat > "$PROJECT_NAME/app/templates/base.html" << 'EOF'
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <title>{% block title %}Flask App{% endblock %}</title>
  <meta name="description" content="{% block description %}Flask application{% endblock %}">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="{% block og_site %}Site Name{% endblock %}">
  <meta property="og:title" content="{% block og_title %}Page Title{% endblock %}">
  <meta property="og:description" content="{% block og_description %}Page description{% endblock %}">
  <meta property="og:type" content="website">
  
  <!-- Preconnect fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/main.css') }}">
  {% block extra_css %}{% endblock %}
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <!-- Header -->
  <header class="header" id="header"></header>

  <!-- Main content -->
  {% block content %}{% endblock %}

  <div class="modal-overlay" id="modal-overlay"></div>

  <!-- Footer -->
  <div id="footer-placeholder"></div>

  <!-- Scripts (Order matters!) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="{{ url_for('static', filename='ukhona/js/shared.js') }}"></script>
  {% block extra_js %}{% endblock %}
</body>
</html>
EOF

# Create index template
cat > "$PROJECT_NAME/app/templates/index.html" << 'EOF'
{% extends "base.html" %}

{% block title %}Home - Flask App{% endblock %}
{% block description %}Welcome to our Flask application{% endblock %}

{% block extra_css %}
<link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/index.css') }}">
{% endblock %}

{% block content %}
<section class="hero" id="hero"></section>
<main class="main-content">
  <section class="services-section" id="services-section"></section>
  <section class="metrics-section" id="metrics-section"></section>
</main>
{% endblock %}

{% block extra_js %}
<script src="{{ url_for('static', filename='ukhona/js/index.js') }}"></script>
{% endblock %}
EOF

# Create about template
cat > "$PROJECT_NAME/app/templates/about.html" << 'EOF'
{% extends "base.html" %}

{% block title %}About - Flask App{% endblock %}
{% block description %}Learn more about us{% endblock %}

{% block extra_css %}
<link rel="stylesheet" href="{{ url_for('static', filename='ukhona/css/about.css') }}">
{% endblock %}

{% block content %}
<section class="about-hero">
  <h1>About Us</h1>
  <p>Our story and mission</p>
</section>
{% endblock %}
EOF

# Create HTML partials (same as static site)
cat > "$PROJECT_NAME/app/static/ukhona/html/body/header.html" << 'EOF'
<nav class="navbar">
  <div class="nav-brand">
    <img src="/ukhona/img/logo.png" alt="Logo" onerror="this.style.display='none'">
    <span class="brand-text">Flask App</span>
  </div>
  <ul class="nav-menu">
    <li><a href="/">Home</a></li>
    <li><a href="/about">About</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/body/hero.html" << 'EOF'
<div class="hero-content">
  <h1>Welcome to Flask</h1>
  <p>Build powerful web applications with Python</p>
  <button class="cta-button" onclick="window.location.href='/about'">Learn More</button>
</div>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/body/services.html" << 'EOF'
<div class="services-grid">
  <div class="service-card">
    <i data-feather="zap"></i>
    <h3>Fast Development</h3>
    <p>Build applications quickly with Flask's simplicity</p>
  </div>
  <div class="service-card">
    <i data-feather="shield"></i>
    <h3>Secure</h3>
    <p>Built-in protection against common vulnerabilities</p>
  </div>
  <div class="service-card">
    <i data-feather="code"></i>
    <h3>Flexible</h3>
    <p>Extend with thousands of Python packages</p>
  </div>
</div>
EOF

cat > "$PROJECT_NAME/app/static/ukhona/html/footer/footer.html" << 'EOF'
<footer class="site-footer">
  <div class="footer-content">
    <p>&copy; 2024 Flask App. All rights reserved.</p>
    <div class="footer-links">
      <a href="/privacy">Privacy</a>
      <a href="/terms">Terms</a>
      <a href="/contact">Contact</a>
    </div>
  </div>
</footer>
EOF

# Create shared.js (same as static site but with Flask-aware paths)
cat > "$PROJECT_NAME/app/static/ukhona/js/shared.js" << 'EOF'
// shared.js - Load HTML partials into the page

async function loadPartial(selector, path) {
  try {
    const response = await fetch(path);
    const html = await response.text();
    const element = document.querySelector(selector);
    if (element) {
      element.innerHTML = html;
    }
  } catch (error) {
    console.error(`Failed to load ${path}:`, error);
  }
}

// Load all partials on page load
document.addEventListener('DOMContentLoaded', () => {
  loadPartial('#header', '/ukhona/html/body/header.html');
  loadPartial('#hero', '/ukhona/html/body/hero.html');
  loadPartial('#services-section', '/ukhona/html/body/services.html');
  loadPartial('#footer-placeholder', '/ukhona/html/footer/footer.html');
  
  // Initialize feather icons after content loads
  setTimeout(() => {
    if (typeof feather !== 'undefined') {
      feather.replace();
    }
  }, 100);
});

// Scroll progress indicator
window.addEventListener('scroll', () => {
  const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
  const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrolled = (winScroll / height) * 100;
  const progress = document.querySelector('.scroll-progress');
  if (progress) {
    progress.style.width = scrolled + '%';
  }
});
EOF

cat > "$PROJECT_NAME/app/static/ukhona/js/index.js" << 'EOF'
// index.js - Homepage specific JavaScript

console.log('Index page loaded');

// Add your page-specific code here
EOF

# Create CSS files (same as static site)
cat > "$PROJECT_NAME/app/static/ukhona/css/main.css" << 'EOF'
/* main.css - Global styles */

:root {
  --bg-primary: #0a0a0f;
  --bg-secondary: #1a1a24;
  --text-primary: #ffffff;
  --text-secondary: #a0a0b0;
  --accent: #4f46e5;
}

[data-theme="light"] {
  --bg-primary: #ffffff;
  --bg-secondary: #f5f5f5;
  --text-primary: #0a0a0f;
  --text-secondary: #505060;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  background-color: var(--bg-primary);
  color: var(--text-primary);
  line-height: 1.6;
}

.scroll-indicator {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 3px;
  background: var(--bg-secondary);
  z-index: 9999;
}

.scroll-progress {
  height: 100%;
  background: var(--accent);
  width: 0%;
  transition: width 0.2s ease;
}

.bg-pattern {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  opacity: 0.03;
  pointer-events: none;
  background-image: 
    linear-gradient(45deg, var(--text-primary) 1px, transparent 1px),
    linear-gradient(-45deg, var(--text-primary) 1px, transparent 1px);
  background-size: 20px 20px;
  z-index: -1;
}
EOF

cat > "$PROJECT_NAME/app/static/ukhona/css/index.css" << 'EOF'
/* index.css - Homepage styles */

.hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 2rem;
}

.hero-content h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
  font-weight: 800;
}

.hero-content p {
  font-size: 1.25rem;
  color: var(--text-secondary);
  margin-bottom: 2rem;
}

.cta-button {
  background: var(--accent);
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1rem;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.cta-button:hover {
  transform: translateY(-2px);
}

.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 3rem;
  background: var(--bg-secondary);
}

.nav-brand {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.brand-text {
  font-size: 1.25rem;
  font-weight: 700;
}

.nav-menu {
  display: flex;
  gap: 2rem;
  list-style: none;
}

.nav-menu a {
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s;
}

.nav-menu a:hover {
  color: var(--accent);
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  padding: 4rem 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.service-card {
  background: var(--bg-secondary);
  padding: 2rem;
  border-radius: 12px;
  text-align: center;
}

.service-card i {
  width: 48px;
  height: 48px;
  margin-bottom: 1rem;
  color: var(--accent);
}

.site-footer {
  background: var(--bg-secondary);
  padding: 2rem;
  text-align: center;
  margin-top: 4rem;
}

.footer-links {
  display: flex;
  gap: 2rem;
  justify-content: center;
  margin-top: 1rem;
}

.footer-links a {
  color: var(--text-secondary);
  text-decoration: none;
}

.footer-links a:hover {
  color: var(--accent);
}
EOF

cat > "$PROJECT_NAME/app/static/ukhona/css/about.css" << 'EOF'
/* about.css - About page styles */

.about-hero {
  min-height: 60vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 4rem 2rem;
}

.about-hero h1 {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.about-hero p {
  font-size: 1.25rem;
  color: var(--text-secondary);
}
EOF

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Flask App

## Structure

```
.
├── app.py                          # Flask application
├── requirements.txt                # Python dependencies
├── .env                            # Environment variables
├── app/
│   ├── templates/                  # Jinja2 templates
│   │   ├── base.html               # Base template
│   │   ├── index.html              # Homepage
│   │   └── about.html              # About page
│   └── static/
│       └── ukhona/                 # Assets (same structure as static site)
│           ├── html/               # HTML partials
│           │   ├── head/
│           │   ├── body/
│           │   └── footer/
│           ├── css/
│           ├── js/
│           └── img/
└── docs/                           # Documentation
```

## Setup

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On macOS/Linux:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

## Run

```bash
# Development
python app.py

# Production (with gunicorn)
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

Visit: http://localhost:5000

## Philosophy

- **Jinja2 templates** for dynamic content
- **Same modular structure** as static site (ukhona/ partials)
- **Flask routes** for backend logic
- **Easy to maintain** - non-coders can still edit HTML partials
- **Scalable** - Add routes, blueprints, database as needed

## Adding Routes

Edit `app.py`:

```python
@app.route('/new-page')
def new_page():
    return render_template('new_page.html')
```

Create `app/templates/new_page.html` extending `base.html`.
EOF

echo "✅ Flask app scaffolded: $PROJECT_NAME/"
echo ""
echo "📁 Structure:"
echo "   app.py (Flask application)"
echo "   app/templates/ (Jinja2 templates)"
echo "   app/static/ukhona/ (same modular structure)"
echo ""
echo "🚀 To run:"
echo "   cd $PROJECT_NAME"
echo "   python -m venv venv"
echo "   source venv/bin/activate  # or venv\\Scripts\\activate on Windows"
echo "   pip install -r requirements.txt"
echo "   python app.py"
echo "   # Visit http://localhost:5000"