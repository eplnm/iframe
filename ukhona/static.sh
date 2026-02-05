#!/bin/bash

# scaffold-website.sh - Creates a clean static website structure
# Usage: ./scaffold-website.sh [project-name]

PROJECT_NAME="${1:-my-website}"

echo "🏗️  Scaffolding static website: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{ukhona/{html,css,js,img},docs}

# Create partials directory for HTML components
mkdir -p "$PROJECT_NAME/ukhona/html"/{head,body,footer}

# Create index.html with modular includes
cat > "$PROJECT_NAME/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <title>Project Title</title>
  <meta name="description" content="Project description">
  <link rel="canonical" href="https://example.com/">
  <meta name="robots" content="index,follow">
  <meta name="color-scheme" content="dark light">
  <meta name="theme-color" content="#0a0a0f">

  <!-- Open Graph / Twitter -->
  <meta property="og:site_name" content="Site Name">
  <meta property="og:title" content="Page Title">
  <meta property="og:description" content="Page description">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://example.com/">
  
  <!-- Preconnect fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" crossorigin>
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="ukhona/css/main.css">
  <link rel="stylesheet" href="ukhona/css/index.css">
</head>

<body>
  <div class="scroll-indicator"><div class="scroll-progress"></div></div>
  <div class="bg-pattern"></div>

  <!-- Header -->
  <header class="header" id="header"></header>

  <!-- Main sections -->
  <section class="hero" id="hero"></section>
  <main class="main-content">
    <section class="services-section" id="services-section"></section>
    <section class="metrics-section" id="metrics-section"></section>
  </main>

  <div class="modal-overlay" id="modal-overlay"></div>

  <!-- Footer -->
  <div id="footer-placeholder"></div>

  <!-- Scripts (Order matters!) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"></script>
  <script src="ukhona/js/shared.js"></script>
  <script src="ukhona/js/index.js"></script>
</body>
</html>
EOF

# Create HTML partials
cat > "$PROJECT_NAME/ukhona/html/head/meta.html" << 'EOF'
<!-- Additional meta tags -->
<meta name="author" content="Your Name">
<meta name="keywords" content="keyword1, keyword2">
EOF

cat > "$PROJECT_NAME/ukhona/html/body/header.html" << 'EOF'
<nav class="navbar">
  <div class="nav-brand">
    <img src="ukhona/img/logo.png" alt="Logo">
  </div>
  <ul class="nav-menu">
    <li><a href="#home">Home</a></li>
    <li><a href="#services">Services</a></li>
    <li><a href="#contact">Contact</a></li>
  </ul>
</nav>
EOF

cat > "$PROJECT_NAME/ukhona/html/body/hero.html" << 'EOF'
<div class="hero-content">
  <h1>Welcome</h1>
  <p>Your tagline here</p>
  <button class="cta-button">Get Started</button>
</div>
EOF

cat > "$PROJECT_NAME/ukhona/html/body/services.html" << 'EOF'
<div class="services-grid">
  <div class="service-card">
    <i data-feather="zap"></i>
    <h3>Service One</h3>
    <p>Description of service one</p>
  </div>
  <div class="service-card">
    <i data-feather="shield"></i>
    <h3>Service Two</h3>
    <p>Description of service two</p>
  </div>
</div>
EOF

cat > "$PROJECT_NAME/ukhona/html/footer/footer.html" << 'EOF'
<footer class="site-footer">
  <div class="footer-content">
    <p>&copy; 2024 Company Name. All rights reserved.</p>
    <div class="footer-links">
      <a href="#privacy">Privacy</a>
      <a href="#terms">Terms</a>
      <a href="#contact">Contact</a>
    </div>
  </div>
</footer>
EOF

# Create shared.js for loading partials
cat > "$PROJECT_NAME/ukhona/js/shared.js" << 'EOF'
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
  loadPartial('#header', 'ukhona/html/body/header.html');
  loadPartial('#hero', 'ukhona/html/body/hero.html');
  loadPartial('#services-section', 'ukhona/html/body/services.html');
  loadPartial('#footer-placeholder', 'ukhona/html/footer/footer.html');
  
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

# Create index.js for page-specific functionality
cat > "$PROJECT_NAME/ukhona/js/index.js" << 'EOF'
// index.js - Page-specific JavaScript

console.log('Index page loaded');

// Add your page-specific code here
EOF

# Create basic CSS
cat > "$PROJECT_NAME/ukhona/css/main.css" << 'EOF'
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

cat > "$PROJECT_NAME/ukhona/css/index.css" << 'EOF'
/* index.css - Page-specific styles */

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

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# Website Project

## Structure

```
.
├── index.html                 # Main entry point (clean, minimal)
├── ukhona/                    # Assets directory
│   ├── html/                  # HTML partials
│   │   ├── head/              # <head> components
│   │   ├── body/              # <body> sections (header, hero, services, etc.)
│   │   └── footer/            # Footer components
│   ├── css/                   # Stylesheets
│   ├── js/                    # JavaScript files
│   └── img/                   # Images
└── docs/                      # Documentation

```

## Usage

1. Open `index.html` in a browser (use a local server for partials to load)
2. Edit partials in `ukhona/html/` to modify page sections
3. Keep `index.html` clean - it just references the partials

## Local Development

```bash
# Python 3
python -m http.server 8000

# Or with Python 2
python -m SimpleHTTPServer 8000

# Then visit: http://localhost:8000
```

## Philosophy

- **Pure HTML in index.html** - No clutter, easy to audit
- **Modular partials** - Each section lives in its own file
- **Organized assets** - Everything in `ukhona/` subdirectories
- **Easy maintenance** - Non-coders can edit individual sections
EOF

echo "✅ Static website scaffolded: $PROJECT_NAME/"
echo ""
echo "📁 Structure:"
echo "   index.html (clean entry point)"
echo "   ukhona/html/{head,body,footer}/ (modular partials)"
echo "   ukhona/{css,js,img}/ (assets)"
echo ""
echo "🚀 To run:"
echo "   cd $PROJECT_NAME"
echo "   python -m http.server 8000"
echo "   # Visit http://localhost:8000"