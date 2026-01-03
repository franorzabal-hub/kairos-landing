# Kairos Landing Page

Landing page for the Kairos SaaS platform - an enterprise business management solution powered by Frappe.

## Tech Stack

- **Framework:** [Astro](https://astro.build/) - Fast static site generator
- **Styling:** [Tailwind CSS v4](https://tailwindcss.com/) - Utility-first CSS framework
- **Deployment:** Google Cloud Run
- **CI/CD:** Google Cloud Build

## Project Structure

```
kairos-landing/
├── public/
│   └── favicon.svg
├── src/
│   ├── components/
│   │   ├── Header.astro
│   │   ├── Hero.astro
│   │   ├── Features.astro
│   │   ├── Pricing.astro
│   │   ├── SignupForm.astro
│   │   └── Footer.astro
│   ├── layouts/
│   │   └── Layout.astro
│   ├── pages/
│   │   └── index.astro
│   └── styles/
│       └── global.css
├── Dockerfile
├── nginx.conf
├── cloudbuild.yaml
└── package.json
```

## Development

### Prerequisites

- Node.js 20+
- npm

### Setup

```bash
# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Start development server
npm run dev
```

The development server will start at `http://localhost:4321`.

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PUBLIC_CONTROL_PLANE_API_URL` | URL of the control-plane API for tenant creation | `https://api.kairos.example.com` |

## Building for Production

```bash
# Build static site
npm run build

# Preview production build
npm run preview
```

## Docker

### Build Image

```bash
docker build -t kairos-landing .
```

### Run Locally

```bash
docker run -p 8080:8080 kairos-landing
```

## Deployment

### Cloud Run (Manual)

```bash
# Build and push image
gcloud builds submit --tag gcr.io/PROJECT_ID/kairos-landing

# Deploy to Cloud Run
gcloud run deploy kairos-landing \
  --image gcr.io/PROJECT_ID/kairos-landing \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### Cloud Build (CI/CD)

The project includes a `cloudbuild.yaml` that:
1. Builds the Docker image
2. Pushes to Google Container Registry
3. Deploys to Cloud Run

Set up a Cloud Build trigger connected to your GitHub repository to enable automatic deployments on push to `main`.

### Configuration

Update the following substitution variables in `cloudbuild.yaml`:

- `_SERVICE_NAME`: Cloud Run service name (default: `kairos-landing`)
- `_REGION`: GCP region (default: `us-central1`)
- `_CONTROL_PLANE_API_URL`: Control plane API URL

## Features

- **Hero Section:** Eye-catching headline and CTAs
- **Features Section:** Showcase of platform capabilities (ERP, CRM, Accounting, HR, etc.)
- **Pricing Section:** Three-tier pricing with feature comparison
- **Signup Form:** Lead capture form that integrates with the control-plane API

## API Integration

The signup form calls the control-plane API to create new tenants:

```javascript
POST ${PUBLIC_CONTROL_PLANE_API_URL}/tenants
Content-Type: application/json

{
  "company_name": "Company Name",
  "admin_email": "admin@company.com",
  "subdomain": "company-name"
}
```

## License

Proprietary - All rights reserved.
