# leggrowm-mini: подготовка установочной флешки

Образ предназначен для Lenovo IdeaPad 3 (81W4) с NVMe `SKHynix_HFM512GDHTNI-87A0B` на 512110190592 байта. Для владельца ноутбука: [установка с готовой флешки](INSTALL.ru.md).

## Сборка

На x86_64 Linux с Nix и включёнными `nix-command flakes` выполните из корня репозитория:

```sh
nix build --no-update-lock-file .#installer-iso --out-link result-installer
ls -lh result-installer/iso/leggrowm-mini-installer.iso
sha256sum result-installer/iso/leggrowm-mini-installer.iso
```

Используйте `flake.lock` из той же ревизии. Сеть нужна машине сборки для получения зависимостей, но не ноутбуку. Образ содержит готовую систему, локальный сценарий Disko и копию конфигурации. Сохраните контрольную сумму для проверки перед записью.

## Запись

1. Возьмите пустую USB-флешку большей ёмкости, чем ISO (рекомендуется 32 ГБ). Запись сотрёт её содержимое.
2. Если переносили ISO на другой компьютер, сравните SHA-256 копии с результатом сборки. В Windows используйте `Get-FileHash .\leggrowm-mini-installer.iso -Algorithm SHA256`.
3. В balenaEtcher выберите ISO через `Flash from file`, затем флешку через `Select target`. Проверьте её размер и имя, нажмите `Flash` и дождитесь проверки записи. Не копируйте ISO на флешку как обычный файл.
4. Извлеките флешку безопасно. Если Windows предложит её отформатировать, откажитесь. Передайте флешку и `INSTALL.ru.md` владельцу.
