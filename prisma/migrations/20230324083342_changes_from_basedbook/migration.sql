-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'MODERATOR', 'FAQ');

-- CreateEnum
CREATE TYPE "enumSkillLvl" AS ENUM ('beginner', 'intermediate', 'advanced');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "username" TEXT NOT NULL,
    "surname" TEXT,
    "class_name" TEXT,
    "passwordHash" TEXT NOT NULL,
    "profileDesc" TEXT NOT NULL,
    "loginID" INTEGER,
    "email" TEXT NOT NULL,
    "restURLId" INTEGER,
    "certificate" TEXT,
    "fingerprint" TEXT,
    "privateKey" TEXT,
    "firebaseToken" TEXT,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "avatar" BYTEA,
    "darkTheme" BOOLEAN NOT NULL DEFAULT false,
    "facebook" TEXT,
    "instagram" TEXT,
    "website" TEXT,
    "youtube" TEXT,
    "userId" INTEGER,
    "role" "Role" NOT NULL DEFAULT 'USER',
    "facebookId" TEXT,
    "googleId" TEXT,
    "newsLetter" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Follows" (
    "followerId" INTEGER NOT NULL,
    "followingId" INTEGER NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Follows_pkey" PRIMARY KEY ("followerId","followingId")
);

-- CreateTable
CREATE TABLE "UserSkils" (
    "id" SERIAL NOT NULL,
    "skillId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "skillLvl" "enumSkillLvl" NOT NULL,

    CONSTRAINT "UserSkils_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Skills" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Skills_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UnverifiedUser" (
    "tempId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "UnverifiedUser_pkey" PRIMARY KEY ("tempId")
);

-- CreateTable
CREATE TABLE "RestURL" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,

    CONSTRAINT "RestURL_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpottedPost" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "isAnonymous" BOOLEAN NOT NULL,

    CONSTRAINT "SpottedPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpottedLikes" (
    "id" SERIAL NOT NULL,
    "postId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "SpottedLikes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SchoolEvent" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "facebook" TEXT,
    "website" TEXT,

    CONSTRAINT "SchoolEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Report" (
    "Id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reason" TEXT NOT NULL,
    "projectId" INTEGER,
    "spottedPostId" INTEGER,
    "groupPostId" INTEGER,
    "userPostId" INTEGER,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id" SERIAL NOT NULL,
    "text" TEXT NOT NULL,
    "postId" INTEGER NOT NULL,
    "parentId" INTEGER,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Group" (
    "Id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Group_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "GroupAdmin" (
    "Id" SERIAL NOT NULL,
    "groupId" INTEGER,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "GroupAdmin_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "GroupMember" (
    "Id" SERIAL NOT NULL,
    "groupId" INTEGER,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "GroupMember_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "GroupPost" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "GroupPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserPost" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,

    CONSTRAINT "UserPost_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Olympics" (
    "id" SERIAL NOT NULL,
    "registrationEnd" TIMESTAMP(3) NOT NULL,
    "startsAt" TIMESTAMP(3) NOT NULL,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "prizePool" INTEGER NOT NULL,
    "organisators" TEXT[],

    CONSTRAINT "Olympics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SpottedComment" (
    "Id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "spottedPostId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "SpottedComment_pkey" PRIMARY KEY ("Id")
);

-- CreateTable
CREATE TABLE "Faq" (
    "id" SERIAL NOT NULL,
    "question" TEXT NOT NULL,
    "answer" TEXT,
    "isAnswered" BOOLEAN NOT NULL DEFAULT false,
    "askerId" INTEGER,
    "hierarchy" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "Faq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_OlympicsToUser" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_facebookId_key" ON "User"("facebookId");

-- CreateIndex
CREATE UNIQUE INDEX "User_googleId_key" ON "User"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "RestURL_url_key" ON "RestURL"("url");

-- CreateIndex
CREATE UNIQUE INDEX "SpottedLikes_userId_postId_key" ON "SpottedLikes"("userId", "postId");

-- CreateIndex
CREATE UNIQUE INDEX "_OlympicsToUser_AB_unique" ON "_OlympicsToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_OlympicsToUser_B_index" ON "_OlympicsToUser"("B");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_restURLId_fkey" FOREIGN KEY ("restURLId") REFERENCES "RestURL"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follows" ADD CONSTRAINT "Follows_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follows" ADD CONSTRAINT "Follows_followingId_fkey" FOREIGN KEY ("followingId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follows" ADD CONSTRAINT "Follows_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSkils" ADD CONSTRAINT "UserSkils_skillId_fkey" FOREIGN KEY ("skillId") REFERENCES "Skills"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserSkils" ADD CONSTRAINT "UserSkils_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnverifiedUser" ADD CONSTRAINT "UnverifiedUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpottedPost" ADD CONSTRAINT "SpottedPost_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpottedLikes" ADD CONSTRAINT "SpottedLikes_postId_fkey" FOREIGN KEY ("postId") REFERENCES "SpottedPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpottedLikes" ADD CONSTRAINT "SpottedLikes_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_spottedPostId_fkey" FOREIGN KEY ("spottedPostId") REFERENCES "SpottedPost"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_userPostId_fkey" FOREIGN KEY ("userPostId") REFERENCES "UserPost"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_groupPostId_fkey" FOREIGN KEY ("groupPostId") REFERENCES "GroupPost"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "SpottedPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupAdmin" ADD CONSTRAINT "GroupAdmin_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupAdmin" ADD CONSTRAINT "GroupAdmin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMember" ADD CONSTRAINT "GroupMember_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "Group"("Id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupMember" ADD CONSTRAINT "GroupMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GroupPost" ADD CONSTRAINT "GroupPost_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserPost" ADD CONSTRAINT "UserPost_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpottedComment" ADD CONSTRAINT "SpottedComment_spottedPostId_fkey" FOREIGN KEY ("spottedPostId") REFERENCES "SpottedPost"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SpottedComment" ADD CONSTRAINT "SpottedComment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Faq" ADD CONSTRAINT "Faq_askerId_fkey" FOREIGN KEY ("askerId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OlympicsToUser" ADD CONSTRAINT "_OlympicsToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Olympics"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_OlympicsToUser" ADD CONSTRAINT "_OlympicsToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
