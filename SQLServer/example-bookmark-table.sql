create table Users (
   User_ID              int                  not null,
   UserName             varchar(50)          not null,
   LoginName            varchar(20)          not null,
   DistinguishedName    varchar(255)         null,
   Password             varchar(50)          null,
   ExpirationDate       datetime             null,
   LockedOut            char(1)              not null default 'F',
   LockedOutReason      varchar(255)         null,
   ResetPassword        char(1)              not null default 'T',
   Inactive             char(1)              not null default 'F',
   LastLoginDate        datetime             null,
   LastLoginProgram_ID  int                  null,
   ReportUserName       varchar(100)         null,
   ReportPassword       varchar(255)         null,
   ChangeBy             varchar(20)          null,
   LastChange           datetime             null,
   constraint PK_USERS primary key (User_ID)
)
go

create unique index UK_USER_LOGINNAME on Users (
	LoginName ASC
)
go

create table Bookmark (
   Bookmark_ID          int                  not null,
   BookmarkFolder_ID    int                  null,
   User_ID              int                  null,
   Caption              varchar(255)         not null,
   Link                 varchar(1000)        not null,
   Program_ID           int                  null,
   ChangeBy             varchar(20)          null,
   LastChange           datetime             null,
   constraint PK_BOOKMARK primary key (Bookmark_ID)
)
go

create table BookmarkFolder (
   BookmarkFolder_ID    int                  not null,
   Name                 varchar(255)         not null,
   ParentBookmarkFolder_ID int                  null,
   User_ID              int                  null,
   Program_ID           int                  null,
   ChangeBy             varchar(20)          null,
   LastChange           datetime             null,
   constraint PK_BOOKMARKFOLDER primary key (BookmarkFolder_ID)
)
go

/* ***************************************************************************
 * http://book.cakephp.org/3.0/en/tutorials-and-examples/bookmarks/intro.html
 ***************************************************************************** */
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created DATETIME,
    modified DATETIME
);

CREATE TABLE bookmarks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(50),
    description TEXT,
    url TEXT,
    created DATETIME,
    modified DATETIME,
    FOREIGN KEY user_key (user_id) REFERENCES users(id)
);

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    created DATETIME,
    modified DATETIME,
    UNIQUE KEY (title)
);

CREATE TABLE bookmarks_tags (
    bookmark_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (bookmark_id, tag_id),
    FOREIGN KEY tag_key(tag_id) REFERENCES tags(id),
    FOREIGN KEY bookmark_key(bookmark_id) REFERENCES bookmarks(id)
);

/* ***************************************************************************
 * http://dba.stackexchange.com/questions/54851/database-design-for-bookmark-system
 ***************************************************************************** */
USE tempdb;
GO
CREATE TABLE Users
(
    UserID INT NOT NULL CONSTRAINT PK_Users PRIMARY KEY CLUSTERED IDENTITY(1,1),
	UserName varchar(255)
);
CREATE TABLE Bookmarks
(
    BookmarkID INT NOT NULL CONSTRAINT PK_Bookmarks PRIMARY KEY CLUSTERED IDENTITY(1,1),
	BookmarkName varchar(255),
	BookmarkURL varchar(255)
);
CREATE TABLE Tags
(
    TagID INT NOT NULL CONSTRAINT PK_Tags PRIMARY KEY CLUSTERED IDENTITY(1,1),
	TagName varchar(255)
);

CREATE TABLE UsersBookmarksTags
(
    UserID INT NOT NULL CONSTRAINT FK_UsersBookmarksTags_UserID FOREIGN KEY REFERENCES Users(UserID),
	TagID INT NOT NULL CONSTRAINT FK_UsersBookmarksTags_TagID FOREIGN KEY REFERENCES Tags(TagID),
	BookmarkID INT NOT NULL CONSTRAINT FK_UsersBooksmarksTags_BookmarkID FOREIGN KEY REFERENCES Bookmarks(BookmarkID),
	CONSTRAINT PK_UsersBookmarksTags PRIMARY KEY CLUSTERED  (UserID, TagID, BookmarkID)
);

CREATE TABLE UsersBookmarksTags
(
    UsersTagsBookmarksID INT NOT NULL CONSTRAINT PK_UsersBookmarksTags PRIMARY KEY CLUSTERED IDENTITY(1,1),
	UserID INT NOT NULL CONSTRAINT FK_UserBookmarks_UserID FOREIGN KEY REFERENCES Users(UserID),
	TagID INT NULL CONSTRAINT FK_UserBookmarks_TagID FOREIGN KEY REFERENCES Tags(TagID),
	BookmarkID INT NULL CONSTRAINT FK_UserBooksmarks_BookmarkID FOREIGN KEY REFERENCES Bookmarks(BookmarkID)
);

CREATE TABLE UserTags
(
    UserID INT NOT NULL CONSTRAINT FK_UserTags_UserID FOREIGN KEY REFERENCES Users(UserID),
	TagID INT NOT NULL CONSTRAINT FK_UserTags_TagID FOREIGN KEY REFERENCES Tags(TagID),
	CONSTRAINT PK_UserTags PRIMARY KEY CLUSTERED  (UserID, TagID)
);
