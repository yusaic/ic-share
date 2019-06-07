
## マイドキュメント →2003
## MyDocuments      →2016


## 1.マイドキュメントの所有者をファイルサーバのローカルアドミンに変更
icacls 1.txt /setowner BUILTIN\Administrators


## 2.MyDocumentsを削除
Remove-Item <変数>

## 3.マイドキュメントをMyDocumentsにRename
Rename-Item <変数1> <変数2>


## 4.空フォルダ「マイドキュメント」を作成
New-Item <変数1> type directory

## 5.MyDocumentsのショートカット作成
    $create_shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut
    $TargetPath = "<旧ドメインの変数>"
    $Shortcut = "<新ドメインの変数>.lnk"
    $s = $create_shortcut.invoke("$Shortcut") # Must end in .lnk
    $s.TargetPath = "<新ドメインの変数>"
    $s.IconLocation = "imageres.dll,3" # This is a reference to a folder icon
    $s.Description = "My Folder"
    $s.Save()

## 6.新ドメインの権限をフォルダ内の全ファイルにつける
cmd /C "icacls <ユーザ変数> /grant <新ドメインの変数>\<ユーザの変数>`:F"



