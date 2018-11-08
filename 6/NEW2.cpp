#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

	int	H;	//Height
	int	W;	//Width
	int MaxCount=0;	//to store the longest path
	int dirx[4]={0,1,0,-1};	//four direction
	int diry[4]={1,0,-1,0};	//four direction
	int Search(int h,int w,int **array);
	int max(int a,int b);

int main(){
	int **array;
	int i,j;
	int x,y;

//create a 2-dimensional dynamic array
	scanf("%d %d",&H,&W);
	array=(int **)malloc((H)*sizeof(int *));	//1-dimensional
	for(i=0;i<H;i++){
		array[i]=(int *)malloc((W)*sizeof(int));	//2-dimensional
		for(j=0;j<W;j++){
			scanf("%d",&array[i][j]);
			}
		}

//Search
	for(x=0;x<H;x++){
		for(y=0;y<W;y++){
			if(Search(x,y,array)>MaxCount){
				MaxCount=Search(x,y,array);
			}
		}
	}

//Printf Result
	printf("%d",MaxCount);
	
//free array
	for(i=0;i<H;i++){
		free(array[i]);	//free 2-dimensional
	}
	free(array);	//free 1-dimensional
	return 0;
}

//choose the longest path
int Search(int x,int y, int **array){
	int k;
	int count=0;
	for(k=0;k<4;k++){
		if(x+dirx[k]>=0&&x+dirx[k]<W&&y+diry[k]>=0&&y+diry[k]<H&&array[x+dirx[k]][y+diry[k]]<array[x][y]){
		  count=max(count,Search(x+dirx[k],y+diry[k],array));
		}
	}
	return count+1;
}

//compare the bigger int
int max(int a,int b){
	if(a<b) return b;
	else return a;
}




