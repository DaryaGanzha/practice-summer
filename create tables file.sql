CREATE TABLE Methodist (
	methodist_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	email VARCHAR(50) UNIQUE NOT NULL,
	methodist_password VARCHAR(60) UNIQUE NOT NULL,
	phone VARCHAR(12) UNIQUE NOT NULL,
	user_role CHAR(9) DEFAULT 'methodist',
	methodist_first_name VARCHAR(50),
	methodist_last_name VARCHAR(50) NULL,
	date_of_birth TIMESTAMPTZ DEFAULT now(),
	date_of_create TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE Teacher (
	teacher_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	email VARCHAR(50) UNIQUE NOT NULL,
	teacher_password VARCHAR(60) UNIQUE NOT NULL,
	phone VARCHAR(12) UNIQUE NOT NULL,
	user_role CHAR(9) DEFAULT 'teacher',
	teacher_first_name VARCHAR(50),
	teacher_last_name VARCHAR(50) NULL,
	date_of_birth TIMESTAMPTZ DEFAULT now(),
	date_of_create TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE Student (
	student_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	email VARCHAR(50) UNIQUE NOT NULL,
	student_password VARCHAR(60) UNIQUE NOT NULL,
	phone VARCHAR(12) UNIQUE NOT NULL,
	user_role CHAR(9) DEFAULT 'student',
	student_first_name VARCHAR(50),
	student_last_name VARCHAR(50) NULL,
	date_of_birth TIMESTAMPTZ DEFAULT now(),
	date_of_create TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE Course (
	course_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	course_name VARCHAR(50) NOT NULL,
	relevance BOOLEAN,
	date_of_update TIMESTAMPTZ DEFAULT now(),
	date_of_create TIMESTAMPTZ DEFAULT now(),
	methodist_id INT,
	teacher_id INT,
	CONSTRAINT fk_course_methodist FOREIGN KEY(methodist_id) REFERENCES Methodist(methodist_id),
	CONSTRAINT fk_course_teacher FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Lesson (
	lesson_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	lesson_name VARCHAR(50) NOT NULL,
	lesson_text TEXT NOT NULL,
	media VARCHAR, 
	date_of_create TIMESTAMPTZ DEFAULT now(),
	date_of_update TIMESTAMPTZ DEFAULT now(),
	course_id INT,
	CONSTRAINT fk_lesson_course FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE OnlineLesson (
	online_lesson_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	online_lesson_name VARCHAR(50) NOT NULL,
	lesson_link VARCHAR(100) NOT NULL,
	lesson_time TIMESTAMPTZ NOT NULL,
	date_of_create TIMESTAMPTZ DEFAULT now(),
	date_of_update TIMESTAMPTZ DEFAULT now(),
	teacher_id INT,
	CONSTRAINT fk_onlineLesson_teacher FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Student_Course (
	subscribe_date TIMESTAMPTZ DEFAULT now(),
	unsubscribe_date TIMESTAMPTZ DEFAULT now(),
	student_id INT,
	course_id INT,
	CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES Student(student_id),
	CONSTRAINT fk_course FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE Homework (
	homework_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	homework_name VARCHAR(100) NOT NULL,
	deadline DATE NOT NULL,
	course_id INT,
	max_grade SMALLINT NOT NULL,
	teacher_id INT,
	CONSTRAINT fk_homework_course FOREIGN KEY(course_id) REFERENCES Course(course_id),
	CONSTRAINT fk_homework_teacher FOREIGN KEY(teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Student_homework (
	grade SMALLINT DEFAULT 0,
	departure_date TIMESTAMPTZ,
	check_time DATE,
	status BOOLEAN DEFAULT FALSE,
	student_id INT,
	homework_id INT,
	PRIMARY KEY (student_id, homework_id),
	CONSTRAINT fk_sh_student FOREIGN KEY(student_id) REFERENCES Student(student_id),
	CONSTRAINT fk_sh_homework FOREIGN KEY(homework_id) REFERENCES Homework(homework_id)
);

CREATE TABLE Homework_task (
	task_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	task_name VARCHAR,
	task_text TEXT,
	media VARCHAR NULL,
	homework_id INT NOT NULL,
	CONSTRAINT fk_task_homework FOREIGN KEY(homework_id) REFERENCES Homework(homework_id)
);

CREATE TABLE Possible_answer (
	answer_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	answer_text VARCHAR NOT NULL,
	correct_answer BOOLEAN NOT NULL
);

CREATE TABLE Task_possible_answer (
	date_of_create TIMESTAMPTZ DEFAULT now(),
	answer_id INT,
	task_id INT,
	CONSTRAINT fk_answer FOREIGN KEY(answer_id) REFERENCES Possible_answer(answer_id),
	CONSTRAINT fk_task FOREIGN KEY(task_id) REFERENCES Homework_task(task_id)
);

CREATE TABLE Student_answers (
	student_id INT, 
	homework_id INT,
	task_id INT,
	answer_id INT,
	CONSTRAINT fk_student FOREIGN KEY(student_id) REFERENCES Student_homework(student_id),
	CONSTRAINT fk_homework FOREIGN KEY(homework_id) REFERENCES Student_homework(homework_id),
	CONSTRAINT fk_task FOREIGN KEY(task_id) REFERENCES Homework_task(task_id),
	CONSTRAINT fk_answer FOREIGN KEY(answer_id) REFERENCES Possible_answer(answer_id)
);