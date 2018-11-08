#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LEN sizeof(struct Node)

typedef struct Node{
	char FirstName[16];
	char LastName[16];
	char room[16];
	struct Node *NextNode;
}Element;

Element *CreateNode(void);

int main(){
	Element *Head;
	
	char NAME[1000][16];
	int i;
	int M;
		
	int count1=0;
	int flag=0;

	Element *P;
	Head=CreateNode();
	P = Head;
	scanf("%d",&M);
	getchar();
	
	
	for(i=0;i<M;i++){
		gets(NAME[i]);
	}
	
	for(i=0;i<M;i++){
		P=Head;
		while(P!=NULL){
			if(strcmp(P->FirstName,NAME[i])==0){
				count1++;
				flag=1;
			}
			else if (strcmp(P->LastName,NAME[i])==0&&flag!=1){
				count1++;
			}
			flag=0;
			P=P->NextNode;
		}
		if(i==0){
			printf("%d",count1);
		}
		else{
			printf("\n%d",count1);
		}
	
		
		P=Head;
		
		while(P!=NULL){
			if(strcmp(P->FirstName,NAME[i])==0){
				printf("\n%s %s %s",P->LastName,P->FirstName,P->room);
				flag=1;
			}
			else if (strcmp(P->LastName,NAME[i])==0&&flag!=1){
				printf("\n%s %s %s",P->LastName,P->FirstName,P->room);
			}
			flag=0;
			P=P->NextNode;
		}
		count1=0;
	}
}


Element *CreateNode(void){
	Element *Head;
	Element *P1,*P2;
	int n;
	
	int N;
	scanf("%d",&N);
	getchar();
	
	Head=NULL;
	P1=P2=NULL;
	
		for(n=1;n<=N;n++){
			P1=(Element *)malloc(LEN);
			if(P1==NULL){
				printf("Alloc failed!\n");
				return NULL;
			}
			
			gets(P1->FirstName); 
			gets(P1->LastName);
			gets(P1->room);
			
			if(n==1){
				Head=P1;
				P2=P1;
			}
			else{
				P2->NextNode=P1;
				P2=P1;
			}
		}
		P1->NextNode=NULL;

	return (Head);
}

