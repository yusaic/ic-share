## フォルダ削除
for($i=500; $i -lt 510; $i++){
$x = "vabb0$i"
rm -r $x
}

## フォルダ作成
for($i=500; $i -lt 510; $i++){
$x = "vabb0$i"
mkdir $x
}

## 資料等移動
for($i=500; $i -lt 510; $i++){
    $x = "vabb0$i"
    cp -R ドキュメント $x  
    cp -R Documents $x
    }    

## ディレクトリの下に説明書きテキストを作る
$dir="\\172.31.242.221\ic-share"
for($i=500; $i -lt 510; $i++){
    $x = "vabb0$i"
    New-Item -Type File "$x\ドキュメント\ドキュメント_2003.txt"
    New-Item -Type File "$x\Documents\document_2016.txt"
}

## ファイルサーバの管理者の権限を削除
for($i=500; $i -lt 510; $i++){
    $x = "vabb0$i"
    echo "ICACLS C:\ic-share\$x /inheritance:d | ICACLS C:\ic-share\$x /remove:g BUILTIN\Administrators"
    ICACLS C:\ic-share\$x /inheritance:d | ICACLS C:\ic-share\$x /remove:g BUILTIN\Users
    ICACLS C:\ic-share\$x /inheritance:d | ICACLS C:\ic-share\$x /remove:g BUILTIN\Administrators
    ICACLS C:\ic-share\$x /inheritance:d | ICACLS C:\ic-share\$x /remove:g FILESERVER\Administrator
    ICACLS C:\ic-share\$x /inheritance:d | ICACLS C:\ic-share\$x /remove:g EVERYONE
    }   
