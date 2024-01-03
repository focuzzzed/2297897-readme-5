/*
  Warnings:

  - You are about to drop the column `tags` on the `posts` table. All the data in the column will be lost.
  - The `post_state` column on the `posts` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `post_type` to the `posts` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "PostType" AS ENUM ('video', 'text', 'quote', 'photo', 'link');

-- CreateEnum
CREATE TYPE "PostState" AS ENUM ('draft', 'published');

-- AlterTable
ALTER TABLE "posts" DROP COLUMN "tags",
ADD COLUMN     "commentsCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "creator_user_id" TEXT,
ADD COLUMN     "is_reposted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "likes_count" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "originalPostId" TEXT,
ADD COLUMN     "post_type" "PostType" NOT NULL,
ADD COLUMN     "publish_date" TIMESTAMP(3),
DROP COLUMN "post_state",
ADD COLUMN     "post_state" "PostState" NOT NULL DEFAULT 'draft';

-- CreateTable
CREATE TABLE "tags" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PostToTag" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "tags_title_idx" ON "tags"("title");

-- CreateIndex
CREATE UNIQUE INDEX "_PostToTag_AB_unique" ON "_PostToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_PostToTag_B_index" ON "_PostToTag"("B");

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;
