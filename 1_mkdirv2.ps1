## フォルダ作成
for($i=190; $i -lt 201; $i++){
$x = "vabb0$i"
mkdir $x
}

## 資料等移動
for($i=190; $i -lt 201; $i++){
    $x = "vabb0$i"
    cp -R ドキュメント $x  
    cp -R Documents $x
    }    

## ディレクトリの下に説明書きテキストを作る
$dir="<file serverのunc>"
for($i=190; $i -lt 201; $i++){
    $x = "vabb0$i"
    New-Item -Type File "$dir\$x\ドキュメント\ドキュメント_2003.txt"
    New-Item -Type File "$dir\$x\Documents\document_2016.txt"
}