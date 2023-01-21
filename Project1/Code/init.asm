
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 f8 07 00 00       	push   $0x7f8
  19:	e8 95 03 00 00       	call   3b3 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 cf 00 00 00    	js     f8 <main+0xf8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 b8 03 00 00       	call   3eb <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 ac 03 00 00       	call   3eb <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 00 08 00 00       	push   $0x800
  50:	6a 01                	push   $0x1
  52:	e8 79 04 00 00       	call   4d0 <printf>
    printf(1, "Group #22:\n");
  57:	58                   	pop    %eax
  58:	5a                   	pop    %edx
  59:	68 13 08 00 00       	push   $0x813
  5e:	6a 01                	push   $0x1
  60:	e8 6b 04 00 00       	call   4d0 <printf>
    printf(1, "1. Danial Saeedi\n");
  65:	59                   	pop    %ecx
  66:	5b                   	pop    %ebx
  67:	68 1f 08 00 00       	push   $0x81f
  6c:	6a 01                	push   $0x1
  6e:	e8 5d 04 00 00       	call   4d0 <printf>
    printf(1, "2. Soroosh Sadeghian\n");
  73:	58                   	pop    %eax
  74:	5a                   	pop    %edx
  75:	68 31 08 00 00       	push   $0x831
  7a:	6a 01                	push   $0x1
  7c:	e8 4f 04 00 00       	call   4d0 <printf>
    printf(1, "3. Mohammad GharehHasanloo\n");    
  81:	59                   	pop    %ecx
  82:	5b                   	pop    %ebx
  83:	68 47 08 00 00       	push   $0x847
  88:	6a 01                	push   $0x1
  8a:	e8 41 04 00 00       	call   4d0 <printf>
    pid = fork();
  8f:	e8 d7 02 00 00       	call   36b <fork>
    if(pid < 0){
  94:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  97:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  99:	85 c0                	test   %eax,%eax
  9b:	78 24                	js     c1 <main+0xc1>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  9d:	74 35                	je     d4 <main+0xd4>
  9f:	90                   	nop
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  a0:	e8 d6 02 00 00       	call   37b <wait>
  a5:	85 c0                	test   %eax,%eax
  a7:	78 9f                	js     48 <main+0x48>
  a9:	39 c3                	cmp    %eax,%ebx
  ab:	74 9b                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  ad:	83 ec 08             	sub    $0x8,%esp
  b0:	68 8f 08 00 00       	push   $0x88f
  b5:	6a 01                	push   $0x1
  b7:	e8 14 04 00 00       	call   4d0 <printf>
  bc:	83 c4 10             	add    $0x10,%esp
  bf:	eb df                	jmp    a0 <main+0xa0>
      printf(1, "init: fork failed\n");
  c1:	53                   	push   %ebx
  c2:	53                   	push   %ebx
  c3:	68 63 08 00 00       	push   $0x863
  c8:	6a 01                	push   $0x1
  ca:	e8 01 04 00 00       	call   4d0 <printf>
      exit();
  cf:	e8 9f 02 00 00       	call   373 <exit>
      exec("sh", argv);
  d4:	50                   	push   %eax
  d5:	50                   	push   %eax
  d6:	68 a4 0b 00 00       	push   $0xba4
  db:	68 76 08 00 00       	push   $0x876
  e0:	e8 c6 02 00 00       	call   3ab <exec>
      printf(1, "init: exec sh failed\n");
  e5:	5a                   	pop    %edx
  e6:	59                   	pop    %ecx
  e7:	68 79 08 00 00       	push   $0x879
  ec:	6a 01                	push   $0x1
  ee:	e8 dd 03 00 00       	call   4d0 <printf>
      exit();
  f3:	e8 7b 02 00 00       	call   373 <exit>
    mknod("console", 1, 1);
  f8:	50                   	push   %eax
  f9:	6a 01                	push   $0x1
  fb:	6a 01                	push   $0x1
  fd:	68 f8 07 00 00       	push   $0x7f8
 102:	e8 b4 02 00 00       	call   3bb <mknod>
    open("console", O_RDWR);
 107:	58                   	pop    %eax
 108:	5a                   	pop    %edx
 109:	6a 02                	push   $0x2
 10b:	68 f8 07 00 00       	push   $0x7f8
 110:	e8 9e 02 00 00       	call   3b3 <open>
 115:	83 c4 10             	add    $0x10,%esp
 118:	e9 0c ff ff ff       	jmp    29 <main+0x29>
 11d:	66 90                	xchg   %ax,%ax
 11f:	90                   	nop

00000120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 120:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 121:	31 c0                	xor    %eax,%eax
{
 123:	89 e5                	mov    %esp,%ebp
 125:	53                   	push   %ebx
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 130:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 134:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 137:	83 c0 01             	add    $0x1,%eax
 13a:	84 d2                	test   %dl,%dl
 13c:	75 f2                	jne    130 <strcpy+0x10>
    ;
  return os;
}
 13e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 141:	89 c8                	mov    %ecx,%eax
 143:	c9                   	leave  
 144:	c3                   	ret    
 145:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	8b 55 08             	mov    0x8(%ebp),%edx
 157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 15a:	0f b6 02             	movzbl (%edx),%eax
 15d:	84 c0                	test   %al,%al
 15f:	75 17                	jne    178 <strcmp+0x28>
 161:	eb 3a                	jmp    19d <strcmp+0x4d>
 163:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 167:	90                   	nop
 168:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 16c:	83 c2 01             	add    $0x1,%edx
 16f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 172:	84 c0                	test   %al,%al
 174:	74 1a                	je     190 <strcmp+0x40>
    p++, q++;
 176:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 178:	0f b6 19             	movzbl (%ecx),%ebx
 17b:	38 c3                	cmp    %al,%bl
 17d:	74 e9                	je     168 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 17f:	29 d8                	sub    %ebx,%eax
}
 181:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 184:	c9                   	leave  
 185:	c3                   	ret    
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 190:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 194:	31 c0                	xor    %eax,%eax
 196:	29 d8                	sub    %ebx,%eax
}
 198:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 19b:	c9                   	leave  
 19c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 19d:	0f b6 19             	movzbl (%ecx),%ebx
 1a0:	31 c0                	xor    %eax,%eax
 1a2:	eb db                	jmp    17f <strcmp+0x2f>
 1a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1af:	90                   	nop

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 3a 00             	cmpb   $0x0,(%edx)
 1b9:	74 15                	je     1d0 <strlen+0x20>
 1bb:	31 c0                	xor    %eax,%eax
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c0 01             	add    $0x1,%eax
 1c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1c7:	89 c1                	mov    %eax,%ecx
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	89 c8                	mov    %ecx,%eax
 1cd:	5d                   	pop    %ebp
 1ce:	c3                   	ret    
 1cf:	90                   	nop
  for(n = 0; s[n]; n++)
 1d0:	31 c9                	xor    %ecx,%ecx
}
 1d2:	5d                   	pop    %ebp
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	c3                   	ret    
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	57                   	push   %edi
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1f5:	89 d0                	mov    %edx,%eax
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    
 1f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 12                	jne    223 <strchr+0x23>
 211:	eb 1d                	jmp    230 <strchr+0x30>
 213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 217:	90                   	nop
 218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 21c:	83 c0 01             	add    $0x1,%eax
 21f:	84 d2                	test   %dl,%dl
 221:	74 0d                	je     230 <strchr+0x30>
    if(*s == c)
 223:	38 d1                	cmp    %dl,%cl
 225:	75 f1                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 227:	5d                   	pop    %ebp
 228:	c3                   	ret    
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 230:	31 c0                	xor    %eax,%eax
}
 232:	5d                   	pop    %ebp
 233:	c3                   	ret    
 234:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 245:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 248:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 249:	31 db                	xor    %ebx,%ebx
{
 24b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 24e:	eb 27                	jmp    277 <gets+0x37>
    cc = read(0, &c, 1);
 250:	83 ec 04             	sub    $0x4,%esp
 253:	6a 01                	push   $0x1
 255:	57                   	push   %edi
 256:	6a 00                	push   $0x0
 258:	e8 2e 01 00 00       	call   38b <read>
    if(cc < 1)
 25d:	83 c4 10             	add    $0x10,%esp
 260:	85 c0                	test   %eax,%eax
 262:	7e 1d                	jle    281 <gets+0x41>
      break;
    buf[i++] = c;
 264:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 26f:	3c 0a                	cmp    $0xa,%al
 271:	74 1d                	je     290 <gets+0x50>
 273:	3c 0d                	cmp    $0xd,%al
 275:	74 19                	je     290 <gets+0x50>
  for(i=0; i+1 < max; ){
 277:	89 de                	mov    %ebx,%esi
 279:	83 c3 01             	add    $0x1,%ebx
 27c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 27f:	7c cf                	jl     250 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 281:	8b 45 08             	mov    0x8(%ebp),%eax
 284:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 288:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28b:	5b                   	pop    %ebx
 28c:	5e                   	pop    %esi
 28d:	5f                   	pop    %edi
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    
  buf[i] = '\0';
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	89 de                	mov    %ebx,%esi
 295:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 299:	8d 65 f4             	lea    -0xc(%ebp),%esp
 29c:	5b                   	pop    %ebx
 29d:	5e                   	pop    %esi
 29e:	5f                   	pop    %edi
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2af:	90                   	nop

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b5:	83 ec 08             	sub    $0x8,%esp
 2b8:	6a 00                	push   $0x0
 2ba:	ff 75 08             	push   0x8(%ebp)
 2bd:	e8 f1 00 00 00       	call   3b3 <open>
  if(fd < 0)
 2c2:	83 c4 10             	add    $0x10,%esp
 2c5:	85 c0                	test   %eax,%eax
 2c7:	78 27                	js     2f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	89 c3                	mov    %eax,%ebx
 2d1:	50                   	push   %eax
 2d2:	e8 f4 00 00 00       	call   3cb <fstat>
  close(fd);
 2d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2da:	89 c6                	mov    %eax,%esi
  close(fd);
 2dc:	e8 ba 00 00 00       	call   39b <close>
  return r;
 2e1:	83 c4 10             	add    $0x10,%esp
}
 2e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2e7:	89 f0                	mov    %esi,%eax
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2f5:	eb ed                	jmp    2e4 <stat+0x34>
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	53                   	push   %ebx
 304:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 02             	movsbl (%edx),%eax
 30a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 30d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 310:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 315:	77 1e                	ja     335 <atoi+0x35>
 317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 31e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 320:	83 c2 01             	add    $0x1,%edx
 323:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 326:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 32a:	0f be 02             	movsbl (%edx),%eax
 32d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 330:	80 fb 09             	cmp    $0x9,%bl
 333:	76 eb                	jbe    320 <atoi+0x20>
  return n;
}
 335:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 338:	89 c8                	mov    %ecx,%eax
 33a:	c9                   	leave  
 33b:	c3                   	ret    
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	8b 45 10             	mov    0x10(%ebp),%eax
 347:	8b 55 08             	mov    0x8(%ebp),%edx
 34a:	56                   	push   %esi
 34b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 34e:	85 c0                	test   %eax,%eax
 350:	7e 13                	jle    365 <memmove+0x25>
 352:	01 d0                	add    %edx,%eax
  dst = vdst;
 354:	89 d7                	mov    %edx,%edi
 356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 360:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 361:	39 f8                	cmp    %edi,%eax
 363:	75 fb                	jne    360 <memmove+0x20>
  return vdst;
}
 365:	5e                   	pop    %esi
 366:	89 d0                	mov    %edx,%eax
 368:	5f                   	pop    %edi
 369:	5d                   	pop    %ebp
 36a:	c3                   	ret    

0000036b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36b:	b8 01 00 00 00       	mov    $0x1,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exit>:
SYSCALL(exit)
 373:	b8 02 00 00 00       	mov    $0x2,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <wait>:
SYSCALL(wait)
 37b:	b8 03 00 00 00       	mov    $0x3,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <pipe>:
SYSCALL(pipe)
 383:	b8 04 00 00 00       	mov    $0x4,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <read>:
SYSCALL(read)
 38b:	b8 05 00 00 00       	mov    $0x5,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <write>:
SYSCALL(write)
 393:	b8 10 00 00 00       	mov    $0x10,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <close>:
SYSCALL(close)
 39b:	b8 15 00 00 00       	mov    $0x15,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <kill>:
SYSCALL(kill)
 3a3:	b8 06 00 00 00       	mov    $0x6,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <exec>:
SYSCALL(exec)
 3ab:	b8 07 00 00 00       	mov    $0x7,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <open>:
SYSCALL(open)
 3b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mknod>:
SYSCALL(mknod)
 3bb:	b8 11 00 00 00       	mov    $0x11,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <unlink>:
SYSCALL(unlink)
 3c3:	b8 12 00 00 00       	mov    $0x12,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <fstat>:
SYSCALL(fstat)
 3cb:	b8 08 00 00 00       	mov    $0x8,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <link>:
SYSCALL(link)
 3d3:	b8 13 00 00 00       	mov    $0x13,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mkdir>:
SYSCALL(mkdir)
 3db:	b8 14 00 00 00       	mov    $0x14,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <chdir>:
SYSCALL(chdir)
 3e3:	b8 09 00 00 00       	mov    $0x9,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <dup>:
SYSCALL(dup)
 3eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <getpid>:
SYSCALL(getpid)
 3f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <sbrk>:
SYSCALL(sbrk)
 3fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <sleep>:
SYSCALL(sleep)
 403:	b8 0d 00 00 00       	mov    $0xd,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <uptime>:
SYSCALL(uptime)
 40b:	b8 0e 00 00 00       	mov    $0xe,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    
 413:	66 90                	xchg   %ax,%ax
 415:	66 90                	xchg   %ax,%ax
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 3c             	sub    $0x3c,%esp
 429:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 42c:	89 d1                	mov    %edx,%ecx
{
 42e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 431:	85 d2                	test   %edx,%edx
 433:	0f 89 7f 00 00 00    	jns    4b8 <printint+0x98>
 439:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43d:	74 79                	je     4b8 <printint+0x98>
    neg = 1;
 43f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 446:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 448:	31 db                	xor    %ebx,%ebx
 44a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 450:	89 c8                	mov    %ecx,%eax
 452:	31 d2                	xor    %edx,%edx
 454:	89 cf                	mov    %ecx,%edi
 456:	f7 75 c4             	divl   -0x3c(%ebp)
 459:	0f b6 92 f8 08 00 00 	movzbl 0x8f8(%edx),%edx
 460:	89 45 c0             	mov    %eax,-0x40(%ebp)
 463:	89 d8                	mov    %ebx,%eax
 465:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 468:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 46b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 46e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 471:	76 dd                	jbe    450 <printint+0x30>
  if(neg)
 473:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 476:	85 c9                	test   %ecx,%ecx
 478:	74 0c                	je     486 <printint+0x66>
    buf[i++] = '-';
 47a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 47f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 481:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 486:	8b 7d b8             	mov    -0x48(%ebp),%edi
 489:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 48d:	eb 07                	jmp    496 <printint+0x76>
 48f:	90                   	nop
    putc(fd, buf[i]);
 490:	0f b6 13             	movzbl (%ebx),%edx
 493:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 496:	83 ec 04             	sub    $0x4,%esp
 499:	88 55 d7             	mov    %dl,-0x29(%ebp)
 49c:	6a 01                	push   $0x1
 49e:	56                   	push   %esi
 49f:	57                   	push   %edi
 4a0:	e8 ee fe ff ff       	call   393 <write>
  while(--i >= 0)
 4a5:	83 c4 10             	add    $0x10,%esp
 4a8:	39 de                	cmp    %ebx,%esi
 4aa:	75 e4                	jne    490 <printint+0x70>
}
 4ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4af:	5b                   	pop    %ebx
 4b0:	5e                   	pop    %esi
 4b1:	5f                   	pop    %edi
 4b2:	5d                   	pop    %ebp
 4b3:	c3                   	ret    
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4b8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4bf:	eb 87                	jmp    448 <printint+0x28>
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4cf:	90                   	nop

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 4dc:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 4df:	0f b6 13             	movzbl (%ebx),%edx
 4e2:	84 d2                	test   %dl,%dl
 4e4:	74 6a                	je     550 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 4e6:	8d 45 10             	lea    0x10(%ebp),%eax
 4e9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4ec:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4ef:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 4f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4f4:	eb 36                	jmp    52c <printf+0x5c>
 4f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 503:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 508:	83 f8 25             	cmp    $0x25,%eax
 50b:	74 15                	je     522 <printf+0x52>
  write(fd, &c, 1);
 50d:	83 ec 04             	sub    $0x4,%esp
 510:	88 55 e7             	mov    %dl,-0x19(%ebp)
 513:	6a 01                	push   $0x1
 515:	57                   	push   %edi
 516:	56                   	push   %esi
 517:	e8 77 fe ff ff       	call   393 <write>
 51c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 51f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 522:	0f b6 13             	movzbl (%ebx),%edx
 525:	83 c3 01             	add    $0x1,%ebx
 528:	84 d2                	test   %dl,%dl
 52a:	74 24                	je     550 <printf+0x80>
    c = fmt[i] & 0xff;
 52c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 52f:	85 c9                	test   %ecx,%ecx
 531:	74 cd                	je     500 <printf+0x30>
      }
    } else if(state == '%'){
 533:	83 f9 25             	cmp    $0x25,%ecx
 536:	75 ea                	jne    522 <printf+0x52>
      if(c == 'd'){
 538:	83 f8 25             	cmp    $0x25,%eax
 53b:	0f 84 07 01 00 00    	je     648 <printf+0x178>
 541:	83 e8 63             	sub    $0x63,%eax
 544:	83 f8 15             	cmp    $0x15,%eax
 547:	77 17                	ja     560 <printf+0x90>
 549:	ff 24 85 a0 08 00 00 	jmp    *0x8a0(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 550:	8d 65 f4             	lea    -0xc(%ebp),%esp
 553:	5b                   	pop    %ebx
 554:	5e                   	pop    %esi
 555:	5f                   	pop    %edi
 556:	5d                   	pop    %ebp
 557:	c3                   	ret    
 558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 566:	6a 01                	push   $0x1
 568:	57                   	push   %edi
 569:	56                   	push   %esi
 56a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 56e:	e8 20 fe ff ff       	call   393 <write>
        putc(fd, c);
 573:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 577:	83 c4 0c             	add    $0xc,%esp
 57a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 57d:	6a 01                	push   $0x1
 57f:	57                   	push   %edi
 580:	56                   	push   %esi
 581:	e8 0d fe ff ff       	call   393 <write>
        putc(fd, c);
 586:	83 c4 10             	add    $0x10,%esp
      state = 0;
 589:	31 c9                	xor    %ecx,%ecx
 58b:	eb 95                	jmp    522 <printf+0x52>
 58d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 10 00 00 00       	mov    $0x10,%ecx
 598:	6a 00                	push   $0x0
 59a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 59d:	8b 10                	mov    (%eax),%edx
 59f:	89 f0                	mov    %esi,%eax
 5a1:	e8 7a fe ff ff       	call   420 <printint>
        ap++;
 5a6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5aa:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ad:	31 c9                	xor    %ecx,%ecx
 5af:	e9 6e ff ff ff       	jmp    522 <printf+0x52>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5b8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5bb:	8b 10                	mov    (%eax),%edx
        ap++;
 5bd:	83 c0 04             	add    $0x4,%eax
 5c0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5c3:	85 d2                	test   %edx,%edx
 5c5:	0f 84 8d 00 00 00    	je     658 <printf+0x188>
        while(*s != 0){
 5cb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 5ce:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 5d0:	84 c0                	test   %al,%al
 5d2:	0f 84 4a ff ff ff    	je     522 <printf+0x52>
 5d8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 5db:	89 d3                	mov    %edx,%ebx
 5dd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5e3:	83 c3 01             	add    $0x1,%ebx
 5e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5e9:	6a 01                	push   $0x1
 5eb:	57                   	push   %edi
 5ec:	56                   	push   %esi
 5ed:	e8 a1 fd ff ff       	call   393 <write>
        while(*s != 0){
 5f2:	0f b6 03             	movzbl (%ebx),%eax
 5f5:	83 c4 10             	add    $0x10,%esp
 5f8:	84 c0                	test   %al,%al
 5fa:	75 e4                	jne    5e0 <printf+0x110>
      state = 0;
 5fc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5ff:	31 c9                	xor    %ecx,%ecx
 601:	e9 1c ff ff ff       	jmp    522 <printf+0x52>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 610:	83 ec 0c             	sub    $0xc,%esp
 613:	b9 0a 00 00 00       	mov    $0xa,%ecx
 618:	6a 01                	push   $0x1
 61a:	e9 7b ff ff ff       	jmp    59a <printf+0xca>
 61f:	90                   	nop
        putc(fd, *ap);
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 623:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 626:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 628:	6a 01                	push   $0x1
 62a:	57                   	push   %edi
 62b:	56                   	push   %esi
        putc(fd, *ap);
 62c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 62f:	e8 5f fd ff ff       	call   393 <write>
        ap++;
 634:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 638:	83 c4 10             	add    $0x10,%esp
      state = 0;
 63b:	31 c9                	xor    %ecx,%ecx
 63d:	e9 e0 fe ff ff       	jmp    522 <printf+0x52>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 648:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 64b:	83 ec 04             	sub    $0x4,%esp
 64e:	e9 2a ff ff ff       	jmp    57d <printf+0xad>
 653:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 657:	90                   	nop
          s = "(null)";
 658:	ba 98 08 00 00       	mov    $0x898,%edx
        while(*s != 0){
 65d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 660:	b8 28 00 00 00       	mov    $0x28,%eax
 665:	89 d3                	mov    %edx,%ebx
 667:	e9 74 ff ff ff       	jmp    5e0 <printf+0x110>
 66c:	66 90                	xchg   %ax,%ax
 66e:	66 90                	xchg   %ax,%ax

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	a1 ac 0b 00 00       	mov    0xbac,%eax
{
 676:	89 e5                	mov    %esp,%ebp
 678:	57                   	push   %edi
 679:	56                   	push   %esi
 67a:	53                   	push   %ebx
 67b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 67e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 688:	89 c2                	mov    %eax,%edx
 68a:	8b 00                	mov    (%eax),%eax
 68c:	39 ca                	cmp    %ecx,%edx
 68e:	73 30                	jae    6c0 <free+0x50>
 690:	39 c1                	cmp    %eax,%ecx
 692:	72 04                	jb     698 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 694:	39 c2                	cmp    %eax,%edx
 696:	72 f0                	jb     688 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 698:	8b 73 fc             	mov    -0x4(%ebx),%esi
 69b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69e:	39 f8                	cmp    %edi,%eax
 6a0:	74 30                	je     6d2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6a5:	8b 42 04             	mov    0x4(%edx),%eax
 6a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6ab:	39 f1                	cmp    %esi,%ecx
 6ad:	74 3a                	je     6e9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6b1:	5b                   	pop    %ebx
  freep = p;
 6b2:	89 15 ac 0b 00 00    	mov    %edx,0xbac
}
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret    
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 c2                	cmp    %eax,%edx
 6c2:	72 c4                	jb     688 <free+0x18>
 6c4:	39 c1                	cmp    %eax,%ecx
 6c6:	73 c0                	jae    688 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 f8                	cmp    %edi,%eax
 6d0:	75 d0                	jne    6a2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 6d2:	03 70 04             	add    0x4(%eax),%esi
 6d5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d8:	8b 02                	mov    (%edx),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6df:	8b 42 04             	mov    0x4(%edx),%eax
 6e2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e5:	39 f1                	cmp    %esi,%ecx
 6e7:	75 c6                	jne    6af <free+0x3f>
    p->s.size += bp->s.size;
 6e9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ec:	89 15 ac 0b 00 00    	mov    %edx,0xbac
    p->s.size += bp->s.size;
 6f2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6f5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6f8:	89 0a                	mov    %ecx,(%edx)
}
 6fa:	5b                   	pop    %ebx
 6fb:	5e                   	pop    %esi
 6fc:	5f                   	pop    %edi
 6fd:	5d                   	pop    %ebp
 6fe:	c3                   	ret    
 6ff:	90                   	nop

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 70c:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	8d 70 07             	lea    0x7(%eax),%esi
 715:	c1 ee 03             	shr    $0x3,%esi
 718:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 71b:	85 ff                	test   %edi,%edi
 71d:	0f 84 9d 00 00 00    	je     7c0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 723:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 725:	8b 4a 04             	mov    0x4(%edx),%ecx
 728:	39 f1                	cmp    %esi,%ecx
 72a:	73 6a                	jae    796 <malloc+0x96>
 72c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 731:	39 de                	cmp    %ebx,%esi
 733:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 736:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 73d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 740:	eb 17                	jmp    759 <malloc+0x59>
 742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 748:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 74a:	8b 48 04             	mov    0x4(%eax),%ecx
 74d:	39 f1                	cmp    %esi,%ecx
 74f:	73 4f                	jae    7a0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 751:	8b 3d ac 0b 00 00    	mov    0xbac,%edi
 757:	89 c2                	mov    %eax,%edx
 759:	39 d7                	cmp    %edx,%edi
 75b:	75 eb                	jne    748 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 75d:	83 ec 0c             	sub    $0xc,%esp
 760:	ff 75 e4             	push   -0x1c(%ebp)
 763:	e8 93 fc ff ff       	call   3fb <sbrk>
  if(p == (char*)-1)
 768:	83 c4 10             	add    $0x10,%esp
 76b:	83 f8 ff             	cmp    $0xffffffff,%eax
 76e:	74 1c                	je     78c <malloc+0x8c>
  hp->s.size = nu;
 770:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 773:	83 ec 0c             	sub    $0xc,%esp
 776:	83 c0 08             	add    $0x8,%eax
 779:	50                   	push   %eax
 77a:	e8 f1 fe ff ff       	call   670 <free>
  return freep;
 77f:	8b 15 ac 0b 00 00    	mov    0xbac,%edx
      if((p = morecore(nunits)) == 0)
 785:	83 c4 10             	add    $0x10,%esp
 788:	85 d2                	test   %edx,%edx
 78a:	75 bc                	jne    748 <malloc+0x48>
        return 0;
  }
}
 78c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 78f:	31 c0                	xor    %eax,%eax
}
 791:	5b                   	pop    %ebx
 792:	5e                   	pop    %esi
 793:	5f                   	pop    %edi
 794:	5d                   	pop    %ebp
 795:	c3                   	ret    
    if(p->s.size >= nunits){
 796:	89 d0                	mov    %edx,%eax
 798:	89 fa                	mov    %edi,%edx
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a0:	39 ce                	cmp    %ecx,%esi
 7a2:	74 4c                	je     7f0 <malloc+0xf0>
        p->s.size -= nunits;
 7a4:	29 f1                	sub    %esi,%ecx
 7a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7ac:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 7af:	89 15 ac 0b 00 00    	mov    %edx,0xbac
}
 7b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7b8:	83 c0 08             	add    $0x8,%eax
}
 7bb:	5b                   	pop    %ebx
 7bc:	5e                   	pop    %esi
 7bd:	5f                   	pop    %edi
 7be:	5d                   	pop    %ebp
 7bf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 7c0:	c7 05 ac 0b 00 00 b0 	movl   $0xbb0,0xbac
 7c7:	0b 00 00 
    base.s.size = 0;
 7ca:	bf b0 0b 00 00       	mov    $0xbb0,%edi
    base.s.ptr = freep = prevp = &base;
 7cf:	c7 05 b0 0b 00 00 b0 	movl   $0xbb0,0xbb0
 7d6:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 7db:	c7 05 b4 0b 00 00 00 	movl   $0x0,0xbb4
 7e2:	00 00 00 
    if(p->s.size >= nunits){
 7e5:	e9 42 ff ff ff       	jmp    72c <malloc+0x2c>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7f0:	8b 08                	mov    (%eax),%ecx
 7f2:	89 0a                	mov    %ecx,(%edx)
 7f4:	eb b9                	jmp    7af <malloc+0xaf>
