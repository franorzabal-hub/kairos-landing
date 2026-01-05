# Landing Kairos

## Qué es este repo

Landing page de marketing para Kairos. Punto de entrada para prospects (directivos de colegios).

## Stack

- **Framework**: Astro 5.16
- **Styling**: Tailwind CSS 4.1
- **Deploy**: Cloud Run

## URL

- Producción: www.1kairos.com

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
└── package.json
```

## Desarrollo

```bash
npm install
npm run dev     # http://localhost:4321
npm run build   # Build producción
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

```bash
PUBLIC_CONTROL_PLANE_API_URL=https://api.1kairos.com
PUBLIC_GOOGLE_CLIENT_ID=xxx.apps.googleusercontent.com
```

## Componentes

| Componente | Función |
|------------|---------|
| Header | Nav fijo con blur, logo, CTAs |
| Hero | Headline, subtítulo, botones principales |
| Features | 6 cards de funcionalidades |
| Pricing | 3 tiers (Starter, Business, Enterprise) |
| SignupForm | Formulario con Google OAuth + email fallback |
| Footer | Links, legal, copyright |
