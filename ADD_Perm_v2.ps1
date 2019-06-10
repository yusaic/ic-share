## ドキュメント →2003
## Documents    →2016


## Listファイルからユーザ名を読み込む
foreach ($user in Get-Content list.txt) {

## 処理中のユーザ名を表示 
Write-Output "Processing $user ...."


## 変数 ##
###################################################################################################################

# $user    = <LISTファイルから取得したユーザ名>                ## 各ユーザ名(Listファイルから取得)
$KATAKANA1 = "<file serverのunc>\ic-share\$user\ドキュメント"  ## 旧2003 Serverのパス
$EIGO1     = "<file serverのunc>\ic-share\$user\Documents"     ## 新2016 Serverのパス
$owner     = 'FILESERVER\Administrator'                        ## 所有者のパス（ドメイン＋ファイルサーバのローカルアドミン）
$domain    = 'OAnoSHINKINCARD'                                 ## 新2016 Serverのドメイン名

###################################################################################################################



## メインコード ##
##############################################################################################

## 1.ドキュメントの所有者をファイルサーバのローカルアドミンに変更
icacls $KATAKANA1 /setowner $owner /T

##所有者確認コマンド
takeown /F $KATAKANA1 /R

## 2.Documentsを削除
Remove-Item $EIGO1 -Force -Recurse

## 3.ドキュメントをDocumentsにRename
Rename-Item $KATAKANA1 $EIGO1

## 4.空フォルダ「ドキュメント」を作成
New-Item $KATAKANA1 -Type directory

## 5.Documentsのショートカット作成
$create_shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut
$TargetPath = "$KATAKANA1"
$Shortcut = "$EIGO1.lnk"
$s = $create_shortcut.invoke("$Shortcut") # Must end in .lnk
$s.TargetPath = "$EIGO1"
$s.IconLocation = "imageres.dll,3" # This is a reference to a folder icon
$s.Description = "My Folder"
$s.Save()
## ショートカットファイルをDocumentsに移動 
Move-Item $Shortcut $TargetPath

## 6.新ドメイン各ユーザの権限をフォルダ内の全ファイルにつける
cmd /C "icacls $dir\$user\* /grant $domain\$user`:F /T"

}
