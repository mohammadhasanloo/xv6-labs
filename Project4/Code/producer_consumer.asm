
_producer_consumer:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 0c             	sub    $0xc,%esp
  sem_init(MUTEX, 1);
  15:	6a 01                	push   $0x1
  17:	6a 02                	push   $0x2
  19:	e8 7d 04 00 00       	call   49b <sem_init>
  sem_init(FULL, BUFF_SIZE);
  1e:	58                   	pop    %eax
  1f:	5a                   	pop    %edx
  20:	6a 05                	push   $0x5
  22:	6a 01                	push   $0x1
  24:	e8 72 04 00 00       	call   49b <sem_init>
  sem_init(EMPTY, BUFF_SIZE);
  29:	59                   	pop    %ecx
  2a:	58                   	pop    %eax
  2b:	6a 05                	push   $0x5
  2d:	6a 00                	push   $0x0
  2f:	e8 67 04 00 00       	call   49b <sem_init>

  if (fork() == 0) producer();
  34:	e8 a2 03 00 00       	call   3db <fork>
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	75 0f                	jne    4f <main+0x4f>
  40:	e8 1b 00 00 00       	call   60 <producer>
  else consumer();

  wait();
  45:	e8 a1 03 00 00       	call   3eb <wait>

  exit();
  4a:	e8 94 03 00 00       	call   3e3 <exit>
  else consumer();
  4f:	e8 9c 00 00 00       	call   f0 <consumer>
  54:	eb ef                	jmp    45 <main+0x45>
  56:	66 90                	xchg   %ax,%ax
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <producer>:
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	56                   	push   %esi
    printf(1, "Producer writes %d in %d\n", i, w_index % BUFF_SIZE);
  68:	be 67 66 66 66       	mov    $0x66666667,%esi
{
  6d:	53                   	push   %ebx
  for(int i = 1; i<ITER_NUM + 1; i++) {
  6e:	bb 01 00 00 00       	mov    $0x1,%ebx
  73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  77:	90                   	nop
    sem_acquire(EMPTY);
  78:	83 ec 0c             	sub    $0xc,%esp
  7b:	6a 00                	push   $0x0
  7d:	e8 09 04 00 00       	call   48b <sem_acquire>
    sem_acquire(MUTEX);
  82:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  89:	e8 fd 03 00 00       	call   48b <sem_acquire>
    printf(1, "Producer writes %d in %d\n", i, w_index % BUFF_SIZE);
  8e:	8b 0d 08 0c 00 00    	mov    0xc08,%ecx
  94:	89 c8                	mov    %ecx,%eax
  96:	f7 ee                	imul   %esi
  98:	89 c8                	mov    %ecx,%eax
  9a:	c1 f8 1f             	sar    $0x1f,%eax
  9d:	d1 fa                	sar    %edx
  9f:	29 c2                	sub    %eax,%edx
  a1:	8d 04 92             	lea    (%edx,%edx,4),%eax
  a4:	29 c1                	sub    %eax,%ecx
  a6:	51                   	push   %ecx
  a7:	53                   	push   %ebx
  for(int i = 1; i<ITER_NUM + 1; i++) {
  a8:	83 c3 01             	add    $0x1,%ebx
    printf(1, "Producer writes %d in %d\n", i, w_index % BUFF_SIZE);
  ab:	68 c8 08 00 00       	push   $0x8c8
  b0:	6a 01                	push   $0x1
  b2:	e8 a9 04 00 00       	call   560 <printf>
    sem_release(MUTEX);
  b7:	83 c4 14             	add    $0x14,%esp
  ba:	6a 02                	push   $0x2
  bc:	e8 d2 03 00 00       	call   493 <sem_release>
    sem_release(FULL);
  c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c8:	e8 c6 03 00 00       	call   493 <sem_release>
    w_index++;
  cd:	83 05 08 0c 00 00 01 	addl   $0x1,0xc08
  for(int i = 1; i<ITER_NUM + 1; i++) {
  d4:	83 c4 10             	add    $0x10,%esp
  d7:	83 fb 15             	cmp    $0x15,%ebx
  da:	75 9c                	jne    78 <producer+0x18>
}
  dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  df:	5b                   	pop    %ebx
  e0:	5e                   	pop    %esi
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <consumer>:
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	56                   	push   %esi
    printf(1, "Consumer writes %d in %d\n", i, r_index % BUFF_SIZE);
  f8:	be 67 66 66 66       	mov    $0x66666667,%esi
{
  fd:	53                   	push   %ebx
  for(int i = 1; i<ITER_NUM + 1; i++) {
  fe:	bb 01 00 00 00       	mov    $0x1,%ebx
 103:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 107:	90                   	nop
    sem_acquire(FULL);
 108:	83 ec 0c             	sub    $0xc,%esp
 10b:	6a 01                	push   $0x1
 10d:	e8 79 03 00 00       	call   48b <sem_acquire>
    sem_acquire(MUTEX);
 112:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 119:	e8 6d 03 00 00       	call   48b <sem_acquire>
    printf(1, "Consumer writes %d in %d\n", i, r_index % BUFF_SIZE);
 11e:	8b 0d 04 0c 00 00    	mov    0xc04,%ecx
 124:	89 c8                	mov    %ecx,%eax
 126:	f7 ee                	imul   %esi
 128:	89 c8                	mov    %ecx,%eax
 12a:	c1 f8 1f             	sar    $0x1f,%eax
 12d:	d1 fa                	sar    %edx
 12f:	29 c2                	sub    %eax,%edx
 131:	8d 04 92             	lea    (%edx,%edx,4),%eax
 134:	29 c1                	sub    %eax,%ecx
 136:	51                   	push   %ecx
 137:	53                   	push   %ebx
  for(int i = 1; i<ITER_NUM + 1; i++) {
 138:	83 c3 01             	add    $0x1,%ebx
    printf(1, "Consumer writes %d in %d\n", i, r_index % BUFF_SIZE);
 13b:	68 e2 08 00 00       	push   $0x8e2
 140:	6a 01                	push   $0x1
 142:	e8 19 04 00 00       	call   560 <printf>
    sem_release(MUTEX);
 147:	83 c4 14             	add    $0x14,%esp
 14a:	6a 02                	push   $0x2
 14c:	e8 42 03 00 00       	call   493 <sem_release>
    sem_release(EMPTY);
 151:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 158:	e8 36 03 00 00       	call   493 <sem_release>
    r_index++;
 15d:	83 05 04 0c 00 00 01 	addl   $0x1,0xc04
  for(int i = 1; i<ITER_NUM + 1; i++) {
 164:	83 c4 10             	add    $0x10,%esp
 167:	83 fb 15             	cmp    $0x15,%ebx
 16a:	75 9c                	jne    108 <consumer+0x18>
}
 16c:	8d 65 f8             	lea    -0x8(%ebp),%esp
 16f:	5b                   	pop    %ebx
 170:	5e                   	pop    %esi
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	66 90                	xchg   %ax,%ax
 175:	66 90                	xchg   %ax,%ax
 177:	66 90                	xchg   %ax,%ax
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 185:	31 c0                	xor    %eax,%eax
{
 187:	89 e5                	mov    %esp,%ebp
 189:	53                   	push   %ebx
 18a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 18d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	89 c8                	mov    %ecx,%eax
 1a0:	5b                   	pop    %ebx
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	53                   	push   %ebx
 1b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1be:	0f b6 01             	movzbl (%ecx),%eax
 1c1:	0f b6 1a             	movzbl (%edx),%ebx
 1c4:	84 c0                	test   %al,%al
 1c6:	75 19                	jne    1e1 <strcmp+0x31>
 1c8:	eb 26                	jmp    1f0 <strcmp+0x40>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1d4:	83 c1 01             	add    $0x1,%ecx
 1d7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1da:	0f b6 1a             	movzbl (%edx),%ebx
 1dd:	84 c0                	test   %al,%al
 1df:	74 0f                	je     1f0 <strcmp+0x40>
 1e1:	38 d8                	cmp    %bl,%al
 1e3:	74 eb                	je     1d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1e5:	29 d8                	sub    %ebx,%eax
}
 1e7:	5b                   	pop    %ebx
 1e8:	5d                   	pop    %ebp
 1e9:	c3                   	ret    
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	f3 0f 1e fb          	endbr32 
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 20a:	80 3a 00             	cmpb   $0x0,(%edx)
 20d:	74 21                	je     230 <strlen+0x30>
 20f:	31 c0                	xor    %eax,%eax
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 218:	83 c0 01             	add    $0x1,%eax
 21b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 21f:	89 c1                	mov    %eax,%ecx
 221:	75 f5                	jne    218 <strlen+0x18>
    ;
  return n;
}
 223:	89 c8                	mov    %ecx,%eax
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret    
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	f3 0f 1e fb          	endbr32 
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	57                   	push   %edi
 248:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 24b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24e:	8b 45 0c             	mov    0xc(%ebp),%eax
 251:	89 d7                	mov    %edx,%edi
 253:	fc                   	cld    
 254:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 256:	89 d0                	mov    %edx,%eax
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	8b 45 08             	mov    0x8(%ebp),%eax
 26a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26e:	0f b6 10             	movzbl (%eax),%edx
 271:	84 d2                	test   %dl,%dl
 273:	75 16                	jne    28b <strchr+0x2b>
 275:	eb 21                	jmp    298 <strchr+0x38>
 277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 27e:	66 90                	xchg   %ax,%ax
 280:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 284:	83 c0 01             	add    $0x1,%eax
 287:	84 d2                	test   %dl,%dl
 289:	74 0d                	je     298 <strchr+0x38>
    if(*s == c)
 28b:	38 d1                	cmp    %dl,%cl
 28d:	75 f1                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
}
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
 291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 298:	31 c0                	xor    %eax,%eax
}
 29a:	5d                   	pop    %ebp
 29b:	c3                   	ret    
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	f3 0f 1e fb          	endbr32 
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	57                   	push   %edi
 2a8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a9:	31 f6                	xor    %esi,%esi
{
 2ab:	53                   	push   %ebx
 2ac:	89 f3                	mov    %esi,%ebx
 2ae:	83 ec 1c             	sub    $0x1c,%esp
 2b1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2b4:	eb 33                	jmp    2e9 <gets+0x49>
 2b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2c6:	6a 01                	push   $0x1
 2c8:	50                   	push   %eax
 2c9:	6a 00                	push   $0x0
 2cb:	e8 2b 01 00 00       	call   3fb <read>
    if(cc < 1)
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	85 c0                	test   %eax,%eax
 2d5:	7e 1c                	jle    2f3 <gets+0x53>
      break;
    buf[i++] = c;
 2d7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2db:	83 c7 01             	add    $0x1,%edi
 2de:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2e1:	3c 0a                	cmp    $0xa,%al
 2e3:	74 23                	je     308 <gets+0x68>
 2e5:	3c 0d                	cmp    $0xd,%al
 2e7:	74 1f                	je     308 <gets+0x68>
  for(i=0; i+1 < max; ){
 2e9:	83 c3 01             	add    $0x1,%ebx
 2ec:	89 fe                	mov    %edi,%esi
 2ee:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2f1:	7c cd                	jl     2c0 <gets+0x20>
 2f3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2f8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2fe:	5b                   	pop    %ebx
 2ff:	5e                   	pop    %esi
 300:	5f                   	pop    %edi
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 307:	90                   	nop
 308:	8b 75 08             	mov    0x8(%ebp),%esi
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	01 de                	add    %ebx,%esi
 310:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 312:	c6 03 00             	movb   $0x0,(%ebx)
}
 315:	8d 65 f4             	lea    -0xc(%ebp),%esp
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	5f                   	pop    %edi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
 31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <stat>:

int
stat(const char *n, struct stat *st)
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	56                   	push   %esi
 328:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	6a 00                	push   $0x0
 32e:	ff 75 08             	pushl  0x8(%ebp)
 331:	e8 ed 00 00 00       	call   423 <open>
  if(fd < 0)
 336:	83 c4 10             	add    $0x10,%esp
 339:	85 c0                	test   %eax,%eax
 33b:	78 2b                	js     368 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 33d:	83 ec 08             	sub    $0x8,%esp
 340:	ff 75 0c             	pushl  0xc(%ebp)
 343:	89 c3                	mov    %eax,%ebx
 345:	50                   	push   %eax
 346:	e8 f0 00 00 00       	call   43b <fstat>
  close(fd);
 34b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 34e:	89 c6                	mov    %eax,%esi
  close(fd);
 350:	e8 b6 00 00 00       	call   40b <close>
  return r;
 355:	83 c4 10             	add    $0x10,%esp
}
 358:	8d 65 f8             	lea    -0x8(%ebp),%esp
 35b:	89 f0                	mov    %esi,%eax
 35d:	5b                   	pop    %ebx
 35e:	5e                   	pop    %esi
 35f:	5d                   	pop    %ebp
 360:	c3                   	ret    
 361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 368:	be ff ff ff ff       	mov    $0xffffffff,%esi
 36d:	eb e9                	jmp    358 <stat+0x38>
 36f:	90                   	nop

00000370 <atoi>:

int
atoi(const char *s)
{
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	53                   	push   %ebx
 378:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 37b:	0f be 02             	movsbl (%edx),%eax
 37e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 381:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 384:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 389:	77 1a                	ja     3a5 <atoi+0x35>
 38b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 38f:	90                   	nop
    n = n*10 + *s++ - '0';
 390:	83 c2 01             	add    $0x1,%edx
 393:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 396:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 39a:	0f be 02             	movsbl (%edx),%eax
 39d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3a0:	80 fb 09             	cmp    $0x9,%bl
 3a3:	76 eb                	jbe    390 <atoi+0x20>
  return n;
}
 3a5:	89 c8                	mov    %ecx,%eax
 3a7:	5b                   	pop    %ebx
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    
 3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	f3 0f 1e fb          	endbr32 
 3b4:	55                   	push   %ebp
 3b5:	89 e5                	mov    %esp,%ebp
 3b7:	57                   	push   %edi
 3b8:	8b 45 10             	mov    0x10(%ebp),%eax
 3bb:	8b 55 08             	mov    0x8(%ebp),%edx
 3be:	56                   	push   %esi
 3bf:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3c2:	85 c0                	test   %eax,%eax
 3c4:	7e 0f                	jle    3d5 <memmove+0x25>
 3c6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3c8:	89 d7                	mov    %edx,%edi
 3ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3d1:	39 f8                	cmp    %edi,%eax
 3d3:	75 fb                	jne    3d0 <memmove+0x20>
  return vdst;
}
 3d5:	5e                   	pop    %esi
 3d6:	89 d0                	mov    %edx,%eax
 3d8:	5f                   	pop    %edi
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3db:	b8 01 00 00 00       	mov    $0x1,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <exit>:
SYSCALL(exit)
 3e3:	b8 02 00 00 00       	mov    $0x2,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <wait>:
SYSCALL(wait)
 3eb:	b8 03 00 00 00       	mov    $0x3,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <pipe>:
SYSCALL(pipe)
 3f3:	b8 04 00 00 00       	mov    $0x4,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <read>:
SYSCALL(read)
 3fb:	b8 05 00 00 00       	mov    $0x5,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <write>:
SYSCALL(write)
 403:	b8 10 00 00 00       	mov    $0x10,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <close>:
SYSCALL(close)
 40b:	b8 15 00 00 00       	mov    $0x15,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <kill>:
SYSCALL(kill)
 413:	b8 06 00 00 00       	mov    $0x6,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <exec>:
SYSCALL(exec)
 41b:	b8 07 00 00 00       	mov    $0x7,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <open>:
SYSCALL(open)
 423:	b8 0f 00 00 00       	mov    $0xf,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <mknod>:
SYSCALL(mknod)
 42b:	b8 11 00 00 00       	mov    $0x11,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <unlink>:
SYSCALL(unlink)
 433:	b8 12 00 00 00       	mov    $0x12,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <fstat>:
SYSCALL(fstat)
 43b:	b8 08 00 00 00       	mov    $0x8,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <link>:
SYSCALL(link)
 443:	b8 13 00 00 00       	mov    $0x13,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <mkdir>:
SYSCALL(mkdir)
 44b:	b8 14 00 00 00       	mov    $0x14,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <chdir>:
SYSCALL(chdir)
 453:	b8 09 00 00 00       	mov    $0x9,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <dup>:
SYSCALL(dup)
 45b:	b8 0a 00 00 00       	mov    $0xa,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <getpid>:
SYSCALL(getpid)
 463:	b8 0b 00 00 00       	mov    $0xb,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <sbrk>:
SYSCALL(sbrk)
 46b:	b8 0c 00 00 00       	mov    $0xc,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <sleep>:
SYSCALL(sleep)
 473:	b8 0d 00 00 00       	mov    $0xd,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <uptime>:
SYSCALL(uptime)
 47b:	b8 0e 00 00 00       	mov    $0xe,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <reentrant_mutex>:
SYSCALL(reentrant_mutex)
 483:	b8 16 00 00 00       	mov    $0x16,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <sem_acquire>:
SYSCALL(sem_acquire)
 48b:	b8 17 00 00 00       	mov    $0x17,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <sem_release>:
SYSCALL(sem_release)
 493:	b8 18 00 00 00       	mov    $0x18,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <sem_init>:
 49b:	b8 19 00 00 00       	mov    $0x19,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    
 4a3:	66 90                	xchg   %ax,%ax
 4a5:	66 90                	xchg   %ax,%ax
 4a7:	66 90                	xchg   %ax,%ax
 4a9:	66 90                	xchg   %ax,%ax
 4ab:	66 90                	xchg   %ax,%ax
 4ad:	66 90                	xchg   %ax,%ax
 4af:	90                   	nop

000004b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 3c             	sub    $0x3c,%esp
 4b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4bc:	89 d1                	mov    %edx,%ecx
{
 4be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4c1:	85 d2                	test   %edx,%edx
 4c3:	0f 89 7f 00 00 00    	jns    548 <printint+0x98>
 4c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4cd:	74 79                	je     548 <printint+0x98>
    neg = 1;
 4cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4d8:	31 db                	xor    %ebx,%ebx
 4da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4e0:	89 c8                	mov    %ecx,%eax
 4e2:	31 d2                	xor    %edx,%edx
 4e4:	89 cf                	mov    %ecx,%edi
 4e6:	f7 75 c4             	divl   -0x3c(%ebp)
 4e9:	0f b6 92 04 09 00 00 	movzbl 0x904(%edx),%edx
 4f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4f3:	89 d8                	mov    %ebx,%eax
 4f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 501:	76 dd                	jbe    4e0 <printint+0x30>
  if(neg)
 503:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 506:	85 c9                	test   %ecx,%ecx
 508:	74 0c                	je     516 <printint+0x66>
    buf[i++] = '-';
 50a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 50f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 511:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 516:	8b 7d b8             	mov    -0x48(%ebp),%edi
 519:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 51d:	eb 07                	jmp    526 <printint+0x76>
 51f:	90                   	nop
 520:	0f b6 13             	movzbl (%ebx),%edx
 523:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 526:	83 ec 04             	sub    $0x4,%esp
 529:	88 55 d7             	mov    %dl,-0x29(%ebp)
 52c:	6a 01                	push   $0x1
 52e:	56                   	push   %esi
 52f:	57                   	push   %edi
 530:	e8 ce fe ff ff       	call   403 <write>
  while(--i >= 0)
 535:	83 c4 10             	add    $0x10,%esp
 538:	39 de                	cmp    %ebx,%esi
 53a:	75 e4                	jne    520 <printint+0x70>
    putc(fd, buf[i]);
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 548:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 54f:	eb 87                	jmp    4d8 <printint+0x28>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop

00000560 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	f3 0f 1e fb          	endbr32 
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56d:	8b 75 0c             	mov    0xc(%ebp),%esi
 570:	0f b6 1e             	movzbl (%esi),%ebx
 573:	84 db                	test   %bl,%bl
 575:	0f 84 b4 00 00 00    	je     62f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 57b:	8d 45 10             	lea    0x10(%ebp),%eax
 57e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 581:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 584:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 586:	89 45 d0             	mov    %eax,-0x30(%ebp)
 589:	eb 33                	jmp    5be <printf+0x5e>
 58b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 58f:	90                   	nop
 590:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 593:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 598:	83 f8 25             	cmp    $0x25,%eax
 59b:	74 17                	je     5b4 <printf+0x54>
  write(fd, &c, 1);
 59d:	83 ec 04             	sub    $0x4,%esp
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5a3:	6a 01                	push   $0x1
 5a5:	57                   	push   %edi
 5a6:	ff 75 08             	pushl  0x8(%ebp)
 5a9:	e8 55 fe ff ff       	call   403 <write>
 5ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5b4:	0f b6 1e             	movzbl (%esi),%ebx
 5b7:	83 c6 01             	add    $0x1,%esi
 5ba:	84 db                	test   %bl,%bl
 5bc:	74 71                	je     62f <printf+0xcf>
    c = fmt[i] & 0xff;
 5be:	0f be cb             	movsbl %bl,%ecx
 5c1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5c4:	85 d2                	test   %edx,%edx
 5c6:	74 c8                	je     590 <printf+0x30>
      }
    } else if(state == '%'){
 5c8:	83 fa 25             	cmp    $0x25,%edx
 5cb:	75 e7                	jne    5b4 <printf+0x54>
      if(c == 'd'){
 5cd:	83 f8 64             	cmp    $0x64,%eax
 5d0:	0f 84 9a 00 00 00    	je     670 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5dc:	83 f9 70             	cmp    $0x70,%ecx
 5df:	74 5f                	je     640 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e1:	83 f8 73             	cmp    $0x73,%eax
 5e4:	0f 84 d6 00 00 00    	je     6c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ea:	83 f8 63             	cmp    $0x63,%eax
 5ed:	0f 84 8d 00 00 00    	je     680 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f3:	83 f8 25             	cmp    $0x25,%eax
 5f6:	0f 84 b4 00 00 00    	je     6b0 <printf+0x150>
  write(fd, &c, 1);
 5fc:	83 ec 04             	sub    $0x4,%esp
 5ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 603:	6a 01                	push   $0x1
 605:	57                   	push   %edi
 606:	ff 75 08             	pushl  0x8(%ebp)
 609:	e8 f5 fd ff ff       	call   403 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 60e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 611:	83 c4 0c             	add    $0xc,%esp
 614:	6a 01                	push   $0x1
 616:	83 c6 01             	add    $0x1,%esi
 619:	57                   	push   %edi
 61a:	ff 75 08             	pushl  0x8(%ebp)
 61d:	e8 e1 fd ff ff       	call   403 <write>
  for(i = 0; fmt[i]; i++){
 622:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 626:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 629:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 62b:	84 db                	test   %bl,%bl
 62d:	75 8f                	jne    5be <printf+0x5e>
    }
  }
}
 62f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 632:	5b                   	pop    %ebx
 633:	5e                   	pop    %esi
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 63e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 640:	83 ec 0c             	sub    $0xc,%esp
 643:	b9 10 00 00 00       	mov    $0x10,%ecx
 648:	6a 00                	push   $0x0
 64a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 64d:	8b 45 08             	mov    0x8(%ebp),%eax
 650:	8b 13                	mov    (%ebx),%edx
 652:	e8 59 fe ff ff       	call   4b0 <printint>
        ap++;
 657:	89 d8                	mov    %ebx,%eax
 659:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65c:	31 d2                	xor    %edx,%edx
        ap++;
 65e:	83 c0 04             	add    $0x4,%eax
 661:	89 45 d0             	mov    %eax,-0x30(%ebp)
 664:	e9 4b ff ff ff       	jmp    5b4 <printf+0x54>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 670:	83 ec 0c             	sub    $0xc,%esp
 673:	b9 0a 00 00 00       	mov    $0xa,%ecx
 678:	6a 01                	push   $0x1
 67a:	eb ce                	jmp    64a <printf+0xea>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 683:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 686:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 688:	6a 01                	push   $0x1
        ap++;
 68a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 68d:	57                   	push   %edi
 68e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 691:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 694:	e8 6a fd ff ff       	call   403 <write>
        ap++;
 699:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 69c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 69f:	31 d2                	xor    %edx,%edx
 6a1:	e9 0e ff ff ff       	jmp    5b4 <printf+0x54>
 6a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6b3:	83 ec 04             	sub    $0x4,%esp
 6b6:	e9 59 ff ff ff       	jmp    614 <printf+0xb4>
 6bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6bf:	90                   	nop
        s = (char*)*ap;
 6c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6cb:	85 db                	test   %ebx,%ebx
 6cd:	74 17                	je     6e6 <printf+0x186>
        while(*s != 0){
 6cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6d4:	84 c0                	test   %al,%al
 6d6:	0f 84 d8 fe ff ff    	je     5b4 <printf+0x54>
 6dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6df:	89 de                	mov    %ebx,%esi
 6e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e4:	eb 1a                	jmp    700 <printf+0x1a0>
          s = "(null)";
 6e6:	bb fc 08 00 00       	mov    $0x8fc,%ebx
        while(*s != 0){
 6eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ee:	b8 28 00 00 00       	mov    $0x28,%eax
 6f3:	89 de                	mov    %ebx,%esi
 6f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
  write(fd, &c, 1);
 700:	83 ec 04             	sub    $0x4,%esp
          s++;
 703:	83 c6 01             	add    $0x1,%esi
 706:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 709:	6a 01                	push   $0x1
 70b:	57                   	push   %edi
 70c:	53                   	push   %ebx
 70d:	e8 f1 fc ff ff       	call   403 <write>
        while(*s != 0){
 712:	0f b6 06             	movzbl (%esi),%eax
 715:	83 c4 10             	add    $0x10,%esp
 718:	84 c0                	test   %al,%al
 71a:	75 e4                	jne    700 <printf+0x1a0>
 71c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 71f:	31 d2                	xor    %edx,%edx
 721:	e9 8e fe ff ff       	jmp    5b4 <printf+0x54>
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	f3 0f 1e fb          	endbr32 
 734:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 735:	a1 0c 0c 00 00       	mov    0xc0c,%eax
{
 73a:	89 e5                	mov    %esp,%ebp
 73c:	57                   	push   %edi
 73d:	56                   	push   %esi
 73e:	53                   	push   %ebx
 73f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 742:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 744:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 747:	39 c8                	cmp    %ecx,%eax
 749:	73 15                	jae    760 <free+0x30>
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop
 750:	39 d1                	cmp    %edx,%ecx
 752:	72 14                	jb     768 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 754:	39 d0                	cmp    %edx,%eax
 756:	73 10                	jae    768 <free+0x38>
{
 758:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 75a:	8b 10                	mov    (%eax),%edx
 75c:	39 c8                	cmp    %ecx,%eax
 75e:	72 f0                	jb     750 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 760:	39 d0                	cmp    %edx,%eax
 762:	72 f4                	jb     758 <free+0x28>
 764:	39 d1                	cmp    %edx,%ecx
 766:	73 f0                	jae    758 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 768:	8b 73 fc             	mov    -0x4(%ebx),%esi
 76b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 76e:	39 fa                	cmp    %edi,%edx
 770:	74 1e                	je     790 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 772:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 775:	8b 50 04             	mov    0x4(%eax),%edx
 778:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 77b:	39 f1                	cmp    %esi,%ecx
 77d:	74 28                	je     7a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 77f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 781:	5b                   	pop    %ebx
  freep = p;
 782:	a3 0c 0c 00 00       	mov    %eax,0xc0c
}
 787:	5e                   	pop    %esi
 788:	5f                   	pop    %edi
 789:	5d                   	pop    %ebp
 78a:	c3                   	ret    
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 790:	03 72 04             	add    0x4(%edx),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 10                	mov    (%eax),%edx
 798:	8b 12                	mov    (%edx),%edx
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 d8                	jne    77f <free+0x4f>
    p->s.size += bp->s.size;
 7a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7aa:	a3 0c 0c 00 00       	mov    %eax,0xc0c
    p->s.size += bp->s.size;
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7b5:	89 10                	mov    %edx,(%eax)
}
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret    
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	f3 0f 1e fb          	endbr32 
 7c4:	55                   	push   %ebp
 7c5:	89 e5                	mov    %esp,%ebp
 7c7:	57                   	push   %edi
 7c8:	56                   	push   %esi
 7c9:	53                   	push   %ebx
 7ca:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7d0:	8b 3d 0c 0c 00 00    	mov    0xc0c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d6:	8d 70 07             	lea    0x7(%eax),%esi
 7d9:	c1 ee 03             	shr    $0x3,%esi
 7dc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7df:	85 ff                	test   %edi,%edi
 7e1:	0f 84 a9 00 00 00    	je     890 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7e9:	8b 48 04             	mov    0x4(%eax),%ecx
 7ec:	39 f1                	cmp    %esi,%ecx
 7ee:	73 6d                	jae    85d <malloc+0x9d>
 7f0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7f6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7fb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7fe:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 805:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 808:	eb 17                	jmp    821 <malloc+0x61>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 812:	8b 4a 04             	mov    0x4(%edx),%ecx
 815:	39 f1                	cmp    %esi,%ecx
 817:	73 4f                	jae    868 <malloc+0xa8>
 819:	8b 3d 0c 0c 00 00    	mov    0xc0c,%edi
 81f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 821:	39 c7                	cmp    %eax,%edi
 823:	75 eb                	jne    810 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 825:	83 ec 0c             	sub    $0xc,%esp
 828:	ff 75 e4             	pushl  -0x1c(%ebp)
 82b:	e8 3b fc ff ff       	call   46b <sbrk>
  if(p == (char*)-1)
 830:	83 c4 10             	add    $0x10,%esp
 833:	83 f8 ff             	cmp    $0xffffffff,%eax
 836:	74 1b                	je     853 <malloc+0x93>
  hp->s.size = nu;
 838:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 83b:	83 ec 0c             	sub    $0xc,%esp
 83e:	83 c0 08             	add    $0x8,%eax
 841:	50                   	push   %eax
 842:	e8 e9 fe ff ff       	call   730 <free>
  return freep;
 847:	a1 0c 0c 00 00       	mov    0xc0c,%eax
      if((p = morecore(nunits)) == 0)
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	85 c0                	test   %eax,%eax
 851:	75 bd                	jne    810 <malloc+0x50>
        return 0;
  }
}
 853:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 856:	31 c0                	xor    %eax,%eax
}
 858:	5b                   	pop    %ebx
 859:	5e                   	pop    %esi
 85a:	5f                   	pop    %edi
 85b:	5d                   	pop    %ebp
 85c:	c3                   	ret    
    if(p->s.size >= nunits){
 85d:	89 c2                	mov    %eax,%edx
 85f:	89 f8                	mov    %edi,%eax
 861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 868:	39 ce                	cmp    %ecx,%esi
 86a:	74 54                	je     8c0 <malloc+0x100>
        p->s.size -= nunits;
 86c:	29 f1                	sub    %esi,%ecx
 86e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 871:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 874:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 877:	a3 0c 0c 00 00       	mov    %eax,0xc0c
}
 87c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 87f:	8d 42 08             	lea    0x8(%edx),%eax
}
 882:	5b                   	pop    %ebx
 883:	5e                   	pop    %esi
 884:	5f                   	pop    %edi
 885:	5d                   	pop    %ebp
 886:	c3                   	ret    
 887:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 890:	c7 05 0c 0c 00 00 10 	movl   $0xc10,0xc0c
 897:	0c 00 00 
    base.s.size = 0;
 89a:	bf 10 0c 00 00       	mov    $0xc10,%edi
    base.s.ptr = freep = prevp = &base;
 89f:	c7 05 10 0c 00 00 10 	movl   $0xc10,0xc10
 8a6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8ab:	c7 05 14 0c 00 00 00 	movl   $0x0,0xc14
 8b2:	00 00 00 
    if(p->s.size >= nunits){
 8b5:	e9 36 ff ff ff       	jmp    7f0 <malloc+0x30>
 8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 0a                	mov    (%edx),%ecx
 8c2:	89 08                	mov    %ecx,(%eax)
 8c4:	eb b1                	jmp    877 <malloc+0xb7>
