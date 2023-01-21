
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 02                	push   $0x2
  18:	68 78 08 00 00       	push   $0x878
  1d:	e8 b1 03 00 00       	call   3d3 <open>
  22:	83 c4 10             	add    $0x10,%esp
  25:	85 c0                	test   %eax,%eax
  27:	0f 88 db 00 00 00    	js     108 <main+0x108>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  2d:	83 ec 0c             	sub    $0xc,%esp
  30:	6a 00                	push   $0x0
  32:	e8 d4 03 00 00       	call   40b <dup>
  dup(0);  // stderr
  37:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3e:	e8 c8 03 00 00       	call   40b <dup>
  43:	83 c4 10             	add    $0x10,%esp
  46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  4d:	8d 76 00             	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  50:	83 ec 08             	sub    $0x8,%esp
  53:	68 80 08 00 00       	push   $0x880
  58:	6a 01                	push   $0x1
  5a:	e8 b1 04 00 00       	call   510 <printf>
    printf(1, "Group #22:\n");
  5f:	58                   	pop    %eax
  60:	5a                   	pop    %edx
  61:	68 93 08 00 00       	push   $0x893
  66:	6a 01                	push   $0x1
  68:	e8 a3 04 00 00       	call   510 <printf>
    printf(1, "1. Danial Saeedi\n");
  6d:	59                   	pop    %ecx
  6e:	5b                   	pop    %ebx
  6f:	68 9f 08 00 00       	push   $0x89f
  74:	6a 01                	push   $0x1
  76:	e8 95 04 00 00       	call   510 <printf>
    printf(1, "2. Soroosh Sadeghian\n");
  7b:	58                   	pop    %eax
  7c:	5a                   	pop    %edx
  7d:	68 b1 08 00 00       	push   $0x8b1
  82:	6a 01                	push   $0x1
  84:	e8 87 04 00 00       	call   510 <printf>
    printf(1, "3. Mohammad GharehHasanloo\n");    
  89:	59                   	pop    %ecx
  8a:	5b                   	pop    %ebx
  8b:	68 c7 08 00 00       	push   $0x8c7
  90:	6a 01                	push   $0x1
  92:	e8 79 04 00 00       	call   510 <printf>
    pid = fork();
  97:	e8 ef 02 00 00       	call   38b <fork>
    if(pid < 0){
  9c:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  9f:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  a1:	85 c0                	test   %eax,%eax
  a3:	78 2c                	js     d1 <main+0xd1>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  a5:	74 3d                	je     e4 <main+0xe4>
  a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ae:	66 90                	xchg   %ax,%ax
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  b0:	e8 e6 02 00 00       	call   39b <wait>
  b5:	85 c0                	test   %eax,%eax
  b7:	78 97                	js     50 <main+0x50>
  b9:	39 c3                	cmp    %eax,%ebx
  bb:	74 93                	je     50 <main+0x50>
      printf(1, "zombie!\n");
  bd:	83 ec 08             	sub    $0x8,%esp
  c0:	68 0f 09 00 00       	push   $0x90f
  c5:	6a 01                	push   $0x1
  c7:	e8 44 04 00 00       	call   510 <printf>
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	eb df                	jmp    b0 <main+0xb0>
      printf(1, "init: fork failed\n");
  d1:	53                   	push   %ebx
  d2:	53                   	push   %ebx
  d3:	68 e3 08 00 00       	push   $0x8e3
  d8:	6a 01                	push   $0x1
  da:	e8 31 04 00 00       	call   510 <printf>
      exit();
  df:	e8 af 02 00 00       	call   393 <exit>
      exec("sh", argv);
  e4:	50                   	push   %eax
  e5:	50                   	push   %eax
  e6:	68 cc 0b 00 00       	push   $0xbcc
  eb:	68 f6 08 00 00       	push   $0x8f6
  f0:	e8 d6 02 00 00       	call   3cb <exec>
      printf(1, "init: exec sh failed\n");
  f5:	5a                   	pop    %edx
  f6:	59                   	pop    %ecx
  f7:	68 f9 08 00 00       	push   $0x8f9
  fc:	6a 01                	push   $0x1
  fe:	e8 0d 04 00 00       	call   510 <printf>
      exit();
 103:	e8 8b 02 00 00       	call   393 <exit>
    mknod("console", 1, 1);
 108:	50                   	push   %eax
 109:	6a 01                	push   $0x1
 10b:	6a 01                	push   $0x1
 10d:	68 78 08 00 00       	push   $0x878
 112:	e8 c4 02 00 00       	call   3db <mknod>
    open("console", O_RDWR);
 117:	58                   	pop    %eax
 118:	5a                   	pop    %edx
 119:	6a 02                	push   $0x2
 11b:	68 78 08 00 00       	push   $0x878
 120:	e8 ae 02 00 00       	call   3d3 <open>
 125:	83 c4 10             	add    $0x10,%esp
 128:	e9 00 ff ff ff       	jmp    2d <main+0x2d>
 12d:	66 90                	xchg   %ax,%ax
 12f:	90                   	nop

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 130:	f3 0f 1e fb          	endbr32 
 134:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 135:	31 c0                	xor    %eax,%eax
{
 137:	89 e5                	mov    %esp,%ebp
 139:	53                   	push   %ebx
 13a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 13d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 140:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 144:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 147:	83 c0 01             	add    $0x1,%eax
 14a:	84 d2                	test   %dl,%dl
 14c:	75 f2                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 14e:	89 c8                	mov    %ecx,%eax
 150:	5b                   	pop    %ebx
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	53                   	push   %ebx
 168:	8b 4d 08             	mov    0x8(%ebp),%ecx
 16b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 16e:	0f b6 01             	movzbl (%ecx),%eax
 171:	0f b6 1a             	movzbl (%edx),%ebx
 174:	84 c0                	test   %al,%al
 176:	75 19                	jne    191 <strcmp+0x31>
 178:	eb 26                	jmp    1a0 <strcmp+0x40>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 184:	83 c1 01             	add    $0x1,%ecx
 187:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 18a:	0f b6 1a             	movzbl (%edx),%ebx
 18d:	84 c0                	test   %al,%al
 18f:	74 0f                	je     1a0 <strcmp+0x40>
 191:	38 d8                	cmp    %bl,%al
 193:	74 eb                	je     180 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 195:	29 d8                	sub    %ebx,%eax
}
 197:	5b                   	pop    %ebx
 198:	5d                   	pop    %ebp
 199:	c3                   	ret    
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1a2:	29 d8                	sub    %ebx,%eax
}
 1a4:	5b                   	pop    %ebx
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ae:	66 90                	xchg   %ax,%ax

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1ba:	80 3a 00             	cmpb   $0x0,(%edx)
 1bd:	74 21                	je     1e0 <strlen+0x30>
 1bf:	31 c0                	xor    %eax,%eax
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1c8:	83 c0 01             	add    $0x1,%eax
 1cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1cf:	89 c1                	mov    %eax,%ecx
 1d1:	75 f5                	jne    1c8 <strlen+0x18>
    ;
  return n;
}
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 1e0:	31 c9                	xor    %ecx,%ecx
}
 1e2:	5d                   	pop    %ebp
 1e3:	89 c8                	mov    %ecx,%eax
 1e5:	c3                   	ret    
 1e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ed:	8d 76 00             	lea    0x0(%esi),%esi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	57                   	push   %edi
 1f8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 201:	89 d7                	mov    %edx,%edi
 203:	fc                   	cld    
 204:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 206:	89 d0                	mov    %edx,%eax
 208:	5f                   	pop    %edi
 209:	5d                   	pop    %ebp
 20a:	c3                   	ret    
 20b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 20f:	90                   	nop

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 21e:	0f b6 10             	movzbl (%eax),%edx
 221:	84 d2                	test   %dl,%dl
 223:	75 16                	jne    23b <strchr+0x2b>
 225:	eb 21                	jmp    248 <strchr+0x38>
 227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22e:	66 90                	xchg   %ax,%ax
 230:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 234:	83 c0 01             	add    $0x1,%eax
 237:	84 d2                	test   %dl,%dl
 239:	74 0d                	je     248 <strchr+0x38>
    if(*s == c)
 23b:	38 d1                	cmp    %dl,%cl
 23d:	75 f1                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
}
 23f:	5d                   	pop    %ebp
 240:	c3                   	ret    
 241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 248:	31 c0                	xor    %eax,%eax
}
 24a:	5d                   	pop    %ebp
 24b:	c3                   	ret    
 24c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	57                   	push   %edi
 258:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 259:	31 f6                	xor    %esi,%esi
{
 25b:	53                   	push   %ebx
 25c:	89 f3                	mov    %esi,%ebx
 25e:	83 ec 1c             	sub    $0x1c,%esp
 261:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 264:	eb 33                	jmp    299 <gets+0x49>
 266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 270:	83 ec 04             	sub    $0x4,%esp
 273:	8d 45 e7             	lea    -0x19(%ebp),%eax
 276:	6a 01                	push   $0x1
 278:	50                   	push   %eax
 279:	6a 00                	push   $0x0
 27b:	e8 2b 01 00 00       	call   3ab <read>
    if(cc < 1)
 280:	83 c4 10             	add    $0x10,%esp
 283:	85 c0                	test   %eax,%eax
 285:	7e 1c                	jle    2a3 <gets+0x53>
      break;
    buf[i++] = c;
 287:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 28b:	83 c7 01             	add    $0x1,%edi
 28e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 291:	3c 0a                	cmp    $0xa,%al
 293:	74 23                	je     2b8 <gets+0x68>
 295:	3c 0d                	cmp    $0xd,%al
 297:	74 1f                	je     2b8 <gets+0x68>
  for(i=0; i+1 < max; ){
 299:	83 c3 01             	add    $0x1,%ebx
 29c:	89 fe                	mov    %edi,%esi
 29e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2a1:	7c cd                	jl     270 <gets+0x20>
 2a3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2a8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ae:	5b                   	pop    %ebx
 2af:	5e                   	pop    %esi
 2b0:	5f                   	pop    %edi
 2b1:	5d                   	pop    %ebp
 2b2:	c3                   	ret    
 2b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b7:	90                   	nop
 2b8:	8b 75 08             	mov    0x8(%ebp),%esi
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	01 de                	add    %ebx,%esi
 2c0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2c2:	c6 03 00             	movb   $0x0,(%ebx)
}
 2c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c8:	5b                   	pop    %ebx
 2c9:	5e                   	pop    %esi
 2ca:	5f                   	pop    %edi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	56                   	push   %esi
 2d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d9:	83 ec 08             	sub    $0x8,%esp
 2dc:	6a 00                	push   $0x0
 2de:	ff 75 08             	pushl  0x8(%ebp)
 2e1:	e8 ed 00 00 00       	call   3d3 <open>
  if(fd < 0)
 2e6:	83 c4 10             	add    $0x10,%esp
 2e9:	85 c0                	test   %eax,%eax
 2eb:	78 2b                	js     318 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2ed:	83 ec 08             	sub    $0x8,%esp
 2f0:	ff 75 0c             	pushl  0xc(%ebp)
 2f3:	89 c3                	mov    %eax,%ebx
 2f5:	50                   	push   %eax
 2f6:	e8 f0 00 00 00       	call   3eb <fstat>
  close(fd);
 2fb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fe:	89 c6                	mov    %eax,%esi
  close(fd);
 300:	e8 b6 00 00 00       	call   3bb <close>
  return r;
 305:	83 c4 10             	add    $0x10,%esp
}
 308:	8d 65 f8             	lea    -0x8(%ebp),%esp
 30b:	89 f0                	mov    %esi,%eax
 30d:	5b                   	pop    %ebx
 30e:	5e                   	pop    %esi
 30f:	5d                   	pop    %ebp
 310:	c3                   	ret    
 311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 318:	be ff ff ff ff       	mov    $0xffffffff,%esi
 31d:	eb e9                	jmp    308 <stat+0x38>
 31f:	90                   	nop

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	53                   	push   %ebx
 328:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32b:	0f be 02             	movsbl (%edx),%eax
 32e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 331:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 334:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 339:	77 1a                	ja     355 <atoi+0x35>
 33b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 33f:	90                   	nop
    n = n*10 + *s++ - '0';
 340:	83 c2 01             	add    $0x1,%edx
 343:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 346:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 34a:	0f be 02             	movsbl (%edx),%eax
 34d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	89 c8                	mov    %ecx,%eax
 357:	5b                   	pop    %ebx
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	f3 0f 1e fb          	endbr32 
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	57                   	push   %edi
 368:	8b 45 10             	mov    0x10(%ebp),%eax
 36b:	8b 55 08             	mov    0x8(%ebp),%edx
 36e:	56                   	push   %esi
 36f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 372:	85 c0                	test   %eax,%eax
 374:	7e 0f                	jle    385 <memmove+0x25>
 376:	01 d0                	add    %edx,%eax
  dst = vdst;
 378:	89 d7                	mov    %edx,%edi
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 380:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 381:	39 f8                	cmp    %edi,%eax
 383:	75 fb                	jne    380 <memmove+0x20>
  return vdst;
}
 385:	5e                   	pop    %esi
 386:	89 d0                	mov    %edx,%eax
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret    

0000038b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 38b:	b8 01 00 00 00       	mov    $0x1,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <exit>:
SYSCALL(exit)
 393:	b8 02 00 00 00       	mov    $0x2,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <wait>:
SYSCALL(wait)
 39b:	b8 03 00 00 00       	mov    $0x3,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <pipe>:
SYSCALL(pipe)
 3a3:	b8 04 00 00 00       	mov    $0x4,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <read>:
SYSCALL(read)
 3ab:	b8 05 00 00 00       	mov    $0x5,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <write>:
SYSCALL(write)
 3b3:	b8 10 00 00 00       	mov    $0x10,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <close>:
SYSCALL(close)
 3bb:	b8 15 00 00 00       	mov    $0x15,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <kill>:
SYSCALL(kill)
 3c3:	b8 06 00 00 00       	mov    $0x6,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <exec>:
SYSCALL(exec)
 3cb:	b8 07 00 00 00       	mov    $0x7,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <open>:
SYSCALL(open)
 3d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <mknod>:
SYSCALL(mknod)
 3db:	b8 11 00 00 00       	mov    $0x11,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <unlink>:
SYSCALL(unlink)
 3e3:	b8 12 00 00 00       	mov    $0x12,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <fstat>:
SYSCALL(fstat)
 3eb:	b8 08 00 00 00       	mov    $0x8,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <link>:
SYSCALL(link)
 3f3:	b8 13 00 00 00       	mov    $0x13,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mkdir>:
SYSCALL(mkdir)
 3fb:	b8 14 00 00 00       	mov    $0x14,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <chdir>:
SYSCALL(chdir)
 403:	b8 09 00 00 00       	mov    $0x9,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <dup>:
SYSCALL(dup)
 40b:	b8 0a 00 00 00       	mov    $0xa,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <getpid>:
SYSCALL(getpid)
 413:	b8 0b 00 00 00       	mov    $0xb,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <sbrk>:
SYSCALL(sbrk)
 41b:	b8 0c 00 00 00       	mov    $0xc,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <sleep>:
SYSCALL(sleep)
 423:	b8 0d 00 00 00       	mov    $0xd,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <uptime>:
SYSCALL(uptime)
 42b:	b8 0e 00 00 00       	mov    $0xe,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <wait_for_process>:
SYSCALL(wait_for_process)
 433:	b8 1d 00 00 00       	mov    $0x1d,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <find_next_prime_number>:
SYSCALL(find_next_prime_number)
 43b:	b8 16 00 00 00       	mov    $0x16,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <get_call_count>:
SYSCALL(get_call_count)
 443:	b8 18 00 00 00       	mov    $0x18,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <get_most_caller>:
SYSCALL(get_most_caller)
 44b:	b8 17 00 00 00       	mov    $0x17,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    
 453:	66 90                	xchg   %ax,%ax
 455:	66 90                	xchg   %ax,%ax
 457:	66 90                	xchg   %ax,%ax
 459:	66 90                	xchg   %ax,%ax
 45b:	66 90                	xchg   %ax,%ax
 45d:	66 90                	xchg   %ax,%ax
 45f:	90                   	nop

00000460 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 3c             	sub    $0x3c,%esp
 469:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 46c:	89 d1                	mov    %edx,%ecx
{
 46e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 471:	85 d2                	test   %edx,%edx
 473:	0f 89 7f 00 00 00    	jns    4f8 <printint+0x98>
 479:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 47d:	74 79                	je     4f8 <printint+0x98>
    neg = 1;
 47f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 486:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 488:	31 db                	xor    %ebx,%ebx
 48a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 48d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 490:	89 c8                	mov    %ecx,%eax
 492:	31 d2                	xor    %edx,%edx
 494:	89 cf                	mov    %ecx,%edi
 496:	f7 75 c4             	divl   -0x3c(%ebp)
 499:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
 4a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4a3:	89 d8                	mov    %ebx,%eax
 4a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 4a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 4ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 4ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4b1:	76 dd                	jbe    490 <printint+0x30>
  if(neg)
 4b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4b6:	85 c9                	test   %ecx,%ecx
 4b8:	74 0c                	je     4c6 <printint+0x66>
    buf[i++] = '-';
 4ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 4bf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 4c1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 4c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 4c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 4cd:	eb 07                	jmp    4d6 <printint+0x76>
 4cf:	90                   	nop
 4d0:	0f b6 13             	movzbl (%ebx),%edx
 4d3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 4d6:	83 ec 04             	sub    $0x4,%esp
 4d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 4dc:	6a 01                	push   $0x1
 4de:	56                   	push   %esi
 4df:	57                   	push   %edi
 4e0:	e8 ce fe ff ff       	call   3b3 <write>
  while(--i >= 0)
 4e5:	83 c4 10             	add    $0x10,%esp
 4e8:	39 de                	cmp    %ebx,%esi
 4ea:	75 e4                	jne    4d0 <printint+0x70>
    putc(fd, buf[i]);
}
 4ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ef:	5b                   	pop    %ebx
 4f0:	5e                   	pop    %esi
 4f1:	5f                   	pop    %edi
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 4ff:	eb 87                	jmp    488 <printint+0x28>
 501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 508:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50f:	90                   	nop

00000510 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 510:	f3 0f 1e fb          	endbr32 
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	57                   	push   %edi
 518:	56                   	push   %esi
 519:	53                   	push   %ebx
 51a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 51d:	8b 75 0c             	mov    0xc(%ebp),%esi
 520:	0f b6 1e             	movzbl (%esi),%ebx
 523:	84 db                	test   %bl,%bl
 525:	0f 84 b4 00 00 00    	je     5df <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 52b:	8d 45 10             	lea    0x10(%ebp),%eax
 52e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 531:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 534:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 536:	89 45 d0             	mov    %eax,-0x30(%ebp)
 539:	eb 33                	jmp    56e <printf+0x5e>
 53b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop
 540:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 543:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 548:	83 f8 25             	cmp    $0x25,%eax
 54b:	74 17                	je     564 <printf+0x54>
  write(fd, &c, 1);
 54d:	83 ec 04             	sub    $0x4,%esp
 550:	88 5d e7             	mov    %bl,-0x19(%ebp)
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 55 fe ff ff       	call   3b3 <write>
 55e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 561:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 564:	0f b6 1e             	movzbl (%esi),%ebx
 567:	83 c6 01             	add    $0x1,%esi
 56a:	84 db                	test   %bl,%bl
 56c:	74 71                	je     5df <printf+0xcf>
    c = fmt[i] & 0xff;
 56e:	0f be cb             	movsbl %bl,%ecx
 571:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 574:	85 d2                	test   %edx,%edx
 576:	74 c8                	je     540 <printf+0x30>
      }
    } else if(state == '%'){
 578:	83 fa 25             	cmp    $0x25,%edx
 57b:	75 e7                	jne    564 <printf+0x54>
      if(c == 'd'){
 57d:	83 f8 64             	cmp    $0x64,%eax
 580:	0f 84 9a 00 00 00    	je     620 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 586:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 58c:	83 f9 70             	cmp    $0x70,%ecx
 58f:	74 5f                	je     5f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 591:	83 f8 73             	cmp    $0x73,%eax
 594:	0f 84 d6 00 00 00    	je     670 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 59a:	83 f8 63             	cmp    $0x63,%eax
 59d:	0f 84 8d 00 00 00    	je     630 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a3:	83 f8 25             	cmp    $0x25,%eax
 5a6:	0f 84 b4 00 00 00    	je     660 <printf+0x150>
  write(fd, &c, 1);
 5ac:	83 ec 04             	sub    $0x4,%esp
 5af:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5b3:	6a 01                	push   $0x1
 5b5:	57                   	push   %edi
 5b6:	ff 75 08             	pushl  0x8(%ebp)
 5b9:	e8 f5 fd ff ff       	call   3b3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5be:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5c1:	83 c4 0c             	add    $0xc,%esp
 5c4:	6a 01                	push   $0x1
 5c6:	83 c6 01             	add    $0x1,%esi
 5c9:	57                   	push   %edi
 5ca:	ff 75 08             	pushl  0x8(%ebp)
 5cd:	e8 e1 fd ff ff       	call   3b3 <write>
  for(i = 0; fmt[i]; i++){
 5d2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 5d6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5d9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 5db:	84 db                	test   %bl,%bl
 5dd:	75 8f                	jne    56e <printf+0x5e>
    }
  }
}
 5df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e2:	5b                   	pop    %ebx
 5e3:	5e                   	pop    %esi
 5e4:	5f                   	pop    %edi
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
 5e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ee:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 5f0:	83 ec 0c             	sub    $0xc,%esp
 5f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 5f8:	6a 00                	push   $0x0
 5fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5fd:	8b 45 08             	mov    0x8(%ebp),%eax
 600:	8b 13                	mov    (%ebx),%edx
 602:	e8 59 fe ff ff       	call   460 <printint>
        ap++;
 607:	89 d8                	mov    %ebx,%eax
 609:	83 c4 10             	add    $0x10,%esp
      state = 0;
 60c:	31 d2                	xor    %edx,%edx
        ap++;
 60e:	83 c0 04             	add    $0x4,%eax
 611:	89 45 d0             	mov    %eax,-0x30(%ebp)
 614:	e9 4b ff ff ff       	jmp    564 <printf+0x54>
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 0a 00 00 00       	mov    $0xa,%ecx
 628:	6a 01                	push   $0x1
 62a:	eb ce                	jmp    5fa <printf+0xea>
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 630:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 633:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 636:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 638:	6a 01                	push   $0x1
        ap++;
 63a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 63d:	57                   	push   %edi
 63e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 641:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 644:	e8 6a fd ff ff       	call   3b3 <write>
        ap++;
 649:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 64c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 64f:	31 d2                	xor    %edx,%edx
 651:	e9 0e ff ff ff       	jmp    564 <printf+0x54>
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 660:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 663:	83 ec 04             	sub    $0x4,%esp
 666:	e9 59 ff ff ff       	jmp    5c4 <printf+0xb4>
 66b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 66f:	90                   	nop
        s = (char*)*ap;
 670:	8b 45 d0             	mov    -0x30(%ebp),%eax
 673:	8b 18                	mov    (%eax),%ebx
        ap++;
 675:	83 c0 04             	add    $0x4,%eax
 678:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 67b:	85 db                	test   %ebx,%ebx
 67d:	74 17                	je     696 <printf+0x186>
        while(*s != 0){
 67f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 682:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 684:	84 c0                	test   %al,%al
 686:	0f 84 d8 fe ff ff    	je     564 <printf+0x54>
 68c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 68f:	89 de                	mov    %ebx,%esi
 691:	8b 5d 08             	mov    0x8(%ebp),%ebx
 694:	eb 1a                	jmp    6b0 <printf+0x1a0>
          s = "(null)";
 696:	bb 18 09 00 00       	mov    $0x918,%ebx
        while(*s != 0){
 69b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 69e:	b8 28 00 00 00       	mov    $0x28,%eax
 6a3:	89 de                	mov    %ebx,%esi
 6a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 6b3:	83 c6 01             	add    $0x1,%esi
 6b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6b9:	6a 01                	push   $0x1
 6bb:	57                   	push   %edi
 6bc:	53                   	push   %ebx
 6bd:	e8 f1 fc ff ff       	call   3b3 <write>
        while(*s != 0){
 6c2:	0f b6 06             	movzbl (%esi),%eax
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	84 c0                	test   %al,%al
 6ca:	75 e4                	jne    6b0 <printf+0x1a0>
 6cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 8e fe ff ff       	jmp    564 <printf+0x54>
 6d6:	66 90                	xchg   %ax,%ax
 6d8:	66 90                	xchg   %ax,%ax
 6da:	66 90                	xchg   %ax,%ax
 6dc:	66 90                	xchg   %ax,%ax
 6de:	66 90                	xchg   %ax,%ax

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	f3 0f 1e fb          	endbr32 
 6e4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e5:	a1 d4 0b 00 00       	mov    0xbd4,%eax
{
 6ea:	89 e5                	mov    %esp,%ebp
 6ec:	57                   	push   %edi
 6ed:	56                   	push   %esi
 6ee:	53                   	push   %ebx
 6ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6f2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 6f4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f7:	39 c8                	cmp    %ecx,%eax
 6f9:	73 15                	jae    710 <free+0x30>
 6fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6ff:	90                   	nop
 700:	39 d1                	cmp    %edx,%ecx
 702:	72 14                	jb     718 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	39 d0                	cmp    %edx,%eax
 706:	73 10                	jae    718 <free+0x38>
{
 708:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70a:	8b 10                	mov    (%eax),%edx
 70c:	39 c8                	cmp    %ecx,%eax
 70e:	72 f0                	jb     700 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 710:	39 d0                	cmp    %edx,%eax
 712:	72 f4                	jb     708 <free+0x28>
 714:	39 d1                	cmp    %edx,%ecx
 716:	73 f0                	jae    708 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 718:	8b 73 fc             	mov    -0x4(%ebx),%esi
 71b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 71e:	39 fa                	cmp    %edi,%edx
 720:	74 1e                	je     740 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 722:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 725:	8b 50 04             	mov    0x4(%eax),%edx
 728:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72b:	39 f1                	cmp    %esi,%ecx
 72d:	74 28                	je     757 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 72f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 731:	5b                   	pop    %ebx
  freep = p;
 732:	a3 d4 0b 00 00       	mov    %eax,0xbd4
}
 737:	5e                   	pop    %esi
 738:	5f                   	pop    %edi
 739:	5d                   	pop    %ebp
 73a:	c3                   	ret    
 73b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 740:	03 72 04             	add    0x4(%edx),%esi
 743:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 12                	mov    (%edx),%edx
 74a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 74d:	8b 50 04             	mov    0x4(%eax),%edx
 750:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	75 d8                	jne    72f <free+0x4f>
    p->s.size += bp->s.size;
 757:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 75a:	a3 d4 0b 00 00       	mov    %eax,0xbd4
    p->s.size += bp->s.size;
 75f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 762:	8b 53 f8             	mov    -0x8(%ebx),%edx
 765:	89 10                	mov    %edx,(%eax)
}
 767:	5b                   	pop    %ebx
 768:	5e                   	pop    %esi
 769:	5f                   	pop    %edi
 76a:	5d                   	pop    %ebp
 76b:	c3                   	ret    
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	f3 0f 1e fb          	endbr32 
 774:	55                   	push   %ebp
 775:	89 e5                	mov    %esp,%ebp
 777:	57                   	push   %edi
 778:	56                   	push   %esi
 779:	53                   	push   %ebx
 77a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 780:	8b 3d d4 0b 00 00    	mov    0xbd4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 786:	8d 70 07             	lea    0x7(%eax),%esi
 789:	c1 ee 03             	shr    $0x3,%esi
 78c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 78f:	85 ff                	test   %edi,%edi
 791:	0f 84 a9 00 00 00    	je     840 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 797:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 799:	8b 48 04             	mov    0x4(%eax),%ecx
 79c:	39 f1                	cmp    %esi,%ecx
 79e:	73 6d                	jae    80d <malloc+0x9d>
 7a0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7a6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7ab:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 7ae:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7b8:	eb 17                	jmp    7d1 <malloc+0x61>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 7c2:	8b 4a 04             	mov    0x4(%edx),%ecx
 7c5:	39 f1                	cmp    %esi,%ecx
 7c7:	73 4f                	jae    818 <malloc+0xa8>
 7c9:	8b 3d d4 0b 00 00    	mov    0xbd4,%edi
 7cf:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7d1:	39 c7                	cmp    %eax,%edi
 7d3:	75 eb                	jne    7c0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 7d5:	83 ec 0c             	sub    $0xc,%esp
 7d8:	ff 75 e4             	pushl  -0x1c(%ebp)
 7db:	e8 3b fc ff ff       	call   41b <sbrk>
  if(p == (char*)-1)
 7e0:	83 c4 10             	add    $0x10,%esp
 7e3:	83 f8 ff             	cmp    $0xffffffff,%eax
 7e6:	74 1b                	je     803 <malloc+0x93>
  hp->s.size = nu;
 7e8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7eb:	83 ec 0c             	sub    $0xc,%esp
 7ee:	83 c0 08             	add    $0x8,%eax
 7f1:	50                   	push   %eax
 7f2:	e8 e9 fe ff ff       	call   6e0 <free>
  return freep;
 7f7:	a1 d4 0b 00 00       	mov    0xbd4,%eax
      if((p = morecore(nunits)) == 0)
 7fc:	83 c4 10             	add    $0x10,%esp
 7ff:	85 c0                	test   %eax,%eax
 801:	75 bd                	jne    7c0 <malloc+0x50>
        return 0;
  }
}
 803:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 806:	31 c0                	xor    %eax,%eax
}
 808:	5b                   	pop    %ebx
 809:	5e                   	pop    %esi
 80a:	5f                   	pop    %edi
 80b:	5d                   	pop    %ebp
 80c:	c3                   	ret    
    if(p->s.size >= nunits){
 80d:	89 c2                	mov    %eax,%edx
 80f:	89 f8                	mov    %edi,%eax
 811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 818:	39 ce                	cmp    %ecx,%esi
 81a:	74 54                	je     870 <malloc+0x100>
        p->s.size -= nunits;
 81c:	29 f1                	sub    %esi,%ecx
 81e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 821:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 824:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 827:	a3 d4 0b 00 00       	mov    %eax,0xbd4
}
 82c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 82f:	8d 42 08             	lea    0x8(%edx),%eax
}
 832:	5b                   	pop    %ebx
 833:	5e                   	pop    %esi
 834:	5f                   	pop    %edi
 835:	5d                   	pop    %ebp
 836:	c3                   	ret    
 837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 840:	c7 05 d4 0b 00 00 d8 	movl   $0xbd8,0xbd4
 847:	0b 00 00 
    base.s.size = 0;
 84a:	bf d8 0b 00 00       	mov    $0xbd8,%edi
    base.s.ptr = freep = prevp = &base;
 84f:	c7 05 d8 0b 00 00 d8 	movl   $0xbd8,0xbd8
 856:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 859:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 85b:	c7 05 dc 0b 00 00 00 	movl   $0x0,0xbdc
 862:	00 00 00 
    if(p->s.size >= nunits){
 865:	e9 36 ff ff ff       	jmp    7a0 <malloc+0x30>
 86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 870:	8b 0a                	mov    (%edx),%ecx
 872:	89 08                	mov    %ecx,(%eax)
 874:	eb b1                	jmp    827 <malloc+0xb7>
