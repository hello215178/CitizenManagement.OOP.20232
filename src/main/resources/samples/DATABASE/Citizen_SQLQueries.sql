--------------------------------------------------------------------------------
--------------------------2. SQL queries----------------------------------------
--------------------------------------------------------------------------------
--Q1
SELECT * FROM NGUOIQUANLY WHERE TENDANGNHAP = 'nguyendinhvu' AND MATKHAU = '123456';
--Q2
SELECT * FROM NGUOIQUANLY WHERE TENDANGNHAP = 'nguyendinhvu';
--Q3
SELECT * FROM NGUOIQUANLY WHERE HOTEN =  'Nguyễn Đình Vũ' AND TENDANGNHAP = 'nguyendinhvu' AND SODIENTHOAI ='0964306632' AND VAITRO = true;
--Q4
UPDATE NGUOIQUANLY SET MATKHAU = 'newpassword'
WHERE HOTEN = 'nguyendinhvu' AND TENDANGNHAP = 'nguyendinhvu' AND SODIENTHOAI = '0964306632' AND VAITRO = true;
--Q5
INSERT INTO NGUOIQUANLY(HOTEN, TENDANGNHAP, MATKHAU, SODIENTHOAI, VAITRO)
              VALUES ( hoTen,  tenDangNhap ,  matKhau , soDienThoai ,vaiTro);
--Q6
SELECT COUNT(MAGIAYTAMTRU) FROM TAMTRU WHERE date_part('year', current_date) BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q7
SELECT COUNT(MAGIAYTAMVANG) FROM TAMVANG WHERE date_part('year', current_date) BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q8
select count(MANHANKHAU) from NHANKHAU where GIOITINH = true;
--Q9
select count(MANHANKHAU) from NHANKHAU where GIOITINH = false;
--Q10
SELECT COUNT(MANHANKHAU)
    FROM NHANKHAU
    WHERE date_part('year', current_date) - date_part('year', NGAYSINH) < 3            AND date_part('year', current_date) - date_part('year', NGAYSINH) >= 0;
--Q11
SELECT COUNT(MAGIAYTAMTRU)
FROM TAMTRU
WHERE
    date_part('month', TUNGAY) <= 5 AND date_part('month', DENNGAY) >= 5
    AND date_part('year', TUNGAY) <= 2023 AND date_part('year', DENNGAY) >= 2023;
--Q12
SELECT COUNT(MAGIAYTAMTRU)
FROM TAMTRU
WHERE LYDO LIKE '%Học tập%' AND 2023 BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q13
SELECT NHANKHAU.*
FROM NHANKHAU JOIN HOKHAU on nhankhau.manhankhau = hokhau.IDCHUHO
join DONGGOP using (MAHOKHAU)
join LOAIPHI using (MAKHOANTHU)
where DONGGOP.trangthai = true and loaiphi.ten = 'Đóng góp phí thương binh liệt sĩ 27/7'
INTERSECT
SELECT NHANKHAU.*
FROM NHANKHAU JOIN HOKHAU on nhankhau.manhankhau = hokhau.IDCHUHO
join DONGGOP using (MAHOKHAU)
join LOAIPHI using (MAKHOANTHU)
where DONGGOP.trangthai = true and loaiphi.ten = 'Học phí 2023.1';
--Q14
SELECT MANHANKHAU, SOCANCUOC, HOTEN, GIOITINH, NGAYSINH, NOITHUONGTRU
FROM NHANKHAU WHERE MANHANKHAU NOT IN (SELECT MANHANKHAU FROM THANHVIENCUAHO);
--Q15
SELECT HK.MAHOKHAU, NK.HOTEN, HK.DIACHI, COUNT(TV.MANHANKHAU)
FROM HOKHAU HK
INNER JOIN NHANKHAU NK ON HK.IDCHUHO = NK.MANHANKHAU
INNER JOIN THANHVIENCUAHO TV ON HK.MAHOKHAU = TV.MAHOKHAU
GROUP BY HK.MAHOKHAU, NK.HOTEN, HK.DIACHI;
--Q16
SELECT HOKHAU.MAHOKHAU, COUNT(THANHVIENCUAHO.MANHANKHAU) AS SOTHANHVIEN
FROM HOKHAU JOIN THANHVIENCUAHO using (mahokhau)
GROUP BY HOKHAU.mahokhau
having count(thanhviencuaho.manhankhau) >=
        (SELECT AVG(THANHVIENCUAMOTHO)
        FROM (SELECT COUNT(THANHVIENCUAHO.manhankhau) as THANHVIENCUAMOTHO
                from hokhau join thanhviencuaho on hokhau.mahokhau = thanhviencuaho.mahokhau
                group by hokhau.mahokhau));

--Q17
SELECT COUNT(MAGIAYTAMVANG)
FROM TAMVANG
WHERE LYDO LIKE '%Làm việc%' AND 2023 BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q18
SELECT COUNT(MAGIAYTAMTRU)
FROM TAMTRU
WHERE LYDO LIKE '%Sức khỏe%' AND 2023 BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q19
SELECT COUNT(MAGIAYTAMVANG)
FROM TAMVANG
WHERE LYDO LIKE '%Sức khỏe%' AND 2023 BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);
--Q20
SELECT COUNT(MAGIAYTAMTRU)
FROM TAMTRU
WHERE 5 BETWEEN date_part('month', TUNGAY) AND date_part('month', DENNGAY)
AND 2023 BETWEEN date_part('year', TUNGAY) AND date_part('year', DENNGAY);

--Q21
SELECT COUNT(*) FROM KHAITU;
--Q22
SELECT COUNT(*)
FROM KHAITU
WHERE LYDOCHET = 'ung thư';
--Q23
SELECT COUNT(MAHOKHAU), LOAIPHI.TEN
  FROM DONGGOP JOIN LOAIPHI USING(MAKHOANTHU)
  WHERE TRANGTHAI = false
GROUP BY LOAIPHI.TEN;
--Q24
SELECT SUM(SOTIENCANDONG)
FROM DONGGOP
WHERE TRANGTHAI = true;
--Q25
SELECT HOKHAU.TENCHUHO, COUNT(THANHVIENCUAHO.MANHANKHAU) AS TOTAL_MEMBERS
FROM HOKHAU
JOIN THANHVIENCUAHO ON HOKHAU.MAHOKHAU = THANHVIENCUAHO.MAHOKHAU
GROUP BY HOKHAU.TENCHUHO
ORDER BY TOTAL_MEMBERS DESC;
--Q26
SELECT DISTINCT HOKHAU.TENCHUHO, HOKHAU.NGAYTAO
FROM HOKHAU
JOIN THANHVIENCUAHO ON HOKHAU.MAHOKHAU = THANHVIENCUAHO.MAHOKHAU
JOIN TAMVANG ON THANHVIENCUAHO.MANHANKHAU = TAMVANG.MANHANKHAU
WHERE TAMVANG.TUNGAY > '2022-01-01';
--Q27
SELECT HOKHAU.*
FROM HOKHAU
JOIN (
    SELECT MAHOKHAU, COUNT(*) AS MEMBER_COUNT
    FROM THANHVIENCUAHO
    GROUP BY MAHOKHAU
    HAVING COUNT(*) > 3
) AS SUBQUERY ON HOKHAU.MAHOKHAU = SUBQUERY.MAHOKHAU;
--Q28
SELECT HOKHAU.TENCHUHO, HOKHAU.DIACHI
FROM HOKHAU
LEFT JOIN THANHVIENCUAHO ON HOKHAU.MAHOKHAU = THANHVIENCUAHO.MAHOKHAU
LEFT JOIN TAMVANG ON THANHVIENCUAHO.MANHANKHAU = TAMVANG.MANHANKHAU
WHERE TAMVANG.MANHANKHAU IS NULL;
--Q29
SELECT HOKHAU.TENCHUHO, HOKHAU.DIACHI
FROM HOKHAU
JOIN NHANKHAU ON HOKHAU.IDCHUHO = NHANKHAU.MANHANKHAU
JOIN THANHVIENCUAHO ON NHANKHAU.MANHANKHAU = THANHVIENCUAHO.MANHANKHAU
GROUP BY HOKHAU.TENCHUHO, HOKHAU.DIACHI
HAVING AVG(DATE_PART('year', AGE(NHANKHAU.NGAYSINH))) > 40;
--Q30
SELECT HOKHAU.TENCHUHO, HOKHAU.DIACHI, COUNT(THANHVIENCUAHO.MANHANKHAU) AS TOTAL_MEMBERS
FROM HOKHAU
JOIN THANHVIENCUAHO ON HOKHAU.MAHOKHAU = THANHVIENCUAHO.MAHOKHAU
GROUP BY HOKHAU.TENCHUHO, HOKHAU.DIACHI
HAVING COUNT(THANHVIENCUAHO.MANHANKHAU) = (
    SELECT MAX(MEMBER_COUNT)
    FROM (
        SELECT COUNT(MANHANKHAU) AS MEMBER_COUNT
        FROM THANHVIENCUAHO
        GROUP BY MAHOKHAU
    ) AS SUBQUERY
);
--------------------------------------------------------------------------------
--------------------------3. Trigger & Function---------------------------------
--------------------------------------------------------------------------------
--Trigger After Insert
CREATE OR REPLACE FUNCTION INSERT_HOKHAU() RETURNS TRIGGER AS $$
DECLARE
    V_TENCHUHO VARCHAR(300);
    V_MAHOKHAU INT;
BEGIN

    SELECT MAX(HOKHAU.MAHOKHAU) INTO V_MAHOKHAU FROM HOKHAU;

    INSERT INTO THANHVIENCUAHO(MANHANKHAU, MAHOKHAU, QUANHEVOICHUHO)
    VALUES (NEW.IDCHUHO, V_MAHOKHAU, 'Chủ hộ');

    SELECT HOTEN INTO V_TENCHUHO FROM NHANKHAU WHERE MANHANKHAU = NEW.IDCHUHO;

    UPDATE HOKHAU
    SET TENCHUHO = V_TENCHUHO
    WHERE MAHOKHAU = V_MAHOKHAU;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tf_INSERT_HOKHAU
AFTER INSERT ON HOKHAU
FOR EACH ROW
EXECUTE PROCEDURE INSERT_HOKHAU();

--Trigger before insert hokhau -> check xem chu ho da thuoc ho khau nào chưa

CREATE OR REPLACE FUNCTION bf_INSERT_HOKHAU() RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (SELECT 1 FROM HOKHAU WHERE IDCHUHO = NEW.IDCHUHO) THEN
        --RAISE NOTICE 'MANHANKHAU % already exists in THANHVIENCUAHO table.', NEW.MANHANKHAU;
        RETURN NULL; -- Không thực hiện thêm vào bảng
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_bf_INSERT_HOKHAU
BEFORE INSERT ON HOKHAU
FOR EACH ROW
EXECUTE PROCEDURE bf_INSERT_HOKHAU();


--Trigger xóa tạm trú
CREATE OR REPLACE FUNCTION DELETE_TAMTRU_FUNCTION() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM NHANKHAU
    WHERE MANHANKHAU = OLD.MANHANKHAU;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER DELETE_TAMTRU
AFTER DELETE ON TAMTRU
FOR EACH ROW
EXECUTE PROCEDURE DELETE_TAMTRU_FUNCTION();


-- Trigger cho việc chèn dữ liệu vào bảng NHANKHAU khi Insert tạm vắng (chèn vào ghi chú)
CREATE OR REPLACE FUNCTION INSERT_TAMVANG_TRIGGER()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật trường GHICHU của NHANKHAU thành 'tạm vắng'
    UPDATE NHANKHAU
    SET GHICHU = 'tạm vắng'
    WHERE MANHANKHAU = NEW.MANHANKHAU;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Kích hoạt trigger khi có sự chèn dữ liệu vào bảng TAMVANG
CREATE TRIGGER INSERT_TAMVANG
AFTER INSERT ON TAMVANG
FOR EACH ROW
EXECUTE PROCEDURE INSERT_TAMVANG_TRIGGER();

-- Trigger cho việc chèn dữ liệu vào bảng NHANKHAU khi Insert tạm trú (chèn vào ghi chú)
CREATE OR REPLACE FUNCTION INSERT_TAMTRU_TRIGGER()
RETURNS TRIGGER AS $$
BEGIN
    -- Cập nhật trường GHICHU của NHANKHAU thành 'tạm vắng'
    UPDATE NHANKHAU
    SET GHICHU = 'tạm trú'
    WHERE MANHANKHAU = NEW.MANHANKHAU;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Kích hoạt trigger khi có sự chèn dữ liệu vào bảng TAMVANG
CREATE TRIGGER INSERT_TAMTRU
AFTER INSERT ON TAMTRU
FOR EACH ROW
EXECUTE PROCEDURE INSERT_TAMTRU_TRIGGER();


-- Trigger cho việc xóa dữ liệu khỏi bảng TAMVANG -> Xóa ghichu ở bảng NHANKHAU
CREATE OR REPLACE FUNCTION DELETE_TAMVANG_TRIGGER()
RETURNS TRIGGER AS $$
BEGIN
        UPDATE NHANKHAU
        SET GHICHU = NULL
        WHERE MANHANKHAU = OLD.MANHANKHAU;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER DELETE_TAMVANG
AFTER DELETE ON TAMVANG
FOR EACH ROW
EXECUTE PROCEDURE DELETE_TAMVANG_TRIGGER();


--Trigger khi thêm khai tử -> Thêm vào ghichu của bảng NHANKHAU
CREATE OR REPLACE FUNCTION INSERT_KHAITU_TRIGGER_FUNCTION()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE NHANKHAU
    SET GHICHU = 'qua đời'
    WHERE MANHANKHAU = NEW.MANHANKHAUNGUOICHET;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER INSERT_KHAITU
AFTER INSERT
ON KHAITU
FOR EACH ROW
EXECUTE PROCEDURE INSERT_KHAITU_TRIGGER_FUNCTION();


--Trigger cho việc insert đóng góp vào -> Tính các thuộc tính của đóng góp (tính số thành viên, số tiền cần đóng)
CREATE OR REPLACE FUNCTION INSERT_DONGGOP () RETURNS TRIGGER AS $$
DECLARE
    V_TENCHUHO VARCHAR(300);
    V_DIACHI VARCHAR(300);
    V_SOTHANHVIEN INT;
    V_SOTIENTRENMOTNGUOI BIGINT;
BEGIN
    SELECT SOTIENTRENMOTNGUOI INTO V_SOTIENTRENMOTNGUOI
    FROM LOAIPHI
    WHERE MAKHOANTHU = NEW.MAKHOANTHU;

    SELECT TENCHUHO, DIACHI INTO V_TENCHUHO, V_DIACHI
    FROM HOKHAU
    WHERE MAHOKHAU = NEW.MAHOKHAU;

    SELECT COUNT(MANHANKHAU) INTO V_SOTHANHVIEN
    FROM THANHVIENCUAHO
    WHERE MAHOKHAU = NEW.MAHOKHAU;

    UPDATE DONGGOP
    SET TENCHUHO = V_TENCHUHO,
        DIACHI = V_DIACHI,
        SOTHANHVIEN = V_SOTHANHVIEN,
        SOTIENCANDONG = V_SOTIENTRENMOTNGUOI * V_SOTHANHVIEN
    WHERE MAKHOANTHU = NEW.MAKHOANTHU AND MAHOKHAU = NEW.MAHOKHAU;

    IF NEW.TRANGTHAI THEN
        UPDATE DONGGOP
        SET SOTIENDADONG = NEW.SOTIENCANDONG
        WHERE MAKHOANTHU = NEW.MAKHOANTHU AND MAHOKHAU = NEW.MAHOKHAU;
    ELSE
        UPDATE DONGGOP
        SET SOTIENDADONG = 0
        WHERE MAKHOANTHU = NEW.MAKHOANTHU AND MAHOKHAU = NEW.MAHOKHAU;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER tf_INSERT_DONGGOP
AFTER INSERT
ON DONGGOP
FOR EACH ROW
EXECUTE PROCEDURE INSERT_DONGGOP();



--Function delete nhân khẩu -> Kiểm tra điều kiện có phải là chủ hộ hay không thì mới được xóa
CREATE OR REPLACE FUNCTION DELETE_NHANKHAU(
    V_MANHANKHAU INT,
    OUT OUTPUT INT
)
RETURNS INT AS
$$
BEGIN
    IF (V_MANHANKHAU NOT IN (SELECT IDCHUHO FROM HOKHAU)) THEN
        DELETE FROM TAMTRU WHERE MANHANKHAU = V_MANHANKHAU;
        DELETE FROM TAMVANG WHERE MANHANKHAU = V_MANHANKHAU;
        DELETE FROM KHAITU WHERE MANHANKHAUNGUOICHET = V_MANHANKHAU;
        DELETE FROM THANHVIENCUAHO WHERE MANHANKHAU = V_MANHANKHAU;
        DELETE FROM NHANKHAU WHERE MANHANKHAU = V_MANHANKHAU;
        OUTPUT := 1;
    ELSE
        OUTPUT := 0;
    END IF;
END;
$$
LANGUAGE plpgsql;


--Hàm thêm tạm trú -> Thêm vào tạm trú thì phải thêm vào nhân khẩu
CREATE OR REPLACE FUNCTION INSERT_TAMTRU (
    P_HOTEN VARCHAR(50),
    P_SOCANCUOC VARCHAR(15),
    P_NGAYSINH DATE,
    P_GIOITINH BOOLEAN,
    P_NOISINH VARCHAR(200),
    P_NGUYENQUAN VARCHAR(200),
    P_DANTOC VARCHAR(20),
    P_TONGIAO VARCHAR(20),
    P_QUOCTICH VARCHAR(20),
    P_NOITHUONGTRU VARCHAR(200),
    P_NGHENGHIEP VARCHAR(100),
    P_SODIENTHOAINGUOIDANGKY VARCHAR(15),
    P_TUNGAY DATE,
    P_DENNGAY DATE,
    P_LYDO VARCHAR(300)
) RETURNS VOID AS $$
DECLARE
    V_MANHANKHAU INT;
BEGIN
    INSERT INTO NHANKHAU (
        HOTEN,
        SOCANCUOC,
        NGAYSINH,
        GIOITINH,
        NOISINH,
        NGUYENQUAN,
        DANTOC,
        TONGIAO,
        QUOCTICH,
        NOITHUONGTRU,
        NGHENGHIEP,
        GHICHU
    )
    VALUES (
        P_HOTEN,
        P_SOCANCUOC,
        P_NGAYSINH,
        P_GIOITINH,
        P_NOISINH,
        P_NGUYENQUAN,
        P_DANTOC,
        P_TONGIAO,
        P_QUOCTICH,
        P_NOITHUONGTRU,
        P_NGHENGHIEP,
        'tạm trú'
    )
    RETURNING MANHANKHAU INTO V_MANHANKHAU;

    INSERT INTO TAMTRU (MANHANKHAU, SODIENTHOAINGUOIDANGKY, TUNGAY, DENNGAY, LYDO)
    VALUES (V_MANHANKHAU, P_SODIENTHOAINGUOIDANGKY, P_TUNGAY, P_DENNGAY, P_LYDO);
END;
$$ LANGUAGE plpgsql;


--Hàm thêm dữ liệu vào bảng tạm vắng -> Chỉ đề insert data vào
CREATE OR REPLACE FUNCTION INSERT_TAM_VANG(
    P_MANHANKHAU_PARAM INT,
    P_NOITAMTRU_PARAM VARCHAR(300),
    P_TUNGAY_PARAM DATE,
    P_DENNGAY_PARAM DATE,
    P_LYDO_PARAM VARCHAR(300)
) RETURNS VOID AS $$
BEGIN
    -- Thêm dữ liệu vào bảng TAMVANG
    INSERT INTO TAMVANG(MANHANKHAU, NOITAMTRU, TUNGAY, DENNGAY, LYDO)
    VALUES (P_MANHANKHAU_PARAM, P_NOITAMTRU_PARAM, P_TUNGAY_PARAM, P_DENNGAY_PARAM, P_LYDO_PARAM);

END;
$$ LANGUAGE plpgsql;
