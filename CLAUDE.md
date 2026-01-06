# Landing Kairos

## Qué es este repo

Landing page de marketing para Kairos. Punto de entrada para prospects (directivos de colegios).

## Stack

- **Framework**: Astro 5.16
- **Styling**: Tailwind CSS 4.1
- **Deploy**: Cloud Run

---

## Desarrollo y Deploy

> **Documentación completa**: Ver [infra/docs/DEVELOPMENT.md](https://github.com/franorzabal-hub/frappe-saas-platform/blob/main/docs/DEVELOPMENT.md)

### Ambientes

| Ambiente | URL | Trigger |
|----------|-----|---------|
| **Dev** | `www-dev.1kairos.com` | Push a `main` |
| **Prod** | `www.1kairos.com` | Tag `v*` |

### Desarrollo (sin Docker local)

```bash
# Configurar ambiente
cat > .env << 'EOF'
PUBLIC_CONTROL_PLANE_URL=https://api-dev.1kairos.com
PUBLIC_APP_URL=https://app-dev.1kairos.com
EOF

# Desarrollar
npm install
npm run dev
# → http://localhost:4321 (conecta a api-dev)
```

### Deploy

```bash
# Deploy a Dev (automático)
git add . && git commit -m "feat: ..." && git push
# → Automático a www-dev.1kairos.com

# Deploy a Prod
git tag v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
# → Automático a www.1kairos.com
```

---

## URLs

| Ambiente | URL |
|----------|-----|
| Dev | `www-dev.1kairos.com` |
| Producción | `www.1kairos.com` |

## Estructura

```
landing/
├── src/
│   ├── pages/
│   │   └── index.astro        # Página principal
│   ├── components/
│   │   ├── Header.astro       # Nav + logo
│   │   ├── Hero.astro         # CTA principal
│   │   ├── Features.astro     # Funcionalidades
│   │   ├── Pricing.astro      # Planes y precios
│   │   ├── SignupForm.astro   # Registro con OAuth
│   │   └── Footer.astro
│   ├── layouts/
│   │   └── Layout.astro       # Base HTML
│   └── styles/
│       └── global.css
├── astro.config.mjs
├── cloudbuild.yaml            # CI/CD
└── package.json
```

## Flujo de Signup

```
1. Usuario llega a www.1kairos.com
2. Click "Probar Gratis"
3. Ingresa nombre del colegio + (Google OAuth | email)
4. POST a control-plane/api/tenants/signup
5. Si Google → redirect inmediato al tenant
   Si email → recibe email de validación
6. Usuario accede a su instancia: org-xxx.1kairos.com
```

## Variables de Entorno

| Variable | Dev | Prod |
|----------|-----|------|
| `PUBLIC_CONTROL_PLANE_URL` | `https://api-dev.1kairos.com` | `https://api.1kairos.com` |
| `PUBLIC_APP_URL` | `https://app-dev.1kairos.com` | `https://app.1kairos.com` |
| `PUBLIC_GOOGLE_CLIENT_ID` | (mismo) | (mismo) |

## Componentes

| Componente | Función |
|------------|---------|
| Header | Nav fijo con blur, logo, CTAs |
| Hero | Headline, subtítulo, botones principales |
| Features | 6 cards de funcionalidades |
| Pricing | 3 tiers (Starter, Business, Enterprise) |
| SignupForm | Formulario con Google OAuth + email fallback |
| Footer | Links, legal, copyright |
