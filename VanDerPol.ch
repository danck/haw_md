#include <math.h>
#include <chplot.h>

// Versuchsparameter
#define H		0.001
#define T_END	31 //0.4

// ---- Funktionsdeklarationen ----
double Abl_V1(double y2){
	return y2;
}

double Abl_V2(double y1){
	return 6*y1 - 6 * Abl_V1(y1) * Abl_V1(y1) * y1 - Abl_V1(y1);
}


int main(){
	int steps = T_END/H;
	array double x[steps];
	
	class CPlot plot;
	int i;
	double h;

	x[0] = 0;

	for (i=0; i<steps; i++){
		x[i+1] = x[i] + H;
	}
	
	// Euler explizit
	array double y1[steps], y2[steps];
	y1[0] = 1;
	y2[0] = 0;
	
	for (i=0; i<steps; i++){
		y1[i+1] = y1[i] + H*Abl_V1(y2[i]);
		y2[i+1] = y2[i] + H*Abl_V2(y1[i]);
		//x[i+1] = x[i] + H;
	}
	
	// RK2
	array double y1_rk[steps], y2_rk[steps];
	double l1, l2, k1, k2;
	y1_rk[0] = 1;
	y2_rk[0] = 0;
	
	for (i=0; i<steps; i++){
		k1 = H*Abl_V1(y2_rk[i]);
		l1 = H*Abl_V2(y1_rk[i]);
		
		k2 = H*Abl_V1(y2_rk[i] + l1/2);
		l2 = H*Abl_V2(y1_rk[i] + k1/2);
		
		y1_rk[i+1] = y1_rk[i] + k2;
		y2_rk[i+1] = y2_rk[i] + l2;
	}
	
	// ---- Funktionen zeichnen ----
	plot.data2D(x,y2);
	plot.data2D(x,y2_rk);
	plot.legend("Euler", 0);
	plot.legend("Ringel-K�tter", 1);
	plot.plotting();
}