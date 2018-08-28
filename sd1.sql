/* start of sql code for the database assigment, based on 'cource experience app */


BEGIN transaction;
/* ------------------------------------------------------------------------------*/
/* --------This part of the code drops the table if it exists already -----------*/
/* ------------------------------------------------------------------------------*/

/*------------------done---------------------*/

  DROP table if exists semesters;               /*1*/
  DROP table if exists teachers;                /*2*/
  DROP table if exists students;                /*3*/
  DROP table if exists faculty;                 /*4*/
  DROP table if exists skills;                  /*5*/
  DROP table if exists classes;                 /*6*/
  DROP table if exists units;                   /*7*/
  DROP table if exists classes_units;           /*8*/
  DROP table if exists skills_experience;       /*9*/
  DROP table if exists skills_units;            /*10*/
  DROP table if exists class_roll;              /*11*/
  DROP table if exists experiences;             /*12*/


/* ----------------------------------------------------------------------------------------------*/
/*-------This part of the code is responsible for creating the tables within the database -------*/
/* ----------------------------------------------------------------------------------------------*/
/*--done--*/
  CREATE TABLE IF NOT EXISTS semesters(
  semester_number INTEGER,
  semester_duration INTEGER,
  semester_start_date TEXT,
  semester_end_date TEXT,
  semester_intermediate TEXT,
  PRIMARY KEY (semester_number)
  );
/*--done--*/
  CREATE TABLE IF NOT EXISTS teachers(
  teacher_first_name TEXT,
  teacher_gender TEXT,
  teacher_age INTEGER,
  teacher_expertise TEXT,
  teacher_starting_date text,
  teacher_last_name INTEGER,
  teacher_id INTEGER,
  teacher_ranking INTEGER,
  PRIMARY KEY (teacher_id),
  FOREIGN KEY (teacher_ranking) REFERENCES experiences (experience_ranking)
  );
/*--done--*/
  CREATE TABLE IF NOT EXISTS students (
  student_id INTEGER,
  student_birth_date text,
  student_gender TEXT,
  student_place_of_birth TEXT,
  student_enrolment_date text,
  student_unenrolment_date text,
  student_final_grade TEXT,
  student_first_name TEXT,
  student_last_name TEXT,
  student_year_level INTEGER null null,
  student_package TEXT null null,
  PRIMARY KEY (student_id)
  );
  /*--done--*/
  CREATE TABLE IF NOT EXISTS skills (
  class_code INTEGER,
  student_id INTEGER,
  faculty_id INTEGER,
  skill_name INTEGER,
  skill_id INTEGER,
  PRIMARY KEY (skill_id)
  );
  /*--done--*/
  CREATE TABLE IF NOT EXISTS faculty (
  faculty_name TEXT,
  faculty_id INTEGER,
  PRIMARY KEY (faculty_id)
  );
  /*--done--*/
  CREATE TABLE IF NOT EXISTS classes (
  class_number INTEGER,
  class_name TEXT,
  class_id INTEGER,
  class_units TEXT,
  class_skills TEXT,
  class_line INTEGER,
  student_id INTEGER,
  faculty_id INTEGER,
  semester_number INTEGER,
  class_semester_start INTEGER,
  class_semester_end INTEGER,
  PRIMARY KEY (class_id, student_id, faculty_id),
  FOREIGN KEY (faculty_id) REFERENCES faculty (faculty_id) ,
  FOREIGN KEY (student_id) REFERENCES students (student_id) ,
  FOREIGN KEY (semester_number, class_id, class_semester_start, class_semester_end) REFERENCES semesters (semester_number,semester_intermediate,semester_start_date,semester_end_date)
  );
  /*--done--*/
  CREATE TABLE IF NOT EXISTS units (
  faculty_id INTEGER,
  unit_name INTEGER,
  unit_id INTEGER,
  class_code INTEGER,
  student_id INTEGER,
  skill_id INTEGER,
  PRIMARY KEY (faculty_id, unit_id, class_code, student_id, skill_id),
  FOREIGN KEY (faculty_id) REFERENCES faculty (faculty_id)
  );
  /*--done--*/    /* intermediary table  and therefor does not have inserts */
  CREATE TABLE IF NOT EXISTS classes_units (
  faculty_id INTEGER,
  unit_id INTEGER,
  class_code INTEGER,
  student_id INTEGER,
  skill_id INTEGER,
  class_code1 INTEGER,
  student_id1 INTEGER,
  faculty_id1 INTEGER,
  CONSTRAINT PK_classes_units PRIMARY KEY (faculty_id, unit_id, class_code, student_id, skill_id, class_code1, student_id1, faculty_id1),
  FOREIGN KEY (faculty_id, unit_id, class_code, student_id, skill_id) REFERENCES units (faculty_id, unit_id, class_code, student_id, skill_id) ,
  FOREIGN KEY (class_code1, student_id1, faculty_id1) REFERENCES classes (class_id, student_id, faculty_id)
  );
  /*--done--*/   /* intermediary table  and therefor does not have inserts */
  CREATE TABLE IF NOT EXISTS skills_experience (
  student_id INTEGER,
  class_id INTEGER,
  faculty_id INTEGER,
  skills_rank INTEGER,
  skills_experience_id INTEGER,
  CONSTRAINT PK_skills_experience PRIMARY KEY (skills_experience_id),
  FOREIGN KEY (student_id) REFERENCES students (student_id) ,
  FOREIGN KEY (class_id, student_id, faculty_id) REFERENCES classes (class_id, student_id, faculty_id)
  );
  /*--done--*/    /* intermediary table  and therefor does not have inserts */
  CREATE TABLE IF NOT EXISTS skills_units (
  skill_id INTEGER,
  faculty_id INTEGER,
  unit_id INTEGER,
  class_code INTEGER,
  student_id INTEGER,
  skill_id1 INTEGER,
  CONSTRAINT PK_skills_units PRIMARY KEY (skill_id, faculty_id, unit_id, class_code, student_id, skill_id1),
  FOREIGN KEY (skill_id) REFERENCES skills (skill_id) ,
  FOREIGN KEY (faculty_id, unit_id, class_code, student_id, skill_id1) REFERENCES units (faculty_id, unit_id, class_code, student_id, skill_id)
  );
  /*--done--*/   /* intermediary table  and therefor does not have inserts */
  CREATE TABLE IF NOT EXISTS class_roll(
  class_roll_line INTEGER,
  class_roll_teacher_first_name TEXT,
  class_roll_student_grade TEXT,
  student_id INTEGER,
  class_roll_teacher_last_name TEXT,
  student_first_name TEXT,
  student_last_name TEXT,
  faculty_id INTEGER,
  class_code INTEGER,
  class_roll_id INTEGER,
  teacher_id INTEGER,
  PRIMARY KEY (student_id, class_roll_id),
  FOREIGN KEY (class_roll_line, student_id, faculty_id, class_code) REFERENCES classes (class_line, student_id, faculty_id, class_id) ,
  FOREIGN KEY (class_roll_teacher_first_name, class_roll_teacher_last_name, teacher_id) REFERENCES teachers (teacher_first_name, teacher_last_name, teacher_id) ,
  FOREIGN KEY (student_id, class_roll_student_grade, student_first_name, student_last_name) REFERENCES students (student_id, student_final_grade, student_first_name, student_last_name)
  );
  /*--done--*/
  CREATE TABLE IF NOT EXISTS experiences (
  experience_id INTEGER,
  student_id INTEGER,
  class_roll_id INTEGER,
  experience_ranking INTEGER,
  experience_semester_intermediate INTEGER,
  semester_number INTEGER,
  experience_satisfaction INTEGER,
  PRIMARY KEY (experience_id, student_id, class_roll_id),
  FOREIGN KEY (student_id) REFERENCES students (student_id) ,
  FOREIGN KEY (student_id, class_roll_id, experience_satisfaction) REFERENCES class_roll (student_id, class_roll_id, class_code) ,
  FOREIGN KEY (semester_number, experience_semester_intermediate) REFERENCES semesters (semester_number, semester_intermediate)
  );

END transaction;

BEGIN transaction;
/* ------------------------------------------------------------------------------*/
/* --------This part of the code populates the database with data ---------------*/
/* ------------------------------------------------------------------------------*/



/*-------------------------------------------------------------------------------*/
/*-----------------------------data for semesters--------------------------------*/
/*-------------------------------------------------------------------------------*/
	INSERT INTO semesters(semester_number, semester_duration, semester_start_date, semester_end_date, semester_intermediate)values (0,10,"01-01","01-03",'F');
  INSERT INTO semesters(semester_number, semester_duration, semester_start_date, semester_end_date, semester_intermediate)values (1,10,"01-03","01-06",'T');
  INSERT INTO semesters(semester_number, semester_duration, semester_start_date, semester_end_date, semester_intermediate)values (2,10,"01-06","01-09",'F');
  INSERT INTO semesters(semester_number, semester_duration, semester_start_date, semester_end_date, semester_intermediate)values (3,10,"01-09","01-12",'F');
/*-------------------------------------------------------------------------------*/
/*-----------------------------data for teachers---------------------------------*/
/*-------------------------------------------------------------------------------*/
  INSERT INTO teachers(teacher_first_name, teacher_gender, teacher_age, teacher_expertise, teacher_starting_date, teacher_last_name, teacher_id, teacher_ranking)values ('Sally', 'F', 30, 'english', 12-03-2010, 'Parkinson', 1, 2);
  INSERT INTO teachers(teacher_first_name, teacher_gender, teacher_age, teacher_expertise, teacher_starting_date, teacher_last_name, teacher_id, teacher_ranking)values ('Peter', 'M', 32, 'maths', 17-08-2015, 'Bell', 2, 5);
  INSERT INTO teachers(teacher_first_name, teacher_gender, teacher_age, teacher_expertise, teacher_starting_date, teacher_last_name, teacher_id, teacher_ranking)values ('Lesa', 'F', 25, 'art', 2-12-2017, 'May', 3, 1);
/*-------------------------------------------------------------------------------*/
/*-----------------------------data for students---------------------------------*/
/*-------------------------------------------------------------------------------*/
  INSERT INTO students(student_id, student_birth_date, student_gender, student_place_of_birth, student_enrolment_date, student_unenrolment_date,student_final_grade, student_first_name, student_last_name, student_year_level, student_package)values (0608458, "27,12,01", 'M', 'Australia', 01-01-2018, 00-00-00, "A", "Daniel", "Davaris", 11, "T");
  INSERT INTO students(student_id, student_birth_date, student_gender, student_place_of_birth, student_enrolment_date, student_unenrolment_date,student_final_grade, student_first_name, student_last_name, student_year_level, student_package)values (485034, "16,03,01", 'F', 'China', 01-01-2018, 00-00-00, "B", "Venessa", "Chow", 11, "A");
  INSERT INTO students(student_id, student_birth_date, student_gender, student_place_of_birth, student_enrolment_date, student_unenrolment_date,student_final_grade, student_first_name, student_last_name, student_year_level, student_package)values (821345, "03,11,00", 'M', 'India', 01-01-2017, 00-00-00, "B", "Tom", "Tucker", 12, "T");
  INSERT INTO students(student_id, student_birth_date, student_gender, student_place_of_birth, student_enrolment_date, student_unenrolment_date,student_final_grade, student_first_name, student_last_name, student_year_level, student_package)values (821335, "03,11,00", 'F', 'New Zealand', 05-07-2017, 00-00-00, "D-", "Lizzy", "Palm", 12, "A");
  INSERT INTO students(student_id, student_birth_date, student_gender, student_place_of_birth, student_enrolment_date, student_unenrolment_date,student_final_grade, student_first_name, student_last_name, student_year_level, student_package)values (778445, "18,01,00", 'F', 'Australia', 01-01-2017, 00-00-00, "B", "Tom", "Tucker", 12, "T");
/*-------------------------------------------------------------------------------*/
/*-----------------------------data for skills-----------------------------------*/
/*-------------------------------------------------------------------------------*/
  INSERT INTO skills(skill_name, skill_id)values ("taking notes", 1);
  INSERT INTO skills(skill_name, skill_id)values ("applying to real world", 2);
  INSERT INTO skills(skill_name, skill_id)values ("listening well", 3);
  INSERT INTO skills(skill_name, skill_id)values ("being on time", 4);
  INSERT INTO skills(skill_name, skill_id)values ("mathematical skills", 5);
  INSERT INTO skills(skill_name, skill_id)values ("team work", 6);
  INSERT INTO skills(skill_name, skill_id)values ("english skills", 7);
/*-------------------------------------------------------------------------------*/
/*-----------------------------data for faculty-----------------------------------*/
/*-------------------------------------------------------------------------------*/
  INSERT INTO faculty(faculty_name, faculty_id)values ("Arts and Social Sciences", 1);
  INSERT INTO faculty(faculty_name, faculty_id)values ("Business", 2);
  INSERT INTO faculty(faculty_name, faculty_id)values ("Engineering and Information Technologies", 3);
  INSERT INTO faculty(faculty_name, faculty_id)values ("Medicine and Health", 4);
/*-------------------------------------------------------------------------------*/
/*-----------------------------data for classes----------------------------------*/
/*-------------------------------------------------------------------------------*/
INSERT INTO classes(class_number, class_name, class_id, class_line)values (1, "maths", 1, 1);
INSERT INTO classes(class_number, class_name, class_id, class_line)values (2, "english", 2, 2);
INSERT INTO classes(class_number, class_name, class_id, class_line)values (3, "science", 3, 3);
INSERT INTO classes(class_number, class_name, class_id, class_line)values (4, "Art", 4, 4);
INSERT INTO classes(class_number, class_name, class_id, class_line)values (4, "Design", 5, 5);
INSERT INTO classes(class_number, class_name, class_id, class_line)values (4, "Sport", 6, 6);

/*-------------------------------------------------------------------------------*/
/*-----------------------------data for units------------------------------------*/
/*-------------------------------------------------------------------------------*/
INSERT INTO units(unit_name, unit_id)values ("unit-1", 1);
INSERT INTO units(unit_name, unit_id)values ("unit-2", 2);
INSERT INTO units(unit_name, unit_id)values ("unit-3", 3);
INSERT INTO units(unit_name, unit_id)values ("unit-4", 4);
INSERT INTO units(unit_name, unit_id)values ("unit-5", 5);
INSERT INTO units(unit_name, unit_id)values ("unit-6", 6);
INSERT INTO units(unit_name, unit_id)values ("unit-7", 7);
INSERT INTO units(unit_name, unit_id)values ("unit-8", 8);
INSERT INTO units(unit_name, unit_id)values ("unit-9", 9);
INSERT INTO units(unit_name, unit_id)values ("unit-10", 10);
INSERT INTO units(unit_name, unit_id)values ("unit-11", 11);
INSERT INTO units(unit_name, unit_id)values ("unit-12", 12);


INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (1, 4, 2);
INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (2, 3, 2);
INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (3, 2, 3);
INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (4, 4, 4);
INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (5, 1, 2);
INSERT INTO experiences(experience_id, experience_ranking, experience_satisfaction)values (6, 2, 1);




END transaction;

.echo on
.echo off
