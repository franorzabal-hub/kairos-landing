# ================================
# Stage 1: Builder
# ================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files for dependency installation
COPY package.json package-lock.json* ./

# Install dependencies with clean install for reproducible builds
RUN npm ci --ignore-scripts

# Copy source code
COPY . .

# Build the Astro project (generates static files in dist/)
RUN npm run build

# ================================
# Stage 2: Production
# ================================
FROM node:20-alpine AS production

# Install dumb-init for proper signal handling
RUN apk add --no-cache dumb-init

# Create non-root user for security
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 astro

WORKDIR /app

# Copy built static files from builder
COPY --from=builder --chown=astro:nodejs /app/dist ./dist

# Install a lightweight static file server
RUN npm install -g serve@14

# Switch to non-root user
USER astro

# Expose Astro default port
EXPOSE 4321

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:4321/ || exit 1

# Use dumb-init to handle signals properly
ENTRYPOINT ["dumb-init", "--"]

# Serve static files on port 4321
CMD ["serve", "-s", "dist", "-l", "4321"]
