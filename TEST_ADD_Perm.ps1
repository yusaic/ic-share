## マイドキュメント →2003
## MyDocuments      →2016


## Listファイルからユーザ名を読み込む
foreach ($user in Get-Content list.txt) {

## 処理中のユーザ名を表示 
Write-Output "Processing $User ...."


## 変数 ##
###################################################################################################################

# $user      = <LISTファイルから取得したユーザ名>     ## 各ユーザ名(Listファイルから取得)
$KATAKANA1 = "<file serverのunc>\$user\ドキュメント"  ## 旧2003 Serverのパス
$EIGO1     = "<file serverのunc>\$user\MyDocuments"   ## 新2016 Serverのパス
$owner     = 'FILESERVER\Administrator'               ## 所有者のパス（ドメイン＋ファイルサーバのローカルアドミン）
$domain    = 'FILESERVER'                             ## 新2016 Serverのドメイン名

###################################################################################################################



## メインコード ##
##############################################################################################

## 1.マイドキュメントの所有者をファイルサーバのローカルアドミンに変更
$x1 = "icacls $KATAKANA1 /setowner $owner /T"
echo "$x1"

##所有者確認コマンド
$x2 = "takeown /F $KATAKANA1 /R"
echo "$x2"

## 2.MyDocumentsを削除
$x3 = "Remove-Item $EIGO1 -Force -Recurse"
echo "$x3"

## 3.マイドキュメントをMyDocumentsにRename
$x4 = "Rename-Item $KATAKANA1 $EIGO1"
echo "$x4"

## 4.空フォルダ「マイドキュメント」を作成
$x5 = "New-Item $KATAKANA1 -Type directory"
echo "$x5"

## 5.MyDocumentsのショートカット作成

#$create_shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut
#$TargetPath = "$KATAKANA1"
#$Shortcut = "$EIGO1.lnk"
#$s = $create_shortcut.invoke("$Shortcut") # Must end in .lnk
#$s.TargetPath = "$EIGO1"
#$s.IconLocation = "imageres.dll,3" # This is a reference to a folder icon
#$s.Description = "My Folder"
#$s.Save()
## ショートカットファイルをMyDocumentsに移動 
#Move-Item $Shortcut $TargetPath

## 6.新ドメイン各ユーザの権限をフォルダ内の全ファイルにつける
$y ="cmd /C `"icacls $EIGO1\* /grant $domain\$user`:F /T`""
echo "$y"
}
