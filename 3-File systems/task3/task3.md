# Продолжаем

## 1. Выведите содержимое fstab. Что хранится в fstab?

Файл `/etc/fstab` описывает постоянные точки монтирования, что монтировать и куда

```
cat /etc/fstab
```

![](1.png)


## 2. Добавьте в виртуальную машину ещё один диск

![](2-1.png)

![](2-2.png)

## 3. Узнайте как ситема видит ваш диск - выведите информацию о блочных устройствах

![](3.png)

Добавленный диск: /dev/vda

## 4. С помощью полученной информации создайте на диске таблицу разделов и фаловую систему ext4

```
parted -s /dev/vda mklabel gpt
parted -s /dev/vda mkpart primary ext4 100MiB 100%
partprobe /dev/vda
mkfs.ext4 -L DATA /dev/vda

lsblk -f /dev/vda /dev/vda1
```

![](4.png)


## 5. Примонитруте диск в каталог /mnt

```
mkdir -p /mnt
mount /dev/vda /mnt

findmnt /mnt
```

![](5.png)

## 6. Зайдите в каталог и создайте там файлы

![](6.png)

## 7. Отмонтируйте диск и проверье остались ли файлы

```
umount /mnt
ls -la /mnt
mount /dev/vda /mnt
ls -lh /mnt
```

![](7.png)

## 8. Сделайте так чтобы диск автоматически подключался при загрузке систем ( добавьте информацию о нём с fstab)

```
UUID=$(blkid -s UUID -o value /dev/vda)
echo "UUID=$UUID /mnt ext4 defaults,nofail 0 2" | tee -a /etc/fstab
```

![](8.png)

## 9. Проверьте корретность записанных в fstab данных перед перезагрузкой

```
umount /mnt 2>/dev/null
mount -av
findmnt /mnt
```

![](9.png)

## 10. Перезагрущите систему и убедитесь что диск был подключён к системе

```
findmnt /mnt
```

![](10.png)
