    %Interfaz del programa
    
    %Solicitud de la variable
    funstr = input('Cuál es su funcion: ','s');
    
    %Pasar cadena a una función
    f = str2func( ['@(x)' funstr ] );
    
    %Solicitud de los límites
    a = input('Valor de a: ');
    
    b = input('Valor de b: ');
    
    %Definición de límites y punto medio del método
    fa=f(a);
    fb=f(b);
    
    c=(a+b)/2;
    
    %Calculo de el márgen de error
    if (f(a)>f(b))
    height = fa-fb;
    else
    height = fb-fa;
    end
    i=0;
    
    %Si los signos son iguales, entonces no hay raíz y el programa termina
    if(f(a)*f(b)<0)
        
        %Encabezado de la tabla
        fprintf('\n\ti\t\ta\t\t\tc\t\t\tb\n\n');
        
        %Si el error es menor a cierta cantidad, o se cumplen un máximo de
        %iteraciones, se acaba el ciclo
        while(height> 0.00001 && i<99)
            
            %iterador
            i=i+1;
            
            %Verifica si los signos de la función evaluada en los valores
            %extremos del intervalo, son iguales. Cambia un extremos, segun
            %el caso.
            if(f(a)*f(c)<0 && f(b)*f(c)>0)
                
               b=c;
               
            elseif(f(a)*f(c)>0 && f(b)*f(c)<0)
                
               a=c;
               
            end
            
            %Vuelve a calcular el punto medio y las imagenes de los nuevos puntos
            c=(a+b)/2;
            fa=f(a);
            fb=f(b);
            
            %recalcula el márgen de error, para verificar si debe salir del
            %ciclo while
            if (f(a)>f(b))
                
                height = fa-fb;
                
            else
                    
                height = fb-fa;
                
            end
            
            %Muestra los valores en cada iteración
            %disp([i',a',c',b']);
            
            fprintf('\t%u \t%.5f \t%.5f \t%.5f \n', i, a, c, b);
            
        end
        
        %Muestra la raíz
        fprintf('\n');
        fprintf('La raiz es: %.5f\n', c);
        
    else
        
        %Si no entra al ciclo, es por una de estas razones
        disp('Hay cero o más de dos raíces en este intervalo');
        
    end
    
