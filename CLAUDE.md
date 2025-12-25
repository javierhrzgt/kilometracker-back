# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

KilomeTracker is a REST API for vehicle management (gestión de vehículos) built with Express, TypeScript, Prisma, and PostgreSQL. The API tracks vehicles, routes, refuels, and maintenance services with user authentication.

## Development Commands

### Package Management
This project uses **pnpm** (version 10.26.2) as the package manager.

```bash
# Install dependencies
pnpm install

# Development server with hot reload
pnpm dev

# Build TypeScript to JavaScript
pnpm build

# Run production build
pnpm start
```

### Database Operations

```bash
# Generate Prisma Client (run after schema changes)
npx prisma generate

# Create a new migration
npx prisma migrate dev --name <migration_name>

# Apply migrations
npx prisma migrate deploy

# Open Prisma Studio (database GUI)
npx prisma studio

# Reset database (development only)
npx prisma migrate reset
```

### Docker

```bash
# Start PostgreSQL container
docker-compose up -d

# Stop containers
docker-compose down

# View logs
docker-compose logs -f postgres
```

## Architecture

### Path Aliases
The project uses TypeScript path aliases configured in tsconfig.json:
- `@/*` maps to `./src/*`

Example: `import { prisma } from "@/lib/prisma"`

### Database Layer

**Prisma Setup:**
- Schema: `prisma/schema.prisma`
- Generated client: `src/generated/prisma/` (auto-generated, gitignored)
- Configuration: `prisma.config.ts` at project root
- Prisma client instance: `src/lib/prisma.ts`

**Custom Prisma Adapter:**
The project uses `@prisma/adapter-pg` for PostgreSQL connections instead of the default Prisma driver. The singleton pattern in `src/lib/prisma.ts` prevents multiple instances in development.

**Database Models:**
- `Users` - Authentication and user management (role-based)
- `Vehicles` - Vehicle information with alias, model, plate, mileage tracking
- `Routes` - Trip distance tracking with dates and notes
- `Refuels` - Fuel expenses with type, gallons, and costs
- `Services` - Maintenance records with provider, mileage, and next service tracking

All models use:
- UUID primary keys (`@id @default(uuid())`)
- Timestamps (`createdAt`, `updatedAt`)
- Cascade deletion on parent relationships
- Indexes on frequently queried fields

### Application Structure

**Entry Point:** `src/index.ts`
- Express server setup with security middleware (helmet, cors, compression)
- Health check endpoint at `/health`
- Database connection managed via Prisma singleton

**Middleware Stack:**
1. Helmet (security headers)
2. CORS (cross-origin resource sharing)
3. Compression (response compression)
4. JSON parser (10mb limit)

**Logging:**
Uses Pino logger (`pino`, `pino-http`, `pino-pretty` for development)

### Environment Configuration

Required environment variables (see `.env.example`):
- `PORT` - Server port (default: 3000)
- `NODE_ENV` - Environment (development/production)
- `LOG_LEVEL` - Logging level
- `DATABASE_URL` - PostgreSQL connection string
- `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` - Docker PostgreSQL credentials
- `JWT_SECRET` - JWT signing key (minimum 32 characters)
- `JWT_EXPIRES_IN` - Token expiration (e.g., "7d")

## Key Dependencies

**Core:**
- `express` v5.2.1 - Web framework
- `@prisma/client` & `@prisma/adapter-pg` - Database ORM
- `pg` - PostgreSQL driver
- `zod` - Runtime type validation
- `jsonwebtoken` - JWT authentication
- `bcrypt` - Password hashing

**Security:**
- `helmet` - Security headers
- `cors` - CORS handling

**Development:**
- `typescript` & `ts-node` - TypeScript runtime
- `nodemon` - Hot reload
- `tsconfig-paths` - Path alias resolution
