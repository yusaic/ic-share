
## マイドキュメント →2003
## MyDocuments      →2016

$KATAKANA1 = 'C:\ic-share\Administrator/ドキュメント'
$EIGO1 = 'C:\ic-share\Administrator/MyDocuments'
$user = 'administrator'


## 1.マイドキュメントの所有者をファイルサーバのローカルアドミンに変更
icacls $KATAKANA1 /setowner FILESERVER\Administrator /T

##所有者確認コマンド
takeown /F $KATAKANA1 /R

## 2.MyDocumentsを削除

Remove-Item $EIGO1 -Force -Recurse

## 3.マイドキュメントをMyDocumentsにRename
Rename-Item $KATAKANA1 $EIGO1

## 4.空フォルダ「マイドキュメント」を作成

New-Item $KATAKANA1 -Type directory


## 5.MyDocumentsのショートカット作成

    $create_shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut
    $TargetPath = "$KATAKANA1"
    $Shortcut = "$EIGO1.lnk"
    $s = $create_shortcut.invoke("$Shortcut") # Must end in .lnk
    $s.TargetPath = "$EIGO1"
    $s.IconLocation = "imageres.dll,3" # This is a reference to a folder icon
    $s.Description = "My Folder"
    $s.Save()
    
    Move-Item $Shortcut $TargetPath

## 6.新ドメインの権限をフォルダ内の全ファイルにつける

cmd /C "icacls $EIGO1\* /grant FILESERVER\Administrator`:F /T"

