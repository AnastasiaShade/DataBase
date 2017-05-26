++1)��������� �������� �� � ���� � ������������� �������� � ������� ������

++2)������ ���������� � �������� ��������� ������, ����������� � ������� ��������� �����.
SELECT client.id_client, client.client_name, client.client_tel
FROM client
    LEFT JOIN settling
    	ON settling.id_client = client.id_client
    INNER JOIN room
       	ON room.id_room = settling.id_room
    INNER JOIN hotel
       	ON room.id_hotel = hotel.id_hotel
    INNER JOIN kind
       	ON room.id_kind = kind.id_kind
WHERE 
    kind.kind_name = 'de luxe'
    AND hotel.hotel_name = 'Altay';

++3)���� ������ ��������� ������� ���� �������� �� 30.05.12.

SELECT DISTINCT hotel.hotel_name, room.num
FROM room
    INNER JOIN settling
    	ON settling.id_room = room.id_room
    LEFT JOIN hotel
       	ON room.id_hotel = hotel.id_hotel
WHERE
    room.id_room NOT IN (SELECT settling.id_room FROM settling WHERE settling.date_in < '2012-05-30' AND settling.date_out > '2012-05-30')
    AND (settling.date_in > '2012-05-30'
    OR settling.date_out < '2012-05-30');

++4)���� ���������� ����������� � ��������� ������� �� 25.05.12 �� ������� ������, ��� ���������������� ����� ���� ��������.

SELECT settling.id_room, COUNT(settling.id_client), room.num
FROM settling
    LEFT JOIN room
    	ON settling.id_room = room.id_room
    INNER JOIN hotel
       	ON room.id_hotel = hotel.id_hotel
WHERE
    hotel.hotel_name = 'Vostok'
    AND settling.date_in <= '2012-05-25'
    AND settling.date_out >= '2012-05-25'
GROUP BY settling.id_room
HAVING COUNT(settling.id_client) > 2;

+5)���� ������ ��������� ����������� �������� �� ���� �������� ��������� �������, ��������� � ������ 2012 � ��������� ���� ������. ���� ������� �� ���� ������, 
        ������ � ����� ������� ������� � ���� NULL.

SELECT room.id_room, room.num,
    (CASE 
        WHEN settling.date_in NOT BETWEEN '2012-04-01' AND '2012-04-31' THEN NULL
        ELSE client.client_name
    END) AS client,
    (CASE 
        WHEN settling.date_in NOT BETWEEN '2012-04-01' AND '2012-04-31' THEN NULL
        ELSE settling.date_out
    END) AS date_out
FROM settling
    LEFT JOIN room
    	ON settling.id_room = room.id_room
    INNER JOIN hotel
       	ON room.id_hotel = hotel.id_hotel
    RIGHT JOIN client
       	ON settling.id_client = client.id_client
WHERE
    hotel.hotel_name = 'Cosmos'
    AND settling.date_out BETWEEN '2012-04-01' AND '2012-04-31';

++6)�������� �� 30.05.12 ���� ���������� � ��������� ������ ���� �������� ������ ��������� �����, ������� ���������� 15.05.12, � �������� 28.05.12.
UPDATE settling
    LEFT JOIN room
    	ON settling.id_room = room.id_room
    LEFT JOIN kind
       	ON room.id_kind = kind.id_kind
    LEFT JOIN hotel
       	ON room.id_hotel = hotel.id_hotel
SET settling.date_out = '2012-05-30'
WHERE 
    settling.date_in = '2012-05-15'
    AND settling.date_out = '2012-05-28'
    AND kind.kind_name = 'de luxe'
    AND hotel.hotel_name = 'Sokol';