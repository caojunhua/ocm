-- 创建公告列表数据表
create table if not exists "T_QDManagerNetInfo"(
"id" integer primary key autoincrement not null default 1,
"chName" text,
"bossId" text,
"contacts" text,
"phone" text,
"chLatitude" real,
"chLogngitude" real,
"rankCode" text,
"distance" real,
"QDid" text unique
);

-- 创建公告详情数据表
create table if not exists "T_AllNetInfo"(
"id" integer primary key autoincrement not null default 1,
"chLatitude" real,
"chLogngitude" real
);

