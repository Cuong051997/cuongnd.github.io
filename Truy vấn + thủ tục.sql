-- Truy vấn tất cả bảng POST và MANAGERS
select * from post;
select * from managers;

-- Trong bảng POST, truy vấn những bài viết có LUOT_XEM lớn hơn 20.
select * from post where LUOT_XEM > 20;

-- Trong bảng POST, viết truy vấn những bài viết đã được xét duyệt và sắp xếp kết quả theo thứ tự bảng chữ cái của cột tiêu đề.
select * from post where XET_DUYET = 1 ORDER BY TIEU_DE ASC;

-- Viết truy vấn để lấy tên các acount_name của user comment vào POST
select C.NGUOI_COMMENT, U.ACCOUNT_NAME, C.NOI_DUNG from comment as C
join users as U on C.NGUOI_COMMENT = U.ID_USER;

-- Viết truy vấn để tìm nội dung bài viết bắt đầu bằng chữ ‘n’
select * from post where NOI_DUNG like upper('n%');

-- Tạo VIEW để lấy ra những bài viết đã được duyệt bởi những người quản lý.
create view post_duoc_duyet as select * from post where XET_DUYET  = 1;

-- Tạo VIEW để lấy ra các comment của user.
create view comment_of_user as select C.NGUOI_COMMENT,U.ACCOUNT_NAME, C.NOI_DUNG
FROM comment as C
join users as U on C.NGUOI_COMMENT = U.ID_USER;

-- Tạo thủ tục để lấy được những bài viết đã được duyệt
DELIMITER $$
CREATE PROCEDURE baivietdaduyet()
begin
select * from post where XET_DUYET = 1;
end $$
DELIMITER ;
call baivietdaduyet();

-- Tạo thủ tục để lấy những bài viết chưa được duyệt trước ngày 01-02-2018.
DELIMITER $$
CREATE PROCEDURE chuaduocduyet()
begin
select * from post
where XET_DUYET = 0 AND month(THOI_GIAN_DANG) <= 2
AND year(THOI_GIAN_DANG) <= 2018;
end $$
DELIMITER ;
call chuaduocduyet();

-- Tạo function để tính số tháng mà các bài viết đã đăng kể từ thời điểm 01-01-2019 trong bảng POST.
DELIMITER $$
CREATE FUNCTION sothang(ID INT) returns int
DETERMINISTIC
begin
DECLARE tinhsothang int;
select  12 + month('2019-01-01') - month(THOI_GIAN_DANG) from post
WHERE ID = ID_POST into tinhsothang;
return tinhsothang;
end $$
DELIMITER ;
select ID_POST, TIEU_DE, sothang(10) FROM post limit 1;

-- Lựa chọn một hoặc nhiều cột trong số các bảng đã tạo để tiến hành tạo INDEX.
create index idx_tieu_de ON post(TIEU_DE);
Chỉ mục này nhằm nâng cao tốc độ tìm kiếm, cột này thường có nhiều dữ liệu và cũng được quan tâm nhiều
