function [ Eigfuncphase_kicked  ] = eigenfunctionkickedregion_phase( p, Tinit )
    global u Thalfperiod Eigfuncphase eta theta_kick

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
        Eigfuncphase_kicked = angle( exp(1i*eta*Tcrit)* exp(1i*Eigfuncphase(-theta_kick, pcrit)));
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
        Eigfuncphase_kicked = angle( exp(1i*eta*Tcrit)* exp(1i*Eigfuncphase(-theta_kick, pcrit)));
    end
end

