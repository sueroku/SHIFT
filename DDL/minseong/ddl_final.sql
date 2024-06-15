CREATE TABLE `genre` (
  `id` bigint unsigned AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `movie` (
  `id` bigint unsigned AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `reservation_rate` INT(11),
  `information` VARCHAR(3000) ,
  `screening_type` VARCHAR(255) ,
  `director` VARCHAR(255),
  `genre_id` bigint unsigned,
  `rating` VARCHAR(10) ,
  `showing_date` date,
  `cast` VARCHAR(255),
  `running_time` INT(11),
  `poster` BLOB ,
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`)
  )
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `region` (
  `id` bigint unsigned AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `theater` (
  `id` bigint unsigned AUTO_INCREMENT,
  `region_id` bigint unsigned,
  `address` VARCHAR(255) NOT NULL,
  name varchar(255) NOT NULL,
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `theater_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `multiplex` (
  `id` bigint unsigned AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `theater_id` bigint unsigned,
  `floor` INT(11) NOT NULL,
  `screen_num` INT(11) NOT NULL,
  `total_seat` INT(11) NOT NULL,
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `multiplex_ibfk_1` FOREIGN KEY (`theater_id`) REFERENCES `theater` (`id`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE `seat` (
  `id` bigint unsigned AUTO_INCREMENT,
  `row` CHAR(1) NOT NULL,
  `column` INT(11) NOT NULL,
  multiplex_id bigint unsigned,
  state enum('Y', 'N') NOT NULL DEFAULT 'N', -- Y 예약 N은 예약전
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (multiplex_id) REFERENCES multiplex (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `showing` (
  `id` bigint unsigned AUTO_INCREMENT,
  `movie_name` VARCHAR(255) NOT NULL,
  `multiplex_id` bigint unsigned,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `movie_id` bigint unsigned,
  `subtitle` TINYINT(1) NOT NULL,
  `state` ENUM('상영전','상영중','상영종료') DEFAULT '상영전',
  live_seat int(11),
  del_YN ENUM('Y', 'N') DEFAULT 'N',
  created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `showing_ibfk_2` FOREIGN KEY (`multiplex_id`) REFERENCES `multiplex` (`id`),
  CONSTRAINT `showing_ibfk_3` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE member(
id        bigint unsigned AUTO_INCREMENT,
email varchar(255) NOT NULL unique,
password varchar(255) NOT NULL,
name varchar(225) NOT NULL,
phoneNumber varchar(255) NOT NULL unique,
birth date NOT NULL,
created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY (`id`)
)ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE rental(
id bigint unsigned AUTO_INCREMENT,
member_id BIGINT unsigned,
title VARCHAR(255) NOT NULL,
contents VARCHAR(255) NOT NULL,
created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY(id),
FOREIGN KEY(member_id) REFERENCES member(id)
);

CREATE TABLE lost(
id   bigint unsigned AUTO_INCREMENT,
member_id bigint unsigned,
title VARCHAR(255) NOT NULL,
contents VARCHAR(255) NOT NULL,
created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY(id),
FOREIGN KEY(member_id) REFERENCES member(id)
);

CREATE TABLE inquiry(
id   bigint unsigned AUTO_INCREMENT,
member_id BIGINT unsigned,
title VARCHAR(255) NOT NULL,
contents VARCHAR(255) NOT NULL,
created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY(id),
FOREIGN KEY(member_id) REFERENCES member(id)
);

CREATE TABLE notice(
id  bigint unsigned AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
contents VARCHAR(255) NOT NULL,
created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY(id)
);

CREATE TABLE points(
id  bigint unsigned AUTO_INCREMENT,
`member_id`   bigint unsigned unique,
amount int(11) unsigned,
created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
del_YN ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY(id),
FOREIGN KEY(member_id) REFERENCES member(id)
);

CREATE TABLE `Pay` (
   `id`   bigint unsigned AUTO_INCREMENT,
   `member_id`   bigint unsigned,
   `showing_id`   bigint unsigned,
   `seat_id`   bigint unsigned,
   `pay_type`   enum('성인', '청소년', '경로', '우대') NOT NULL,
   `PRICE`   decimal(10,2) NOT NULL,
   created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
   `del_YN`   ENUM('Y', 'N') DEFAULT 'N',
PRIMARY KEY (`id`),
FOREIGN KEY(member_id) REFERENCES member(id),
FOREIGN KEY(showing_id) REFERENCES showing(id),
FOREIGN KEY(seat_id) REFERENCES seat(id)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE `Pay_method` (
   `id`  bigint unsigned AUTO_INCREMENT,
   `member_id`   bigint unsigned,
   `card_name`   varchar(255) NOT NULL,
   `card_company`   varchar(255) NOT NULL,
   `card_num`   varchar(255) NOT NULL,
   `card_password`   int    NOT NULL,
   `del_YN`   ENUM('Y', 'N') DEFAULT 'N',
   created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
FOREIGN KEY(member_id) REFERENCES member(id)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


CREATE TABLE `ticket` (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `price` VARCHAR(100) NOT NULL,
    `description` VARCHAR(3000),
    `image` BLOB,
    PRIMARY KEY (id)
);

CREATE TABLE `snack` (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `price` VARCHAR(100) NOT NULL,
    `description` VARCHAR(3000),
    `image` BLOB,
    PRIMARY KEY (id)
);"