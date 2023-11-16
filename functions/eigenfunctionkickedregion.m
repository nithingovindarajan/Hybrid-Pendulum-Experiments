function [ Eigfuncnorm_kicked  ] = eigenfunctionkickedregion( p, Tinit )
    global u Thalfperiod Eigfuncmod sigma theta_kick

    if p>=0
        check = p;
        k = 0;
        Tpassed = Tinit;
        while ~isnan(u(check)) && k<1000
            Tpassed = Tpassed + Thalfperiod(check);
            check = u(check);
            k = k+1;
        end
        Tcrit = Tpassed;
        pcrit = check;
        Eigfuncnorm_kicked = exp(-sigma*Tcrit)*Eigfuncmod(-theta_kick, pcrit);
    end
    if p<0
        check = -p;
        k = 0;
        Tpassed = Tinit;
        while ~isnan(u(check)) && k<1000
            Tpassed = Tpassed + Thalfperiod(check);
            check = u(check);
            k = k+1;
        end
        Tcrit = Tpassed;
        pcrit = check;
        Eigfuncnorm_kicked = exp(-sigma*Tcrit)*Eigfuncmod(-theta_kick, pcrit);
    end
end

