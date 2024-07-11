#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main (int argc, char *argv[])
{
  setuid (0);

  char buf[BUFSIZ];

  //Patient's Name
  snprintf(buf, sizeof(buf), "dcmodify -nb -m '(0010,0010)=%s' /opt/dcm4chee-2.18.1-mysql/server/default/archive/%s", argv[2], argv[1]);
  system (buf);

  //Patient's ID
  snprintf(buf, sizeof(buf), "dcmodify -nb -m '(0010,0020)=%s' /opt/dcm4chee-2.18.1-mysql/server/default/archive/%s", argv[3], argv[1]);
  system (buf);

  //Patient's Birth Date
  snprintf(buf, sizeof(buf), "dcmodify -nb -m '(0010,0030)=%s' /opt/dcm4chee-2.18.1-mysql/server/default/archive/%s", argv[4], argv[1]);
  system (buf);

  //Patient's Sex
  snprintf(buf, sizeof(buf), "dcmodify -nb -m '(0010,0040)=%s' /opt/dcm4chee-2.18.1-mysql/server/default/archive/%s", argv[5], argv[1]);
  system (buf);


  return 0;
} 
