
# Tính toán và phân tích điểm thi

Tính toán điểm thi cho nhiều lớp với sĩ số hàng nghìn học sinh.
Mục đích của chương trình giúp giảm thời gian chấm điểm.

## Điều kiện
 - [Sử dụng Google colab](https://colab.research.google.com/drive/1mN9PUl4fFzhghJqvUICzFCbto1Wbb775?authuser=0)
 Nhấp vào link phía trên -> file -> Open notebook -> Upload -> Chọn thư mục DAP304x_01-A_VN_asm1_cuongndFX20942@funix.edu.vn -> Chọn file lastname_firstname_grade_the_exams.py


## Hướng dẫn sử dụng

Để dễ dàng trong việc sử dụng các câu lệnh và các hàm chúng ta sẽ sử dụng đến 2 thư viện trong python: Pandas và Numpy

```bash
import pandas as pd
import numpy as np
```
### 1. Đọc dữ liệu từ file 
#### Tạo hàm `read_file` để đọc dữ liệu và kiểm tra xem file có tồn tại hay không?
Nhập file muốn đọc vào trong input
```bash
def read_file():
    filename = input("Enter the file name (i.e. class1 for class1.txt): ")
    try:
        with open(filename+'.txt', 'r') as file:
            print("Successfully opened", filename)
            lines = file.readlines()
            data = [line.strip().split(",") for line in lines]
            return pd.DataFrame(data),filename
    except FileNotFoundError: 
        print("File not found.")
        return None
```
### 2. Phân tích và xử lý bài test của các học sinh

#### Tạo hàm `analyze` để thực hiện thu thập kết quả các câu trả lời của học sinh
```bash
def analyze(data):
```
#### Khai báo các biến và thư viện liên quan
```bash
valid_line = 0
invalid_line = 0
student_answers = {}
not26value = {} 
invalid_N = {} 
```
#### Vòng lặp qua từng dòng trong DataFrame 'data'
```bash
for index, row in data.iterrows():
        row = row.dropna()
        if len(row) == 26 and row[0][0] == 'N' and row[0][1:9].isdigit():
            valid_line += 1
            student_id = row[0]
            answers = row.iloc[1:].tolist()
            student_answers[student_id] = answers
        elif len(row) != 26:
            not26value[row[0]] = row.iloc[1:26].tolist()
            invalid_line += 1
        elif row[0][0] != 'N' or not row[0][1:9].isdigit():
            invalid_N[row[0]] = row.iloc[1:26].tolist()
            invalid_line += 1
```
#### Trả về dữ liệu và số dòng hợp lệ và không hợp lệ dưới dạng tuple
```bash
return student_answers, not26value, invalid_N, valid_line, invalid_line
```
### 3. Chấm điểm
#### Tạo hàm `grades`
```bash
def grades(student_answers):
```
#### Khai báo một bộ đáp án đúng mẫu
```bash
answer_key = "B,A,D,D,C,B,D,A,C,C,D,B,A,B,A,C,B,D,A,C,A,A,B,D,D"
answer_key = answer_key.split(',')
```
#### Tạo các từ điển để lưu trữ kết quả chấm điểm của từng sinh viên
```bash
scores = {}
skip_question = {}
wrong_answers = {}
```
####  Vòng lặp qua từng câu hỏi và câu trả lời tương ứng của sinh viên
 ```bash
for student_id, answers in student_answers.items():
        score = 0
        for i, answer in enumerate(answers):
```
#### Kiểm tra nếu chưa có thông tin về câu hỏi thứ i trong từ điển, thì khởi tạo giá trị ban đầu
 ```bash
if i not in skip_question:
    skip_question[i] = 0
    wrong_answers[i] = 0
```
#### Cộng điểm cho câu trả lời đúng
```bash
if answer == answer_key[i]:
     score += 4
elif answer == '':
    score += 0

    skip_question[i] += 1  
```
####  Câu trả lời sai và không bị bỏ qua, trừ điểm và cập nhật số câu trả lời sai
```bash
elif answer != answer_key[i] and answer != '':
    score -= 1
    wrong_answers[i] +=1
```
#### Lưu điểm số của sinh viên vào từ điển
```bash
scores[student_id] = score
```
#### Trả kết quả của từng sinh viên
```bash
return scores,skip_question,wrong_answers
```
### 4. Gọi hàm để đọc file
```bash
data,filename = read_file()
```
### 5. Dữ liệu đầu vào
Sau khi đã tạo các hàm chúng ta sẽ cần sử dụng các hàm này để thực hiện việc phân tích và xử lý dữ liệu đầu vào
```bash
if data is not None:
```
Phân tích dữ liệu từ DataFrame data
```bash
 student_answers, not26value, invalid_N, valid_line, invalid_line = analyze(data)
```
Tính điểm cho từng sinh viên từ các câu trả lời
```bash
 scores,skip_question, wrong_answers = grades(student_answers)
 print()
    print("**** ANALYZING ****")
    print()
```
Kiểm tra và in thông tin về các dòng dữ liệu không hợp lệ
```bash
 if not26value != {} or invalid_N != {}:
        if not26value != {}:
            print("Invalid lines of data: does not contain exactly 26 values:")
            for student_id, answers in not26value.items():
                print(student_id + ',', ','.join(answers))
        else: pass


        if invalid_N != {}:
            print("Invalid lines of data: N# is invalid:")
            for student_id, answers in invalid_N.items():
                print(student_id + ',', ','.join(answers))
        else: pass
    else:

        print("No errors found!")
    print()
```
### 6. In báo cáo tổng quan về dữ liệu và kết quả chấm điểm 
Tổng số dòng hợp lệ và không hợp lệ
```bash
    print("Total valid lines of data:", valid_line)
    print("Total invalid lines of data:", invalid_line)
```
Tổng số học sinh có điểm số > 80
```bash
    count_high_scores = sum(score> 80 for score in scores.values())
    print("Total students with high scores (>80):", count_high_scores)
```
Điểm trung bình của bài kiểm tra
```bash
    average_score = round(np.mean(list(scores.values())), 3)
    print("Mean (average) score:", average_score)
```
Số điểm cao nhất, thấp nhất và khoảng điểm
```bash
    max_score = np.max(list(scores.values()))
    print("Max score:", max_score)

    min_score = np.min(list(scores.values()))
    print("Min score:", min_score)

    range_score = max_score-min_score
    print("Range of scores:",range_score)
```
Số điểm trung vị
```bash
    median_score = np.median(list(scores.values()))
    print("Median score:",median_score)
```
#### Tìm câu hỏi mà sinh viên trả lời nhiều nhất và sai nhiều nhất
Câu hỏi có nhiều học sinh bỏ qua nhất
```bash
max_skip = np.max(list(skip_question.values()))
most_skipped_questions = []
for question, count in skip_question.items():
    if skip_question[question] == max_skip:
         skip_rate = round(count / len(student_answers), 3)
        most_skipped_questions.append(f"{question+1} - {count} - {skip_rate}")

print("Question that most people skip:", ', '.join(most_skipped_questions))
```
Câu hỏi các học sinh làm sai nhiều nhất
```bash
max_wrong = np.max(list(wrong_answers.values()))
    most_wrong_answers = []
    for answer, count in wrong_answers.items():
        if wrong_answers[answer] == max_wrong:
            wrong_rate = round(count / len(student_answers), 3)
            most_wrong_answers.append(f"{answer+1} - {count} - {wrong_rate}")

    print("Question that most people answer incorrectly:", ', '.join(most_wrong_answers))
```
### 7. Lưu kết quả chấm điểm vào file
```bash
output_filename = filename +"_grade.txt"
    with open (output_filename,"w") as output_file:
        for student_id, score in scores.items():
            output_file.write(f"{student_id},{score}\n")
```