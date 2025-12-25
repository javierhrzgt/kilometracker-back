-- CreateTable
CREATE TABLE "Vehicles" (
    "id" TEXT NOT NULL,
    "alias" TEXT NOT NULL,
    "model" INTEGER NOT NULL,
    "plate" TEXT,
    "currentMileage" INTEGER,
    "ActualMileage" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Routes" (
    "id" TEXT NOT NULL,
    "distance" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "vehicleId" TEXT NOT NULL,

    CONSTRAINT "Routes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Refuels" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "expense" INTEGER NOT NULL,
    "gallons" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "vehicleId" TEXT NOT NULL,

    CONSTRAINT "Refuels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Services" (
    "id" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "description" TEXT,
    "expense" INTEGER NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "mileage" INTEGER NOT NULL,
    "provider" TEXT NOT NULL,
    "next" TIMESTAMP(3),
    "nextMileage" INTEGER,
    "nextNotes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "vehicleId" TEXT NOT NULL,

    CONSTRAINT "Services_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Vehicles_alias_key" ON "Vehicles"("alias");

-- CreateIndex
CREATE INDEX "Vehicles_alias_idx" ON "Vehicles"("alias");

-- CreateIndex
CREATE INDEX "Vehicles_createdAt_idx" ON "Vehicles"("createdAt" DESC);

-- CreateIndex
CREATE INDEX "Routes_vehicleId_idx" ON "Routes"("vehicleId");

-- CreateIndex
CREATE INDEX "Routes_date_idx" ON "Routes"("date" DESC);

-- CreateIndex
CREATE INDEX "Routes_createdAt_idx" ON "Routes"("createdAt" DESC);

-- CreateIndex
CREATE INDEX "Refuels_vehicleId_idx" ON "Refuels"("vehicleId");

-- CreateIndex
CREATE INDEX "Refuels_date_idx" ON "Refuels"("date" DESC);

-- CreateIndex
CREATE INDEX "Refuels_createdAt_idx" ON "Refuels"("createdAt" DESC);

-- CreateIndex
CREATE INDEX "Services_vehicleId_idx" ON "Services"("vehicleId");

-- CreateIndex
CREATE INDEX "Services_date_idx" ON "Services"("date" DESC);

-- CreateIndex
CREATE INDEX "Services_createdAt_idx" ON "Services"("createdAt" DESC);

-- AddForeignKey
ALTER TABLE "Routes" ADD CONSTRAINT "Routes_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Refuels" ADD CONSTRAINT "Refuels_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Services" ADD CONSTRAINT "Services_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
