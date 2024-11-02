$alphabets = @(
    "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
)

# a,b,c,...のアルファベットを、0,1,2,...のインデックスに変える
# 引数として大文字が渡された時、小文字に変換してインデックスを返す。
function ToIndex {
    param([string]$alphabet)
    
    if ($alphabet -notmatch "^[a-zA-Z]$") {
        throw "Only 1 alphabet character"
    }
    
    return [Array]::IndexOf($alphabets, $alphabet.ToLower())
}
