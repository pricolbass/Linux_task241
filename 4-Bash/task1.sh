#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Начало скрипта: Работа с файлами"
workdir="$HOME/smt"
mkdir -p "$workdir"

echo "1) Переместиться между директориями"
cd "$HOME"; pwd
cd /usr; pwd
cd "$HOME"; pwd
echo

echo "2) Вывести список файлов в директории"
ls -l "$HOME" || true
echo

echo "3) Вывести список Всех файлов в директории"
ls -la "$HOME" || true
echo

echo "4) Создать папку с подпапками"
mkdir -p "$workdir"/{in,out,temp}
ls -R "$workdir" || true
echo

echo "5) Внутри папки создать файлик и записать в него что-нибудь"
cat > "$workdir/in/data.txt" << 'EOF'
Apple
Banana
cherry
EOF
echo "Содержимое файла"
cat "$workdir/in/data.txt"
echo

echo "6) Переместить файл из одной директории в другую"
mv "$workdir/in/data.txt" "$workdir/temp/"
ls -l "$workdir/in" || true
ls -l "$workdir/temp"
echo

echo "7) Cкопировать файл из одной директории в другую"
cp "$workdir/temp/data.txt" "$workdir/out/data_copy.txt"
ls -l "$workdir/out"
cat "$workdir/out/data_copy.txt"
echo

echo "8) Переименовать файл"
mv "$workdir/out/data_copy.txt" "$workdir/out/do_not_delete.txt"
ls -l "$workdir/out"
echo

echo "9) Сравнить содержимое файлов"
echo "Изменений показать не должно"
diff -u "$workdir/temp/data.txt" "$workdir/out/do_not_delete.txt" || true
echo "А теперь изменим один из файлов и сравним снова"
echo "Orange" >> "$workdir/temp/data.txt"
diff -u "$workdir/temp/data.txt" "$workdir/out/do_not_delete.txt" || true
echo

echo "10) отсортировать содержимоей файла по возрастанию и убыванию"
echo "Отсортировано:"
LC_ALL=C sort "$workdir/temp/data.txt"
echo "Отсортировано (в обратном порядке):"
LC_ALL=C sort -r "$workdir/temp/data.txt"
echo

echo "11) Удаляем все папки и файлы:"
rm -rf "$workdir"
if [ ! -e "$workdir" ]; then
echo "$workdir удалился успешно!"
else
echo "ОШИБКА! $workdir не был удал\н" >&2
exit 1
fi

echo "Конец скрипта: Работа с файлами"