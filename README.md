# Antlr-playground
Grammar of a simple programming language. [documentation](https://github.com/RezaAbbaszadeh/Antlr-playground/blob/master/docs/Antlr%20Project.pdf)

## Sample

### Input
```
import reza;
import math1234;

{
    class Test:
    <
        ///this line is a comment
        /*
        also
        this
        lines
        */
    
        int ab,bc,cd=3,fg,gh=xy=10+6.12e-1;
        float cd;
        bool ef= is_set = false;
        
        Function foo(float i1,bool is_set)<
            i1 = i2 += not -i3 + 804.32e7 * i4  >> ~(-i5 # i6 & i7);
            is_done = true and is_set;
            
            for(int ab=0 ,cd=no ; ab==0 || (ab<10 && bc+ab>11) ; ab++)<
            
                if(ab != cd || ab == 0)<
                    if(cd >= 20)<
                    cd = ab^i1;
                    >
                    else if(cd ==0) < 
                        cd+=1;
                    >
                >
                
                else if(ab >= cd)< 
                    ab *= 2; 
                >
                
                else<
                    ab = ab>>2;
                >
            >
            
            while( ab < cd)<
            
                no += 1;
            >
            
            switch(ab)<
                case 1.6 + 5.2: output = 1; break;
                case 1.6e-1 : output= dsd; break;
            >
            
        
        >
    >
}
```

### Output
[Parse Tree](https://github.com/RezaAbbaszadeh/Antlr-playground/blob/master/docs/parseTree3(final).png)
