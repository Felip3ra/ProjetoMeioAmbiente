void main(){
    int[5] numeros = [7,8,9,10,11,12];
    int soma = 0;
    for(int i = 0; i<= numeros.lenght;i++)
    {
        if(numeros[i] % 3 || numeros[i % 5]){
            soma += numeros[i];
        }
    }
    console.WriteLine(soma);
}

