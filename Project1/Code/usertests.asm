
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 16 4d 00 00       	push   $0x4d16
      16:	6a 01                	push   $0x1
      18:	e8 e3 39 00 00       	call   3a00 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 2a 4d 00 00       	push   $0x4d2a
      26:	e8 b8 38 00 00       	call   38e3 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 64 54 00 00       	push   $0x5464
      39:	6a 01                	push   $0x1
      3b:	e8 c0 39 00 00       	call   3a00 <printf>
    exit();
      40:	e8 5e 38 00 00       	call   38a3 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 2a 4d 00 00       	push   $0x4d2a
      51:	e8 8d 38 00 00       	call   38e3 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 6d 38 00 00       	call   38cb <close>

  argptest();
      5e:	e8 5d 35 00 00       	call   35c0 <argptest>
  createdelete();
      63:	e8 b8 11 00 00       	call   1220 <createdelete>
  linkunlink();
      68:	e8 73 1a 00 00       	call   1ae0 <linkunlink>
  concreate();
      6d:	e8 6e 17 00 00       	call   17e0 <concreate>
  fourfiles();
      72:	e8 a9 0f 00 00       	call   1020 <fourfiles>
  sharedfd();
      77:	e8 e4 0d 00 00       	call   e60 <sharedfd>

  bigargtest();
      7c:	e8 ff 31 00 00       	call   3280 <bigargtest>
  bigwrite();
      81:	e8 7a 23 00 00       	call   2400 <bigwrite>
  bigargtest();
      86:	e8 f5 31 00 00       	call   3280 <bigargtest>
  bsstest();
      8b:	e8 80 31 00 00       	call   3210 <bsstest>
  sbrktest();
      90:	e8 ab 2c 00 00       	call   2d40 <sbrktest>
  validatetest();
      95:	e8 c6 30 00 00       	call   3160 <validatetest>

  opentest();
      9a:	e8 61 03 00 00       	call   400 <opentest>
  writetest();
      9f:	e8 ec 03 00 00       	call   490 <writetest>
  writetest1();
      a4:	e8 c7 05 00 00       	call   670 <writetest1>
  createtest();
      a9:	e8 92 07 00 00       	call   840 <createtest>

  openiputtest();
      ae:	e8 4d 02 00 00       	call   300 <openiputtest>
  exitiputtest();
      b3:	e8 48 01 00 00       	call   200 <exitiputtest>
  iputtest();
      b8:	e8 63 00 00 00       	call   120 <iputtest>

  mem();
      bd:	e8 ce 0c 00 00       	call   d90 <mem>
  pipe1();
      c2:	e8 59 09 00 00       	call   a20 <pipe1>
  preempt();
      c7:	e8 e4 0a 00 00       	call   bb0 <preempt>
  exitwait();
      cc:	e8 3f 0c 00 00       	call   d10 <exitwait>

  rmdot();
      d1:	e8 1a 27 00 00       	call   27f0 <rmdot>
  fourteen();
      d6:	e8 d5 25 00 00       	call   26b0 <fourteen>
  bigfile();
      db:	e8 00 24 00 00       	call   24e0 <bigfile>
  subdir();
      e0:	e8 3b 1c 00 00       	call   1d20 <subdir>
  linktest();
      e5:	e8 e6 14 00 00       	call   15d0 <linktest>
  unlinkread();
      ea:	e8 51 13 00 00       	call   1440 <unlinkread>
  dirfile();
      ef:	e8 7c 28 00 00       	call   2970 <dirfile>
  iref();
      f4:	e8 77 2a 00 00       	call   2b70 <iref>
  forktest();
      f9:	e8 92 2b 00 00       	call   2c90 <forktest>
  bigdir(); // slow
      fe:	e8 ed 1a 00 00       	call   1bf0 <bigdir>

  uio();
     103:	e8 48 34 00 00       	call   3550 <uio>

  exectest();
     108:	e8 c3 08 00 00       	call   9d0 <exectest>

  exit();
     10d:	e8 91 37 00 00       	call   38a3 <exit>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     126:	68 bc 3d 00 00       	push   $0x3dbc
     12b:	ff 35 e8 5d 00 00    	push   0x5de8
     131:	e8 ca 38 00 00       	call   3a00 <printf>
  if(mkdir("iputdir") < 0){
     136:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
     13d:	e8 c9 37 00 00       	call   390b <mkdir>
     142:	83 c4 10             	add    $0x10,%esp
     145:	85 c0                	test   %eax,%eax
     147:	78 58                	js     1a1 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     149:	83 ec 0c             	sub    $0xc,%esp
     14c:	68 4f 3d 00 00       	push   $0x3d4f
     151:	e8 bd 37 00 00       	call   3913 <chdir>
     156:	83 c4 10             	add    $0x10,%esp
     159:	85 c0                	test   %eax,%eax
     15b:	0f 88 85 00 00 00    	js     1e6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     161:	83 ec 0c             	sub    $0xc,%esp
     164:	68 4c 3d 00 00       	push   $0x3d4c
     169:	e8 85 37 00 00       	call   38f3 <unlink>
     16e:	83 c4 10             	add    $0x10,%esp
     171:	85 c0                	test   %eax,%eax
     173:	78 5a                	js     1cf <iputtest+0xaf>
  if(chdir("/") < 0){
     175:	83 ec 0c             	sub    $0xc,%esp
     178:	68 71 3d 00 00       	push   $0x3d71
     17d:	e8 91 37 00 00       	call   3913 <chdir>
     182:	83 c4 10             	add    $0x10,%esp
     185:	85 c0                	test   %eax,%eax
     187:	78 2f                	js     1b8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 f4 3d 00 00       	push   $0x3df4
     191:	ff 35 e8 5d 00 00    	push   0x5de8
     197:	e8 64 38 00 00       	call   3a00 <printf>
}
     19c:	83 c4 10             	add    $0x10,%esp
     19f:	c9                   	leave  
     1a0:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     1a1:	50                   	push   %eax
     1a2:	50                   	push   %eax
     1a3:	68 28 3d 00 00       	push   $0x3d28
     1a8:	ff 35 e8 5d 00 00    	push   0x5de8
     1ae:	e8 4d 38 00 00       	call   3a00 <printf>
    exit();
     1b3:	e8 eb 36 00 00       	call   38a3 <exit>
    printf(stdout, "chdir / failed\n");
     1b8:	50                   	push   %eax
     1b9:	50                   	push   %eax
     1ba:	68 73 3d 00 00       	push   $0x3d73
     1bf:	ff 35 e8 5d 00 00    	push   0x5de8
     1c5:	e8 36 38 00 00       	call   3a00 <printf>
    exit();
     1ca:	e8 d4 36 00 00       	call   38a3 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1cf:	52                   	push   %edx
     1d0:	52                   	push   %edx
     1d1:	68 57 3d 00 00       	push   $0x3d57
     1d6:	ff 35 e8 5d 00 00    	push   0x5de8
     1dc:	e8 1f 38 00 00       	call   3a00 <printf>
    exit();
     1e1:	e8 bd 36 00 00       	call   38a3 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1e6:	51                   	push   %ecx
     1e7:	51                   	push   %ecx
     1e8:	68 36 3d 00 00       	push   $0x3d36
     1ed:	ff 35 e8 5d 00 00    	push   0x5de8
     1f3:	e8 08 38 00 00       	call   3a00 <printf>
    exit();
     1f8:	e8 a6 36 00 00       	call   38a3 <exit>
     1fd:	8d 76 00             	lea    0x0(%esi),%esi

00000200 <exitiputtest>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     206:	68 83 3d 00 00       	push   $0x3d83
     20b:	ff 35 e8 5d 00 00    	push   0x5de8
     211:	e8 ea 37 00 00       	call   3a00 <printf>
  pid = fork();
     216:	e8 80 36 00 00       	call   389b <fork>
  if(pid < 0){
     21b:	83 c4 10             	add    $0x10,%esp
     21e:	85 c0                	test   %eax,%eax
     220:	0f 88 8a 00 00 00    	js     2b0 <exitiputtest+0xb0>
  if(pid == 0){
     226:	75 50                	jne    278 <exitiputtest+0x78>
    if(mkdir("iputdir") < 0){
     228:	83 ec 0c             	sub    $0xc,%esp
     22b:	68 4f 3d 00 00       	push   $0x3d4f
     230:	e8 d6 36 00 00       	call   390b <mkdir>
     235:	83 c4 10             	add    $0x10,%esp
     238:	85 c0                	test   %eax,%eax
     23a:	0f 88 87 00 00 00    	js     2c7 <exitiputtest+0xc7>
    if(chdir("iputdir") < 0){
     240:	83 ec 0c             	sub    $0xc,%esp
     243:	68 4f 3d 00 00       	push   $0x3d4f
     248:	e8 c6 36 00 00       	call   3913 <chdir>
     24d:	83 c4 10             	add    $0x10,%esp
     250:	85 c0                	test   %eax,%eax
     252:	0f 88 86 00 00 00    	js     2de <exitiputtest+0xde>
    if(unlink("../iputdir") < 0){
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	68 4c 3d 00 00       	push   $0x3d4c
     260:	e8 8e 36 00 00       	call   38f3 <unlink>
     265:	83 c4 10             	add    $0x10,%esp
     268:	85 c0                	test   %eax,%eax
     26a:	78 2c                	js     298 <exitiputtest+0x98>
    exit();
     26c:	e8 32 36 00 00       	call   38a3 <exit>
     271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  wait();
     278:	e8 2e 36 00 00       	call   38ab <wait>
  printf(stdout, "exitiput test ok\n");
     27d:	83 ec 08             	sub    $0x8,%esp
     280:	68 a6 3d 00 00       	push   $0x3da6
     285:	ff 35 e8 5d 00 00    	push   0x5de8
     28b:	e8 70 37 00 00       	call   3a00 <printf>
}
     290:	83 c4 10             	add    $0x10,%esp
     293:	c9                   	leave  
     294:	c3                   	ret    
     295:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     298:	83 ec 08             	sub    $0x8,%esp
     29b:	68 57 3d 00 00       	push   $0x3d57
     2a0:	ff 35 e8 5d 00 00    	push   0x5de8
     2a6:	e8 55 37 00 00       	call   3a00 <printf>
      exit();
     2ab:	e8 f3 35 00 00       	call   38a3 <exit>
    printf(stdout, "fork failed\n");
     2b0:	51                   	push   %ecx
     2b1:	51                   	push   %ecx
     2b2:	68 69 4c 00 00       	push   $0x4c69
     2b7:	ff 35 e8 5d 00 00    	push   0x5de8
     2bd:	e8 3e 37 00 00       	call   3a00 <printf>
    exit();
     2c2:	e8 dc 35 00 00       	call   38a3 <exit>
      printf(stdout, "mkdir failed\n");
     2c7:	52                   	push   %edx
     2c8:	52                   	push   %edx
     2c9:	68 28 3d 00 00       	push   $0x3d28
     2ce:	ff 35 e8 5d 00 00    	push   0x5de8
     2d4:	e8 27 37 00 00       	call   3a00 <printf>
      exit();
     2d9:	e8 c5 35 00 00       	call   38a3 <exit>
      printf(stdout, "child chdir failed\n");
     2de:	50                   	push   %eax
     2df:	50                   	push   %eax
     2e0:	68 92 3d 00 00       	push   $0x3d92
     2e5:	ff 35 e8 5d 00 00    	push   0x5de8
     2eb:	e8 10 37 00 00       	call   3a00 <printf>
      exit();
     2f0:	e8 ae 35 00 00       	call   38a3 <exit>
     2f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <openiputtest>:
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     306:	68 b8 3d 00 00       	push   $0x3db8
     30b:	ff 35 e8 5d 00 00    	push   0x5de8
     311:	e8 ea 36 00 00       	call   3a00 <printf>
  if(mkdir("oidir") < 0){
     316:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
     31d:	e8 e9 35 00 00       	call   390b <mkdir>
     322:	83 c4 10             	add    $0x10,%esp
     325:	85 c0                	test   %eax,%eax
     327:	0f 88 9f 00 00 00    	js     3cc <openiputtest+0xcc>
  pid = fork();
     32d:	e8 69 35 00 00       	call   389b <fork>
  if(pid < 0){
     332:	85 c0                	test   %eax,%eax
     334:	78 7f                	js     3b5 <openiputtest+0xb5>
  if(pid == 0){
     336:	75 38                	jne    370 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     338:	83 ec 08             	sub    $0x8,%esp
     33b:	6a 02                	push   $0x2
     33d:	68 c7 3d 00 00       	push   $0x3dc7
     342:	e8 9c 35 00 00       	call   38e3 <open>
    if(fd >= 0){
     347:	83 c4 10             	add    $0x10,%esp
     34a:	85 c0                	test   %eax,%eax
     34c:	78 62                	js     3b0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     34e:	83 ec 08             	sub    $0x8,%esp
     351:	68 4c 4d 00 00       	push   $0x4d4c
     356:	ff 35 e8 5d 00 00    	push   0x5de8
     35c:	e8 9f 36 00 00       	call   3a00 <printf>
      exit();
     361:	e8 3d 35 00 00       	call   38a3 <exit>
     366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     36d:	8d 76 00             	lea    0x0(%esi),%esi
  sleep(1);
     370:	83 ec 0c             	sub    $0xc,%esp
     373:	6a 01                	push   $0x1
     375:	e8 b9 35 00 00       	call   3933 <sleep>
  if(unlink("oidir") != 0){
     37a:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
     381:	e8 6d 35 00 00       	call   38f3 <unlink>
     386:	83 c4 10             	add    $0x10,%esp
     389:	85 c0                	test   %eax,%eax
     38b:	75 56                	jne    3e3 <openiputtest+0xe3>
  wait();
     38d:	e8 19 35 00 00       	call   38ab <wait>
  printf(stdout, "openiput test ok\n");
     392:	83 ec 08             	sub    $0x8,%esp
     395:	68 f0 3d 00 00       	push   $0x3df0
     39a:	ff 35 e8 5d 00 00    	push   0x5de8
     3a0:	e8 5b 36 00 00       	call   3a00 <printf>
}
     3a5:	83 c4 10             	add    $0x10,%esp
     3a8:	c9                   	leave  
     3a9:	c3                   	ret    
     3aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     3b0:	e8 ee 34 00 00       	call   38a3 <exit>
    printf(stdout, "fork failed\n");
     3b5:	52                   	push   %edx
     3b6:	52                   	push   %edx
     3b7:	68 69 4c 00 00       	push   $0x4c69
     3bc:	ff 35 e8 5d 00 00    	push   0x5de8
     3c2:	e8 39 36 00 00       	call   3a00 <printf>
    exit();
     3c7:	e8 d7 34 00 00       	call   38a3 <exit>
    printf(stdout, "mkdir oidir failed\n");
     3cc:	51                   	push   %ecx
     3cd:	51                   	push   %ecx
     3ce:	68 cd 3d 00 00       	push   $0x3dcd
     3d3:	ff 35 e8 5d 00 00    	push   0x5de8
     3d9:	e8 22 36 00 00       	call   3a00 <printf>
    exit();
     3de:	e8 c0 34 00 00       	call   38a3 <exit>
    printf(stdout, "unlink failed\n");
     3e3:	50                   	push   %eax
     3e4:	50                   	push   %eax
     3e5:	68 e1 3d 00 00       	push   $0x3de1
     3ea:	ff 35 e8 5d 00 00    	push   0x5de8
     3f0:	e8 0b 36 00 00       	call   3a00 <printf>
    exit();
     3f5:	e8 a9 34 00 00       	call   38a3 <exit>
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <opentest>:
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     406:	68 02 3e 00 00       	push   $0x3e02
     40b:	ff 35 e8 5d 00 00    	push   0x5de8
     411:	e8 ea 35 00 00       	call   3a00 <printf>
  fd = open("echo", 0);
     416:	58                   	pop    %eax
     417:	5a                   	pop    %edx
     418:	6a 00                	push   $0x0
     41a:	68 0d 3e 00 00       	push   $0x3e0d
     41f:	e8 bf 34 00 00       	call   38e3 <open>
  if(fd < 0){
     424:	83 c4 10             	add    $0x10,%esp
     427:	85 c0                	test   %eax,%eax
     429:	78 36                	js     461 <opentest+0x61>
  close(fd);
     42b:	83 ec 0c             	sub    $0xc,%esp
     42e:	50                   	push   %eax
     42f:	e8 97 34 00 00       	call   38cb <close>
  fd = open("doesnotexist", 0);
     434:	5a                   	pop    %edx
     435:	59                   	pop    %ecx
     436:	6a 00                	push   $0x0
     438:	68 25 3e 00 00       	push   $0x3e25
     43d:	e8 a1 34 00 00       	call   38e3 <open>
  if(fd >= 0){
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	79 2f                	jns    478 <opentest+0x78>
  printf(stdout, "open test ok\n");
     449:	83 ec 08             	sub    $0x8,%esp
     44c:	68 50 3e 00 00       	push   $0x3e50
     451:	ff 35 e8 5d 00 00    	push   0x5de8
     457:	e8 a4 35 00 00       	call   3a00 <printf>
}
     45c:	83 c4 10             	add    $0x10,%esp
     45f:	c9                   	leave  
     460:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     461:	50                   	push   %eax
     462:	50                   	push   %eax
     463:	68 12 3e 00 00       	push   $0x3e12
     468:	ff 35 e8 5d 00 00    	push   0x5de8
     46e:	e8 8d 35 00 00       	call   3a00 <printf>
    exit();
     473:	e8 2b 34 00 00       	call   38a3 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     478:	50                   	push   %eax
     479:	50                   	push   %eax
     47a:	68 32 3e 00 00       	push   $0x3e32
     47f:	ff 35 e8 5d 00 00    	push   0x5de8
     485:	e8 76 35 00 00       	call   3a00 <printf>
    exit();
     48a:	e8 14 34 00 00       	call   38a3 <exit>
     48f:	90                   	nop

00000490 <writetest>:
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     495:	83 ec 08             	sub    $0x8,%esp
     498:	68 5e 3e 00 00       	push   $0x3e5e
     49d:	ff 35 e8 5d 00 00    	push   0x5de8
     4a3:	e8 58 35 00 00       	call   3a00 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4a8:	58                   	pop    %eax
     4a9:	5a                   	pop    %edx
     4aa:	68 02 02 00 00       	push   $0x202
     4af:	68 6f 3e 00 00       	push   $0x3e6f
     4b4:	e8 2a 34 00 00       	call   38e3 <open>
  if(fd >= 0){
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	0f 88 88 01 00 00    	js     64c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4c4:	83 ec 08             	sub    $0x8,%esp
     4c7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4c9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4cb:	68 75 3e 00 00       	push   $0x3e75
     4d0:	ff 35 e8 5d 00 00    	push   0x5de8
     4d6:	e8 25 35 00 00       	call   3a00 <printf>
     4db:	83 c4 10             	add    $0x10,%esp
     4de:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4e0:	83 ec 04             	sub    $0x4,%esp
     4e3:	6a 0a                	push   $0xa
     4e5:	68 ac 3e 00 00       	push   $0x3eac
     4ea:	56                   	push   %esi
     4eb:	e8 d3 33 00 00       	call   38c3 <write>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	83 f8 0a             	cmp    $0xa,%eax
     4f6:	0f 85 d9 00 00 00    	jne    5d5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4fc:	83 ec 04             	sub    $0x4,%esp
     4ff:	6a 0a                	push   $0xa
     501:	68 b7 3e 00 00       	push   $0x3eb7
     506:	56                   	push   %esi
     507:	e8 b7 33 00 00       	call   38c3 <write>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	83 f8 0a             	cmp    $0xa,%eax
     512:	0f 85 d6 00 00 00    	jne    5ee <writetest+0x15e>
  for(i = 0; i < 100; i++){
     518:	83 c3 01             	add    $0x1,%ebx
     51b:	83 fb 64             	cmp    $0x64,%ebx
     51e:	75 c0                	jne    4e0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     520:	83 ec 08             	sub    $0x8,%esp
     523:	68 c2 3e 00 00       	push   $0x3ec2
     528:	ff 35 e8 5d 00 00    	push   0x5de8
     52e:	e8 cd 34 00 00       	call   3a00 <printf>
  close(fd);
     533:	89 34 24             	mov    %esi,(%esp)
     536:	e8 90 33 00 00       	call   38cb <close>
  fd = open("small", O_RDONLY);
     53b:	5b                   	pop    %ebx
     53c:	5e                   	pop    %esi
     53d:	6a 00                	push   $0x0
     53f:	68 6f 3e 00 00       	push   $0x3e6f
     544:	e8 9a 33 00 00       	call   38e3 <open>
  if(fd >= 0){
     549:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     54c:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     54e:	85 c0                	test   %eax,%eax
     550:	0f 88 b1 00 00 00    	js     607 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     556:	83 ec 08             	sub    $0x8,%esp
     559:	68 cd 3e 00 00       	push   $0x3ecd
     55e:	ff 35 e8 5d 00 00    	push   0x5de8
     564:	e8 97 34 00 00       	call   3a00 <printf>
  i = read(fd, buf, 2000);
     569:	83 c4 0c             	add    $0xc,%esp
     56c:	68 d0 07 00 00       	push   $0x7d0
     571:	68 20 85 00 00       	push   $0x8520
     576:	53                   	push   %ebx
     577:	e8 3f 33 00 00       	call   38bb <read>
  if(i == 2000){
     57c:	83 c4 10             	add    $0x10,%esp
     57f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     584:	0f 85 94 00 00 00    	jne    61e <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     58a:	83 ec 08             	sub    $0x8,%esp
     58d:	68 01 3f 00 00       	push   $0x3f01
     592:	ff 35 e8 5d 00 00    	push   0x5de8
     598:	e8 63 34 00 00       	call   3a00 <printf>
  close(fd);
     59d:	89 1c 24             	mov    %ebx,(%esp)
     5a0:	e8 26 33 00 00       	call   38cb <close>
  if(unlink("small") < 0){
     5a5:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
     5ac:	e8 42 33 00 00       	call   38f3 <unlink>
     5b1:	83 c4 10             	add    $0x10,%esp
     5b4:	85 c0                	test   %eax,%eax
     5b6:	78 7d                	js     635 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     5b8:	83 ec 08             	sub    $0x8,%esp
     5bb:	68 29 3f 00 00       	push   $0x3f29
     5c0:	ff 35 e8 5d 00 00    	push   0x5de8
     5c6:	e8 35 34 00 00       	call   3a00 <printf>
}
     5cb:	83 c4 10             	add    $0x10,%esp
     5ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5d1:	5b                   	pop    %ebx
     5d2:	5e                   	pop    %esi
     5d3:	5d                   	pop    %ebp
     5d4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5d5:	83 ec 04             	sub    $0x4,%esp
     5d8:	53                   	push   %ebx
     5d9:	68 70 4d 00 00       	push   $0x4d70
     5de:	ff 35 e8 5d 00 00    	push   0x5de8
     5e4:	e8 17 34 00 00       	call   3a00 <printf>
      exit();
     5e9:	e8 b5 32 00 00       	call   38a3 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ee:	83 ec 04             	sub    $0x4,%esp
     5f1:	53                   	push   %ebx
     5f2:	68 94 4d 00 00       	push   $0x4d94
     5f7:	ff 35 e8 5d 00 00    	push   0x5de8
     5fd:	e8 fe 33 00 00       	call   3a00 <printf>
      exit();
     602:	e8 9c 32 00 00       	call   38a3 <exit>
    printf(stdout, "error: open small failed!\n");
     607:	51                   	push   %ecx
     608:	51                   	push   %ecx
     609:	68 e6 3e 00 00       	push   $0x3ee6
     60e:	ff 35 e8 5d 00 00    	push   0x5de8
     614:	e8 e7 33 00 00       	call   3a00 <printf>
    exit();
     619:	e8 85 32 00 00       	call   38a3 <exit>
    printf(stdout, "read failed\n");
     61e:	52                   	push   %edx
     61f:	52                   	push   %edx
     620:	68 2d 42 00 00       	push   $0x422d
     625:	ff 35 e8 5d 00 00    	push   0x5de8
     62b:	e8 d0 33 00 00       	call   3a00 <printf>
    exit();
     630:	e8 6e 32 00 00       	call   38a3 <exit>
    printf(stdout, "unlink small failed\n");
     635:	50                   	push   %eax
     636:	50                   	push   %eax
     637:	68 14 3f 00 00       	push   $0x3f14
     63c:	ff 35 e8 5d 00 00    	push   0x5de8
     642:	e8 b9 33 00 00       	call   3a00 <printf>
    exit();
     647:	e8 57 32 00 00       	call   38a3 <exit>
    printf(stdout, "error: creat small failed!\n");
     64c:	50                   	push   %eax
     64d:	50                   	push   %eax
     64e:	68 90 3e 00 00       	push   $0x3e90
     653:	ff 35 e8 5d 00 00    	push   0x5de8
     659:	e8 a2 33 00 00       	call   3a00 <printf>
    exit();
     65e:	e8 40 32 00 00       	call   38a3 <exit>
     663:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     66a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000670 <writetest1>:
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	56                   	push   %esi
     674:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     675:	83 ec 08             	sub    $0x8,%esp
     678:	68 3d 3f 00 00       	push   $0x3f3d
     67d:	ff 35 e8 5d 00 00    	push   0x5de8
     683:	e8 78 33 00 00       	call   3a00 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     688:	58                   	pop    %eax
     689:	5a                   	pop    %edx
     68a:	68 02 02 00 00       	push   $0x202
     68f:	68 b7 3f 00 00       	push   $0x3fb7
     694:	e8 4a 32 00 00       	call   38e3 <open>
  if(fd < 0){
     699:	83 c4 10             	add    $0x10,%esp
     69c:	85 c0                	test   %eax,%eax
     69e:	0f 88 61 01 00 00    	js     805 <writetest1+0x195>
     6a4:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     6a6:	31 db                	xor    %ebx,%ebx
     6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6af:	90                   	nop
    if(write(fd, buf, 512) != 512){
     6b0:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     6b3:	89 1d 20 85 00 00    	mov    %ebx,0x8520
    if(write(fd, buf, 512) != 512){
     6b9:	68 00 02 00 00       	push   $0x200
     6be:	68 20 85 00 00       	push   $0x8520
     6c3:	56                   	push   %esi
     6c4:	e8 fa 31 00 00       	call   38c3 <write>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d1:	0f 85 b3 00 00 00    	jne    78a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6d7:	83 c3 01             	add    $0x1,%ebx
     6da:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6e0:	75 ce                	jne    6b0 <writetest1+0x40>
  close(fd);
     6e2:	83 ec 0c             	sub    $0xc,%esp
     6e5:	56                   	push   %esi
     6e6:	e8 e0 31 00 00       	call   38cb <close>
  fd = open("big", O_RDONLY);
     6eb:	5b                   	pop    %ebx
     6ec:	5e                   	pop    %esi
     6ed:	6a 00                	push   $0x0
     6ef:	68 b7 3f 00 00       	push   $0x3fb7
     6f4:	e8 ea 31 00 00       	call   38e3 <open>
  if(fd < 0){
     6f9:	83 c4 10             	add    $0x10,%esp
  fd = open("big", O_RDONLY);
     6fc:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
     6fe:	85 c0                	test   %eax,%eax
     700:	0f 88 e8 00 00 00    	js     7ee <writetest1+0x17e>
  n = 0;
     706:	31 f6                	xor    %esi,%esi
     708:	eb 1d                	jmp    727 <writetest1+0xb7>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     710:	3d 00 02 00 00       	cmp    $0x200,%eax
     715:	0f 85 9f 00 00 00    	jne    7ba <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     71b:	a1 20 85 00 00       	mov    0x8520,%eax
     720:	39 f0                	cmp    %esi,%eax
     722:	75 7f                	jne    7a3 <writetest1+0x133>
    n++;
     724:	83 c6 01             	add    $0x1,%esi
    i = read(fd, buf, 512);
     727:	83 ec 04             	sub    $0x4,%esp
     72a:	68 00 02 00 00       	push   $0x200
     72f:	68 20 85 00 00       	push   $0x8520
     734:	53                   	push   %ebx
     735:	e8 81 31 00 00       	call   38bb <read>
    if(i == 0){
     73a:	83 c4 10             	add    $0x10,%esp
     73d:	85 c0                	test   %eax,%eax
     73f:	75 cf                	jne    710 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     741:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     747:	0f 84 86 00 00 00    	je     7d3 <writetest1+0x163>
  close(fd);
     74d:	83 ec 0c             	sub    $0xc,%esp
     750:	53                   	push   %ebx
     751:	e8 75 31 00 00       	call   38cb <close>
  if(unlink("big") < 0){
     756:	c7 04 24 b7 3f 00 00 	movl   $0x3fb7,(%esp)
     75d:	e8 91 31 00 00       	call   38f3 <unlink>
     762:	83 c4 10             	add    $0x10,%esp
     765:	85 c0                	test   %eax,%eax
     767:	0f 88 af 00 00 00    	js     81c <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 de 3f 00 00       	push   $0x3fde
     775:	ff 35 e8 5d 00 00    	push   0x5de8
     77b:	e8 80 32 00 00       	call   3a00 <printf>
}
     780:	83 c4 10             	add    $0x10,%esp
     783:	8d 65 f8             	lea    -0x8(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5d                   	pop    %ebp
     789:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     78a:	83 ec 04             	sub    $0x4,%esp
     78d:	53                   	push   %ebx
     78e:	68 67 3f 00 00       	push   $0x3f67
     793:	ff 35 e8 5d 00 00    	push   0x5de8
     799:	e8 62 32 00 00       	call   3a00 <printf>
      exit();
     79e:	e8 00 31 00 00       	call   38a3 <exit>
      printf(stdout, "read content of block %d is %d\n",
     7a3:	50                   	push   %eax
     7a4:	56                   	push   %esi
     7a5:	68 b8 4d 00 00       	push   $0x4db8
     7aa:	ff 35 e8 5d 00 00    	push   0x5de8
     7b0:	e8 4b 32 00 00       	call   3a00 <printf>
      exit();
     7b5:	e8 e9 30 00 00       	call   38a3 <exit>
      printf(stdout, "read failed %d\n", i);
     7ba:	83 ec 04             	sub    $0x4,%esp
     7bd:	50                   	push   %eax
     7be:	68 bb 3f 00 00       	push   $0x3fbb
     7c3:	ff 35 e8 5d 00 00    	push   0x5de8
     7c9:	e8 32 32 00 00       	call   3a00 <printf>
      exit();
     7ce:	e8 d0 30 00 00       	call   38a3 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7d3:	52                   	push   %edx
     7d4:	68 8b 00 00 00       	push   $0x8b
     7d9:	68 9e 3f 00 00       	push   $0x3f9e
     7de:	ff 35 e8 5d 00 00    	push   0x5de8
     7e4:	e8 17 32 00 00       	call   3a00 <printf>
        exit();
     7e9:	e8 b5 30 00 00       	call   38a3 <exit>
    printf(stdout, "error: open big failed!\n");
     7ee:	51                   	push   %ecx
     7ef:	51                   	push   %ecx
     7f0:	68 85 3f 00 00       	push   $0x3f85
     7f5:	ff 35 e8 5d 00 00    	push   0x5de8
     7fb:	e8 00 32 00 00       	call   3a00 <printf>
    exit();
     800:	e8 9e 30 00 00       	call   38a3 <exit>
    printf(stdout, "error: creat big failed!\n");
     805:	50                   	push   %eax
     806:	50                   	push   %eax
     807:	68 4d 3f 00 00       	push   $0x3f4d
     80c:	ff 35 e8 5d 00 00    	push   0x5de8
     812:	e8 e9 31 00 00       	call   3a00 <printf>
    exit();
     817:	e8 87 30 00 00       	call   38a3 <exit>
    printf(stdout, "unlink big failed\n");
     81c:	50                   	push   %eax
     81d:	50                   	push   %eax
     81e:	68 cb 3f 00 00       	push   $0x3fcb
     823:	ff 35 e8 5d 00 00    	push   0x5de8
     829:	e8 d2 31 00 00       	call   3a00 <printf>
    exit();
     82e:	e8 70 30 00 00       	call   38a3 <exit>
     833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000840 <createtest>:
{
     840:	55                   	push   %ebp
     841:	89 e5                	mov    %esp,%ebp
     843:	53                   	push   %ebx
  name[2] = '\0';
     844:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     849:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     84c:	68 d8 4d 00 00       	push   $0x4dd8
     851:	ff 35 e8 5d 00 00    	push   0x5de8
     857:	e8 a4 31 00 00       	call   3a00 <printf>
  name[0] = 'a';
     85c:	c6 05 10 85 00 00 61 	movb   $0x61,0x8510
  name[2] = '\0';
     863:	83 c4 10             	add    $0x10,%esp
     866:	c6 05 12 85 00 00 00 	movb   $0x0,0x8512
  for(i = 0; i < 52; i++){
     86d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     870:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     873:	88 1d 11 85 00 00    	mov    %bl,0x8511
  for(i = 0; i < 52; i++){
     879:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     87c:	68 02 02 00 00       	push   $0x202
     881:	68 10 85 00 00       	push   $0x8510
     886:	e8 58 30 00 00       	call   38e3 <open>
    close(fd);
     88b:	89 04 24             	mov    %eax,(%esp)
     88e:	e8 38 30 00 00       	call   38cb <close>
  for(i = 0; i < 52; i++){
     893:	83 c4 10             	add    $0x10,%esp
     896:	80 fb 64             	cmp    $0x64,%bl
     899:	75 d5                	jne    870 <createtest+0x30>
  name[0] = 'a';
     89b:	c6 05 10 85 00 00 61 	movb   $0x61,0x8510
  name[2] = '\0';
     8a2:	bb 30 00 00 00       	mov    $0x30,%ebx
     8a7:	c6 05 12 85 00 00 00 	movb   $0x0,0x8512
  for(i = 0; i < 52; i++){
     8ae:	66 90                	xchg   %ax,%ax
    unlink(name);
     8b0:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     8b3:	88 1d 11 85 00 00    	mov    %bl,0x8511
  for(i = 0; i < 52; i++){
     8b9:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     8bc:	68 10 85 00 00       	push   $0x8510
     8c1:	e8 2d 30 00 00       	call   38f3 <unlink>
  for(i = 0; i < 52; i++){
     8c6:	83 c4 10             	add    $0x10,%esp
     8c9:	80 fb 64             	cmp    $0x64,%bl
     8cc:	75 e2                	jne    8b0 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ce:	83 ec 08             	sub    $0x8,%esp
     8d1:	68 00 4e 00 00       	push   $0x4e00
     8d6:	ff 35 e8 5d 00 00    	push   0x5de8
     8dc:	e8 1f 31 00 00       	call   3a00 <printf>
}
     8e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e4:	83 c4 10             	add    $0x10,%esp
     8e7:	c9                   	leave  
     8e8:	c3                   	ret    
     8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008f0 <dirtest>:
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8f6:	68 ec 3f 00 00       	push   $0x3fec
     8fb:	ff 35 e8 5d 00 00    	push   0x5de8
     901:	e8 fa 30 00 00       	call   3a00 <printf>
  if(mkdir("dir0") < 0){
     906:	c7 04 24 f8 3f 00 00 	movl   $0x3ff8,(%esp)
     90d:	e8 f9 2f 00 00       	call   390b <mkdir>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 58                	js     971 <dirtest+0x81>
  if(chdir("dir0") < 0){
     919:	83 ec 0c             	sub    $0xc,%esp
     91c:	68 f8 3f 00 00       	push   $0x3ff8
     921:	e8 ed 2f 00 00       	call   3913 <chdir>
     926:	83 c4 10             	add    $0x10,%esp
     929:	85 c0                	test   %eax,%eax
     92b:	0f 88 85 00 00 00    	js     9b6 <dirtest+0xc6>
  if(chdir("..") < 0){
     931:	83 ec 0c             	sub    $0xc,%esp
     934:	68 9d 45 00 00       	push   $0x459d
     939:	e8 d5 2f 00 00       	call   3913 <chdir>
     93e:	83 c4 10             	add    $0x10,%esp
     941:	85 c0                	test   %eax,%eax
     943:	78 5a                	js     99f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     945:	83 ec 0c             	sub    $0xc,%esp
     948:	68 f8 3f 00 00       	push   $0x3ff8
     94d:	e8 a1 2f 00 00       	call   38f3 <unlink>
     952:	83 c4 10             	add    $0x10,%esp
     955:	85 c0                	test   %eax,%eax
     957:	78 2f                	js     988 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     959:	83 ec 08             	sub    $0x8,%esp
     95c:	68 35 40 00 00       	push   $0x4035
     961:	ff 35 e8 5d 00 00    	push   0x5de8
     967:	e8 94 30 00 00       	call   3a00 <printf>
}
     96c:	83 c4 10             	add    $0x10,%esp
     96f:	c9                   	leave  
     970:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     971:	50                   	push   %eax
     972:	50                   	push   %eax
     973:	68 28 3d 00 00       	push   $0x3d28
     978:	ff 35 e8 5d 00 00    	push   0x5de8
     97e:	e8 7d 30 00 00       	call   3a00 <printf>
    exit();
     983:	e8 1b 2f 00 00       	call   38a3 <exit>
    printf(stdout, "unlink dir0 failed\n");
     988:	50                   	push   %eax
     989:	50                   	push   %eax
     98a:	68 21 40 00 00       	push   $0x4021
     98f:	ff 35 e8 5d 00 00    	push   0x5de8
     995:	e8 66 30 00 00       	call   3a00 <printf>
    exit();
     99a:	e8 04 2f 00 00       	call   38a3 <exit>
    printf(stdout, "chdir .. failed\n");
     99f:	52                   	push   %edx
     9a0:	52                   	push   %edx
     9a1:	68 10 40 00 00       	push   $0x4010
     9a6:	ff 35 e8 5d 00 00    	push   0x5de8
     9ac:	e8 4f 30 00 00       	call   3a00 <printf>
    exit();
     9b1:	e8 ed 2e 00 00       	call   38a3 <exit>
    printf(stdout, "chdir dir0 failed\n");
     9b6:	51                   	push   %ecx
     9b7:	51                   	push   %ecx
     9b8:	68 fd 3f 00 00       	push   $0x3ffd
     9bd:	ff 35 e8 5d 00 00    	push   0x5de8
     9c3:	e8 38 30 00 00       	call   3a00 <printf>
    exit();
     9c8:	e8 d6 2e 00 00       	call   38a3 <exit>
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <exectest>:
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9d6:	68 44 40 00 00       	push   $0x4044
     9db:	ff 35 e8 5d 00 00    	push   0x5de8
     9e1:	e8 1a 30 00 00       	call   3a00 <printf>
  if(exec("echo", echoargv) < 0){
     9e6:	5a                   	pop    %edx
     9e7:	59                   	pop    %ecx
     9e8:	68 ec 5d 00 00       	push   $0x5dec
     9ed:	68 0d 3e 00 00       	push   $0x3e0d
     9f2:	e8 e4 2e 00 00       	call   38db <exec>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	78 02                	js     a00 <exectest+0x30>
}
     9fe:	c9                   	leave  
     9ff:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     a00:	50                   	push   %eax
     a01:	50                   	push   %eax
     a02:	68 4f 40 00 00       	push   $0x404f
     a07:	ff 35 e8 5d 00 00    	push   0x5de8
     a0d:	e8 ee 2f 00 00       	call   3a00 <printf>
    exit();
     a12:	e8 8c 2e 00 00       	call   38a3 <exit>
     a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a1e:	66 90                	xchg   %ax,%ax

00000a20 <pipe1>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
  if(pipe(fds) != 0){
     a25:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a28:	53                   	push   %ebx
     a29:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a2c:	50                   	push   %eax
     a2d:	e8 81 2e 00 00       	call   38b3 <pipe>
     a32:	83 c4 10             	add    $0x10,%esp
     a35:	85 c0                	test   %eax,%eax
     a37:	0f 85 34 01 00 00    	jne    b71 <pipe1+0x151>
  pid = fork();
     a3d:	e8 59 2e 00 00       	call   389b <fork>
  if(pid == 0){
     a42:	85 c0                	test   %eax,%eax
     a44:	0f 84 85 00 00 00    	je     acf <pipe1+0xaf>
  } else if(pid > 0){
     a4a:	0f 8e 34 01 00 00    	jle    b84 <pipe1+0x164>
    close(fds[1]);
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 75 e4             	push   -0x1c(%ebp)
  seq = 0;
     a56:	31 db                	xor    %ebx,%ebx
    cc = 1;
     a58:	be 01 00 00 00       	mov    $0x1,%esi
    close(fds[1]);
     a5d:	e8 69 2e 00 00       	call   38cb <close>
    total = 0;
     a62:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a69:	83 c4 10             	add    $0x10,%esp
     a6c:	83 ec 04             	sub    $0x4,%esp
     a6f:	56                   	push   %esi
     a70:	68 20 85 00 00       	push   $0x8520
     a75:	ff 75 e0             	push   -0x20(%ebp)
     a78:	e8 3e 2e 00 00       	call   38bb <read>
     a7d:	83 c4 10             	add    $0x10,%esp
     a80:	89 c7                	mov    %eax,%edi
     a82:	85 c0                	test   %eax,%eax
     a84:	0f 8e a3 00 00 00    	jle    b2d <pipe1+0x10d>
     a8a:	8d 0c 1f             	lea    (%edi,%ebx,1),%ecx
      for(i = 0; i < n; i++){
     a8d:	31 c0                	xor    %eax,%eax
     a8f:	90                   	nop
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a90:	89 da                	mov    %ebx,%edx
     a92:	83 c3 01             	add    $0x1,%ebx
     a95:	38 90 20 85 00 00    	cmp    %dl,0x8520(%eax)
     a9b:	75 18                	jne    ab5 <pipe1+0x95>
      for(i = 0; i < n; i++){
     a9d:	83 c0 01             	add    $0x1,%eax
     aa0:	39 d9                	cmp    %ebx,%ecx
     aa2:	75 ec                	jne    a90 <pipe1+0x70>
      cc = cc * 2;
     aa4:	01 f6                	add    %esi,%esi
     aa6:	b8 00 20 00 00       	mov    $0x2000,%eax
      total += n;
     aab:	01 7d d4             	add    %edi,-0x2c(%ebp)
     aae:	39 c6                	cmp    %eax,%esi
     ab0:	0f 4f f0             	cmovg  %eax,%esi
     ab3:	eb b7                	jmp    a6c <pipe1+0x4c>
          printf(1, "pipe1 oops 2\n");
     ab5:	83 ec 08             	sub    $0x8,%esp
     ab8:	68 7e 40 00 00       	push   $0x407e
     abd:	6a 01                	push   $0x1
     abf:	e8 3c 2f 00 00       	call   3a00 <printf>
     ac4:	83 c4 10             	add    $0x10,%esp
}
     ac7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aca:	5b                   	pop    %ebx
     acb:	5e                   	pop    %esi
     acc:	5f                   	pop    %edi
     acd:	5d                   	pop    %ebp
     ace:	c3                   	ret    
    close(fds[0]);
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	ff 75 e0             	push   -0x20(%ebp)
  seq = 0;
     ad5:	31 db                	xor    %ebx,%ebx
    close(fds[0]);
     ad7:	e8 ef 2d 00 00       	call   38cb <close>
     adc:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 1033; i++)
     adf:	31 c0                	xor    %eax,%eax
     ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        buf[i] = seq++;
     ae8:	8d 14 18             	lea    (%eax,%ebx,1),%edx
      for(i = 0; i < 1033; i++)
     aeb:	83 c0 01             	add    $0x1,%eax
        buf[i] = seq++;
     aee:	88 90 1f 85 00 00    	mov    %dl,0x851f(%eax)
      for(i = 0; i < 1033; i++)
     af4:	3d 09 04 00 00       	cmp    $0x409,%eax
     af9:	75 ed                	jne    ae8 <pipe1+0xc8>
      if(write(fds[1], buf, 1033) != 1033){
     afb:	83 ec 04             	sub    $0x4,%esp
        buf[i] = seq++;
     afe:	81 c3 09 04 00 00    	add    $0x409,%ebx
      if(write(fds[1], buf, 1033) != 1033){
     b04:	68 09 04 00 00       	push   $0x409
     b09:	68 20 85 00 00       	push   $0x8520
     b0e:	ff 75 e4             	push   -0x1c(%ebp)
     b11:	e8 ad 2d 00 00       	call   38c3 <write>
     b16:	83 c4 10             	add    $0x10,%esp
     b19:	3d 09 04 00 00       	cmp    $0x409,%eax
     b1e:	75 77                	jne    b97 <pipe1+0x177>
    for(n = 0; n < 5; n++){
     b20:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b26:	75 b7                	jne    adf <pipe1+0xbf>
    exit();
     b28:	e8 76 2d 00 00       	call   38a3 <exit>
    if(total != 5 * 1033){
     b2d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b34:	75 26                	jne    b5c <pipe1+0x13c>
    close(fds[0]);
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	ff 75 e0             	push   -0x20(%ebp)
     b3c:	e8 8a 2d 00 00       	call   38cb <close>
    wait();
     b41:	e8 65 2d 00 00       	call   38ab <wait>
  printf(1, "pipe1 ok\n");
     b46:	5a                   	pop    %edx
     b47:	59                   	pop    %ecx
     b48:	68 a3 40 00 00       	push   $0x40a3
     b4d:	6a 01                	push   $0x1
     b4f:	e8 ac 2e 00 00       	call   3a00 <printf>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	e9 6b ff ff ff       	jmp    ac7 <pipe1+0xa7>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b5c:	53                   	push   %ebx
     b5d:	ff 75 d4             	push   -0x2c(%ebp)
     b60:	68 8c 40 00 00       	push   $0x408c
     b65:	6a 01                	push   $0x1
     b67:	e8 94 2e 00 00       	call   3a00 <printf>
      exit();
     b6c:	e8 32 2d 00 00       	call   38a3 <exit>
    printf(1, "pipe() failed\n");
     b71:	57                   	push   %edi
     b72:	57                   	push   %edi
     b73:	68 61 40 00 00       	push   $0x4061
     b78:	6a 01                	push   $0x1
     b7a:	e8 81 2e 00 00       	call   3a00 <printf>
    exit();
     b7f:	e8 1f 2d 00 00       	call   38a3 <exit>
    printf(1, "fork() failed\n");
     b84:	50                   	push   %eax
     b85:	50                   	push   %eax
     b86:	68 ad 40 00 00       	push   $0x40ad
     b8b:	6a 01                	push   $0x1
     b8d:	e8 6e 2e 00 00       	call   3a00 <printf>
    exit();
     b92:	e8 0c 2d 00 00       	call   38a3 <exit>
        printf(1, "pipe1 oops 1\n");
     b97:	56                   	push   %esi
     b98:	56                   	push   %esi
     b99:	68 70 40 00 00       	push   $0x4070
     b9e:	6a 01                	push   $0x1
     ba0:	e8 5b 2e 00 00       	call   3a00 <printf>
        exit();
     ba5:	e8 f9 2c 00 00       	call   38a3 <exit>
     baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000bb0 <preempt>:
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	57                   	push   %edi
     bb4:	56                   	push   %esi
     bb5:	53                   	push   %ebx
     bb6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     bb9:	68 bc 40 00 00       	push   $0x40bc
     bbe:	6a 01                	push   $0x1
     bc0:	e8 3b 2e 00 00       	call   3a00 <printf>
  pid1 = fork();
     bc5:	e8 d1 2c 00 00       	call   389b <fork>
  if(pid1 == 0)
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	85 c0                	test   %eax,%eax
     bcf:	75 07                	jne    bd8 <preempt+0x28>
    for(;;)
     bd1:	eb fe                	jmp    bd1 <preempt+0x21>
     bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bd7:	90                   	nop
     bd8:	89 c3                	mov    %eax,%ebx
  pid2 = fork();
     bda:	e8 bc 2c 00 00       	call   389b <fork>
     bdf:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     be1:	85 c0                	test   %eax,%eax
     be3:	75 0b                	jne    bf0 <preempt+0x40>
    for(;;)
     be5:	eb fe                	jmp    be5 <preempt+0x35>
     be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bee:	66 90                	xchg   %ax,%ax
  pipe(pfds);
     bf0:	83 ec 0c             	sub    $0xc,%esp
     bf3:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bf6:	50                   	push   %eax
     bf7:	e8 b7 2c 00 00       	call   38b3 <pipe>
  pid3 = fork();
     bfc:	e8 9a 2c 00 00       	call   389b <fork>
  if(pid3 == 0){
     c01:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     c04:	89 c7                	mov    %eax,%edi
  if(pid3 == 0){
     c06:	85 c0                	test   %eax,%eax
     c08:	75 3e                	jne    c48 <preempt+0x98>
    close(pfds[0]);
     c0a:	83 ec 0c             	sub    $0xc,%esp
     c0d:	ff 75 e0             	push   -0x20(%ebp)
     c10:	e8 b6 2c 00 00       	call   38cb <close>
    if(write(pfds[1], "x", 1) != 1)
     c15:	83 c4 0c             	add    $0xc,%esp
     c18:	6a 01                	push   $0x1
     c1a:	68 81 46 00 00       	push   $0x4681
     c1f:	ff 75 e4             	push   -0x1c(%ebp)
     c22:	e8 9c 2c 00 00       	call   38c3 <write>
     c27:	83 c4 10             	add    $0x10,%esp
     c2a:	83 f8 01             	cmp    $0x1,%eax
     c2d:	0f 85 b8 00 00 00    	jne    ceb <preempt+0x13b>
    close(pfds[1]);
     c33:	83 ec 0c             	sub    $0xc,%esp
     c36:	ff 75 e4             	push   -0x1c(%ebp)
     c39:	e8 8d 2c 00 00       	call   38cb <close>
     c3e:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c41:	eb fe                	jmp    c41 <preempt+0x91>
     c43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c47:	90                   	nop
  close(pfds[1]);
     c48:	83 ec 0c             	sub    $0xc,%esp
     c4b:	ff 75 e4             	push   -0x1c(%ebp)
     c4e:	e8 78 2c 00 00       	call   38cb <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c53:	83 c4 0c             	add    $0xc,%esp
     c56:	68 00 20 00 00       	push   $0x2000
     c5b:	68 20 85 00 00       	push   $0x8520
     c60:	ff 75 e0             	push   -0x20(%ebp)
     c63:	e8 53 2c 00 00       	call   38bb <read>
     c68:	83 c4 10             	add    $0x10,%esp
     c6b:	83 f8 01             	cmp    $0x1,%eax
     c6e:	75 67                	jne    cd7 <preempt+0x127>
  close(pfds[0]);
     c70:	83 ec 0c             	sub    $0xc,%esp
     c73:	ff 75 e0             	push   -0x20(%ebp)
     c76:	e8 50 2c 00 00       	call   38cb <close>
  printf(1, "kill... ");
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	68 ed 40 00 00       	push   $0x40ed
     c82:	6a 01                	push   $0x1
     c84:	e8 77 2d 00 00       	call   3a00 <printf>
  kill(pid1);
     c89:	89 1c 24             	mov    %ebx,(%esp)
     c8c:	e8 42 2c 00 00       	call   38d3 <kill>
  kill(pid2);
     c91:	89 34 24             	mov    %esi,(%esp)
     c94:	e8 3a 2c 00 00       	call   38d3 <kill>
  kill(pid3);
     c99:	89 3c 24             	mov    %edi,(%esp)
     c9c:	e8 32 2c 00 00       	call   38d3 <kill>
  printf(1, "wait... ");
     ca1:	59                   	pop    %ecx
     ca2:	5b                   	pop    %ebx
     ca3:	68 f6 40 00 00       	push   $0x40f6
     ca8:	6a 01                	push   $0x1
     caa:	e8 51 2d 00 00       	call   3a00 <printf>
  wait();
     caf:	e8 f7 2b 00 00       	call   38ab <wait>
  wait();
     cb4:	e8 f2 2b 00 00       	call   38ab <wait>
  wait();
     cb9:	e8 ed 2b 00 00       	call   38ab <wait>
  printf(1, "preempt ok\n");
     cbe:	5e                   	pop    %esi
     cbf:	5f                   	pop    %edi
     cc0:	68 ff 40 00 00       	push   $0x40ff
     cc5:	6a 01                	push   $0x1
     cc7:	e8 34 2d 00 00       	call   3a00 <printf>
     ccc:	83 c4 10             	add    $0x10,%esp
}
     ccf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd2:	5b                   	pop    %ebx
     cd3:	5e                   	pop    %esi
     cd4:	5f                   	pop    %edi
     cd5:	5d                   	pop    %ebp
     cd6:	c3                   	ret    
    printf(1, "preempt read error");
     cd7:	83 ec 08             	sub    $0x8,%esp
     cda:	68 da 40 00 00       	push   $0x40da
     cdf:	6a 01                	push   $0x1
     ce1:	e8 1a 2d 00 00       	call   3a00 <printf>
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	eb e4                	jmp    ccf <preempt+0x11f>
      printf(1, "preempt write error");
     ceb:	83 ec 08             	sub    $0x8,%esp
     cee:	68 c6 40 00 00       	push   $0x40c6
     cf3:	6a 01                	push   $0x1
     cf5:	e8 06 2d 00 00       	call   3a00 <printf>
     cfa:	83 c4 10             	add    $0x10,%esp
     cfd:	e9 31 ff ff ff       	jmp    c33 <preempt+0x83>
     d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d10 <exitwait>:
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	be 64 00 00 00       	mov    $0x64,%esi
     d19:	53                   	push   %ebx
     d1a:	eb 14                	jmp    d30 <exitwait+0x20>
     d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     d20:	74 68                	je     d8a <exitwait+0x7a>
      if(wait() != pid){
     d22:	e8 84 2b 00 00       	call   38ab <wait>
     d27:	39 d8                	cmp    %ebx,%eax
     d29:	75 2d                	jne    d58 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     d2b:	83 ee 01             	sub    $0x1,%esi
     d2e:	74 41                	je     d71 <exitwait+0x61>
    pid = fork();
     d30:	e8 66 2b 00 00       	call   389b <fork>
     d35:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d37:	85 c0                	test   %eax,%eax
     d39:	79 e5                	jns    d20 <exitwait+0x10>
      printf(1, "fork failed\n");
     d3b:	83 ec 08             	sub    $0x8,%esp
     d3e:	68 69 4c 00 00       	push   $0x4c69
     d43:	6a 01                	push   $0x1
     d45:	e8 b6 2c 00 00       	call   3a00 <printf>
      return;
     d4a:	83 c4 10             	add    $0x10,%esp
}
     d4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d50:	5b                   	pop    %ebx
     d51:	5e                   	pop    %esi
     d52:	5d                   	pop    %ebp
     d53:	c3                   	ret    
     d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d58:	83 ec 08             	sub    $0x8,%esp
     d5b:	68 0b 41 00 00       	push   $0x410b
     d60:	6a 01                	push   $0x1
     d62:	e8 99 2c 00 00       	call   3a00 <printf>
        return;
     d67:	83 c4 10             	add    $0x10,%esp
}
     d6a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d6d:	5b                   	pop    %ebx
     d6e:	5e                   	pop    %esi
     d6f:	5d                   	pop    %ebp
     d70:	c3                   	ret    
  printf(1, "exitwait ok\n");
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 1b 41 00 00       	push   $0x411b
     d79:	6a 01                	push   $0x1
     d7b:	e8 80 2c 00 00       	call   3a00 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
}
     d83:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d86:	5b                   	pop    %ebx
     d87:	5e                   	pop    %esi
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
      exit();
     d8a:	e8 14 2b 00 00       	call   38a3 <exit>
     d8f:	90                   	nop

00000d90 <mem>:
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	31 f6                	xor    %esi,%esi
     d96:	53                   	push   %ebx
  printf(1, "mem test\n");
     d97:	83 ec 08             	sub    $0x8,%esp
     d9a:	68 28 41 00 00       	push   $0x4128
     d9f:	6a 01                	push   $0x1
     da1:	e8 5a 2c 00 00       	call   3a00 <printf>
  ppid = getpid();
     da6:	e8 78 2b 00 00       	call   3923 <getpid>
     dab:	89 c3                	mov    %eax,%ebx
  if((pid = fork()) == 0){
     dad:	e8 e9 2a 00 00       	call   389b <fork>
     db2:	83 c4 10             	add    $0x10,%esp
     db5:	85 c0                	test   %eax,%eax
     db7:	74 0b                	je     dc4 <mem+0x34>
     db9:	e9 8a 00 00 00       	jmp    e48 <mem+0xb8>
     dbe:	66 90                	xchg   %ax,%ax
      *(char**)m2 = m1;
     dc0:	89 30                	mov    %esi,(%eax)
     dc2:	89 c6                	mov    %eax,%esi
    while((m2 = malloc(10001)) != 0){
     dc4:	83 ec 0c             	sub    $0xc,%esp
     dc7:	68 11 27 00 00       	push   $0x2711
     dcc:	e8 5f 2e 00 00       	call   3c30 <malloc>
     dd1:	83 c4 10             	add    $0x10,%esp
     dd4:	85 c0                	test   %eax,%eax
     dd6:	75 e8                	jne    dc0 <mem+0x30>
    while(m1){
     dd8:	85 f6                	test   %esi,%esi
     dda:	74 18                	je     df4 <mem+0x64>
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     de0:	89 f0                	mov    %esi,%eax
      free(m1);
     de2:	83 ec 0c             	sub    $0xc,%esp
      m2 = *(char**)m1;
     de5:	8b 36                	mov    (%esi),%esi
      free(m1);
     de7:	50                   	push   %eax
     de8:	e8 b3 2d 00 00       	call   3ba0 <free>
    while(m1){
     ded:	83 c4 10             	add    $0x10,%esp
     df0:	85 f6                	test   %esi,%esi
     df2:	75 ec                	jne    de0 <mem+0x50>
    m1 = malloc(1024*20);
     df4:	83 ec 0c             	sub    $0xc,%esp
     df7:	68 00 50 00 00       	push   $0x5000
     dfc:	e8 2f 2e 00 00       	call   3c30 <malloc>
    if(m1 == 0){
     e01:	83 c4 10             	add    $0x10,%esp
     e04:	85 c0                	test   %eax,%eax
     e06:	74 20                	je     e28 <mem+0x98>
    free(m1);
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	50                   	push   %eax
     e0c:	e8 8f 2d 00 00       	call   3ba0 <free>
    printf(1, "mem ok\n");
     e11:	58                   	pop    %eax
     e12:	5a                   	pop    %edx
     e13:	68 4c 41 00 00       	push   $0x414c
     e18:	6a 01                	push   $0x1
     e1a:	e8 e1 2b 00 00       	call   3a00 <printf>
    exit();
     e1f:	e8 7f 2a 00 00       	call   38a3 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e28:	83 ec 08             	sub    $0x8,%esp
     e2b:	68 32 41 00 00       	push   $0x4132
     e30:	6a 01                	push   $0x1
     e32:	e8 c9 2b 00 00       	call   3a00 <printf>
      kill(ppid);
     e37:	89 1c 24             	mov    %ebx,(%esp)
     e3a:	e8 94 2a 00 00       	call   38d3 <kill>
      exit();
     e3f:	e8 5f 2a 00 00       	call   38a3 <exit>
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e4b:	5b                   	pop    %ebx
     e4c:	5e                   	pop    %esi
     e4d:	5d                   	pop    %ebp
    wait();
     e4e:	e9 58 2a 00 00       	jmp    38ab <wait>
     e53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000e60 <sharedfd>:
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e69:	68 54 41 00 00       	push   $0x4154
     e6e:	6a 01                	push   $0x1
     e70:	e8 8b 2b 00 00       	call   3a00 <printf>
  unlink("sharedfd");
     e75:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     e7c:	e8 72 2a 00 00       	call   38f3 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e81:	5b                   	pop    %ebx
     e82:	5e                   	pop    %esi
     e83:	68 02 02 00 00       	push   $0x202
     e88:	68 63 41 00 00       	push   $0x4163
     e8d:	e8 51 2a 00 00       	call   38e3 <open>
  if(fd < 0){
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	85 c0                	test   %eax,%eax
     e97:	0f 88 2a 01 00 00    	js     fc7 <sharedfd+0x167>
     e9d:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e9f:	8d 75 de             	lea    -0x22(%ebp),%esi
     ea2:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     ea7:	e8 ef 29 00 00       	call   389b <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eac:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     eaf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb2:	19 c0                	sbb    %eax,%eax
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	83 e0 f3             	and    $0xfffffff3,%eax
     eba:	6a 0a                	push   $0xa
     ebc:	83 c0 70             	add    $0x70,%eax
     ebf:	50                   	push   %eax
     ec0:	56                   	push   %esi
     ec1:	e8 4a 28 00 00       	call   3710 <memset>
     ec6:	83 c4 10             	add    $0x10,%esp
     ec9:	eb 0a                	jmp    ed5 <sharedfd+0x75>
     ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ecf:	90                   	nop
  for(i = 0; i < 1000; i++){
     ed0:	83 eb 01             	sub    $0x1,%ebx
     ed3:	74 26                	je     efb <sharedfd+0x9b>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ed5:	83 ec 04             	sub    $0x4,%esp
     ed8:	6a 0a                	push   $0xa
     eda:	56                   	push   %esi
     edb:	57                   	push   %edi
     edc:	e8 e2 29 00 00       	call   38c3 <write>
     ee1:	83 c4 10             	add    $0x10,%esp
     ee4:	83 f8 0a             	cmp    $0xa,%eax
     ee7:	74 e7                	je     ed0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ee9:	83 ec 08             	sub    $0x8,%esp
     eec:	68 54 4e 00 00       	push   $0x4e54
     ef1:	6a 01                	push   $0x1
     ef3:	e8 08 2b 00 00       	call   3a00 <printf>
      break;
     ef8:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     efb:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     efe:	85 c9                	test   %ecx,%ecx
     f00:	0f 84 f5 00 00 00    	je     ffb <sharedfd+0x19b>
    wait();
     f06:	e8 a0 29 00 00       	call   38ab <wait>
  close(fd);
     f0b:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     f0e:	31 db                	xor    %ebx,%ebx
  close(fd);
     f10:	57                   	push   %edi
     f11:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f14:	e8 b2 29 00 00       	call   38cb <close>
  fd = open("sharedfd", 0);
     f19:	58                   	pop    %eax
     f1a:	5a                   	pop    %edx
     f1b:	6a 00                	push   $0x0
     f1d:	68 63 41 00 00       	push   $0x4163
     f22:	e8 bc 29 00 00       	call   38e3 <open>
  if(fd < 0){
     f27:	83 c4 10             	add    $0x10,%esp
  nc = np = 0;
     f2a:	31 d2                	xor    %edx,%edx
  fd = open("sharedfd", 0);
     f2c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f2f:	85 c0                	test   %eax,%eax
     f31:	0f 88 aa 00 00 00    	js     fe1 <sharedfd+0x181>
     f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3e:	66 90                	xchg   %ax,%ax
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f40:	83 ec 04             	sub    $0x4,%esp
     f43:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f46:	6a 0a                	push   $0xa
     f48:	56                   	push   %esi
     f49:	ff 75 d0             	push   -0x30(%ebp)
     f4c:	e8 6a 29 00 00       	call   38bb <read>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	85 c0                	test   %eax,%eax
     f56:	7e 28                	jle    f80 <sharedfd+0x120>
     f58:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f5b:	89 f0                	mov    %esi,%eax
     f5d:	eb 13                	jmp    f72 <sharedfd+0x112>
     f5f:	90                   	nop
        np++;
     f60:	80 f9 70             	cmp    $0x70,%cl
     f63:	0f 94 c1             	sete   %cl
     f66:	0f b6 c9             	movzbl %cl,%ecx
     f69:	01 cb                	add    %ecx,%ebx
    for(i = 0; i < sizeof(buf); i++){
     f6b:	83 c0 01             	add    $0x1,%eax
     f6e:	39 f8                	cmp    %edi,%eax
     f70:	74 ce                	je     f40 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f72:	0f b6 08             	movzbl (%eax),%ecx
     f75:	80 f9 63             	cmp    $0x63,%cl
     f78:	75 e6                	jne    f60 <sharedfd+0x100>
        nc++;
     f7a:	83 c2 01             	add    $0x1,%edx
      if(buf[i] == 'p')
     f7d:	eb ec                	jmp    f6b <sharedfd+0x10b>
     f7f:	90                   	nop
  close(fd);
     f80:	83 ec 0c             	sub    $0xc,%esp
     f83:	ff 75 d0             	push   -0x30(%ebp)
     f86:	e8 40 29 00 00       	call   38cb <close>
  unlink("sharedfd");
     f8b:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     f92:	e8 5c 29 00 00       	call   38f3 <unlink>
  if(nc == 10000 && np == 10000){
     f97:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f9a:	83 c4 10             	add    $0x10,%esp
     f9d:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fa3:	75 5b                	jne    1000 <sharedfd+0x1a0>
     fa5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     fab:	75 53                	jne    1000 <sharedfd+0x1a0>
    printf(1, "sharedfd ok\n");
     fad:	83 ec 08             	sub    $0x8,%esp
     fb0:	68 6c 41 00 00       	push   $0x416c
     fb5:	6a 01                	push   $0x1
     fb7:	e8 44 2a 00 00       	call   3a00 <printf>
     fbc:	83 c4 10             	add    $0x10,%esp
}
     fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc2:	5b                   	pop    %ebx
     fc3:	5e                   	pop    %esi
     fc4:	5f                   	pop    %edi
     fc5:	5d                   	pop    %ebp
     fc6:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for writing");
     fc7:	83 ec 08             	sub    $0x8,%esp
     fca:	68 28 4e 00 00       	push   $0x4e28
     fcf:	6a 01                	push   $0x1
     fd1:	e8 2a 2a 00 00       	call   3a00 <printf>
    return;
     fd6:	83 c4 10             	add    $0x10,%esp
}
     fd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdc:	5b                   	pop    %ebx
     fdd:	5e                   	pop    %esi
     fde:	5f                   	pop    %edi
     fdf:	5d                   	pop    %ebp
     fe0:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fe1:	83 ec 08             	sub    $0x8,%esp
     fe4:	68 74 4e 00 00       	push   $0x4e74
     fe9:	6a 01                	push   $0x1
     feb:	e8 10 2a 00 00       	call   3a00 <printf>
    return;
     ff0:	83 c4 10             	add    $0x10,%esp
}
     ff3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff6:	5b                   	pop    %ebx
     ff7:	5e                   	pop    %esi
     ff8:	5f                   	pop    %edi
     ff9:	5d                   	pop    %ebp
     ffa:	c3                   	ret    
    exit();
     ffb:	e8 a3 28 00 00       	call   38a3 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1000:	53                   	push   %ebx
    1001:	52                   	push   %edx
    1002:	68 79 41 00 00       	push   $0x4179
    1007:	6a 01                	push   $0x1
    1009:	e8 f2 29 00 00       	call   3a00 <printf>
    exit();
    100e:	e8 90 28 00 00       	call   38a3 <exit>
    1013:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001020 <fourfiles>:
{
    1020:	55                   	push   %ebp
    1021:	89 e5                	mov    %esp,%ebp
    1023:	57                   	push   %edi
    1024:	56                   	push   %esi
  printf(1, "fourfiles test\n");
    1025:	be 8e 41 00 00       	mov    $0x418e,%esi
{
    102a:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    102b:	31 db                	xor    %ebx,%ebx
{
    102d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1030:	c7 45 d8 8e 41 00 00 	movl   $0x418e,-0x28(%ebp)
  printf(1, "fourfiles test\n");
    1037:	68 94 41 00 00       	push   $0x4194
    103c:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    103e:	c7 45 dc d7 42 00 00 	movl   $0x42d7,-0x24(%ebp)
    1045:	c7 45 e0 db 42 00 00 	movl   $0x42db,-0x20(%ebp)
    104c:	c7 45 e4 91 41 00 00 	movl   $0x4191,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1053:	e8 a8 29 00 00       	call   3a00 <printf>
    1058:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    105b:	83 ec 0c             	sub    $0xc,%esp
    105e:	56                   	push   %esi
    105f:	e8 8f 28 00 00       	call   38f3 <unlink>
    pid = fork();
    1064:	e8 32 28 00 00       	call   389b <fork>
    if(pid < 0){
    1069:	83 c4 10             	add    $0x10,%esp
    106c:	85 c0                	test   %eax,%eax
    106e:	0f 88 64 01 00 00    	js     11d8 <fourfiles+0x1b8>
    if(pid == 0){
    1074:	0f 84 e9 00 00 00    	je     1163 <fourfiles+0x143>
  for(pi = 0; pi < 4; pi++){
    107a:	83 c3 01             	add    $0x1,%ebx
    107d:	83 fb 04             	cmp    $0x4,%ebx
    1080:	74 06                	je     1088 <fourfiles+0x68>
    fname = names[pi];
    1082:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1086:	eb d3                	jmp    105b <fourfiles+0x3b>
    wait();
    1088:	e8 1e 28 00 00       	call   38ab <wait>
  for(i = 0; i < 2; i++){
    108d:	31 f6                	xor    %esi,%esi
    wait();
    108f:	e8 17 28 00 00       	call   38ab <wait>
    1094:	e8 12 28 00 00       	call   38ab <wait>
    1099:	e8 0d 28 00 00       	call   38ab <wait>
    fname = names[i];
    109e:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    fd = open(fname, 0);
    10a2:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    10a5:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    10a7:	6a 00                	push   $0x0
    10a9:	50                   	push   %eax
    fname = names[i];
    10aa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    fd = open(fname, 0);
    10ad:	e8 31 28 00 00       	call   38e3 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b2:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    10b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bf:	90                   	nop
    10c0:	83 ec 04             	sub    $0x4,%esp
    10c3:	68 00 20 00 00       	push   $0x2000
    10c8:	68 20 85 00 00       	push   $0x8520
    10cd:	ff 75 d4             	push   -0x2c(%ebp)
    10d0:	e8 e6 27 00 00       	call   38bb <read>
    10d5:	83 c4 10             	add    $0x10,%esp
    10d8:	89 c7                	mov    %eax,%edi
    10da:	85 c0                	test   %eax,%eax
    10dc:	7e 20                	jle    10fe <fourfiles+0xde>
      for(j = 0; j < n; j++){
    10de:	31 c0                	xor    %eax,%eax
        if(buf[j] != '0'+i){
    10e0:	83 fe 01             	cmp    $0x1,%esi
    10e3:	0f be 88 20 85 00 00 	movsbl 0x8520(%eax),%ecx
    10ea:	19 d2                	sbb    %edx,%edx
    10ec:	83 c2 31             	add    $0x31,%edx
    10ef:	39 d1                	cmp    %edx,%ecx
    10f1:	75 5c                	jne    114f <fourfiles+0x12f>
      for(j = 0; j < n; j++){
    10f3:	83 c0 01             	add    $0x1,%eax
    10f6:	39 c7                	cmp    %eax,%edi
    10f8:	75 e6                	jne    10e0 <fourfiles+0xc0>
      total += n;
    10fa:	01 fb                	add    %edi,%ebx
    10fc:	eb c2                	jmp    10c0 <fourfiles+0xa0>
    close(fd);
    10fe:	83 ec 0c             	sub    $0xc,%esp
    1101:	ff 75 d4             	push   -0x2c(%ebp)
    1104:	e8 c2 27 00 00       	call   38cb <close>
    if(total != 12*500){
    1109:	83 c4 10             	add    $0x10,%esp
    110c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1112:	0f 85 d4 00 00 00    	jne    11ec <fourfiles+0x1cc>
    unlink(fname);
    1118:	83 ec 0c             	sub    $0xc,%esp
    111b:	ff 75 d0             	push   -0x30(%ebp)
    111e:	e8 d0 27 00 00       	call   38f3 <unlink>
  for(i = 0; i < 2; i++){
    1123:	83 c4 10             	add    $0x10,%esp
    1126:	83 fe 01             	cmp    $0x1,%esi
    1129:	75 1a                	jne    1145 <fourfiles+0x125>
  printf(1, "fourfiles ok\n");
    112b:	83 ec 08             	sub    $0x8,%esp
    112e:	68 d2 41 00 00       	push   $0x41d2
    1133:	6a 01                	push   $0x1
    1135:	e8 c6 28 00 00       	call   3a00 <printf>
}
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1140:	5b                   	pop    %ebx
    1141:	5e                   	pop    %esi
    1142:	5f                   	pop    %edi
    1143:	5d                   	pop    %ebp
    1144:	c3                   	ret    
    1145:	be 01 00 00 00       	mov    $0x1,%esi
    114a:	e9 4f ff ff ff       	jmp    109e <fourfiles+0x7e>
          printf(1, "wrong char\n");
    114f:	83 ec 08             	sub    $0x8,%esp
    1152:	68 b5 41 00 00       	push   $0x41b5
    1157:	6a 01                	push   $0x1
    1159:	e8 a2 28 00 00       	call   3a00 <printf>
          exit();
    115e:	e8 40 27 00 00       	call   38a3 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    1163:	83 ec 08             	sub    $0x8,%esp
    1166:	68 02 02 00 00       	push   $0x202
    116b:	56                   	push   %esi
    116c:	e8 72 27 00 00       	call   38e3 <open>
      if(fd < 0){
    1171:	83 c4 10             	add    $0x10,%esp
      fd = open(fname, O_CREATE | O_RDWR);
    1174:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1176:	85 c0                	test   %eax,%eax
    1178:	78 45                	js     11bf <fourfiles+0x19f>
      memset(buf, '0'+pi, 512);
    117a:	83 ec 04             	sub    $0x4,%esp
    117d:	83 c3 30             	add    $0x30,%ebx
    1180:	68 00 02 00 00       	push   $0x200
    1185:	53                   	push   %ebx
    1186:	bb 0c 00 00 00       	mov    $0xc,%ebx
    118b:	68 20 85 00 00       	push   $0x8520
    1190:	e8 7b 25 00 00       	call   3710 <memset>
    1195:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    1198:	83 ec 04             	sub    $0x4,%esp
    119b:	68 f4 01 00 00       	push   $0x1f4
    11a0:	68 20 85 00 00       	push   $0x8520
    11a5:	56                   	push   %esi
    11a6:	e8 18 27 00 00       	call   38c3 <write>
    11ab:	83 c4 10             	add    $0x10,%esp
    11ae:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11b3:	75 4a                	jne    11ff <fourfiles+0x1df>
      for(i = 0; i < 12; i++){
    11b5:	83 eb 01             	sub    $0x1,%ebx
    11b8:	75 de                	jne    1198 <fourfiles+0x178>
      exit();
    11ba:	e8 e4 26 00 00       	call   38a3 <exit>
        printf(1, "create failed\n");
    11bf:	51                   	push   %ecx
    11c0:	51                   	push   %ecx
    11c1:	68 2f 44 00 00       	push   $0x442f
    11c6:	6a 01                	push   $0x1
    11c8:	e8 33 28 00 00       	call   3a00 <printf>
        exit();
    11cd:	e8 d1 26 00 00       	call   38a3 <exit>
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
    11d8:	83 ec 08             	sub    $0x8,%esp
    11db:	68 69 4c 00 00       	push   $0x4c69
    11e0:	6a 01                	push   $0x1
    11e2:	e8 19 28 00 00       	call   3a00 <printf>
      exit();
    11e7:	e8 b7 26 00 00       	call   38a3 <exit>
      printf(1, "wrong length %d\n", total);
    11ec:	50                   	push   %eax
    11ed:	53                   	push   %ebx
    11ee:	68 c1 41 00 00       	push   $0x41c1
    11f3:	6a 01                	push   $0x1
    11f5:	e8 06 28 00 00       	call   3a00 <printf>
      exit();
    11fa:	e8 a4 26 00 00       	call   38a3 <exit>
          printf(1, "write failed %d\n", n);
    11ff:	52                   	push   %edx
    1200:	50                   	push   %eax
    1201:	68 a4 41 00 00       	push   $0x41a4
    1206:	6a 01                	push   $0x1
    1208:	e8 f3 27 00 00       	call   3a00 <printf>
          exit();
    120d:	e8 91 26 00 00       	call   38a3 <exit>
    1212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001220 <createdelete>:
{
    1220:	55                   	push   %ebp
    1221:	89 e5                	mov    %esp,%ebp
    1223:	57                   	push   %edi
    1224:	56                   	push   %esi
    1225:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1226:	31 db                	xor    %ebx,%ebx
{
    1228:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    122b:	68 e0 41 00 00       	push   $0x41e0
    1230:	6a 01                	push   $0x1
    1232:	e8 c9 27 00 00       	call   3a00 <printf>
    1237:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    123a:	e8 5c 26 00 00       	call   389b <fork>
    if(pid < 0){
    123f:	85 c0                	test   %eax,%eax
    1241:	0f 88 c3 01 00 00    	js     140a <createdelete+0x1ea>
    if(pid == 0){
    1247:	0f 84 13 01 00 00    	je     1360 <createdelete+0x140>
  for(pi = 0; pi < 4; pi++){
    124d:	83 c3 01             	add    $0x1,%ebx
    1250:	83 fb 04             	cmp    $0x4,%ebx
    1253:	75 e5                	jne    123a <createdelete+0x1a>
    wait();
    1255:	e8 51 26 00 00       	call   38ab <wait>
  for(i = 0; i < N; i++){
    125a:	31 f6                	xor    %esi,%esi
    125c:	8d 7d c8             	lea    -0x38(%ebp),%edi
    wait();
    125f:	e8 47 26 00 00       	call   38ab <wait>
    1264:	e8 42 26 00 00       	call   38ab <wait>
    1269:	e8 3d 26 00 00       	call   38ab <wait>
  name[0] = name[1] = name[2] = 0;
    126e:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    1272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if((i == 0 || i >= N/2) && fd < 0){
    1278:	85 f6                	test   %esi,%esi
    127a:	8d 46 30             	lea    0x30(%esi),%eax
    127d:	0f 94 c3             	sete   %bl
    1280:	83 fe 09             	cmp    $0x9,%esi
    1283:	88 45 c7             	mov    %al,-0x39(%ebp)
    1286:	0f 9f c0             	setg   %al
    1289:	09 c3                	or     %eax,%ebx
      } else if((i >= 1 && i < N/2) && fd >= 0){
    128b:	8d 46 ff             	lea    -0x1(%esi),%eax
    128e:	89 45 c0             	mov    %eax,-0x40(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1291:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    1294:	bb 70 00 00 00       	mov    $0x70,%ebx
      fd = open(name, 0);
    1299:	83 ec 08             	sub    $0x8,%esp
      name[1] = '0' + i;
    129c:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      name[0] = 'p' + pi;
    12a0:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    12a3:	6a 00                	push   $0x0
    12a5:	57                   	push   %edi
      name[1] = '0' + i;
    12a6:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    12a9:	e8 35 26 00 00       	call   38e3 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    12ae:	83 c4 10             	add    $0x10,%esp
    12b1:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    12b5:	0f 84 85 00 00 00    	je     1340 <createdelete+0x120>
    12bb:	85 c0                	test   %eax,%eax
    12bd:	0f 88 32 01 00 00    	js     13f5 <createdelete+0x1d5>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12c3:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12c7:	76 7b                	jbe    1344 <createdelete+0x124>
        close(fd);
    12c9:	83 ec 0c             	sub    $0xc,%esp
    12cc:	50                   	push   %eax
    12cd:	e8 f9 25 00 00       	call   38cb <close>
    12d2:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    12d5:	83 c3 01             	add    $0x1,%ebx
    12d8:	80 fb 74             	cmp    $0x74,%bl
    12db:	75 bc                	jne    1299 <createdelete+0x79>
  for(i = 0; i < N; i++){
    12dd:	83 c6 01             	add    $0x1,%esi
    12e0:	83 fe 14             	cmp    $0x14,%esi
    12e3:	75 93                	jne    1278 <createdelete+0x58>
    12e5:	be 70 00 00 00       	mov    $0x70,%esi
    12ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(pi = 0; pi < 4; pi++){
    12f0:	8d 46 c0             	lea    -0x40(%esi),%eax
      name[0] = 'p' + i;
    12f3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12f8:	88 45 c7             	mov    %al,-0x39(%ebp)
      unlink(name);
    12fb:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    12fe:	89 f0                	mov    %esi,%eax
      unlink(name);
    1300:	57                   	push   %edi
      name[0] = 'p' + i;
    1301:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1304:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1308:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    130b:	e8 e3 25 00 00       	call   38f3 <unlink>
    for(pi = 0; pi < 4; pi++){
    1310:	83 c4 10             	add    $0x10,%esp
    1313:	83 eb 01             	sub    $0x1,%ebx
    1316:	75 e3                	jne    12fb <createdelete+0xdb>
  for(i = 0; i < N; i++){
    1318:	83 c6 01             	add    $0x1,%esi
    131b:	89 f0                	mov    %esi,%eax
    131d:	3c 84                	cmp    $0x84,%al
    131f:	75 cf                	jne    12f0 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    1321:	83 ec 08             	sub    $0x8,%esp
    1324:	68 f3 41 00 00       	push   $0x41f3
    1329:	6a 01                	push   $0x1
    132b:	e8 d0 26 00 00       	call   3a00 <printf>
}
    1330:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1333:	5b                   	pop    %ebx
    1334:	5e                   	pop    %esi
    1335:	5f                   	pop    %edi
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    133f:	90                   	nop
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1340:	85 c0                	test   %eax,%eax
    1342:	78 91                	js     12d5 <createdelete+0xb5>
        printf(1, "oops createdelete %s did exist\n", name);
    1344:	50                   	push   %eax
    1345:	57                   	push   %edi
    1346:	68 c4 4e 00 00       	push   $0x4ec4
    134b:	6a 01                	push   $0x1
    134d:	e8 ae 26 00 00       	call   3a00 <printf>
        exit();
    1352:	e8 4c 25 00 00       	call   38a3 <exit>
    1357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    135e:	66 90                	xchg   %ax,%ax
      name[0] = 'p' + pi;
    1360:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    1363:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1367:	be 01 00 00 00       	mov    $0x1,%esi
    136c:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    136f:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1372:	31 db                	xor    %ebx,%ebx
    1374:	eb 15                	jmp    138b <createdelete+0x16b>
    1376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    137d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < N; i++){
    1380:	83 fe 14             	cmp    $0x14,%esi
    1383:	74 6b                	je     13f0 <createdelete+0x1d0>
    1385:	83 c3 01             	add    $0x1,%ebx
    1388:	83 c6 01             	add    $0x1,%esi
        fd = open(name, O_CREATE | O_RDWR);
    138b:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    138e:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    1391:	68 02 02 00 00       	push   $0x202
    1396:	57                   	push   %edi
        name[1] = '0' + i;
    1397:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    139a:	e8 44 25 00 00       	call   38e3 <open>
        if(fd < 0){
    139f:	83 c4 10             	add    $0x10,%esp
    13a2:	85 c0                	test   %eax,%eax
    13a4:	78 78                	js     141e <createdelete+0x1fe>
        close(fd);
    13a6:	83 ec 0c             	sub    $0xc,%esp
    13a9:	50                   	push   %eax
    13aa:	e8 1c 25 00 00       	call   38cb <close>
        if(i > 0 && (i % 2 ) == 0){
    13af:	83 c4 10             	add    $0x10,%esp
    13b2:	85 db                	test   %ebx,%ebx
    13b4:	74 cf                	je     1385 <createdelete+0x165>
    13b6:	f6 c3 01             	test   $0x1,%bl
    13b9:	75 c5                	jne    1380 <createdelete+0x160>
          if(unlink(name) < 0){
    13bb:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    13be:	89 d8                	mov    %ebx,%eax
          if(unlink(name) < 0){
    13c0:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    13c1:	d1 f8                	sar    %eax
    13c3:	83 c0 30             	add    $0x30,%eax
    13c6:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    13c9:	e8 25 25 00 00       	call   38f3 <unlink>
    13ce:	83 c4 10             	add    $0x10,%esp
    13d1:	85 c0                	test   %eax,%eax
    13d3:	79 ab                	jns    1380 <createdelete+0x160>
            printf(1, "unlink failed\n");
    13d5:	52                   	push   %edx
    13d6:	52                   	push   %edx
    13d7:	68 e1 3d 00 00       	push   $0x3de1
    13dc:	6a 01                	push   $0x1
    13de:	e8 1d 26 00 00       	call   3a00 <printf>
            exit();
    13e3:	e8 bb 24 00 00       	call   38a3 <exit>
    13e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ef:	90                   	nop
      exit();
    13f0:	e8 ae 24 00 00       	call   38a3 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    13f5:	83 ec 04             	sub    $0x4,%esp
    13f8:	57                   	push   %edi
    13f9:	68 a0 4e 00 00       	push   $0x4ea0
    13fe:	6a 01                	push   $0x1
    1400:	e8 fb 25 00 00       	call   3a00 <printf>
        exit();
    1405:	e8 99 24 00 00       	call   38a3 <exit>
      printf(1, "fork failed\n");
    140a:	83 ec 08             	sub    $0x8,%esp
    140d:	68 69 4c 00 00       	push   $0x4c69
    1412:	6a 01                	push   $0x1
    1414:	e8 e7 25 00 00       	call   3a00 <printf>
      exit();
    1419:	e8 85 24 00 00       	call   38a3 <exit>
          printf(1, "create failed\n");
    141e:	83 ec 08             	sub    $0x8,%esp
    1421:	68 2f 44 00 00       	push   $0x442f
    1426:	6a 01                	push   $0x1
    1428:	e8 d3 25 00 00       	call   3a00 <printf>
          exit();
    142d:	e8 71 24 00 00       	call   38a3 <exit>
    1432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001440 <unlinkread>:
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	56                   	push   %esi
    1444:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1445:	83 ec 08             	sub    $0x8,%esp
    1448:	68 04 42 00 00       	push   $0x4204
    144d:	6a 01                	push   $0x1
    144f:	e8 ac 25 00 00       	call   3a00 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1454:	5b                   	pop    %ebx
    1455:	5e                   	pop    %esi
    1456:	68 02 02 00 00       	push   $0x202
    145b:	68 15 42 00 00       	push   $0x4215
    1460:	e8 7e 24 00 00       	call   38e3 <open>
  if(fd < 0){
    1465:	83 c4 10             	add    $0x10,%esp
    1468:	85 c0                	test   %eax,%eax
    146a:	0f 88 e6 00 00 00    	js     1556 <unlinkread+0x116>
  write(fd, "hello", 5);
    1470:	83 ec 04             	sub    $0x4,%esp
    1473:	89 c3                	mov    %eax,%ebx
    1475:	6a 05                	push   $0x5
    1477:	68 3a 42 00 00       	push   $0x423a
    147c:	50                   	push   %eax
    147d:	e8 41 24 00 00       	call   38c3 <write>
  close(fd);
    1482:	89 1c 24             	mov    %ebx,(%esp)
    1485:	e8 41 24 00 00       	call   38cb <close>
  fd = open("unlinkread", O_RDWR);
    148a:	58                   	pop    %eax
    148b:	5a                   	pop    %edx
    148c:	6a 02                	push   $0x2
    148e:	68 15 42 00 00       	push   $0x4215
    1493:	e8 4b 24 00 00       	call   38e3 <open>
  if(fd < 0){
    1498:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_RDWR);
    149b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    149d:	85 c0                	test   %eax,%eax
    149f:	0f 88 10 01 00 00    	js     15b5 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    14a5:	83 ec 0c             	sub    $0xc,%esp
    14a8:	68 15 42 00 00       	push   $0x4215
    14ad:	e8 41 24 00 00       	call   38f3 <unlink>
    14b2:	83 c4 10             	add    $0x10,%esp
    14b5:	85 c0                	test   %eax,%eax
    14b7:	0f 85 e5 00 00 00    	jne    15a2 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14bd:	83 ec 08             	sub    $0x8,%esp
    14c0:	68 02 02 00 00       	push   $0x202
    14c5:	68 15 42 00 00       	push   $0x4215
    14ca:	e8 14 24 00 00       	call   38e3 <open>
  write(fd1, "yyy", 3);
    14cf:	83 c4 0c             	add    $0xc,%esp
    14d2:	6a 03                	push   $0x3
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14d4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14d6:	68 72 42 00 00       	push   $0x4272
    14db:	50                   	push   %eax
    14dc:	e8 e2 23 00 00       	call   38c3 <write>
  close(fd1);
    14e1:	89 34 24             	mov    %esi,(%esp)
    14e4:	e8 e2 23 00 00       	call   38cb <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14e9:	83 c4 0c             	add    $0xc,%esp
    14ec:	68 00 20 00 00       	push   $0x2000
    14f1:	68 20 85 00 00       	push   $0x8520
    14f6:	53                   	push   %ebx
    14f7:	e8 bf 23 00 00       	call   38bb <read>
    14fc:	83 c4 10             	add    $0x10,%esp
    14ff:	83 f8 05             	cmp    $0x5,%eax
    1502:	0f 85 87 00 00 00    	jne    158f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    1508:	80 3d 20 85 00 00 68 	cmpb   $0x68,0x8520
    150f:	75 6b                	jne    157c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    1511:	83 ec 04             	sub    $0x4,%esp
    1514:	6a 0a                	push   $0xa
    1516:	68 20 85 00 00       	push   $0x8520
    151b:	53                   	push   %ebx
    151c:	e8 a2 23 00 00       	call   38c3 <write>
    1521:	83 c4 10             	add    $0x10,%esp
    1524:	83 f8 0a             	cmp    $0xa,%eax
    1527:	75 40                	jne    1569 <unlinkread+0x129>
  close(fd);
    1529:	83 ec 0c             	sub    $0xc,%esp
    152c:	53                   	push   %ebx
    152d:	e8 99 23 00 00       	call   38cb <close>
  unlink("unlinkread");
    1532:	c7 04 24 15 42 00 00 	movl   $0x4215,(%esp)
    1539:	e8 b5 23 00 00       	call   38f3 <unlink>
  printf(1, "unlinkread ok\n");
    153e:	58                   	pop    %eax
    153f:	5a                   	pop    %edx
    1540:	68 bd 42 00 00       	push   $0x42bd
    1545:	6a 01                	push   $0x1
    1547:	e8 b4 24 00 00       	call   3a00 <printf>
}
    154c:	83 c4 10             	add    $0x10,%esp
    154f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1552:	5b                   	pop    %ebx
    1553:	5e                   	pop    %esi
    1554:	5d                   	pop    %ebp
    1555:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1556:	51                   	push   %ecx
    1557:	51                   	push   %ecx
    1558:	68 20 42 00 00       	push   $0x4220
    155d:	6a 01                	push   $0x1
    155f:	e8 9c 24 00 00       	call   3a00 <printf>
    exit();
    1564:	e8 3a 23 00 00       	call   38a3 <exit>
    printf(1, "unlinkread write failed\n");
    1569:	51                   	push   %ecx
    156a:	51                   	push   %ecx
    156b:	68 a4 42 00 00       	push   $0x42a4
    1570:	6a 01                	push   $0x1
    1572:	e8 89 24 00 00       	call   3a00 <printf>
    exit();
    1577:	e8 27 23 00 00       	call   38a3 <exit>
    printf(1, "unlinkread wrong data\n");
    157c:	53                   	push   %ebx
    157d:	53                   	push   %ebx
    157e:	68 8d 42 00 00       	push   $0x428d
    1583:	6a 01                	push   $0x1
    1585:	e8 76 24 00 00       	call   3a00 <printf>
    exit();
    158a:	e8 14 23 00 00       	call   38a3 <exit>
    printf(1, "unlinkread read failed");
    158f:	56                   	push   %esi
    1590:	56                   	push   %esi
    1591:	68 76 42 00 00       	push   $0x4276
    1596:	6a 01                	push   $0x1
    1598:	e8 63 24 00 00       	call   3a00 <printf>
    exit();
    159d:	e8 01 23 00 00       	call   38a3 <exit>
    printf(1, "unlink unlinkread failed\n");
    15a2:	50                   	push   %eax
    15a3:	50                   	push   %eax
    15a4:	68 58 42 00 00       	push   $0x4258
    15a9:	6a 01                	push   $0x1
    15ab:	e8 50 24 00 00       	call   3a00 <printf>
    exit();
    15b0:	e8 ee 22 00 00       	call   38a3 <exit>
    printf(1, "open unlinkread failed\n");
    15b5:	50                   	push   %eax
    15b6:	50                   	push   %eax
    15b7:	68 40 42 00 00       	push   $0x4240
    15bc:	6a 01                	push   $0x1
    15be:	e8 3d 24 00 00       	call   3a00 <printf>
    exit();
    15c3:	e8 db 22 00 00       	call   38a3 <exit>
    15c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    15cf:	90                   	nop

000015d0 <linktest>:
{
    15d0:	55                   	push   %ebp
    15d1:	89 e5                	mov    %esp,%ebp
    15d3:	53                   	push   %ebx
    15d4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15d7:	68 cc 42 00 00       	push   $0x42cc
    15dc:	6a 01                	push   $0x1
    15de:	e8 1d 24 00 00       	call   3a00 <printf>
  unlink("lf1");
    15e3:	c7 04 24 d6 42 00 00 	movl   $0x42d6,(%esp)
    15ea:	e8 04 23 00 00       	call   38f3 <unlink>
  unlink("lf2");
    15ef:	c7 04 24 da 42 00 00 	movl   $0x42da,(%esp)
    15f6:	e8 f8 22 00 00       	call   38f3 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15fb:	58                   	pop    %eax
    15fc:	5a                   	pop    %edx
    15fd:	68 02 02 00 00       	push   $0x202
    1602:	68 d6 42 00 00       	push   $0x42d6
    1607:	e8 d7 22 00 00       	call   38e3 <open>
  if(fd < 0){
    160c:	83 c4 10             	add    $0x10,%esp
    160f:	85 c0                	test   %eax,%eax
    1611:	0f 88 1e 01 00 00    	js     1735 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    1617:	83 ec 04             	sub    $0x4,%esp
    161a:	89 c3                	mov    %eax,%ebx
    161c:	6a 05                	push   $0x5
    161e:	68 3a 42 00 00       	push   $0x423a
    1623:	50                   	push   %eax
    1624:	e8 9a 22 00 00       	call   38c3 <write>
    1629:	83 c4 10             	add    $0x10,%esp
    162c:	83 f8 05             	cmp    $0x5,%eax
    162f:	0f 85 98 01 00 00    	jne    17cd <linktest+0x1fd>
  close(fd);
    1635:	83 ec 0c             	sub    $0xc,%esp
    1638:	53                   	push   %ebx
    1639:	e8 8d 22 00 00       	call   38cb <close>
  if(link("lf1", "lf2") < 0){
    163e:	5b                   	pop    %ebx
    163f:	58                   	pop    %eax
    1640:	68 da 42 00 00       	push   $0x42da
    1645:	68 d6 42 00 00       	push   $0x42d6
    164a:	e8 b4 22 00 00       	call   3903 <link>
    164f:	83 c4 10             	add    $0x10,%esp
    1652:	85 c0                	test   %eax,%eax
    1654:	0f 88 60 01 00 00    	js     17ba <linktest+0x1ea>
  unlink("lf1");
    165a:	83 ec 0c             	sub    $0xc,%esp
    165d:	68 d6 42 00 00       	push   $0x42d6
    1662:	e8 8c 22 00 00       	call   38f3 <unlink>
  if(open("lf1", 0) >= 0){
    1667:	58                   	pop    %eax
    1668:	5a                   	pop    %edx
    1669:	6a 00                	push   $0x0
    166b:	68 d6 42 00 00       	push   $0x42d6
    1670:	e8 6e 22 00 00       	call   38e3 <open>
    1675:	83 c4 10             	add    $0x10,%esp
    1678:	85 c0                	test   %eax,%eax
    167a:	0f 89 27 01 00 00    	jns    17a7 <linktest+0x1d7>
  fd = open("lf2", 0);
    1680:	83 ec 08             	sub    $0x8,%esp
    1683:	6a 00                	push   $0x0
    1685:	68 da 42 00 00       	push   $0x42da
    168a:	e8 54 22 00 00       	call   38e3 <open>
  if(fd < 0){
    168f:	83 c4 10             	add    $0x10,%esp
  fd = open("lf2", 0);
    1692:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1694:	85 c0                	test   %eax,%eax
    1696:	0f 88 f8 00 00 00    	js     1794 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    169c:	83 ec 04             	sub    $0x4,%esp
    169f:	68 00 20 00 00       	push   $0x2000
    16a4:	68 20 85 00 00       	push   $0x8520
    16a9:	50                   	push   %eax
    16aa:	e8 0c 22 00 00       	call   38bb <read>
    16af:	83 c4 10             	add    $0x10,%esp
    16b2:	83 f8 05             	cmp    $0x5,%eax
    16b5:	0f 85 c6 00 00 00    	jne    1781 <linktest+0x1b1>
  close(fd);
    16bb:	83 ec 0c             	sub    $0xc,%esp
    16be:	53                   	push   %ebx
    16bf:	e8 07 22 00 00       	call   38cb <close>
  if(link("lf2", "lf2") >= 0){
    16c4:	58                   	pop    %eax
    16c5:	5a                   	pop    %edx
    16c6:	68 da 42 00 00       	push   $0x42da
    16cb:	68 da 42 00 00       	push   $0x42da
    16d0:	e8 2e 22 00 00       	call   3903 <link>
    16d5:	83 c4 10             	add    $0x10,%esp
    16d8:	85 c0                	test   %eax,%eax
    16da:	0f 89 8e 00 00 00    	jns    176e <linktest+0x19e>
  unlink("lf2");
    16e0:	83 ec 0c             	sub    $0xc,%esp
    16e3:	68 da 42 00 00       	push   $0x42da
    16e8:	e8 06 22 00 00       	call   38f3 <unlink>
  if(link("lf2", "lf1") >= 0){
    16ed:	59                   	pop    %ecx
    16ee:	5b                   	pop    %ebx
    16ef:	68 d6 42 00 00       	push   $0x42d6
    16f4:	68 da 42 00 00       	push   $0x42da
    16f9:	e8 05 22 00 00       	call   3903 <link>
    16fe:	83 c4 10             	add    $0x10,%esp
    1701:	85 c0                	test   %eax,%eax
    1703:	79 56                	jns    175b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    1705:	83 ec 08             	sub    $0x8,%esp
    1708:	68 d6 42 00 00       	push   $0x42d6
    170d:	68 9e 45 00 00       	push   $0x459e
    1712:	e8 ec 21 00 00       	call   3903 <link>
    1717:	83 c4 10             	add    $0x10,%esp
    171a:	85 c0                	test   %eax,%eax
    171c:	79 2a                	jns    1748 <linktest+0x178>
  printf(1, "linktest ok\n");
    171e:	83 ec 08             	sub    $0x8,%esp
    1721:	68 74 43 00 00       	push   $0x4374
    1726:	6a 01                	push   $0x1
    1728:	e8 d3 22 00 00       	call   3a00 <printf>
}
    172d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1730:	83 c4 10             	add    $0x10,%esp
    1733:	c9                   	leave  
    1734:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1735:	50                   	push   %eax
    1736:	50                   	push   %eax
    1737:	68 de 42 00 00       	push   $0x42de
    173c:	6a 01                	push   $0x1
    173e:	e8 bd 22 00 00       	call   3a00 <printf>
    exit();
    1743:	e8 5b 21 00 00       	call   38a3 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1748:	50                   	push   %eax
    1749:	50                   	push   %eax
    174a:	68 58 43 00 00       	push   $0x4358
    174f:	6a 01                	push   $0x1
    1751:	e8 aa 22 00 00       	call   3a00 <printf>
    exit();
    1756:	e8 48 21 00 00       	call   38a3 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    175b:	52                   	push   %edx
    175c:	52                   	push   %edx
    175d:	68 0c 4f 00 00       	push   $0x4f0c
    1762:	6a 01                	push   $0x1
    1764:	e8 97 22 00 00       	call   3a00 <printf>
    exit();
    1769:	e8 35 21 00 00       	call   38a3 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    176e:	50                   	push   %eax
    176f:	50                   	push   %eax
    1770:	68 3a 43 00 00       	push   $0x433a
    1775:	6a 01                	push   $0x1
    1777:	e8 84 22 00 00       	call   3a00 <printf>
    exit();
    177c:	e8 22 21 00 00       	call   38a3 <exit>
    printf(1, "read lf2 failed\n");
    1781:	51                   	push   %ecx
    1782:	51                   	push   %ecx
    1783:	68 29 43 00 00       	push   $0x4329
    1788:	6a 01                	push   $0x1
    178a:	e8 71 22 00 00       	call   3a00 <printf>
    exit();
    178f:	e8 0f 21 00 00       	call   38a3 <exit>
    printf(1, "open lf2 failed\n");
    1794:	53                   	push   %ebx
    1795:	53                   	push   %ebx
    1796:	68 18 43 00 00       	push   $0x4318
    179b:	6a 01                	push   $0x1
    179d:	e8 5e 22 00 00       	call   3a00 <printf>
    exit();
    17a2:	e8 fc 20 00 00       	call   38a3 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    17a7:	50                   	push   %eax
    17a8:	50                   	push   %eax
    17a9:	68 e4 4e 00 00       	push   $0x4ee4
    17ae:	6a 01                	push   $0x1
    17b0:	e8 4b 22 00 00       	call   3a00 <printf>
    exit();
    17b5:	e8 e9 20 00 00       	call   38a3 <exit>
    printf(1, "link lf1 lf2 failed\n");
    17ba:	51                   	push   %ecx
    17bb:	51                   	push   %ecx
    17bc:	68 03 43 00 00       	push   $0x4303
    17c1:	6a 01                	push   $0x1
    17c3:	e8 38 22 00 00       	call   3a00 <printf>
    exit();
    17c8:	e8 d6 20 00 00       	call   38a3 <exit>
    printf(1, "write lf1 failed\n");
    17cd:	50                   	push   %eax
    17ce:	50                   	push   %eax
    17cf:	68 f1 42 00 00       	push   $0x42f1
    17d4:	6a 01                	push   $0x1
    17d6:	e8 25 22 00 00       	call   3a00 <printf>
    exit();
    17db:	e8 c3 20 00 00       	call   38a3 <exit>

000017e0 <concreate>:
{
    17e0:	55                   	push   %ebp
    17e1:	89 e5                	mov    %esp,%ebp
    17e3:	57                   	push   %edi
    17e4:	56                   	push   %esi
  for(i = 0; i < 40; i++){
    17e5:	31 f6                	xor    %esi,%esi
{
    17e7:	53                   	push   %ebx
    17e8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    17eb:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17ee:	68 81 43 00 00       	push   $0x4381
    17f3:	6a 01                	push   $0x1
    17f5:	e8 06 22 00 00       	call   3a00 <printf>
  file[0] = 'C';
    17fa:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17fe:	83 c4 10             	add    $0x10,%esp
    1801:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    1805:	eb 4c                	jmp    1853 <concreate+0x73>
    1807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    180e:	66 90                	xchg   %ax,%ax
    1810:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    if(pid && (i % 3) == 1){
    1816:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    181b:	0f 83 af 00 00 00    	jae    18d0 <concreate+0xf0>
      fd = open(file, O_CREATE | O_RDWR);
    1821:	83 ec 08             	sub    $0x8,%esp
    1824:	68 02 02 00 00       	push   $0x202
    1829:	53                   	push   %ebx
    182a:	e8 b4 20 00 00       	call   38e3 <open>
      if(fd < 0){
    182f:	83 c4 10             	add    $0x10,%esp
    1832:	85 c0                	test   %eax,%eax
    1834:	78 5f                	js     1895 <concreate+0xb5>
      close(fd);
    1836:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    1839:	83 c6 01             	add    $0x1,%esi
      close(fd);
    183c:	50                   	push   %eax
    183d:	e8 89 20 00 00       	call   38cb <close>
    1842:	83 c4 10             	add    $0x10,%esp
      wait();
    1845:	e8 61 20 00 00       	call   38ab <wait>
  for(i = 0; i < 40; i++){
    184a:	83 fe 28             	cmp    $0x28,%esi
    184d:	0f 84 9f 00 00 00    	je     18f2 <concreate+0x112>
    unlink(file);
    1853:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    1856:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    1859:	53                   	push   %ebx
    file[1] = '0' + i;
    185a:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    185d:	e8 91 20 00 00       	call   38f3 <unlink>
    pid = fork();
    1862:	e8 34 20 00 00       	call   389b <fork>
    if(pid && (i % 3) == 1){
    1867:	83 c4 10             	add    $0x10,%esp
    186a:	85 c0                	test   %eax,%eax
    186c:	75 a2                	jne    1810 <concreate+0x30>
      link("C0", file);
    186e:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    } else if(pid == 0 && (i % 5) == 1){
    1874:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    187a:	73 34                	jae    18b0 <concreate+0xd0>
      fd = open(file, O_CREATE | O_RDWR);
    187c:	83 ec 08             	sub    $0x8,%esp
    187f:	68 02 02 00 00       	push   $0x202
    1884:	53                   	push   %ebx
    1885:	e8 59 20 00 00       	call   38e3 <open>
      if(fd < 0){
    188a:	83 c4 10             	add    $0x10,%esp
    188d:	85 c0                	test   %eax,%eax
    188f:	0f 89 39 02 00 00    	jns    1ace <concreate+0x2ee>
        printf(1, "concreate create %s failed\n", file);
    1895:	83 ec 04             	sub    $0x4,%esp
    1898:	53                   	push   %ebx
    1899:	68 94 43 00 00       	push   $0x4394
    189e:	6a 01                	push   $0x1
    18a0:	e8 5b 21 00 00       	call   3a00 <printf>
        exit();
    18a5:	e8 f9 1f 00 00       	call   38a3 <exit>
    18aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("C0", file);
    18b0:	83 ec 08             	sub    $0x8,%esp
    18b3:	53                   	push   %ebx
    18b4:	68 91 43 00 00       	push   $0x4391
    18b9:	e8 45 20 00 00       	call   3903 <link>
    18be:	83 c4 10             	add    $0x10,%esp
      exit();
    18c1:	e8 dd 1f 00 00       	call   38a3 <exit>
    18c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18cd:	8d 76 00             	lea    0x0(%esi),%esi
      link("C0", file);
    18d0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18d3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18d6:	53                   	push   %ebx
    18d7:	68 91 43 00 00       	push   $0x4391
    18dc:	e8 22 20 00 00       	call   3903 <link>
    18e1:	83 c4 10             	add    $0x10,%esp
      wait();
    18e4:	e8 c2 1f 00 00       	call   38ab <wait>
  for(i = 0; i < 40; i++){
    18e9:	83 fe 28             	cmp    $0x28,%esi
    18ec:	0f 85 61 ff ff ff    	jne    1853 <concreate+0x73>
  memset(fa, 0, sizeof(fa));
    18f2:	83 ec 04             	sub    $0x4,%esp
    18f5:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18f8:	6a 28                	push   $0x28
    18fa:	6a 00                	push   $0x0
    18fc:	50                   	push   %eax
    18fd:	e8 0e 1e 00 00       	call   3710 <memset>
  fd = open(".", 0);
    1902:	5e                   	pop    %esi
    1903:	5f                   	pop    %edi
    1904:	6a 00                	push   $0x0
    1906:	68 9e 45 00 00       	push   $0x459e
    190b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    190e:	e8 d0 1f 00 00       	call   38e3 <open>
  n = 0;
    1913:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    191a:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    191d:	89 c6                	mov    %eax,%esi
  while(read(fd, &de, sizeof(de)) > 0){
    191f:	90                   	nop
    1920:	83 ec 04             	sub    $0x4,%esp
    1923:	6a 10                	push   $0x10
    1925:	57                   	push   %edi
    1926:	56                   	push   %esi
    1927:	e8 8f 1f 00 00       	call   38bb <read>
    192c:	83 c4 10             	add    $0x10,%esp
    192f:	85 c0                	test   %eax,%eax
    1931:	7e 3d                	jle    1970 <concreate+0x190>
    if(de.inum == 0)
    1933:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1938:	74 e6                	je     1920 <concreate+0x140>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    193a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    193e:	75 e0                	jne    1920 <concreate+0x140>
    1940:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1944:	75 da                	jne    1920 <concreate+0x140>
      i = de.name[1] - '0';
    1946:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    194a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    194d:	83 f8 27             	cmp    $0x27,%eax
    1950:	0f 87 60 01 00 00    	ja     1ab6 <concreate+0x2d6>
      if(fa[i]){
    1956:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    195b:	0f 85 3d 01 00 00    	jne    1a9e <concreate+0x2be>
      n++;
    1961:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
      fa[i] = 1;
    1965:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    196a:	eb b4                	jmp    1920 <concreate+0x140>
    196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1970:	83 ec 0c             	sub    $0xc,%esp
    1973:	56                   	push   %esi
    1974:	e8 52 1f 00 00       	call   38cb <close>
  if(n != 40){
    1979:	83 c4 10             	add    $0x10,%esp
    197c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1980:	0f 85 05 01 00 00    	jne    1a8b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1986:	31 f6                	xor    %esi,%esi
    1988:	eb 4c                	jmp    19d6 <concreate+0x1f6>
    198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    1990:	85 ff                	test   %edi,%edi
    1992:	74 05                	je     1999 <concreate+0x1b9>
    1994:	83 f8 01             	cmp    $0x1,%eax
    1997:	74 6c                	je     1a05 <concreate+0x225>
      unlink(file);
    1999:	83 ec 0c             	sub    $0xc,%esp
    199c:	53                   	push   %ebx
    199d:	e8 51 1f 00 00       	call   38f3 <unlink>
      unlink(file);
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 49 1f 00 00       	call   38f3 <unlink>
      unlink(file);
    19aa:	89 1c 24             	mov    %ebx,(%esp)
    19ad:	e8 41 1f 00 00       	call   38f3 <unlink>
      unlink(file);
    19b2:	89 1c 24             	mov    %ebx,(%esp)
    19b5:	e8 39 1f 00 00       	call   38f3 <unlink>
    19ba:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19bd:	85 ff                	test   %edi,%edi
    19bf:	0f 84 fc fe ff ff    	je     18c1 <concreate+0xe1>
      wait();
    19c5:	e8 e1 1e 00 00       	call   38ab <wait>
  for(i = 0; i < 40; i++){
    19ca:	83 c6 01             	add    $0x1,%esi
    19cd:	83 fe 28             	cmp    $0x28,%esi
    19d0:	0f 84 8a 00 00 00    	je     1a60 <concreate+0x280>
    file[1] = '0' + i;
    19d6:	8d 46 30             	lea    0x30(%esi),%eax
    19d9:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19dc:	e8 ba 1e 00 00       	call   389b <fork>
    19e1:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19e3:	85 c0                	test   %eax,%eax
    19e5:	0f 88 8c 00 00 00    	js     1a77 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19eb:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19f0:	f7 e6                	mul    %esi
    19f2:	89 d0                	mov    %edx,%eax
    19f4:	83 e2 fe             	and    $0xfffffffe,%edx
    19f7:	d1 e8                	shr    %eax
    19f9:	01 c2                	add    %eax,%edx
    19fb:	89 f0                	mov    %esi,%eax
    19fd:	29 d0                	sub    %edx,%eax
    19ff:	89 c1                	mov    %eax,%ecx
    1a01:	09 f9                	or     %edi,%ecx
    1a03:	75 8b                	jne    1990 <concreate+0x1b0>
      close(open(file, 0));
    1a05:	83 ec 08             	sub    $0x8,%esp
    1a08:	6a 00                	push   $0x0
    1a0a:	53                   	push   %ebx
    1a0b:	e8 d3 1e 00 00       	call   38e3 <open>
    1a10:	89 04 24             	mov    %eax,(%esp)
    1a13:	e8 b3 1e 00 00       	call   38cb <close>
      close(open(file, 0));
    1a18:	58                   	pop    %eax
    1a19:	5a                   	pop    %edx
    1a1a:	6a 00                	push   $0x0
    1a1c:	53                   	push   %ebx
    1a1d:	e8 c1 1e 00 00       	call   38e3 <open>
    1a22:	89 04 24             	mov    %eax,(%esp)
    1a25:	e8 a1 1e 00 00       	call   38cb <close>
      close(open(file, 0));
    1a2a:	59                   	pop    %ecx
    1a2b:	58                   	pop    %eax
    1a2c:	6a 00                	push   $0x0
    1a2e:	53                   	push   %ebx
    1a2f:	e8 af 1e 00 00       	call   38e3 <open>
    1a34:	89 04 24             	mov    %eax,(%esp)
    1a37:	e8 8f 1e 00 00       	call   38cb <close>
      close(open(file, 0));
    1a3c:	58                   	pop    %eax
    1a3d:	5a                   	pop    %edx
    1a3e:	6a 00                	push   $0x0
    1a40:	53                   	push   %ebx
    1a41:	e8 9d 1e 00 00       	call   38e3 <open>
    1a46:	89 04 24             	mov    %eax,(%esp)
    1a49:	e8 7d 1e 00 00       	call   38cb <close>
    1a4e:	83 c4 10             	add    $0x10,%esp
    1a51:	e9 67 ff ff ff       	jmp    19bd <concreate+0x1dd>
    1a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1a5d:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "concreate ok\n");
    1a60:	83 ec 08             	sub    $0x8,%esp
    1a63:	68 e6 43 00 00       	push   $0x43e6
    1a68:	6a 01                	push   $0x1
    1a6a:	e8 91 1f 00 00       	call   3a00 <printf>
}
    1a6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a72:	5b                   	pop    %ebx
    1a73:	5e                   	pop    %esi
    1a74:	5f                   	pop    %edi
    1a75:	5d                   	pop    %ebp
    1a76:	c3                   	ret    
      printf(1, "fork failed\n");
    1a77:	83 ec 08             	sub    $0x8,%esp
    1a7a:	68 69 4c 00 00       	push   $0x4c69
    1a7f:	6a 01                	push   $0x1
    1a81:	e8 7a 1f 00 00       	call   3a00 <printf>
      exit();
    1a86:	e8 18 1e 00 00       	call   38a3 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a8b:	51                   	push   %ecx
    1a8c:	51                   	push   %ecx
    1a8d:	68 30 4f 00 00       	push   $0x4f30
    1a92:	6a 01                	push   $0x1
    1a94:	e8 67 1f 00 00       	call   3a00 <printf>
    exit();
    1a99:	e8 05 1e 00 00       	call   38a3 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a9e:	83 ec 04             	sub    $0x4,%esp
    1aa1:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1aa4:	50                   	push   %eax
    1aa5:	68 c9 43 00 00       	push   $0x43c9
    1aaa:	6a 01                	push   $0x1
    1aac:	e8 4f 1f 00 00       	call   3a00 <printf>
        exit();
    1ab1:	e8 ed 1d 00 00       	call   38a3 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1ab6:	83 ec 04             	sub    $0x4,%esp
    1ab9:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1abc:	50                   	push   %eax
    1abd:	68 b0 43 00 00       	push   $0x43b0
    1ac2:	6a 01                	push   $0x1
    1ac4:	e8 37 1f 00 00       	call   3a00 <printf>
        exit();
    1ac9:	e8 d5 1d 00 00       	call   38a3 <exit>
      close(fd);
    1ace:	83 ec 0c             	sub    $0xc,%esp
    1ad1:	50                   	push   %eax
    1ad2:	e8 f4 1d 00 00       	call   38cb <close>
    1ad7:	83 c4 10             	add    $0x10,%esp
    1ada:	e9 e2 fd ff ff       	jmp    18c1 <concreate+0xe1>
    1adf:	90                   	nop

00001ae0 <linkunlink>:
{
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    1ae3:	57                   	push   %edi
    1ae4:	56                   	push   %esi
    1ae5:	53                   	push   %ebx
    1ae6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1ae9:	68 f4 43 00 00       	push   $0x43f4
    1aee:	6a 01                	push   $0x1
    1af0:	e8 0b 1f 00 00       	call   3a00 <printf>
  unlink("x");
    1af5:	c7 04 24 81 46 00 00 	movl   $0x4681,(%esp)
    1afc:	e8 f2 1d 00 00       	call   38f3 <unlink>
  pid = fork();
    1b01:	e8 95 1d 00 00       	call   389b <fork>
  if(pid < 0){
    1b06:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1b09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b0c:	85 c0                	test   %eax,%eax
    1b0e:	0f 88 b6 00 00 00    	js     1bca <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1b14:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b18:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1b1d:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b22:	19 ff                	sbb    %edi,%edi
    1b24:	83 e7 60             	and    $0x60,%edi
    1b27:	83 c7 01             	add    $0x1,%edi
    1b2a:	eb 1e                	jmp    1b4a <linkunlink+0x6a>
    1b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b30:	83 f8 01             	cmp    $0x1,%eax
    1b33:	74 7b                	je     1bb0 <linkunlink+0xd0>
      unlink("x");
    1b35:	83 ec 0c             	sub    $0xc,%esp
    1b38:	68 81 46 00 00       	push   $0x4681
    1b3d:	e8 b1 1d 00 00       	call   38f3 <unlink>
    1b42:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b45:	83 eb 01             	sub    $0x1,%ebx
    1b48:	74 41                	je     1b8b <linkunlink+0xab>
    x = x * 1103515245 + 12345;
    1b4a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b50:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b56:	89 f8                	mov    %edi,%eax
    1b58:	f7 e6                	mul    %esi
    1b5a:	89 d0                	mov    %edx,%eax
    1b5c:	83 e2 fe             	and    $0xfffffffe,%edx
    1b5f:	d1 e8                	shr    %eax
    1b61:	01 c2                	add    %eax,%edx
    1b63:	89 f8                	mov    %edi,%eax
    1b65:	29 d0                	sub    %edx,%eax
    1b67:	75 c7                	jne    1b30 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b69:	83 ec 08             	sub    $0x8,%esp
    1b6c:	68 02 02 00 00       	push   $0x202
    1b71:	68 81 46 00 00       	push   $0x4681
    1b76:	e8 68 1d 00 00       	call   38e3 <open>
    1b7b:	89 04 24             	mov    %eax,(%esp)
    1b7e:	e8 48 1d 00 00       	call   38cb <close>
    1b83:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b86:	83 eb 01             	sub    $0x1,%ebx
    1b89:	75 bf                	jne    1b4a <linkunlink+0x6a>
  if(pid)
    1b8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b8e:	85 c0                	test   %eax,%eax
    1b90:	74 4b                	je     1bdd <linkunlink+0xfd>
    wait();
    1b92:	e8 14 1d 00 00       	call   38ab <wait>
  printf(1, "linkunlink ok\n");
    1b97:	83 ec 08             	sub    $0x8,%esp
    1b9a:	68 09 44 00 00       	push   $0x4409
    1b9f:	6a 01                	push   $0x1
    1ba1:	e8 5a 1e 00 00       	call   3a00 <printf>
}
    1ba6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ba9:	5b                   	pop    %ebx
    1baa:	5e                   	pop    %esi
    1bab:	5f                   	pop    %edi
    1bac:	5d                   	pop    %ebp
    1bad:	c3                   	ret    
    1bae:	66 90                	xchg   %ax,%ax
      link("cat", "x");
    1bb0:	83 ec 08             	sub    $0x8,%esp
    1bb3:	68 81 46 00 00       	push   $0x4681
    1bb8:	68 05 44 00 00       	push   $0x4405
    1bbd:	e8 41 1d 00 00       	call   3903 <link>
    1bc2:	83 c4 10             	add    $0x10,%esp
    1bc5:	e9 7b ff ff ff       	jmp    1b45 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1bca:	52                   	push   %edx
    1bcb:	52                   	push   %edx
    1bcc:	68 69 4c 00 00       	push   $0x4c69
    1bd1:	6a 01                	push   $0x1
    1bd3:	e8 28 1e 00 00       	call   3a00 <printf>
    exit();
    1bd8:	e8 c6 1c 00 00       	call   38a3 <exit>
    exit();
    1bdd:	e8 c1 1c 00 00       	call   38a3 <exit>
    1be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001bf0 <bigdir>:
{
    1bf0:	55                   	push   %ebp
    1bf1:	89 e5                	mov    %esp,%ebp
    1bf3:	57                   	push   %edi
    1bf4:	56                   	push   %esi
    1bf5:	53                   	push   %ebx
    1bf6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1bf9:	68 18 44 00 00       	push   $0x4418
    1bfe:	6a 01                	push   $0x1
    1c00:	e8 fb 1d 00 00       	call   3a00 <printf>
  unlink("bd");
    1c05:	c7 04 24 25 44 00 00 	movl   $0x4425,(%esp)
    1c0c:	e8 e2 1c 00 00       	call   38f3 <unlink>
  fd = open("bd", O_CREATE);
    1c11:	5a                   	pop    %edx
    1c12:	59                   	pop    %ecx
    1c13:	68 00 02 00 00       	push   $0x200
    1c18:	68 25 44 00 00       	push   $0x4425
    1c1d:	e8 c1 1c 00 00       	call   38e3 <open>
  if(fd < 0){
    1c22:	83 c4 10             	add    $0x10,%esp
    1c25:	85 c0                	test   %eax,%eax
    1c27:	0f 88 de 00 00 00    	js     1d0b <bigdir+0x11b>
  close(fd);
    1c2d:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 500; i++){
    1c30:	31 f6                	xor    %esi,%esi
    1c32:	8d 7d de             	lea    -0x22(%ebp),%edi
  close(fd);
    1c35:	50                   	push   %eax
    1c36:	e8 90 1c 00 00       	call   38cb <close>
    1c3b:	83 c4 10             	add    $0x10,%esp
    1c3e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c40:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c42:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c45:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c49:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c4c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c4d:	83 c0 30             	add    $0x30,%eax
    if(link("bd", name) != 0){
    1c50:	68 25 44 00 00       	push   $0x4425
    name[1] = '0' + (i / 64);
    1c55:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c58:	89 f0                	mov    %esi,%eax
    1c5a:	83 e0 3f             	and    $0x3f,%eax
    name[3] = '\0';
    1c5d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[2] = '0' + (i % 64);
    1c61:	83 c0 30             	add    $0x30,%eax
    1c64:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c67:	e8 97 1c 00 00       	call   3903 <link>
    1c6c:	83 c4 10             	add    $0x10,%esp
    1c6f:	89 c3                	mov    %eax,%ebx
    1c71:	85 c0                	test   %eax,%eax
    1c73:	75 6e                	jne    1ce3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c75:	83 c6 01             	add    $0x1,%esi
    1c78:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c7e:	75 c0                	jne    1c40 <bigdir+0x50>
  unlink("bd");
    1c80:	83 ec 0c             	sub    $0xc,%esp
    1c83:	68 25 44 00 00       	push   $0x4425
    1c88:	e8 66 1c 00 00       	call   38f3 <unlink>
    1c8d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1c90:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c92:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c95:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c99:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1c9c:	57                   	push   %edi
    name[1] = '0' + (i / 64);
    1c9d:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1ca0:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1ca4:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1ca7:	89 d8                	mov    %ebx,%eax
    1ca9:	83 e0 3f             	and    $0x3f,%eax
    1cac:	83 c0 30             	add    $0x30,%eax
    1caf:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1cb2:	e8 3c 1c 00 00       	call   38f3 <unlink>
    1cb7:	83 c4 10             	add    $0x10,%esp
    1cba:	85 c0                	test   %eax,%eax
    1cbc:	75 39                	jne    1cf7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1cbe:	83 c3 01             	add    $0x1,%ebx
    1cc1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cc7:	75 c7                	jne    1c90 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1cc9:	83 ec 08             	sub    $0x8,%esp
    1ccc:	68 67 44 00 00       	push   $0x4467
    1cd1:	6a 01                	push   $0x1
    1cd3:	e8 28 1d 00 00       	call   3a00 <printf>
    1cd8:	83 c4 10             	add    $0x10,%esp
}
    1cdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cde:	5b                   	pop    %ebx
    1cdf:	5e                   	pop    %esi
    1ce0:	5f                   	pop    %edi
    1ce1:	5d                   	pop    %ebp
    1ce2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1ce3:	83 ec 08             	sub    $0x8,%esp
    1ce6:	68 3e 44 00 00       	push   $0x443e
    1ceb:	6a 01                	push   $0x1
    1ced:	e8 0e 1d 00 00       	call   3a00 <printf>
      exit();
    1cf2:	e8 ac 1b 00 00       	call   38a3 <exit>
      printf(1, "bigdir unlink failed");
    1cf7:	83 ec 08             	sub    $0x8,%esp
    1cfa:	68 52 44 00 00       	push   $0x4452
    1cff:	6a 01                	push   $0x1
    1d01:	e8 fa 1c 00 00       	call   3a00 <printf>
      exit();
    1d06:	e8 98 1b 00 00       	call   38a3 <exit>
    printf(1, "bigdir create failed\n");
    1d0b:	50                   	push   %eax
    1d0c:	50                   	push   %eax
    1d0d:	68 28 44 00 00       	push   $0x4428
    1d12:	6a 01                	push   $0x1
    1d14:	e8 e7 1c 00 00       	call   3a00 <printf>
    exit();
    1d19:	e8 85 1b 00 00       	call   38a3 <exit>
    1d1e:	66 90                	xchg   %ax,%ax

00001d20 <subdir>:
{
    1d20:	55                   	push   %ebp
    1d21:	89 e5                	mov    %esp,%ebp
    1d23:	53                   	push   %ebx
    1d24:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d27:	68 72 44 00 00       	push   $0x4472
    1d2c:	6a 01                	push   $0x1
    1d2e:	e8 cd 1c 00 00       	call   3a00 <printf>
  unlink("ff");
    1d33:	c7 04 24 fb 44 00 00 	movl   $0x44fb,(%esp)
    1d3a:	e8 b4 1b 00 00       	call   38f3 <unlink>
  if(mkdir("dd") != 0){
    1d3f:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d46:	e8 c0 1b 00 00       	call   390b <mkdir>
    1d4b:	83 c4 10             	add    $0x10,%esp
    1d4e:	85 c0                	test   %eax,%eax
    1d50:	0f 85 b3 05 00 00    	jne    2309 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d56:	83 ec 08             	sub    $0x8,%esp
    1d59:	68 02 02 00 00       	push   $0x202
    1d5e:	68 d1 44 00 00       	push   $0x44d1
    1d63:	e8 7b 1b 00 00       	call   38e3 <open>
  if(fd < 0){
    1d68:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d6b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d6d:	85 c0                	test   %eax,%eax
    1d6f:	0f 88 81 05 00 00    	js     22f6 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d75:	83 ec 04             	sub    $0x4,%esp
    1d78:	6a 02                	push   $0x2
    1d7a:	68 fb 44 00 00       	push   $0x44fb
    1d7f:	50                   	push   %eax
    1d80:	e8 3e 1b 00 00       	call   38c3 <write>
  close(fd);
    1d85:	89 1c 24             	mov    %ebx,(%esp)
    1d88:	e8 3e 1b 00 00       	call   38cb <close>
  if(unlink("dd") >= 0){
    1d8d:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d94:	e8 5a 1b 00 00       	call   38f3 <unlink>
    1d99:	83 c4 10             	add    $0x10,%esp
    1d9c:	85 c0                	test   %eax,%eax
    1d9e:	0f 89 3f 05 00 00    	jns    22e3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1da4:	83 ec 0c             	sub    $0xc,%esp
    1da7:	68 ac 44 00 00       	push   $0x44ac
    1dac:	e8 5a 1b 00 00       	call   390b <mkdir>
    1db1:	83 c4 10             	add    $0x10,%esp
    1db4:	85 c0                	test   %eax,%eax
    1db6:	0f 85 14 05 00 00    	jne    22d0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dbc:	83 ec 08             	sub    $0x8,%esp
    1dbf:	68 02 02 00 00       	push   $0x202
    1dc4:	68 ce 44 00 00       	push   $0x44ce
    1dc9:	e8 15 1b 00 00       	call   38e3 <open>
  if(fd < 0){
    1dce:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dd1:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dd3:	85 c0                	test   %eax,%eax
    1dd5:	0f 88 24 04 00 00    	js     21ff <subdir+0x4df>
  write(fd, "FF", 2);
    1ddb:	83 ec 04             	sub    $0x4,%esp
    1dde:	6a 02                	push   $0x2
    1de0:	68 ef 44 00 00       	push   $0x44ef
    1de5:	50                   	push   %eax
    1de6:	e8 d8 1a 00 00       	call   38c3 <write>
  close(fd);
    1deb:	89 1c 24             	mov    %ebx,(%esp)
    1dee:	e8 d8 1a 00 00       	call   38cb <close>
  fd = open("dd/dd/../ff", 0);
    1df3:	58                   	pop    %eax
    1df4:	5a                   	pop    %edx
    1df5:	6a 00                	push   $0x0
    1df7:	68 f2 44 00 00       	push   $0x44f2
    1dfc:	e8 e2 1a 00 00       	call   38e3 <open>
  if(fd < 0){
    1e01:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/../ff", 0);
    1e04:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e06:	85 c0                	test   %eax,%eax
    1e08:	0f 88 de 03 00 00    	js     21ec <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1e0e:	83 ec 04             	sub    $0x4,%esp
    1e11:	68 00 20 00 00       	push   $0x2000
    1e16:	68 20 85 00 00       	push   $0x8520
    1e1b:	50                   	push   %eax
    1e1c:	e8 9a 1a 00 00       	call   38bb <read>
  if(cc != 2 || buf[0] != 'f'){
    1e21:	83 c4 10             	add    $0x10,%esp
    1e24:	83 f8 02             	cmp    $0x2,%eax
    1e27:	0f 85 3a 03 00 00    	jne    2167 <subdir+0x447>
    1e2d:	80 3d 20 85 00 00 66 	cmpb   $0x66,0x8520
    1e34:	0f 85 2d 03 00 00    	jne    2167 <subdir+0x447>
  close(fd);
    1e3a:	83 ec 0c             	sub    $0xc,%esp
    1e3d:	53                   	push   %ebx
    1e3e:	e8 88 1a 00 00       	call   38cb <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e43:	59                   	pop    %ecx
    1e44:	5b                   	pop    %ebx
    1e45:	68 32 45 00 00       	push   $0x4532
    1e4a:	68 ce 44 00 00       	push   $0x44ce
    1e4f:	e8 af 1a 00 00       	call   3903 <link>
    1e54:	83 c4 10             	add    $0x10,%esp
    1e57:	85 c0                	test   %eax,%eax
    1e59:	0f 85 c6 03 00 00    	jne    2225 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e5f:	83 ec 0c             	sub    $0xc,%esp
    1e62:	68 ce 44 00 00       	push   $0x44ce
    1e67:	e8 87 1a 00 00       	call   38f3 <unlink>
    1e6c:	83 c4 10             	add    $0x10,%esp
    1e6f:	85 c0                	test   %eax,%eax
    1e71:	0f 85 16 03 00 00    	jne    218d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e77:	83 ec 08             	sub    $0x8,%esp
    1e7a:	6a 00                	push   $0x0
    1e7c:	68 ce 44 00 00       	push   $0x44ce
    1e81:	e8 5d 1a 00 00       	call   38e3 <open>
    1e86:	83 c4 10             	add    $0x10,%esp
    1e89:	85 c0                	test   %eax,%eax
    1e8b:	0f 89 2c 04 00 00    	jns    22bd <subdir+0x59d>
  if(chdir("dd") != 0){
    1e91:	83 ec 0c             	sub    $0xc,%esp
    1e94:	68 98 45 00 00       	push   $0x4598
    1e99:	e8 75 1a 00 00       	call   3913 <chdir>
    1e9e:	83 c4 10             	add    $0x10,%esp
    1ea1:	85 c0                	test   %eax,%eax
    1ea3:	0f 85 01 04 00 00    	jne    22aa <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1ea9:	83 ec 0c             	sub    $0xc,%esp
    1eac:	68 66 45 00 00       	push   $0x4566
    1eb1:	e8 5d 1a 00 00       	call   3913 <chdir>
    1eb6:	83 c4 10             	add    $0x10,%esp
    1eb9:	85 c0                	test   %eax,%eax
    1ebb:	0f 85 b9 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ec1:	83 ec 0c             	sub    $0xc,%esp
    1ec4:	68 8c 45 00 00       	push   $0x458c
    1ec9:	e8 45 1a 00 00       	call   3913 <chdir>
    1ece:	83 c4 10             	add    $0x10,%esp
    1ed1:	85 c0                	test   %eax,%eax
    1ed3:	0f 85 a1 02 00 00    	jne    217a <subdir+0x45a>
  if(chdir("./..") != 0){
    1ed9:	83 ec 0c             	sub    $0xc,%esp
    1edc:	68 9b 45 00 00       	push   $0x459b
    1ee1:	e8 2d 1a 00 00       	call   3913 <chdir>
    1ee6:	83 c4 10             	add    $0x10,%esp
    1ee9:	85 c0                	test   %eax,%eax
    1eeb:	0f 85 21 03 00 00    	jne    2212 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ef1:	83 ec 08             	sub    $0x8,%esp
    1ef4:	6a 00                	push   $0x0
    1ef6:	68 32 45 00 00       	push   $0x4532
    1efb:	e8 e3 19 00 00       	call   38e3 <open>
  if(fd < 0){
    1f00:	83 c4 10             	add    $0x10,%esp
  fd = open("dd/dd/ffff", 0);
    1f03:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f05:	85 c0                	test   %eax,%eax
    1f07:	0f 88 e0 04 00 00    	js     23ed <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1f0d:	83 ec 04             	sub    $0x4,%esp
    1f10:	68 00 20 00 00       	push   $0x2000
    1f15:	68 20 85 00 00       	push   $0x8520
    1f1a:	50                   	push   %eax
    1f1b:	e8 9b 19 00 00       	call   38bb <read>
    1f20:	83 c4 10             	add    $0x10,%esp
    1f23:	83 f8 02             	cmp    $0x2,%eax
    1f26:	0f 85 ae 04 00 00    	jne    23da <subdir+0x6ba>
  close(fd);
    1f2c:	83 ec 0c             	sub    $0xc,%esp
    1f2f:	53                   	push   %ebx
    1f30:	e8 96 19 00 00       	call   38cb <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f35:	58                   	pop    %eax
    1f36:	5a                   	pop    %edx
    1f37:	6a 00                	push   $0x0
    1f39:	68 ce 44 00 00       	push   $0x44ce
    1f3e:	e8 a0 19 00 00       	call   38e3 <open>
    1f43:	83 c4 10             	add    $0x10,%esp
    1f46:	85 c0                	test   %eax,%eax
    1f48:	0f 89 65 02 00 00    	jns    21b3 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f4e:	83 ec 08             	sub    $0x8,%esp
    1f51:	68 02 02 00 00       	push   $0x202
    1f56:	68 e6 45 00 00       	push   $0x45e6
    1f5b:	e8 83 19 00 00       	call   38e3 <open>
    1f60:	83 c4 10             	add    $0x10,%esp
    1f63:	85 c0                	test   %eax,%eax
    1f65:	0f 89 35 02 00 00    	jns    21a0 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f6b:	83 ec 08             	sub    $0x8,%esp
    1f6e:	68 02 02 00 00       	push   $0x202
    1f73:	68 0b 46 00 00       	push   $0x460b
    1f78:	e8 66 19 00 00       	call   38e3 <open>
    1f7d:	83 c4 10             	add    $0x10,%esp
    1f80:	85 c0                	test   %eax,%eax
    1f82:	0f 89 0f 03 00 00    	jns    2297 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f88:	83 ec 08             	sub    $0x8,%esp
    1f8b:	68 00 02 00 00       	push   $0x200
    1f90:	68 98 45 00 00       	push   $0x4598
    1f95:	e8 49 19 00 00       	call   38e3 <open>
    1f9a:	83 c4 10             	add    $0x10,%esp
    1f9d:	85 c0                	test   %eax,%eax
    1f9f:	0f 89 df 02 00 00    	jns    2284 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1fa5:	83 ec 08             	sub    $0x8,%esp
    1fa8:	6a 02                	push   $0x2
    1faa:	68 98 45 00 00       	push   $0x4598
    1faf:	e8 2f 19 00 00       	call   38e3 <open>
    1fb4:	83 c4 10             	add    $0x10,%esp
    1fb7:	85 c0                	test   %eax,%eax
    1fb9:	0f 89 b2 02 00 00    	jns    2271 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1fbf:	83 ec 08             	sub    $0x8,%esp
    1fc2:	6a 01                	push   $0x1
    1fc4:	68 98 45 00 00       	push   $0x4598
    1fc9:	e8 15 19 00 00       	call   38e3 <open>
    1fce:	83 c4 10             	add    $0x10,%esp
    1fd1:	85 c0                	test   %eax,%eax
    1fd3:	0f 89 85 02 00 00    	jns    225e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fd9:	83 ec 08             	sub    $0x8,%esp
    1fdc:	68 7a 46 00 00       	push   $0x467a
    1fe1:	68 e6 45 00 00       	push   $0x45e6
    1fe6:	e8 18 19 00 00       	call   3903 <link>
    1feb:	83 c4 10             	add    $0x10,%esp
    1fee:	85 c0                	test   %eax,%eax
    1ff0:	0f 84 55 02 00 00    	je     224b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1ff6:	83 ec 08             	sub    $0x8,%esp
    1ff9:	68 7a 46 00 00       	push   $0x467a
    1ffe:	68 0b 46 00 00       	push   $0x460b
    2003:	e8 fb 18 00 00       	call   3903 <link>
    2008:	83 c4 10             	add    $0x10,%esp
    200b:	85 c0                	test   %eax,%eax
    200d:	0f 84 25 02 00 00    	je     2238 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2013:	83 ec 08             	sub    $0x8,%esp
    2016:	68 32 45 00 00       	push   $0x4532
    201b:	68 d1 44 00 00       	push   $0x44d1
    2020:	e8 de 18 00 00       	call   3903 <link>
    2025:	83 c4 10             	add    $0x10,%esp
    2028:	85 c0                	test   %eax,%eax
    202a:	0f 84 a9 01 00 00    	je     21d9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2030:	83 ec 0c             	sub    $0xc,%esp
    2033:	68 e6 45 00 00       	push   $0x45e6
    2038:	e8 ce 18 00 00       	call   390b <mkdir>
    203d:	83 c4 10             	add    $0x10,%esp
    2040:	85 c0                	test   %eax,%eax
    2042:	0f 84 7e 01 00 00    	je     21c6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2048:	83 ec 0c             	sub    $0xc,%esp
    204b:	68 0b 46 00 00       	push   $0x460b
    2050:	e8 b6 18 00 00       	call   390b <mkdir>
    2055:	83 c4 10             	add    $0x10,%esp
    2058:	85 c0                	test   %eax,%eax
    205a:	0f 84 67 03 00 00    	je     23c7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2060:	83 ec 0c             	sub    $0xc,%esp
    2063:	68 32 45 00 00       	push   $0x4532
    2068:	e8 9e 18 00 00       	call   390b <mkdir>
    206d:	83 c4 10             	add    $0x10,%esp
    2070:	85 c0                	test   %eax,%eax
    2072:	0f 84 3c 03 00 00    	je     23b4 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2078:	83 ec 0c             	sub    $0xc,%esp
    207b:	68 0b 46 00 00       	push   $0x460b
    2080:	e8 6e 18 00 00       	call   38f3 <unlink>
    2085:	83 c4 10             	add    $0x10,%esp
    2088:	85 c0                	test   %eax,%eax
    208a:	0f 84 11 03 00 00    	je     23a1 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2090:	83 ec 0c             	sub    $0xc,%esp
    2093:	68 e6 45 00 00       	push   $0x45e6
    2098:	e8 56 18 00 00       	call   38f3 <unlink>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	85 c0                	test   %eax,%eax
    20a2:	0f 84 e6 02 00 00    	je     238e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    20a8:	83 ec 0c             	sub    $0xc,%esp
    20ab:	68 d1 44 00 00       	push   $0x44d1
    20b0:	e8 5e 18 00 00       	call   3913 <chdir>
    20b5:	83 c4 10             	add    $0x10,%esp
    20b8:	85 c0                	test   %eax,%eax
    20ba:	0f 84 bb 02 00 00    	je     237b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20c0:	83 ec 0c             	sub    $0xc,%esp
    20c3:	68 7d 46 00 00       	push   $0x467d
    20c8:	e8 46 18 00 00       	call   3913 <chdir>
    20cd:	83 c4 10             	add    $0x10,%esp
    20d0:	85 c0                	test   %eax,%eax
    20d2:	0f 84 90 02 00 00    	je     2368 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20d8:	83 ec 0c             	sub    $0xc,%esp
    20db:	68 32 45 00 00       	push   $0x4532
    20e0:	e8 0e 18 00 00       	call   38f3 <unlink>
    20e5:	83 c4 10             	add    $0x10,%esp
    20e8:	85 c0                	test   %eax,%eax
    20ea:	0f 85 9d 00 00 00    	jne    218d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20f0:	83 ec 0c             	sub    $0xc,%esp
    20f3:	68 d1 44 00 00       	push   $0x44d1
    20f8:	e8 f6 17 00 00       	call   38f3 <unlink>
    20fd:	83 c4 10             	add    $0x10,%esp
    2100:	85 c0                	test   %eax,%eax
    2102:	0f 85 4d 02 00 00    	jne    2355 <subdir+0x635>
  if(unlink("dd") == 0){
    2108:	83 ec 0c             	sub    $0xc,%esp
    210b:	68 98 45 00 00       	push   $0x4598
    2110:	e8 de 17 00 00       	call   38f3 <unlink>
    2115:	83 c4 10             	add    $0x10,%esp
    2118:	85 c0                	test   %eax,%eax
    211a:	0f 84 22 02 00 00    	je     2342 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2120:	83 ec 0c             	sub    $0xc,%esp
    2123:	68 ad 44 00 00       	push   $0x44ad
    2128:	e8 c6 17 00 00       	call   38f3 <unlink>
    212d:	83 c4 10             	add    $0x10,%esp
    2130:	85 c0                	test   %eax,%eax
    2132:	0f 88 f7 01 00 00    	js     232f <subdir+0x60f>
  if(unlink("dd") < 0){
    2138:	83 ec 0c             	sub    $0xc,%esp
    213b:	68 98 45 00 00       	push   $0x4598
    2140:	e8 ae 17 00 00       	call   38f3 <unlink>
    2145:	83 c4 10             	add    $0x10,%esp
    2148:	85 c0                	test   %eax,%eax
    214a:	0f 88 cc 01 00 00    	js     231c <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2150:	83 ec 08             	sub    $0x8,%esp
    2153:	68 7a 47 00 00       	push   $0x477a
    2158:	6a 01                	push   $0x1
    215a:	e8 a1 18 00 00       	call   3a00 <printf>
}
    215f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2162:	83 c4 10             	add    $0x10,%esp
    2165:	c9                   	leave  
    2166:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2167:	50                   	push   %eax
    2168:	50                   	push   %eax
    2169:	68 17 45 00 00       	push   $0x4517
    216e:	6a 01                	push   $0x1
    2170:	e8 8b 18 00 00       	call   3a00 <printf>
    exit();
    2175:	e8 29 17 00 00       	call   38a3 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    217a:	50                   	push   %eax
    217b:	50                   	push   %eax
    217c:	68 72 45 00 00       	push   $0x4572
    2181:	6a 01                	push   $0x1
    2183:	e8 78 18 00 00       	call   3a00 <printf>
    exit();
    2188:	e8 16 17 00 00       	call   38a3 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    218d:	50                   	push   %eax
    218e:	50                   	push   %eax
    218f:	68 3d 45 00 00       	push   $0x453d
    2194:	6a 01                	push   $0x1
    2196:	e8 65 18 00 00       	call   3a00 <printf>
    exit();
    219b:	e8 03 17 00 00       	call   38a3 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    21a0:	51                   	push   %ecx
    21a1:	51                   	push   %ecx
    21a2:	68 ef 45 00 00       	push   $0x45ef
    21a7:	6a 01                	push   $0x1
    21a9:	e8 52 18 00 00       	call   3a00 <printf>
    exit();
    21ae:	e8 f0 16 00 00       	call   38a3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21b3:	53                   	push   %ebx
    21b4:	53                   	push   %ebx
    21b5:	68 d4 4f 00 00       	push   $0x4fd4
    21ba:	6a 01                	push   $0x1
    21bc:	e8 3f 18 00 00       	call   3a00 <printf>
    exit();
    21c1:	e8 dd 16 00 00       	call   38a3 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21c6:	51                   	push   %ecx
    21c7:	51                   	push   %ecx
    21c8:	68 83 46 00 00       	push   $0x4683
    21cd:	6a 01                	push   $0x1
    21cf:	e8 2c 18 00 00       	call   3a00 <printf>
    exit();
    21d4:	e8 ca 16 00 00       	call   38a3 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21d9:	53                   	push   %ebx
    21da:	53                   	push   %ebx
    21db:	68 44 50 00 00       	push   $0x5044
    21e0:	6a 01                	push   $0x1
    21e2:	e8 19 18 00 00       	call   3a00 <printf>
    exit();
    21e7:	e8 b7 16 00 00       	call   38a3 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21ec:	50                   	push   %eax
    21ed:	50                   	push   %eax
    21ee:	68 fe 44 00 00       	push   $0x44fe
    21f3:	6a 01                	push   $0x1
    21f5:	e8 06 18 00 00       	call   3a00 <printf>
    exit();
    21fa:	e8 a4 16 00 00       	call   38a3 <exit>
    printf(1, "create dd/dd/ff failed\n");
    21ff:	51                   	push   %ecx
    2200:	51                   	push   %ecx
    2201:	68 d7 44 00 00       	push   $0x44d7
    2206:	6a 01                	push   $0x1
    2208:	e8 f3 17 00 00       	call   3a00 <printf>
    exit();
    220d:	e8 91 16 00 00       	call   38a3 <exit>
    printf(1, "chdir ./.. failed\n");
    2212:	50                   	push   %eax
    2213:	50                   	push   %eax
    2214:	68 a0 45 00 00       	push   $0x45a0
    2219:	6a 01                	push   $0x1
    221b:	e8 e0 17 00 00       	call   3a00 <printf>
    exit();
    2220:	e8 7e 16 00 00       	call   38a3 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2225:	52                   	push   %edx
    2226:	52                   	push   %edx
    2227:	68 8c 4f 00 00       	push   $0x4f8c
    222c:	6a 01                	push   $0x1
    222e:	e8 cd 17 00 00       	call   3a00 <printf>
    exit();
    2233:	e8 6b 16 00 00       	call   38a3 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2238:	50                   	push   %eax
    2239:	50                   	push   %eax
    223a:	68 20 50 00 00       	push   $0x5020
    223f:	6a 01                	push   $0x1
    2241:	e8 ba 17 00 00       	call   3a00 <printf>
    exit();
    2246:	e8 58 16 00 00       	call   38a3 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    224b:	50                   	push   %eax
    224c:	50                   	push   %eax
    224d:	68 fc 4f 00 00       	push   $0x4ffc
    2252:	6a 01                	push   $0x1
    2254:	e8 a7 17 00 00       	call   3a00 <printf>
    exit();
    2259:	e8 45 16 00 00       	call   38a3 <exit>
    printf(1, "open dd wronly succeeded!\n");
    225e:	50                   	push   %eax
    225f:	50                   	push   %eax
    2260:	68 5f 46 00 00       	push   $0x465f
    2265:	6a 01                	push   $0x1
    2267:	e8 94 17 00 00       	call   3a00 <printf>
    exit();
    226c:	e8 32 16 00 00       	call   38a3 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2271:	50                   	push   %eax
    2272:	50                   	push   %eax
    2273:	68 46 46 00 00       	push   $0x4646
    2278:	6a 01                	push   $0x1
    227a:	e8 81 17 00 00       	call   3a00 <printf>
    exit();
    227f:	e8 1f 16 00 00       	call   38a3 <exit>
    printf(1, "create dd succeeded!\n");
    2284:	50                   	push   %eax
    2285:	50                   	push   %eax
    2286:	68 30 46 00 00       	push   $0x4630
    228b:	6a 01                	push   $0x1
    228d:	e8 6e 17 00 00       	call   3a00 <printf>
    exit();
    2292:	e8 0c 16 00 00       	call   38a3 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2297:	52                   	push   %edx
    2298:	52                   	push   %edx
    2299:	68 14 46 00 00       	push   $0x4614
    229e:	6a 01                	push   $0x1
    22a0:	e8 5b 17 00 00       	call   3a00 <printf>
    exit();
    22a5:	e8 f9 15 00 00       	call   38a3 <exit>
    printf(1, "chdir dd failed\n");
    22aa:	50                   	push   %eax
    22ab:	50                   	push   %eax
    22ac:	68 55 45 00 00       	push   $0x4555
    22b1:	6a 01                	push   $0x1
    22b3:	e8 48 17 00 00       	call   3a00 <printf>
    exit();
    22b8:	e8 e6 15 00 00       	call   38a3 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22bd:	50                   	push   %eax
    22be:	50                   	push   %eax
    22bf:	68 b0 4f 00 00       	push   $0x4fb0
    22c4:	6a 01                	push   $0x1
    22c6:	e8 35 17 00 00       	call   3a00 <printf>
    exit();
    22cb:	e8 d3 15 00 00       	call   38a3 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22d0:	53                   	push   %ebx
    22d1:	53                   	push   %ebx
    22d2:	68 b3 44 00 00       	push   $0x44b3
    22d7:	6a 01                	push   $0x1
    22d9:	e8 22 17 00 00       	call   3a00 <printf>
    exit();
    22de:	e8 c0 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22e3:	50                   	push   %eax
    22e4:	50                   	push   %eax
    22e5:	68 64 4f 00 00       	push   $0x4f64
    22ea:	6a 01                	push   $0x1
    22ec:	e8 0f 17 00 00       	call   3a00 <printf>
    exit();
    22f1:	e8 ad 15 00 00       	call   38a3 <exit>
    printf(1, "create dd/ff failed\n");
    22f6:	50                   	push   %eax
    22f7:	50                   	push   %eax
    22f8:	68 97 44 00 00       	push   $0x4497
    22fd:	6a 01                	push   $0x1
    22ff:	e8 fc 16 00 00       	call   3a00 <printf>
    exit();
    2304:	e8 9a 15 00 00       	call   38a3 <exit>
    printf(1, "subdir mkdir dd failed\n");
    2309:	50                   	push   %eax
    230a:	50                   	push   %eax
    230b:	68 7f 44 00 00       	push   $0x447f
    2310:	6a 01                	push   $0x1
    2312:	e8 e9 16 00 00       	call   3a00 <printf>
    exit();
    2317:	e8 87 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd failed\n");
    231c:	50                   	push   %eax
    231d:	50                   	push   %eax
    231e:	68 68 47 00 00       	push   $0x4768
    2323:	6a 01                	push   $0x1
    2325:	e8 d6 16 00 00       	call   3a00 <printf>
    exit();
    232a:	e8 74 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd/dd failed\n");
    232f:	52                   	push   %edx
    2330:	52                   	push   %edx
    2331:	68 53 47 00 00       	push   $0x4753
    2336:	6a 01                	push   $0x1
    2338:	e8 c3 16 00 00       	call   3a00 <printf>
    exit();
    233d:	e8 61 15 00 00       	call   38a3 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2342:	51                   	push   %ecx
    2343:	51                   	push   %ecx
    2344:	68 68 50 00 00       	push   $0x5068
    2349:	6a 01                	push   $0x1
    234b:	e8 b0 16 00 00       	call   3a00 <printf>
    exit();
    2350:	e8 4e 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd/ff failed\n");
    2355:	53                   	push   %ebx
    2356:	53                   	push   %ebx
    2357:	68 3e 47 00 00       	push   $0x473e
    235c:	6a 01                	push   $0x1
    235e:	e8 9d 16 00 00       	call   3a00 <printf>
    exit();
    2363:	e8 3b 15 00 00       	call   38a3 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2368:	50                   	push   %eax
    2369:	50                   	push   %eax
    236a:	68 26 47 00 00       	push   $0x4726
    236f:	6a 01                	push   $0x1
    2371:	e8 8a 16 00 00       	call   3a00 <printf>
    exit();
    2376:	e8 28 15 00 00       	call   38a3 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    237b:	50                   	push   %eax
    237c:	50                   	push   %eax
    237d:	68 0e 47 00 00       	push   $0x470e
    2382:	6a 01                	push   $0x1
    2384:	e8 77 16 00 00       	call   3a00 <printf>
    exit();
    2389:	e8 15 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    238e:	50                   	push   %eax
    238f:	50                   	push   %eax
    2390:	68 f2 46 00 00       	push   $0x46f2
    2395:	6a 01                	push   $0x1
    2397:	e8 64 16 00 00       	call   3a00 <printf>
    exit();
    239c:	e8 02 15 00 00       	call   38a3 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    23a1:	50                   	push   %eax
    23a2:	50                   	push   %eax
    23a3:	68 d6 46 00 00       	push   $0x46d6
    23a8:	6a 01                	push   $0x1
    23aa:	e8 51 16 00 00       	call   3a00 <printf>
    exit();
    23af:	e8 ef 14 00 00       	call   38a3 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    23b4:	50                   	push   %eax
    23b5:	50                   	push   %eax
    23b6:	68 b9 46 00 00       	push   $0x46b9
    23bb:	6a 01                	push   $0x1
    23bd:	e8 3e 16 00 00       	call   3a00 <printf>
    exit();
    23c2:	e8 dc 14 00 00       	call   38a3 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23c7:	52                   	push   %edx
    23c8:	52                   	push   %edx
    23c9:	68 9e 46 00 00       	push   $0x469e
    23ce:	6a 01                	push   $0x1
    23d0:	e8 2b 16 00 00       	call   3a00 <printf>
    exit();
    23d5:	e8 c9 14 00 00       	call   38a3 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23da:	51                   	push   %ecx
    23db:	51                   	push   %ecx
    23dc:	68 cb 45 00 00       	push   $0x45cb
    23e1:	6a 01                	push   $0x1
    23e3:	e8 18 16 00 00       	call   3a00 <printf>
    exit();
    23e8:	e8 b6 14 00 00       	call   38a3 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23ed:	53                   	push   %ebx
    23ee:	53                   	push   %ebx
    23ef:	68 b3 45 00 00       	push   $0x45b3
    23f4:	6a 01                	push   $0x1
    23f6:	e8 05 16 00 00       	call   3a00 <printf>
    exit();
    23fb:	e8 a3 14 00 00       	call   38a3 <exit>

00002400 <bigwrite>:
{
    2400:	55                   	push   %ebp
    2401:	89 e5                	mov    %esp,%ebp
    2403:	56                   	push   %esi
    2404:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    2405:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    240a:	83 ec 08             	sub    $0x8,%esp
    240d:	68 85 47 00 00       	push   $0x4785
    2412:	6a 01                	push   $0x1
    2414:	e8 e7 15 00 00       	call   3a00 <printf>
  unlink("bigwrite");
    2419:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    2420:	e8 ce 14 00 00       	call   38f3 <unlink>
    2425:	83 c4 10             	add    $0x10,%esp
    2428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    242f:	90                   	nop
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2430:	83 ec 08             	sub    $0x8,%esp
    2433:	68 02 02 00 00       	push   $0x202
    2438:	68 94 47 00 00       	push   $0x4794
    243d:	e8 a1 14 00 00       	call   38e3 <open>
    if(fd < 0){
    2442:	83 c4 10             	add    $0x10,%esp
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2445:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2447:	85 c0                	test   %eax,%eax
    2449:	78 7e                	js     24c9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    244b:	83 ec 04             	sub    $0x4,%esp
    244e:	53                   	push   %ebx
    244f:	68 20 85 00 00       	push   $0x8520
    2454:	50                   	push   %eax
    2455:	e8 69 14 00 00       	call   38c3 <write>
      if(cc != sz){
    245a:	83 c4 10             	add    $0x10,%esp
    245d:	39 d8                	cmp    %ebx,%eax
    245f:	75 55                	jne    24b6 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2461:	83 ec 04             	sub    $0x4,%esp
    2464:	53                   	push   %ebx
    2465:	68 20 85 00 00       	push   $0x8520
    246a:	56                   	push   %esi
    246b:	e8 53 14 00 00       	call   38c3 <write>
      if(cc != sz){
    2470:	83 c4 10             	add    $0x10,%esp
    2473:	39 d8                	cmp    %ebx,%eax
    2475:	75 3f                	jne    24b6 <bigwrite+0xb6>
    close(fd);
    2477:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    247a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2480:	56                   	push   %esi
    2481:	e8 45 14 00 00       	call   38cb <close>
    unlink("bigwrite");
    2486:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    248d:	e8 61 14 00 00       	call   38f3 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2492:	83 c4 10             	add    $0x10,%esp
    2495:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    249b:	75 93                	jne    2430 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    249d:	83 ec 08             	sub    $0x8,%esp
    24a0:	68 c7 47 00 00       	push   $0x47c7
    24a5:	6a 01                	push   $0x1
    24a7:	e8 54 15 00 00       	call   3a00 <printf>
}
    24ac:	83 c4 10             	add    $0x10,%esp
    24af:	8d 65 f8             	lea    -0x8(%ebp),%esp
    24b2:	5b                   	pop    %ebx
    24b3:	5e                   	pop    %esi
    24b4:	5d                   	pop    %ebp
    24b5:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    24b6:	50                   	push   %eax
    24b7:	53                   	push   %ebx
    24b8:	68 b5 47 00 00       	push   $0x47b5
    24bd:	6a 01                	push   $0x1
    24bf:	e8 3c 15 00 00       	call   3a00 <printf>
        exit();
    24c4:	e8 da 13 00 00       	call   38a3 <exit>
      printf(1, "cannot create bigwrite\n");
    24c9:	83 ec 08             	sub    $0x8,%esp
    24cc:	68 9d 47 00 00       	push   $0x479d
    24d1:	6a 01                	push   $0x1
    24d3:	e8 28 15 00 00       	call   3a00 <printf>
      exit();
    24d8:	e8 c6 13 00 00       	call   38a3 <exit>
    24dd:	8d 76 00             	lea    0x0(%esi),%esi

000024e0 <bigfile>:
{
    24e0:	55                   	push   %ebp
    24e1:	89 e5                	mov    %esp,%ebp
    24e3:	57                   	push   %edi
    24e4:	56                   	push   %esi
    24e5:	53                   	push   %ebx
    24e6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24e9:	68 d4 47 00 00       	push   $0x47d4
    24ee:	6a 01                	push   $0x1
    24f0:	e8 0b 15 00 00       	call   3a00 <printf>
  unlink("bigfile");
    24f5:	c7 04 24 f0 47 00 00 	movl   $0x47f0,(%esp)
    24fc:	e8 f2 13 00 00       	call   38f3 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2501:	58                   	pop    %eax
    2502:	5a                   	pop    %edx
    2503:	68 02 02 00 00       	push   $0x202
    2508:	68 f0 47 00 00       	push   $0x47f0
    250d:	e8 d1 13 00 00       	call   38e3 <open>
  if(fd < 0){
    2512:	83 c4 10             	add    $0x10,%esp
    2515:	85 c0                	test   %eax,%eax
    2517:	0f 88 5e 01 00 00    	js     267b <bigfile+0x19b>
    251d:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    251f:	31 db                	xor    %ebx,%ebx
    2521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2528:	83 ec 04             	sub    $0x4,%esp
    252b:	68 58 02 00 00       	push   $0x258
    2530:	53                   	push   %ebx
    2531:	68 20 85 00 00       	push   $0x8520
    2536:	e8 d5 11 00 00       	call   3710 <memset>
    if(write(fd, buf, 600) != 600){
    253b:	83 c4 0c             	add    $0xc,%esp
    253e:	68 58 02 00 00       	push   $0x258
    2543:	68 20 85 00 00       	push   $0x8520
    2548:	56                   	push   %esi
    2549:	e8 75 13 00 00       	call   38c3 <write>
    254e:	83 c4 10             	add    $0x10,%esp
    2551:	3d 58 02 00 00       	cmp    $0x258,%eax
    2556:	0f 85 f8 00 00 00    	jne    2654 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    255c:	83 c3 01             	add    $0x1,%ebx
    255f:	83 fb 14             	cmp    $0x14,%ebx
    2562:	75 c4                	jne    2528 <bigfile+0x48>
  close(fd);
    2564:	83 ec 0c             	sub    $0xc,%esp
    2567:	56                   	push   %esi
    2568:	e8 5e 13 00 00       	call   38cb <close>
  fd = open("bigfile", 0);
    256d:	5e                   	pop    %esi
    256e:	5f                   	pop    %edi
    256f:	6a 00                	push   $0x0
    2571:	68 f0 47 00 00       	push   $0x47f0
    2576:	e8 68 13 00 00       	call   38e3 <open>
  if(fd < 0){
    257b:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", 0);
    257e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2580:	85 c0                	test   %eax,%eax
    2582:	0f 88 e0 00 00 00    	js     2668 <bigfile+0x188>
  total = 0;
    2588:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    258a:	31 ff                	xor    %edi,%edi
    258c:	eb 30                	jmp    25be <bigfile+0xde>
    258e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2590:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2595:	0f 85 91 00 00 00    	jne    262c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    259b:	89 fa                	mov    %edi,%edx
    259d:	0f be 05 20 85 00 00 	movsbl 0x8520,%eax
    25a4:	d1 fa                	sar    %edx
    25a6:	39 d0                	cmp    %edx,%eax
    25a8:	75 6e                	jne    2618 <bigfile+0x138>
    25aa:	0f be 15 4b 86 00 00 	movsbl 0x864b,%edx
    25b1:	39 d0                	cmp    %edx,%eax
    25b3:	75 63                	jne    2618 <bigfile+0x138>
    total += cc;
    25b5:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    25bb:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    25be:	83 ec 04             	sub    $0x4,%esp
    25c1:	68 2c 01 00 00       	push   $0x12c
    25c6:	68 20 85 00 00       	push   $0x8520
    25cb:	56                   	push   %esi
    25cc:	e8 ea 12 00 00       	call   38bb <read>
    if(cc < 0){
    25d1:	83 c4 10             	add    $0x10,%esp
    25d4:	85 c0                	test   %eax,%eax
    25d6:	78 68                	js     2640 <bigfile+0x160>
    if(cc == 0)
    25d8:	75 b6                	jne    2590 <bigfile+0xb0>
  close(fd);
    25da:	83 ec 0c             	sub    $0xc,%esp
    25dd:	56                   	push   %esi
    25de:	e8 e8 12 00 00       	call   38cb <close>
  if(total != 20*600){
    25e3:	83 c4 10             	add    $0x10,%esp
    25e6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25ec:	0f 85 9c 00 00 00    	jne    268e <bigfile+0x1ae>
  unlink("bigfile");
    25f2:	83 ec 0c             	sub    $0xc,%esp
    25f5:	68 f0 47 00 00       	push   $0x47f0
    25fa:	e8 f4 12 00 00       	call   38f3 <unlink>
  printf(1, "bigfile test ok\n");
    25ff:	58                   	pop    %eax
    2600:	5a                   	pop    %edx
    2601:	68 7f 48 00 00       	push   $0x487f
    2606:	6a 01                	push   $0x1
    2608:	e8 f3 13 00 00       	call   3a00 <printf>
}
    260d:	83 c4 10             	add    $0x10,%esp
    2610:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2613:	5b                   	pop    %ebx
    2614:	5e                   	pop    %esi
    2615:	5f                   	pop    %edi
    2616:	5d                   	pop    %ebp
    2617:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    2618:	83 ec 08             	sub    $0x8,%esp
    261b:	68 4c 48 00 00       	push   $0x484c
    2620:	6a 01                	push   $0x1
    2622:	e8 d9 13 00 00       	call   3a00 <printf>
      exit();
    2627:	e8 77 12 00 00       	call   38a3 <exit>
      printf(1, "short read bigfile\n");
    262c:	83 ec 08             	sub    $0x8,%esp
    262f:	68 38 48 00 00       	push   $0x4838
    2634:	6a 01                	push   $0x1
    2636:	e8 c5 13 00 00       	call   3a00 <printf>
      exit();
    263b:	e8 63 12 00 00       	call   38a3 <exit>
      printf(1, "read bigfile failed\n");
    2640:	83 ec 08             	sub    $0x8,%esp
    2643:	68 23 48 00 00       	push   $0x4823
    2648:	6a 01                	push   $0x1
    264a:	e8 b1 13 00 00       	call   3a00 <printf>
      exit();
    264f:	e8 4f 12 00 00       	call   38a3 <exit>
      printf(1, "write bigfile failed\n");
    2654:	83 ec 08             	sub    $0x8,%esp
    2657:	68 f8 47 00 00       	push   $0x47f8
    265c:	6a 01                	push   $0x1
    265e:	e8 9d 13 00 00       	call   3a00 <printf>
      exit();
    2663:	e8 3b 12 00 00       	call   38a3 <exit>
    printf(1, "cannot open bigfile\n");
    2668:	53                   	push   %ebx
    2669:	53                   	push   %ebx
    266a:	68 0e 48 00 00       	push   $0x480e
    266f:	6a 01                	push   $0x1
    2671:	e8 8a 13 00 00       	call   3a00 <printf>
    exit();
    2676:	e8 28 12 00 00       	call   38a3 <exit>
    printf(1, "cannot create bigfile");
    267b:	50                   	push   %eax
    267c:	50                   	push   %eax
    267d:	68 e2 47 00 00       	push   $0x47e2
    2682:	6a 01                	push   $0x1
    2684:	e8 77 13 00 00       	call   3a00 <printf>
    exit();
    2689:	e8 15 12 00 00       	call   38a3 <exit>
    printf(1, "read bigfile wrong total\n");
    268e:	51                   	push   %ecx
    268f:	51                   	push   %ecx
    2690:	68 65 48 00 00       	push   $0x4865
    2695:	6a 01                	push   $0x1
    2697:	e8 64 13 00 00       	call   3a00 <printf>
    exit();
    269c:	e8 02 12 00 00       	call   38a3 <exit>
    26a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    26af:	90                   	nop

000026b0 <fourteen>:
{
    26b0:	55                   	push   %ebp
    26b1:	89 e5                	mov    %esp,%ebp
    26b3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    26b6:	68 90 48 00 00       	push   $0x4890
    26bb:	6a 01                	push   $0x1
    26bd:	e8 3e 13 00 00       	call   3a00 <printf>
  if(mkdir("12345678901234") != 0){
    26c2:	c7 04 24 cb 48 00 00 	movl   $0x48cb,(%esp)
    26c9:	e8 3d 12 00 00       	call   390b <mkdir>
    26ce:	83 c4 10             	add    $0x10,%esp
    26d1:	85 c0                	test   %eax,%eax
    26d3:	0f 85 97 00 00 00    	jne    2770 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26d9:	83 ec 0c             	sub    $0xc,%esp
    26dc:	68 88 50 00 00       	push   $0x5088
    26e1:	e8 25 12 00 00       	call   390b <mkdir>
    26e6:	83 c4 10             	add    $0x10,%esp
    26e9:	85 c0                	test   %eax,%eax
    26eb:	0f 85 de 00 00 00    	jne    27cf <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26f1:	83 ec 08             	sub    $0x8,%esp
    26f4:	68 00 02 00 00       	push   $0x200
    26f9:	68 d8 50 00 00       	push   $0x50d8
    26fe:	e8 e0 11 00 00       	call   38e3 <open>
  if(fd < 0){
    2703:	83 c4 10             	add    $0x10,%esp
    2706:	85 c0                	test   %eax,%eax
    2708:	0f 88 ae 00 00 00    	js     27bc <fourteen+0x10c>
  close(fd);
    270e:	83 ec 0c             	sub    $0xc,%esp
    2711:	50                   	push   %eax
    2712:	e8 b4 11 00 00       	call   38cb <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2717:	58                   	pop    %eax
    2718:	5a                   	pop    %edx
    2719:	6a 00                	push   $0x0
    271b:	68 48 51 00 00       	push   $0x5148
    2720:	e8 be 11 00 00       	call   38e3 <open>
  if(fd < 0){
    2725:	83 c4 10             	add    $0x10,%esp
    2728:	85 c0                	test   %eax,%eax
    272a:	78 7d                	js     27a9 <fourteen+0xf9>
  close(fd);
    272c:	83 ec 0c             	sub    $0xc,%esp
    272f:	50                   	push   %eax
    2730:	e8 96 11 00 00       	call   38cb <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2735:	c7 04 24 bc 48 00 00 	movl   $0x48bc,(%esp)
    273c:	e8 ca 11 00 00       	call   390b <mkdir>
    2741:	83 c4 10             	add    $0x10,%esp
    2744:	85 c0                	test   %eax,%eax
    2746:	74 4e                	je     2796 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2748:	83 ec 0c             	sub    $0xc,%esp
    274b:	68 e4 51 00 00       	push   $0x51e4
    2750:	e8 b6 11 00 00       	call   390b <mkdir>
    2755:	83 c4 10             	add    $0x10,%esp
    2758:	85 c0                	test   %eax,%eax
    275a:	74 27                	je     2783 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    275c:	83 ec 08             	sub    $0x8,%esp
    275f:	68 da 48 00 00       	push   $0x48da
    2764:	6a 01                	push   $0x1
    2766:	e8 95 12 00 00       	call   3a00 <printf>
}
    276b:	83 c4 10             	add    $0x10,%esp
    276e:	c9                   	leave  
    276f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2770:	50                   	push   %eax
    2771:	50                   	push   %eax
    2772:	68 9f 48 00 00       	push   $0x489f
    2777:	6a 01                	push   $0x1
    2779:	e8 82 12 00 00       	call   3a00 <printf>
    exit();
    277e:	e8 20 11 00 00       	call   38a3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2783:	50                   	push   %eax
    2784:	50                   	push   %eax
    2785:	68 04 52 00 00       	push   $0x5204
    278a:	6a 01                	push   $0x1
    278c:	e8 6f 12 00 00       	call   3a00 <printf>
    exit();
    2791:	e8 0d 11 00 00       	call   38a3 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2796:	52                   	push   %edx
    2797:	52                   	push   %edx
    2798:	68 b4 51 00 00       	push   $0x51b4
    279d:	6a 01                	push   $0x1
    279f:	e8 5c 12 00 00       	call   3a00 <printf>
    exit();
    27a4:	e8 fa 10 00 00       	call   38a3 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27a9:	51                   	push   %ecx
    27aa:	51                   	push   %ecx
    27ab:	68 78 51 00 00       	push   $0x5178
    27b0:	6a 01                	push   $0x1
    27b2:	e8 49 12 00 00       	call   3a00 <printf>
    exit();
    27b7:	e8 e7 10 00 00       	call   38a3 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27bc:	51                   	push   %ecx
    27bd:	51                   	push   %ecx
    27be:	68 08 51 00 00       	push   $0x5108
    27c3:	6a 01                	push   $0x1
    27c5:	e8 36 12 00 00       	call   3a00 <printf>
    exit();
    27ca:	e8 d4 10 00 00       	call   38a3 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27cf:	50                   	push   %eax
    27d0:	50                   	push   %eax
    27d1:	68 a8 50 00 00       	push   $0x50a8
    27d6:	6a 01                	push   $0x1
    27d8:	e8 23 12 00 00       	call   3a00 <printf>
    exit();
    27dd:	e8 c1 10 00 00       	call   38a3 <exit>
    27e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000027f0 <rmdot>:
{
    27f0:	55                   	push   %ebp
    27f1:	89 e5                	mov    %esp,%ebp
    27f3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27f6:	68 e7 48 00 00       	push   $0x48e7
    27fb:	6a 01                	push   $0x1
    27fd:	e8 fe 11 00 00       	call   3a00 <printf>
  if(mkdir("dots") != 0){
    2802:	c7 04 24 f3 48 00 00 	movl   $0x48f3,(%esp)
    2809:	e8 fd 10 00 00       	call   390b <mkdir>
    280e:	83 c4 10             	add    $0x10,%esp
    2811:	85 c0                	test   %eax,%eax
    2813:	0f 85 b0 00 00 00    	jne    28c9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    2819:	83 ec 0c             	sub    $0xc,%esp
    281c:	68 f3 48 00 00       	push   $0x48f3
    2821:	e8 ed 10 00 00       	call   3913 <chdir>
    2826:	83 c4 10             	add    $0x10,%esp
    2829:	85 c0                	test   %eax,%eax
    282b:	0f 85 1d 01 00 00    	jne    294e <rmdot+0x15e>
  if(unlink(".") == 0){
    2831:	83 ec 0c             	sub    $0xc,%esp
    2834:	68 9e 45 00 00       	push   $0x459e
    2839:	e8 b5 10 00 00       	call   38f3 <unlink>
    283e:	83 c4 10             	add    $0x10,%esp
    2841:	85 c0                	test   %eax,%eax
    2843:	0f 84 f2 00 00 00    	je     293b <rmdot+0x14b>
  if(unlink("..") == 0){
    2849:	83 ec 0c             	sub    $0xc,%esp
    284c:	68 9d 45 00 00       	push   $0x459d
    2851:	e8 9d 10 00 00       	call   38f3 <unlink>
    2856:	83 c4 10             	add    $0x10,%esp
    2859:	85 c0                	test   %eax,%eax
    285b:	0f 84 c7 00 00 00    	je     2928 <rmdot+0x138>
  if(chdir("/") != 0){
    2861:	83 ec 0c             	sub    $0xc,%esp
    2864:	68 71 3d 00 00       	push   $0x3d71
    2869:	e8 a5 10 00 00       	call   3913 <chdir>
    286e:	83 c4 10             	add    $0x10,%esp
    2871:	85 c0                	test   %eax,%eax
    2873:	0f 85 9c 00 00 00    	jne    2915 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2879:	83 ec 0c             	sub    $0xc,%esp
    287c:	68 3b 49 00 00       	push   $0x493b
    2881:	e8 6d 10 00 00       	call   38f3 <unlink>
    2886:	83 c4 10             	add    $0x10,%esp
    2889:	85 c0                	test   %eax,%eax
    288b:	74 75                	je     2902 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    288d:	83 ec 0c             	sub    $0xc,%esp
    2890:	68 59 49 00 00       	push   $0x4959
    2895:	e8 59 10 00 00       	call   38f3 <unlink>
    289a:	83 c4 10             	add    $0x10,%esp
    289d:	85 c0                	test   %eax,%eax
    289f:	74 4e                	je     28ef <rmdot+0xff>
  if(unlink("dots") != 0){
    28a1:	83 ec 0c             	sub    $0xc,%esp
    28a4:	68 f3 48 00 00       	push   $0x48f3
    28a9:	e8 45 10 00 00       	call   38f3 <unlink>
    28ae:	83 c4 10             	add    $0x10,%esp
    28b1:	85 c0                	test   %eax,%eax
    28b3:	75 27                	jne    28dc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    28b5:	83 ec 08             	sub    $0x8,%esp
    28b8:	68 8e 49 00 00       	push   $0x498e
    28bd:	6a 01                	push   $0x1
    28bf:	e8 3c 11 00 00       	call   3a00 <printf>
}
    28c4:	83 c4 10             	add    $0x10,%esp
    28c7:	c9                   	leave  
    28c8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28c9:	50                   	push   %eax
    28ca:	50                   	push   %eax
    28cb:	68 f8 48 00 00       	push   $0x48f8
    28d0:	6a 01                	push   $0x1
    28d2:	e8 29 11 00 00       	call   3a00 <printf>
    exit();
    28d7:	e8 c7 0f 00 00       	call   38a3 <exit>
    printf(1, "unlink dots failed!\n");
    28dc:	50                   	push   %eax
    28dd:	50                   	push   %eax
    28de:	68 79 49 00 00       	push   $0x4979
    28e3:	6a 01                	push   $0x1
    28e5:	e8 16 11 00 00       	call   3a00 <printf>
    exit();
    28ea:	e8 b4 0f 00 00       	call   38a3 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28ef:	52                   	push   %edx
    28f0:	52                   	push   %edx
    28f1:	68 61 49 00 00       	push   $0x4961
    28f6:	6a 01                	push   $0x1
    28f8:	e8 03 11 00 00       	call   3a00 <printf>
    exit();
    28fd:	e8 a1 0f 00 00       	call   38a3 <exit>
    printf(1, "unlink dots/. worked!\n");
    2902:	51                   	push   %ecx
    2903:	51                   	push   %ecx
    2904:	68 42 49 00 00       	push   $0x4942
    2909:	6a 01                	push   $0x1
    290b:	e8 f0 10 00 00       	call   3a00 <printf>
    exit();
    2910:	e8 8e 0f 00 00       	call   38a3 <exit>
    printf(1, "chdir / failed\n");
    2915:	50                   	push   %eax
    2916:	50                   	push   %eax
    2917:	68 73 3d 00 00       	push   $0x3d73
    291c:	6a 01                	push   $0x1
    291e:	e8 dd 10 00 00       	call   3a00 <printf>
    exit();
    2923:	e8 7b 0f 00 00       	call   38a3 <exit>
    printf(1, "rm .. worked!\n");
    2928:	50                   	push   %eax
    2929:	50                   	push   %eax
    292a:	68 2c 49 00 00       	push   $0x492c
    292f:	6a 01                	push   $0x1
    2931:	e8 ca 10 00 00       	call   3a00 <printf>
    exit();
    2936:	e8 68 0f 00 00       	call   38a3 <exit>
    printf(1, "rm . worked!\n");
    293b:	50                   	push   %eax
    293c:	50                   	push   %eax
    293d:	68 1e 49 00 00       	push   $0x491e
    2942:	6a 01                	push   $0x1
    2944:	e8 b7 10 00 00       	call   3a00 <printf>
    exit();
    2949:	e8 55 0f 00 00       	call   38a3 <exit>
    printf(1, "chdir dots failed\n");
    294e:	50                   	push   %eax
    294f:	50                   	push   %eax
    2950:	68 0b 49 00 00       	push   $0x490b
    2955:	6a 01                	push   $0x1
    2957:	e8 a4 10 00 00       	call   3a00 <printf>
    exit();
    295c:	e8 42 0f 00 00       	call   38a3 <exit>
    2961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2968:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    296f:	90                   	nop

00002970 <dirfile>:
{
    2970:	55                   	push   %ebp
    2971:	89 e5                	mov    %esp,%ebp
    2973:	53                   	push   %ebx
    2974:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2977:	68 98 49 00 00       	push   $0x4998
    297c:	6a 01                	push   $0x1
    297e:	e8 7d 10 00 00       	call   3a00 <printf>
  fd = open("dirfile", O_CREATE);
    2983:	5b                   	pop    %ebx
    2984:	58                   	pop    %eax
    2985:	68 00 02 00 00       	push   $0x200
    298a:	68 a5 49 00 00       	push   $0x49a5
    298f:	e8 4f 0f 00 00       	call   38e3 <open>
  if(fd < 0){
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 88 43 01 00 00    	js     2ae2 <dirfile+0x172>
  close(fd);
    299f:	83 ec 0c             	sub    $0xc,%esp
    29a2:	50                   	push   %eax
    29a3:	e8 23 0f 00 00       	call   38cb <close>
  if(chdir("dirfile") == 0){
    29a8:	c7 04 24 a5 49 00 00 	movl   $0x49a5,(%esp)
    29af:	e8 5f 0f 00 00       	call   3913 <chdir>
    29b4:	83 c4 10             	add    $0x10,%esp
    29b7:	85 c0                	test   %eax,%eax
    29b9:	0f 84 10 01 00 00    	je     2acf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    29bf:	83 ec 08             	sub    $0x8,%esp
    29c2:	6a 00                	push   $0x0
    29c4:	68 de 49 00 00       	push   $0x49de
    29c9:	e8 15 0f 00 00       	call   38e3 <open>
  if(fd >= 0){
    29ce:	83 c4 10             	add    $0x10,%esp
    29d1:	85 c0                	test   %eax,%eax
    29d3:	0f 89 e3 00 00 00    	jns    2abc <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29d9:	83 ec 08             	sub    $0x8,%esp
    29dc:	68 00 02 00 00       	push   $0x200
    29e1:	68 de 49 00 00       	push   $0x49de
    29e6:	e8 f8 0e 00 00       	call   38e3 <open>
  if(fd >= 0){
    29eb:	83 c4 10             	add    $0x10,%esp
    29ee:	85 c0                	test   %eax,%eax
    29f0:	0f 89 c6 00 00 00    	jns    2abc <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    29f6:	83 ec 0c             	sub    $0xc,%esp
    29f9:	68 de 49 00 00       	push   $0x49de
    29fe:	e8 08 0f 00 00       	call   390b <mkdir>
    2a03:	83 c4 10             	add    $0x10,%esp
    2a06:	85 c0                	test   %eax,%eax
    2a08:	0f 84 46 01 00 00    	je     2b54 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    2a0e:	83 ec 0c             	sub    $0xc,%esp
    2a11:	68 de 49 00 00       	push   $0x49de
    2a16:	e8 d8 0e 00 00       	call   38f3 <unlink>
    2a1b:	83 c4 10             	add    $0x10,%esp
    2a1e:	85 c0                	test   %eax,%eax
    2a20:	0f 84 1b 01 00 00    	je     2b41 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a26:	83 ec 08             	sub    $0x8,%esp
    2a29:	68 de 49 00 00       	push   $0x49de
    2a2e:	68 42 4a 00 00       	push   $0x4a42
    2a33:	e8 cb 0e 00 00       	call   3903 <link>
    2a38:	83 c4 10             	add    $0x10,%esp
    2a3b:	85 c0                	test   %eax,%eax
    2a3d:	0f 84 eb 00 00 00    	je     2b2e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a43:	83 ec 0c             	sub    $0xc,%esp
    2a46:	68 a5 49 00 00       	push   $0x49a5
    2a4b:	e8 a3 0e 00 00       	call   38f3 <unlink>
    2a50:	83 c4 10             	add    $0x10,%esp
    2a53:	85 c0                	test   %eax,%eax
    2a55:	0f 85 c0 00 00 00    	jne    2b1b <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a5b:	83 ec 08             	sub    $0x8,%esp
    2a5e:	6a 02                	push   $0x2
    2a60:	68 9e 45 00 00       	push   $0x459e
    2a65:	e8 79 0e 00 00       	call   38e3 <open>
  if(fd >= 0){
    2a6a:	83 c4 10             	add    $0x10,%esp
    2a6d:	85 c0                	test   %eax,%eax
    2a6f:	0f 89 93 00 00 00    	jns    2b08 <dirfile+0x198>
  fd = open(".", 0);
    2a75:	83 ec 08             	sub    $0x8,%esp
    2a78:	6a 00                	push   $0x0
    2a7a:	68 9e 45 00 00       	push   $0x459e
    2a7f:	e8 5f 0e 00 00       	call   38e3 <open>
  if(write(fd, "x", 1) > 0){
    2a84:	83 c4 0c             	add    $0xc,%esp
    2a87:	6a 01                	push   $0x1
  fd = open(".", 0);
    2a89:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a8b:	68 81 46 00 00       	push   $0x4681
    2a90:	50                   	push   %eax
    2a91:	e8 2d 0e 00 00       	call   38c3 <write>
    2a96:	83 c4 10             	add    $0x10,%esp
    2a99:	85 c0                	test   %eax,%eax
    2a9b:	7f 58                	jg     2af5 <dirfile+0x185>
  close(fd);
    2a9d:	83 ec 0c             	sub    $0xc,%esp
    2aa0:	53                   	push   %ebx
    2aa1:	e8 25 0e 00 00       	call   38cb <close>
  printf(1, "dir vs file OK\n");
    2aa6:	58                   	pop    %eax
    2aa7:	5a                   	pop    %edx
    2aa8:	68 75 4a 00 00       	push   $0x4a75
    2aad:	6a 01                	push   $0x1
    2aaf:	e8 4c 0f 00 00       	call   3a00 <printf>
}
    2ab4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2ab7:	83 c4 10             	add    $0x10,%esp
    2aba:	c9                   	leave  
    2abb:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2abc:	50                   	push   %eax
    2abd:	50                   	push   %eax
    2abe:	68 e9 49 00 00       	push   $0x49e9
    2ac3:	6a 01                	push   $0x1
    2ac5:	e8 36 0f 00 00       	call   3a00 <printf>
    exit();
    2aca:	e8 d4 0d 00 00       	call   38a3 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2acf:	52                   	push   %edx
    2ad0:	52                   	push   %edx
    2ad1:	68 c4 49 00 00       	push   $0x49c4
    2ad6:	6a 01                	push   $0x1
    2ad8:	e8 23 0f 00 00       	call   3a00 <printf>
    exit();
    2add:	e8 c1 0d 00 00       	call   38a3 <exit>
    printf(1, "create dirfile failed\n");
    2ae2:	51                   	push   %ecx
    2ae3:	51                   	push   %ecx
    2ae4:	68 ad 49 00 00       	push   $0x49ad
    2ae9:	6a 01                	push   $0x1
    2aeb:	e8 10 0f 00 00       	call   3a00 <printf>
    exit();
    2af0:	e8 ae 0d 00 00       	call   38a3 <exit>
    printf(1, "write . succeeded!\n");
    2af5:	51                   	push   %ecx
    2af6:	51                   	push   %ecx
    2af7:	68 61 4a 00 00       	push   $0x4a61
    2afc:	6a 01                	push   $0x1
    2afe:	e8 fd 0e 00 00       	call   3a00 <printf>
    exit();
    2b03:	e8 9b 0d 00 00       	call   38a3 <exit>
    printf(1, "open . for writing succeeded!\n");
    2b08:	53                   	push   %ebx
    2b09:	53                   	push   %ebx
    2b0a:	68 58 52 00 00       	push   $0x5258
    2b0f:	6a 01                	push   $0x1
    2b11:	e8 ea 0e 00 00       	call   3a00 <printf>
    exit();
    2b16:	e8 88 0d 00 00       	call   38a3 <exit>
    printf(1, "unlink dirfile failed!\n");
    2b1b:	50                   	push   %eax
    2b1c:	50                   	push   %eax
    2b1d:	68 49 4a 00 00       	push   $0x4a49
    2b22:	6a 01                	push   $0x1
    2b24:	e8 d7 0e 00 00       	call   3a00 <printf>
    exit();
    2b29:	e8 75 0d 00 00       	call   38a3 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b2e:	50                   	push   %eax
    2b2f:	50                   	push   %eax
    2b30:	68 38 52 00 00       	push   $0x5238
    2b35:	6a 01                	push   $0x1
    2b37:	e8 c4 0e 00 00       	call   3a00 <printf>
    exit();
    2b3c:	e8 62 0d 00 00       	call   38a3 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b41:	50                   	push   %eax
    2b42:	50                   	push   %eax
    2b43:	68 24 4a 00 00       	push   $0x4a24
    2b48:	6a 01                	push   $0x1
    2b4a:	e8 b1 0e 00 00       	call   3a00 <printf>
    exit();
    2b4f:	e8 4f 0d 00 00       	call   38a3 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b54:	50                   	push   %eax
    2b55:	50                   	push   %eax
    2b56:	68 07 4a 00 00       	push   $0x4a07
    2b5b:	6a 01                	push   $0x1
    2b5d:	e8 9e 0e 00 00       	call   3a00 <printf>
    exit();
    2b62:	e8 3c 0d 00 00       	call   38a3 <exit>
    2b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2b6e:	66 90                	xchg   %ax,%ax

00002b70 <iref>:
{
    2b70:	55                   	push   %ebp
    2b71:	89 e5                	mov    %esp,%ebp
    2b73:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b74:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b79:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b7c:	68 85 4a 00 00       	push   $0x4a85
    2b81:	6a 01                	push   $0x1
    2b83:	e8 78 0e 00 00       	call   3a00 <printf>
    2b88:	83 c4 10             	add    $0x10,%esp
    2b8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2b8f:	90                   	nop
    if(mkdir("irefd") != 0){
    2b90:	83 ec 0c             	sub    $0xc,%esp
    2b93:	68 96 4a 00 00       	push   $0x4a96
    2b98:	e8 6e 0d 00 00       	call   390b <mkdir>
    2b9d:	83 c4 10             	add    $0x10,%esp
    2ba0:	85 c0                	test   %eax,%eax
    2ba2:	0f 85 bb 00 00 00    	jne    2c63 <iref+0xf3>
    if(chdir("irefd") != 0){
    2ba8:	83 ec 0c             	sub    $0xc,%esp
    2bab:	68 96 4a 00 00       	push   $0x4a96
    2bb0:	e8 5e 0d 00 00       	call   3913 <chdir>
    2bb5:	83 c4 10             	add    $0x10,%esp
    2bb8:	85 c0                	test   %eax,%eax
    2bba:	0f 85 b7 00 00 00    	jne    2c77 <iref+0x107>
    mkdir("");
    2bc0:	83 ec 0c             	sub    $0xc,%esp
    2bc3:	68 4b 41 00 00       	push   $0x414b
    2bc8:	e8 3e 0d 00 00       	call   390b <mkdir>
    link("README", "");
    2bcd:	59                   	pop    %ecx
    2bce:	58                   	pop    %eax
    2bcf:	68 4b 41 00 00       	push   $0x414b
    2bd4:	68 42 4a 00 00       	push   $0x4a42
    2bd9:	e8 25 0d 00 00       	call   3903 <link>
    fd = open("", O_CREATE);
    2bde:	58                   	pop    %eax
    2bdf:	5a                   	pop    %edx
    2be0:	68 00 02 00 00       	push   $0x200
    2be5:	68 4b 41 00 00       	push   $0x414b
    2bea:	e8 f4 0c 00 00       	call   38e3 <open>
    if(fd >= 0)
    2bef:	83 c4 10             	add    $0x10,%esp
    2bf2:	85 c0                	test   %eax,%eax
    2bf4:	78 0c                	js     2c02 <iref+0x92>
      close(fd);
    2bf6:	83 ec 0c             	sub    $0xc,%esp
    2bf9:	50                   	push   %eax
    2bfa:	e8 cc 0c 00 00       	call   38cb <close>
    2bff:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2c02:	83 ec 08             	sub    $0x8,%esp
    2c05:	68 00 02 00 00       	push   $0x200
    2c0a:	68 80 46 00 00       	push   $0x4680
    2c0f:	e8 cf 0c 00 00       	call   38e3 <open>
    if(fd >= 0)
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	85 c0                	test   %eax,%eax
    2c19:	78 0c                	js     2c27 <iref+0xb7>
      close(fd);
    2c1b:	83 ec 0c             	sub    $0xc,%esp
    2c1e:	50                   	push   %eax
    2c1f:	e8 a7 0c 00 00       	call   38cb <close>
    2c24:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c27:	83 ec 0c             	sub    $0xc,%esp
    2c2a:	68 80 46 00 00       	push   $0x4680
    2c2f:	e8 bf 0c 00 00       	call   38f3 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c34:	83 c4 10             	add    $0x10,%esp
    2c37:	83 eb 01             	sub    $0x1,%ebx
    2c3a:	0f 85 50 ff ff ff    	jne    2b90 <iref+0x20>
  chdir("/");
    2c40:	83 ec 0c             	sub    $0xc,%esp
    2c43:	68 71 3d 00 00       	push   $0x3d71
    2c48:	e8 c6 0c 00 00       	call   3913 <chdir>
  printf(1, "empty file name OK\n");
    2c4d:	58                   	pop    %eax
    2c4e:	5a                   	pop    %edx
    2c4f:	68 c4 4a 00 00       	push   $0x4ac4
    2c54:	6a 01                	push   $0x1
    2c56:	e8 a5 0d 00 00       	call   3a00 <printf>
}
    2c5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c5e:	83 c4 10             	add    $0x10,%esp
    2c61:	c9                   	leave  
    2c62:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c63:	83 ec 08             	sub    $0x8,%esp
    2c66:	68 9c 4a 00 00       	push   $0x4a9c
    2c6b:	6a 01                	push   $0x1
    2c6d:	e8 8e 0d 00 00       	call   3a00 <printf>
      exit();
    2c72:	e8 2c 0c 00 00       	call   38a3 <exit>
      printf(1, "chdir irefd failed\n");
    2c77:	83 ec 08             	sub    $0x8,%esp
    2c7a:	68 b0 4a 00 00       	push   $0x4ab0
    2c7f:	6a 01                	push   $0x1
    2c81:	e8 7a 0d 00 00       	call   3a00 <printf>
      exit();
    2c86:	e8 18 0c 00 00       	call   38a3 <exit>
    2c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2c8f:	90                   	nop

00002c90 <forktest>:
{
    2c90:	55                   	push   %ebp
    2c91:	89 e5                	mov    %esp,%ebp
    2c93:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2c94:	31 db                	xor    %ebx,%ebx
{
    2c96:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2c99:	68 d8 4a 00 00       	push   $0x4ad8
    2c9e:	6a 01                	push   $0x1
    2ca0:	e8 5b 0d 00 00       	call   3a00 <printf>
    2ca5:	83 c4 10             	add    $0x10,%esp
    2ca8:	eb 13                	jmp    2cbd <forktest+0x2d>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2cb0:	74 4a                	je     2cfc <forktest+0x6c>
  for(n=0; n<1000; n++){
    2cb2:	83 c3 01             	add    $0x1,%ebx
    2cb5:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2cbb:	74 6b                	je     2d28 <forktest+0x98>
    pid = fork();
    2cbd:	e8 d9 0b 00 00       	call   389b <fork>
    if(pid < 0)
    2cc2:	85 c0                	test   %eax,%eax
    2cc4:	79 ea                	jns    2cb0 <forktest+0x20>
  for(; n > 0; n--){
    2cc6:	85 db                	test   %ebx,%ebx
    2cc8:	74 14                	je     2cde <forktest+0x4e>
    2cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2cd0:	e8 d6 0b 00 00       	call   38ab <wait>
    2cd5:	85 c0                	test   %eax,%eax
    2cd7:	78 28                	js     2d01 <forktest+0x71>
  for(; n > 0; n--){
    2cd9:	83 eb 01             	sub    $0x1,%ebx
    2cdc:	75 f2                	jne    2cd0 <forktest+0x40>
  if(wait() != -1){
    2cde:	e8 c8 0b 00 00       	call   38ab <wait>
    2ce3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ce6:	75 2d                	jne    2d15 <forktest+0x85>
  printf(1, "fork test OK\n");
    2ce8:	83 ec 08             	sub    $0x8,%esp
    2ceb:	68 0a 4b 00 00       	push   $0x4b0a
    2cf0:	6a 01                	push   $0x1
    2cf2:	e8 09 0d 00 00       	call   3a00 <printf>
}
    2cf7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cfa:	c9                   	leave  
    2cfb:	c3                   	ret    
      exit();
    2cfc:	e8 a2 0b 00 00       	call   38a3 <exit>
      printf(1, "wait stopped early\n");
    2d01:	83 ec 08             	sub    $0x8,%esp
    2d04:	68 e3 4a 00 00       	push   $0x4ae3
    2d09:	6a 01                	push   $0x1
    2d0b:	e8 f0 0c 00 00       	call   3a00 <printf>
      exit();
    2d10:	e8 8e 0b 00 00       	call   38a3 <exit>
    printf(1, "wait got too many\n");
    2d15:	52                   	push   %edx
    2d16:	52                   	push   %edx
    2d17:	68 f7 4a 00 00       	push   $0x4af7
    2d1c:	6a 01                	push   $0x1
    2d1e:	e8 dd 0c 00 00       	call   3a00 <printf>
    exit();
    2d23:	e8 7b 0b 00 00       	call   38a3 <exit>
    printf(1, "fork claimed to work 1000 times!\n");
    2d28:	50                   	push   %eax
    2d29:	50                   	push   %eax
    2d2a:	68 78 52 00 00       	push   $0x5278
    2d2f:	6a 01                	push   $0x1
    2d31:	e8 ca 0c 00 00       	call   3a00 <printf>
    exit();
    2d36:	e8 68 0b 00 00       	call   38a3 <exit>
    2d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d3f:	90                   	nop

00002d40 <sbrktest>:
{
    2d40:	55                   	push   %ebp
    2d41:	89 e5                	mov    %esp,%ebp
    2d43:	57                   	push   %edi
    2d44:	56                   	push   %esi
  for(i = 0; i < 5000; i++){
    2d45:	31 f6                	xor    %esi,%esi
{
    2d47:	53                   	push   %ebx
    2d48:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2d4b:	68 18 4b 00 00       	push   $0x4b18
    2d50:	ff 35 e8 5d 00 00    	push   0x5de8
    2d56:	e8 a5 0c 00 00       	call   3a00 <printf>
  oldbrk = sbrk(0);
    2d5b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d62:	e8 c4 0b 00 00       	call   392b <sbrk>
  a = sbrk(0);
    2d67:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d6e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  a = sbrk(0);
    2d71:	e8 b5 0b 00 00       	call   392b <sbrk>
    2d76:	83 c4 10             	add    $0x10,%esp
    2d79:	89 c3                	mov    %eax,%ebx
  for(i = 0; i < 5000; i++){
    2d7b:	eb 05                	jmp    2d82 <sbrktest+0x42>
    2d7d:	8d 76 00             	lea    0x0(%esi),%esi
    a = b + 1;
    2d80:	89 c3                	mov    %eax,%ebx
    b = sbrk(1);
    2d82:	83 ec 0c             	sub    $0xc,%esp
    2d85:	6a 01                	push   $0x1
    2d87:	e8 9f 0b 00 00       	call   392b <sbrk>
    if(b != a){
    2d8c:	83 c4 10             	add    $0x10,%esp
    2d8f:	39 d8                	cmp    %ebx,%eax
    2d91:	0f 85 8c 02 00 00    	jne    3023 <sbrktest+0x2e3>
  for(i = 0; i < 5000; i++){
    2d97:	83 c6 01             	add    $0x1,%esi
    *b = 1;
    2d9a:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2d9d:	8d 43 01             	lea    0x1(%ebx),%eax
  for(i = 0; i < 5000; i++){
    2da0:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2da6:	75 d8                	jne    2d80 <sbrktest+0x40>
  pid = fork();
    2da8:	e8 ee 0a 00 00       	call   389b <fork>
    2dad:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    2daf:	85 c0                	test   %eax,%eax
    2db1:	0f 88 1c 03 00 00    	js     30d3 <sbrktest+0x393>
  c = sbrk(1);
    2db7:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2dba:	83 c3 02             	add    $0x2,%ebx
  c = sbrk(1);
    2dbd:	6a 01                	push   $0x1
    2dbf:	e8 67 0b 00 00       	call   392b <sbrk>
  c = sbrk(1);
    2dc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dcb:	e8 5b 0b 00 00       	call   392b <sbrk>
  if(c != a + 1){
    2dd0:	83 c4 10             	add    $0x10,%esp
    2dd3:	39 c3                	cmp    %eax,%ebx
    2dd5:	0f 85 14 03 00 00    	jne    30ef <sbrktest+0x3af>
  if(pid == 0)
    2ddb:	85 f6                	test   %esi,%esi
    2ddd:	0f 84 07 03 00 00    	je     30ea <sbrktest+0x3aa>
  wait();
    2de3:	e8 c3 0a 00 00       	call   38ab <wait>
  a = sbrk(0);
    2de8:	83 ec 0c             	sub    $0xc,%esp
    2deb:	6a 00                	push   $0x0
    2ded:	e8 39 0b 00 00       	call   392b <sbrk>
    2df2:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2df4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2df9:	29 d8                	sub    %ebx,%eax
  p = sbrk(amt);
    2dfb:	89 04 24             	mov    %eax,(%esp)
    2dfe:	e8 28 0b 00 00       	call   392b <sbrk>
  if (p != a) {
    2e03:	83 c4 10             	add    $0x10,%esp
    2e06:	39 c3                	cmp    %eax,%ebx
    2e08:	0f 85 80 02 00 00    	jne    308e <sbrktest+0x34e>
  a = sbrk(0);
    2e0e:	83 ec 0c             	sub    $0xc,%esp
    2e11:	6a 00                	push   $0x0
    2e13:	e8 13 0b 00 00       	call   392b <sbrk>
  c = sbrk(-4096);
    2e18:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e1f:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2e21:	e8 05 0b 00 00       	call   392b <sbrk>
  if(c == (char*)0xffffffff){
    2e26:	83 c4 10             	add    $0x10,%esp
    2e29:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e2c:	0f 84 02 03 00 00    	je     3134 <sbrktest+0x3f4>
  c = sbrk(0);
    2e32:	83 ec 0c             	sub    $0xc,%esp
    2e35:	6a 00                	push   $0x0
    2e37:	e8 ef 0a 00 00       	call   392b <sbrk>
  if(c != a - 4096){
    2e3c:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2e42:	83 c4 10             	add    $0x10,%esp
    2e45:	39 d0                	cmp    %edx,%eax
    2e47:	0f 85 d0 02 00 00    	jne    311d <sbrktest+0x3dd>
  a = sbrk(0);
    2e4d:	83 ec 0c             	sub    $0xc,%esp
    2e50:	6a 00                	push   $0x0
    2e52:	e8 d4 0a 00 00       	call   392b <sbrk>
  c = sbrk(4096);
    2e57:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
  a = sbrk(0);
    2e5e:	89 c3                	mov    %eax,%ebx
  c = sbrk(4096);
    2e60:	e8 c6 0a 00 00       	call   392b <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e65:	83 c4 10             	add    $0x10,%esp
  c = sbrk(4096);
    2e68:	89 c6                	mov    %eax,%esi
  if(c != a || sbrk(0) != a + 4096){
    2e6a:	39 c3                	cmp    %eax,%ebx
    2e6c:	0f 85 94 02 00 00    	jne    3106 <sbrktest+0x3c6>
    2e72:	83 ec 0c             	sub    $0xc,%esp
    2e75:	6a 00                	push   $0x0
    2e77:	e8 af 0a 00 00       	call   392b <sbrk>
    2e7c:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    2e82:	83 c4 10             	add    $0x10,%esp
    2e85:	39 c2                	cmp    %eax,%edx
    2e87:	0f 85 79 02 00 00    	jne    3106 <sbrktest+0x3c6>
  a = sbrk(0);
    2e8d:	83 ec 0c             	sub    $0xc,%esp
    2e90:	6a 00                	push   $0x0
    2e92:	e8 94 0a 00 00       	call   392b <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e97:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2e9e:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    2ea0:	e8 86 0a 00 00       	call   392b <sbrk>
    2ea5:	89 c2                	mov    %eax,%edx
    2ea7:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    2eaa:	29 d0                	sub    %edx,%eax
    2eac:	89 04 24             	mov    %eax,(%esp)
    2eaf:	e8 77 0a 00 00       	call   392b <sbrk>
  if(c != a){
    2eb4:	83 c4 10             	add    $0x10,%esp
    2eb7:	39 c3                	cmp    %eax,%ebx
    2eb9:	0f 85 e6 01 00 00    	jne    30a5 <sbrktest+0x365>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ebf:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    2ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ppid = getpid();
    2ec8:	e8 56 0a 00 00       	call   3923 <getpid>
    2ecd:	89 c6                	mov    %eax,%esi
    pid = fork();
    2ecf:	e8 c7 09 00 00       	call   389b <fork>
    if(pid < 0){
    2ed4:	85 c0                	test   %eax,%eax
    2ed6:	0f 88 65 01 00 00    	js     3041 <sbrktest+0x301>
    if(pid == 0){
    2edc:	0f 84 77 01 00 00    	je     3059 <sbrktest+0x319>
    wait();
    2ee2:	e8 c4 09 00 00       	call   38ab <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ee7:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    2eed:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    2ef3:	75 d3                	jne    2ec8 <sbrktest+0x188>
  if(pipe(fds) != 0){
    2ef5:	83 ec 0c             	sub    $0xc,%esp
    2ef8:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2efb:	50                   	push   %eax
    2efc:	e8 b2 09 00 00       	call   38b3 <pipe>
    2f01:	83 c4 10             	add    $0x10,%esp
    2f04:	85 c0                	test   %eax,%eax
    2f06:	0f 85 6f 01 00 00    	jne    307b <sbrktest+0x33b>
    2f0c:	8d 5d c0             	lea    -0x40(%ebp),%ebx
    2f0f:	8d 75 e8             	lea    -0x18(%ebp),%esi
    2f12:	89 df                	mov    %ebx,%edi
    2f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((pids[i] = fork()) == 0){
    2f18:	e8 7e 09 00 00       	call   389b <fork>
    2f1d:	89 07                	mov    %eax,(%edi)
    2f1f:	85 c0                	test   %eax,%eax
    2f21:	0f 84 91 00 00 00    	je     2fb8 <sbrktest+0x278>
    if(pids[i] != -1)
    2f27:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f2a:	74 14                	je     2f40 <sbrktest+0x200>
      read(fds[0], &scratch, 1);
    2f2c:	83 ec 04             	sub    $0x4,%esp
    2f2f:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f32:	6a 01                	push   $0x1
    2f34:	50                   	push   %eax
    2f35:	ff 75 b8             	push   -0x48(%ebp)
    2f38:	e8 7e 09 00 00       	call   38bb <read>
    2f3d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f40:	83 c7 04             	add    $0x4,%edi
    2f43:	39 f7                	cmp    %esi,%edi
    2f45:	75 d1                	jne    2f18 <sbrktest+0x1d8>
  c = sbrk(4096);
    2f47:	83 ec 0c             	sub    $0xc,%esp
    2f4a:	68 00 10 00 00       	push   $0x1000
    2f4f:	e8 d7 09 00 00       	call   392b <sbrk>
    2f54:	83 c4 10             	add    $0x10,%esp
    2f57:	89 c7                	mov    %eax,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pids[i] == -1)
    2f60:	8b 03                	mov    (%ebx),%eax
    2f62:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f65:	74 11                	je     2f78 <sbrktest+0x238>
    kill(pids[i]);
    2f67:	83 ec 0c             	sub    $0xc,%esp
    2f6a:	50                   	push   %eax
    2f6b:	e8 63 09 00 00       	call   38d3 <kill>
    wait();
    2f70:	e8 36 09 00 00       	call   38ab <wait>
    2f75:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f78:	83 c3 04             	add    $0x4,%ebx
    2f7b:	39 de                	cmp    %ebx,%esi
    2f7d:	75 e1                	jne    2f60 <sbrktest+0x220>
  if(c == (char*)0xffffffff){
    2f7f:	83 ff ff             	cmp    $0xffffffff,%edi
    2f82:	0f 84 34 01 00 00    	je     30bc <sbrktest+0x37c>
  if(sbrk(0) > oldbrk)
    2f88:	83 ec 0c             	sub    $0xc,%esp
    2f8b:	6a 00                	push   $0x0
    2f8d:	e8 99 09 00 00       	call   392b <sbrk>
    2f92:	83 c4 10             	add    $0x10,%esp
    2f95:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    2f98:	72 68                	jb     3002 <sbrktest+0x2c2>
  printf(stdout, "sbrk test OK\n");
    2f9a:	83 ec 08             	sub    $0x8,%esp
    2f9d:	68 c0 4b 00 00       	push   $0x4bc0
    2fa2:	ff 35 e8 5d 00 00    	push   0x5de8
    2fa8:	e8 53 0a 00 00       	call   3a00 <printf>
}
    2fad:	83 c4 10             	add    $0x10,%esp
    2fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fb3:	5b                   	pop    %ebx
    2fb4:	5e                   	pop    %esi
    2fb5:	5f                   	pop    %edi
    2fb6:	5d                   	pop    %ebp
    2fb7:	c3                   	ret    
      sbrk(BIG - (uint)sbrk(0));
    2fb8:	83 ec 0c             	sub    $0xc,%esp
    2fbb:	6a 00                	push   $0x0
    2fbd:	e8 69 09 00 00       	call   392b <sbrk>
    2fc2:	89 c2                	mov    %eax,%edx
    2fc4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2fc9:	29 d0                	sub    %edx,%eax
    2fcb:	89 04 24             	mov    %eax,(%esp)
    2fce:	e8 58 09 00 00       	call   392b <sbrk>
      write(fds[1], "x", 1);
    2fd3:	83 c4 0c             	add    $0xc,%esp
    2fd6:	6a 01                	push   $0x1
    2fd8:	68 81 46 00 00       	push   $0x4681
    2fdd:	ff 75 bc             	push   -0x44(%ebp)
    2fe0:	e8 de 08 00 00       	call   38c3 <write>
    2fe5:	83 c4 10             	add    $0x10,%esp
    2fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2fef:	90                   	nop
      for(;;) sleep(1000);
    2ff0:	83 ec 0c             	sub    $0xc,%esp
    2ff3:	68 e8 03 00 00       	push   $0x3e8
    2ff8:	e8 36 09 00 00       	call   3933 <sleep>
    2ffd:	83 c4 10             	add    $0x10,%esp
    3000:	eb ee                	jmp    2ff0 <sbrktest+0x2b0>
    sbrk(-(sbrk(0) - oldbrk));
    3002:	83 ec 0c             	sub    $0xc,%esp
    3005:	6a 00                	push   $0x0
    3007:	e8 1f 09 00 00       	call   392b <sbrk>
    300c:	89 c2                	mov    %eax,%edx
    300e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    3011:	29 d0                	sub    %edx,%eax
    3013:	89 04 24             	mov    %eax,(%esp)
    3016:	e8 10 09 00 00       	call   392b <sbrk>
    301b:	83 c4 10             	add    $0x10,%esp
    301e:	e9 77 ff ff ff       	jmp    2f9a <sbrktest+0x25a>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3023:	83 ec 0c             	sub    $0xc,%esp
    3026:	50                   	push   %eax
    3027:	53                   	push   %ebx
    3028:	56                   	push   %esi
    3029:	68 23 4b 00 00       	push   $0x4b23
    302e:	ff 35 e8 5d 00 00    	push   0x5de8
    3034:	e8 c7 09 00 00       	call   3a00 <printf>
      exit();
    3039:	83 c4 20             	add    $0x20,%esp
    303c:	e8 62 08 00 00       	call   38a3 <exit>
      printf(stdout, "fork failed\n");
    3041:	83 ec 08             	sub    $0x8,%esp
    3044:	68 69 4c 00 00       	push   $0x4c69
    3049:	ff 35 e8 5d 00 00    	push   0x5de8
    304f:	e8 ac 09 00 00       	call   3a00 <printf>
      exit();
    3054:	e8 4a 08 00 00       	call   38a3 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3059:	0f be 03             	movsbl (%ebx),%eax
    305c:	50                   	push   %eax
    305d:	53                   	push   %ebx
    305e:	68 8c 4b 00 00       	push   $0x4b8c
    3063:	ff 35 e8 5d 00 00    	push   0x5de8
    3069:	e8 92 09 00 00       	call   3a00 <printf>
      kill(ppid);
    306e:	89 34 24             	mov    %esi,(%esp)
    3071:	e8 5d 08 00 00       	call   38d3 <kill>
      exit();
    3076:	e8 28 08 00 00       	call   38a3 <exit>
    printf(1, "pipe() failed\n");
    307b:	52                   	push   %edx
    307c:	52                   	push   %edx
    307d:	68 61 40 00 00       	push   $0x4061
    3082:	6a 01                	push   $0x1
    3084:	e8 77 09 00 00       	call   3a00 <printf>
    exit();
    3089:	e8 15 08 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    308e:	53                   	push   %ebx
    308f:	53                   	push   %ebx
    3090:	68 9c 52 00 00       	push   $0x529c
    3095:	ff 35 e8 5d 00 00    	push   0x5de8
    309b:	e8 60 09 00 00       	call   3a00 <printf>
    exit();
    30a0:	e8 fe 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30a5:	50                   	push   %eax
    30a6:	53                   	push   %ebx
    30a7:	68 3c 53 00 00       	push   $0x533c
    30ac:	ff 35 e8 5d 00 00    	push   0x5de8
    30b2:	e8 49 09 00 00       	call   3a00 <printf>
    exit();
    30b7:	e8 e7 07 00 00       	call   38a3 <exit>
    printf(stdout, "failed sbrk leaked memory\n");
    30bc:	50                   	push   %eax
    30bd:	50                   	push   %eax
    30be:	68 a5 4b 00 00       	push   $0x4ba5
    30c3:	ff 35 e8 5d 00 00    	push   0x5de8
    30c9:	e8 32 09 00 00       	call   3a00 <printf>
    exit();
    30ce:	e8 d0 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk test fork failed\n");
    30d3:	57                   	push   %edi
    30d4:	57                   	push   %edi
    30d5:	68 3e 4b 00 00       	push   $0x4b3e
    30da:	ff 35 e8 5d 00 00    	push   0x5de8
    30e0:	e8 1b 09 00 00       	call   3a00 <printf>
    exit();
    30e5:	e8 b9 07 00 00       	call   38a3 <exit>
    exit();
    30ea:	e8 b4 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    30ef:	56                   	push   %esi
    30f0:	56                   	push   %esi
    30f1:	68 55 4b 00 00       	push   $0x4b55
    30f6:	ff 35 e8 5d 00 00    	push   0x5de8
    30fc:	e8 ff 08 00 00       	call   3a00 <printf>
    exit();
    3101:	e8 9d 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3106:	56                   	push   %esi
    3107:	53                   	push   %ebx
    3108:	68 14 53 00 00       	push   $0x5314
    310d:	ff 35 e8 5d 00 00    	push   0x5de8
    3113:	e8 e8 08 00 00       	call   3a00 <printf>
    exit();
    3118:	e8 86 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    311d:	50                   	push   %eax
    311e:	53                   	push   %ebx
    311f:	68 dc 52 00 00       	push   $0x52dc
    3124:	ff 35 e8 5d 00 00    	push   0x5de8
    312a:	e8 d1 08 00 00       	call   3a00 <printf>
    exit();
    312f:	e8 6f 07 00 00       	call   38a3 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    3134:	51                   	push   %ecx
    3135:	51                   	push   %ecx
    3136:	68 71 4b 00 00       	push   $0x4b71
    313b:	ff 35 e8 5d 00 00    	push   0x5de8
    3141:	e8 ba 08 00 00       	call   3a00 <printf>
    exit();
    3146:	e8 58 07 00 00       	call   38a3 <exit>
    314b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    314f:	90                   	nop

00003150 <validateint>:
}
    3150:	c3                   	ret    
    3151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    315f:	90                   	nop

00003160 <validatetest>:
{
    3160:	55                   	push   %ebp
    3161:	89 e5                	mov    %esp,%ebp
    3163:	56                   	push   %esi
  for(p = 0; p <= (uint)hi; p += 4096){
    3164:	31 f6                	xor    %esi,%esi
{
    3166:	53                   	push   %ebx
  printf(stdout, "validate test\n");
    3167:	83 ec 08             	sub    $0x8,%esp
    316a:	68 ce 4b 00 00       	push   $0x4bce
    316f:	ff 35 e8 5d 00 00    	push   0x5de8
    3175:	e8 86 08 00 00       	call   3a00 <printf>
    317a:	83 c4 10             	add    $0x10,%esp
    317d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3180:	e8 16 07 00 00       	call   389b <fork>
    3185:	89 c3                	mov    %eax,%ebx
    3187:	85 c0                	test   %eax,%eax
    3189:	74 63                	je     31ee <validatetest+0x8e>
    sleep(0);
    318b:	83 ec 0c             	sub    $0xc,%esp
    318e:	6a 00                	push   $0x0
    3190:	e8 9e 07 00 00       	call   3933 <sleep>
    sleep(0);
    3195:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    319c:	e8 92 07 00 00       	call   3933 <sleep>
    kill(pid);
    31a1:	89 1c 24             	mov    %ebx,(%esp)
    31a4:	e8 2a 07 00 00       	call   38d3 <kill>
    wait();
    31a9:	e8 fd 06 00 00       	call   38ab <wait>
    if(link("nosuchfile", (char*)p) != -1){
    31ae:	58                   	pop    %eax
    31af:	5a                   	pop    %edx
    31b0:	56                   	push   %esi
    31b1:	68 dd 4b 00 00       	push   $0x4bdd
    31b6:	e8 48 07 00 00       	call   3903 <link>
    31bb:	83 c4 10             	add    $0x10,%esp
    31be:	83 f8 ff             	cmp    $0xffffffff,%eax
    31c1:	75 30                	jne    31f3 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    31c3:	81 c6 00 10 00 00    	add    $0x1000,%esi
    31c9:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    31cf:	75 af                	jne    3180 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    31d1:	83 ec 08             	sub    $0x8,%esp
    31d4:	68 01 4c 00 00       	push   $0x4c01
    31d9:	ff 35 e8 5d 00 00    	push   0x5de8
    31df:	e8 1c 08 00 00       	call   3a00 <printf>
}
    31e4:	83 c4 10             	add    $0x10,%esp
    31e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31ea:	5b                   	pop    %ebx
    31eb:	5e                   	pop    %esi
    31ec:	5d                   	pop    %ebp
    31ed:	c3                   	ret    
      exit();
    31ee:	e8 b0 06 00 00       	call   38a3 <exit>
      printf(stdout, "link should not succeed\n");
    31f3:	83 ec 08             	sub    $0x8,%esp
    31f6:	68 e8 4b 00 00       	push   $0x4be8
    31fb:	ff 35 e8 5d 00 00    	push   0x5de8
    3201:	e8 fa 07 00 00       	call   3a00 <printf>
      exit();
    3206:	e8 98 06 00 00       	call   38a3 <exit>
    320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    320f:	90                   	nop

00003210 <bsstest>:
{
    3210:	55                   	push   %ebp
    3211:	89 e5                	mov    %esp,%ebp
    3213:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    3216:	68 0e 4c 00 00       	push   $0x4c0e
    321b:	ff 35 e8 5d 00 00    	push   0x5de8
    3221:	e8 da 07 00 00       	call   3a00 <printf>
    3226:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3229:	31 c0                	xor    %eax,%eax
    322b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    322f:	90                   	nop
    if(uninit[i] != '\0'){
    3230:	80 b8 00 5e 00 00 00 	cmpb   $0x0,0x5e00(%eax)
    3237:	75 22                	jne    325b <bsstest+0x4b>
  for(i = 0; i < sizeof(uninit); i++){
    3239:	83 c0 01             	add    $0x1,%eax
    323c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3241:	75 ed                	jne    3230 <bsstest+0x20>
  printf(stdout, "bss test ok\n");
    3243:	83 ec 08             	sub    $0x8,%esp
    3246:	68 29 4c 00 00       	push   $0x4c29
    324b:	ff 35 e8 5d 00 00    	push   0x5de8
    3251:	e8 aa 07 00 00       	call   3a00 <printf>
}
    3256:	83 c4 10             	add    $0x10,%esp
    3259:	c9                   	leave  
    325a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    325b:	83 ec 08             	sub    $0x8,%esp
    325e:	68 18 4c 00 00       	push   $0x4c18
    3263:	ff 35 e8 5d 00 00    	push   0x5de8
    3269:	e8 92 07 00 00       	call   3a00 <printf>
      exit();
    326e:	e8 30 06 00 00       	call   38a3 <exit>
    3273:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    327a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003280 <bigargtest>:
{
    3280:	55                   	push   %ebp
    3281:	89 e5                	mov    %esp,%ebp
    3283:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3286:	68 36 4c 00 00       	push   $0x4c36
    328b:	e8 63 06 00 00       	call   38f3 <unlink>
  pid = fork();
    3290:	e8 06 06 00 00       	call   389b <fork>
  if(pid == 0){
    3295:	83 c4 10             	add    $0x10,%esp
    3298:	85 c0                	test   %eax,%eax
    329a:	74 44                	je     32e0 <bigargtest+0x60>
  } else if(pid < 0){
    329c:	0f 88 c5 00 00 00    	js     3367 <bigargtest+0xe7>
  wait();
    32a2:	e8 04 06 00 00       	call   38ab <wait>
  fd = open("bigarg-ok", 0);
    32a7:	83 ec 08             	sub    $0x8,%esp
    32aa:	6a 00                	push   $0x0
    32ac:	68 36 4c 00 00       	push   $0x4c36
    32b1:	e8 2d 06 00 00       	call   38e3 <open>
  if(fd < 0){
    32b6:	83 c4 10             	add    $0x10,%esp
    32b9:	85 c0                	test   %eax,%eax
    32bb:	0f 88 8f 00 00 00    	js     3350 <bigargtest+0xd0>
  close(fd);
    32c1:	83 ec 0c             	sub    $0xc,%esp
    32c4:	50                   	push   %eax
    32c5:	e8 01 06 00 00       	call   38cb <close>
  unlink("bigarg-ok");
    32ca:	c7 04 24 36 4c 00 00 	movl   $0x4c36,(%esp)
    32d1:	e8 1d 06 00 00       	call   38f3 <unlink>
}
    32d6:	83 c4 10             	add    $0x10,%esp
    32d9:	c9                   	leave  
    32da:	c3                   	ret    
    32db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    32df:	90                   	nop
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    32e0:	c7 04 85 20 a5 00 00 	movl   $0x5360,0xa520(,%eax,4)
    32e7:	60 53 00 00 
    for(i = 0; i < MAXARG-1; i++)
    32eb:	83 c0 01             	add    $0x1,%eax
    32ee:	83 f8 1f             	cmp    $0x1f,%eax
    32f1:	75 ed                	jne    32e0 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    32f3:	51                   	push   %ecx
    32f4:	51                   	push   %ecx
    32f5:	68 40 4c 00 00       	push   $0x4c40
    32fa:	ff 35 e8 5d 00 00    	push   0x5de8
    args[MAXARG-1] = 0;
    3300:	c7 05 9c a5 00 00 00 	movl   $0x0,0xa59c
    3307:	00 00 00 
    printf(stdout, "bigarg test\n");
    330a:	e8 f1 06 00 00       	call   3a00 <printf>
    exec("echo", args);
    330f:	58                   	pop    %eax
    3310:	5a                   	pop    %edx
    3311:	68 20 a5 00 00       	push   $0xa520
    3316:	68 0d 3e 00 00       	push   $0x3e0d
    331b:	e8 bb 05 00 00       	call   38db <exec>
    printf(stdout, "bigarg test ok\n");
    3320:	59                   	pop    %ecx
    3321:	58                   	pop    %eax
    3322:	68 4d 4c 00 00       	push   $0x4c4d
    3327:	ff 35 e8 5d 00 00    	push   0x5de8
    332d:	e8 ce 06 00 00       	call   3a00 <printf>
    fd = open("bigarg-ok", O_CREATE);
    3332:	58                   	pop    %eax
    3333:	5a                   	pop    %edx
    3334:	68 00 02 00 00       	push   $0x200
    3339:	68 36 4c 00 00       	push   $0x4c36
    333e:	e8 a0 05 00 00       	call   38e3 <open>
    close(fd);
    3343:	89 04 24             	mov    %eax,(%esp)
    3346:	e8 80 05 00 00       	call   38cb <close>
    exit();
    334b:	e8 53 05 00 00       	call   38a3 <exit>
    printf(stdout, "bigarg test failed!\n");
    3350:	50                   	push   %eax
    3351:	50                   	push   %eax
    3352:	68 76 4c 00 00       	push   $0x4c76
    3357:	ff 35 e8 5d 00 00    	push   0x5de8
    335d:	e8 9e 06 00 00       	call   3a00 <printf>
    exit();
    3362:	e8 3c 05 00 00       	call   38a3 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3367:	52                   	push   %edx
    3368:	52                   	push   %edx
    3369:	68 5d 4c 00 00       	push   $0x4c5d
    336e:	ff 35 e8 5d 00 00    	push   0x5de8
    3374:	e8 87 06 00 00       	call   3a00 <printf>
    exit();
    3379:	e8 25 05 00 00       	call   38a3 <exit>
    337e:	66 90                	xchg   %ax,%ax

00003380 <fsfull>:
{
    3380:	55                   	push   %ebp
    3381:	89 e5                	mov    %esp,%ebp
    3383:	57                   	push   %edi
    3384:	56                   	push   %esi
  for(nfiles = 0; ; nfiles++){
    3385:	31 f6                	xor    %esi,%esi
{
    3387:	53                   	push   %ebx
    3388:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    338b:	68 8b 4c 00 00       	push   $0x4c8b
    3390:	6a 01                	push   $0x1
    3392:	e8 69 06 00 00       	call   3a00 <printf>
    3397:	83 c4 10             	add    $0x10,%esp
    339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    33a0:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33a5:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    33aa:	83 ec 04             	sub    $0x4,%esp
    name[0] = 'f';
    33ad:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    33b1:	f7 e6                	mul    %esi
    name[5] = '\0';
    33b3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33b7:	c1 ea 06             	shr    $0x6,%edx
    33ba:	8d 42 30             	lea    0x30(%edx),%eax
    33bd:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33c0:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    33c6:	89 f2                	mov    %esi,%edx
    33c8:	29 c2                	sub    %eax,%edx
    33ca:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33cf:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33d1:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33d6:	c1 ea 05             	shr    $0x5,%edx
    33d9:	83 c2 30             	add    $0x30,%edx
    33dc:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    33df:	f7 e6                	mul    %esi
    33e1:	c1 ea 05             	shr    $0x5,%edx
    33e4:	6b c2 64             	imul   $0x64,%edx,%eax
    33e7:	89 f2                	mov    %esi,%edx
    33e9:	29 c2                	sub    %eax,%edx
    33eb:	89 d0                	mov    %edx,%eax
    33ed:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    33ef:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33f1:	c1 ea 03             	shr    $0x3,%edx
    33f4:	83 c2 30             	add    $0x30,%edx
    33f7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    33fa:	f7 e1                	mul    %ecx
    33fc:	89 f0                	mov    %esi,%eax
    33fe:	c1 ea 03             	shr    $0x3,%edx
    3401:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3404:	01 d2                	add    %edx,%edx
    3406:	29 d0                	sub    %edx,%eax
    3408:	83 c0 30             	add    $0x30,%eax
    340b:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    340e:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3411:	50                   	push   %eax
    3412:	68 98 4c 00 00       	push   $0x4c98
    3417:	6a 01                	push   $0x1
    3419:	e8 e2 05 00 00       	call   3a00 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    341e:	58                   	pop    %eax
    341f:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3422:	5a                   	pop    %edx
    3423:	68 02 02 00 00       	push   $0x202
    3428:	50                   	push   %eax
    3429:	e8 b5 04 00 00       	call   38e3 <open>
    if(fd < 0){
    342e:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    3431:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3433:	85 c0                	test   %eax,%eax
    3435:	78 4f                	js     3486 <fsfull+0x106>
    int total = 0;
    3437:	31 db                	xor    %ebx,%ebx
    3439:	eb 07                	jmp    3442 <fsfull+0xc2>
    343b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    343f:	90                   	nop
      total += cc;
    3440:	01 c3                	add    %eax,%ebx
      int cc = write(fd, buf, 512);
    3442:	83 ec 04             	sub    $0x4,%esp
    3445:	68 00 02 00 00       	push   $0x200
    344a:	68 20 85 00 00       	push   $0x8520
    344f:	57                   	push   %edi
    3450:	e8 6e 04 00 00       	call   38c3 <write>
      if(cc < 512)
    3455:	83 c4 10             	add    $0x10,%esp
    3458:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    345d:	7f e1                	jg     3440 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    345f:	83 ec 04             	sub    $0x4,%esp
    3462:	53                   	push   %ebx
    3463:	68 b4 4c 00 00       	push   $0x4cb4
    3468:	6a 01                	push   $0x1
    346a:	e8 91 05 00 00       	call   3a00 <printf>
    close(fd);
    346f:	89 3c 24             	mov    %edi,(%esp)
    3472:	e8 54 04 00 00       	call   38cb <close>
    if(total == 0)
    3477:	83 c4 10             	add    $0x10,%esp
    347a:	85 db                	test   %ebx,%ebx
    347c:	74 1e                	je     349c <fsfull+0x11c>
  for(nfiles = 0; ; nfiles++){
    347e:	83 c6 01             	add    $0x1,%esi
    3481:	e9 1a ff ff ff       	jmp    33a0 <fsfull+0x20>
      printf(1, "open %s failed\n", name);
    3486:	83 ec 04             	sub    $0x4,%esp
    3489:	8d 45 a8             	lea    -0x58(%ebp),%eax
    348c:	50                   	push   %eax
    348d:	68 a4 4c 00 00       	push   $0x4ca4
    3492:	6a 01                	push   $0x1
    3494:	e8 67 05 00 00       	call   3a00 <printf>
      break;
    3499:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    349c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    34a1:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    34a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    34ad:	8d 76 00             	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    34b0:	89 f0                	mov    %esi,%eax
    unlink(name);
    34b2:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'f';
    34b5:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    34b9:	f7 e7                	mul    %edi
    name[5] = '\0';
    34bb:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34bf:	c1 ea 06             	shr    $0x6,%edx
    34c2:	8d 42 30             	lea    0x30(%edx),%eax
    34c5:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34c8:	69 c2 e8 03 00 00    	imul   $0x3e8,%edx,%eax
    34ce:	89 f2                	mov    %esi,%edx
    34d0:	29 c2                	sub    %eax,%edx
    34d2:	89 d0                	mov    %edx,%eax
    34d4:	f7 e3                	mul    %ebx
    name[3] = '0' + (nfiles % 100) / 10;
    34d6:	89 f0                	mov    %esi,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34d8:	c1 ea 05             	shr    $0x5,%edx
    34db:	83 c2 30             	add    $0x30,%edx
    34de:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    34e1:	f7 e3                	mul    %ebx
    34e3:	c1 ea 05             	shr    $0x5,%edx
    34e6:	6b ca 64             	imul   $0x64,%edx,%ecx
    34e9:	89 f2                	mov    %esi,%edx
    34eb:	29 ca                	sub    %ecx,%edx
    34ed:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    34f2:	89 d0                	mov    %edx,%eax
    34f4:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    34f6:	89 f0                	mov    %esi,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34f8:	c1 ea 03             	shr    $0x3,%edx
    34fb:	83 c2 30             	add    $0x30,%edx
    34fe:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3501:	f7 e1                	mul    %ecx
    3503:	89 f0                	mov    %esi,%eax
    nfiles--;
    3505:	83 ee 01             	sub    $0x1,%esi
    name[4] = '0' + (nfiles % 10);
    3508:	c1 ea 03             	shr    $0x3,%edx
    350b:	8d 14 92             	lea    (%edx,%edx,4),%edx
    350e:	01 d2                	add    %edx,%edx
    3510:	29 d0                	sub    %edx,%eax
    3512:	83 c0 30             	add    $0x30,%eax
    3515:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3518:	8d 45 a8             	lea    -0x58(%ebp),%eax
    351b:	50                   	push   %eax
    351c:	e8 d2 03 00 00       	call   38f3 <unlink>
  while(nfiles >= 0){
    3521:	83 c4 10             	add    $0x10,%esp
    3524:	83 fe ff             	cmp    $0xffffffff,%esi
    3527:	75 87                	jne    34b0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3529:	83 ec 08             	sub    $0x8,%esp
    352c:	68 c4 4c 00 00       	push   $0x4cc4
    3531:	6a 01                	push   $0x1
    3533:	e8 c8 04 00 00       	call   3a00 <printf>
}
    3538:	83 c4 10             	add    $0x10,%esp
    353b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    353e:	5b                   	pop    %ebx
    353f:	5e                   	pop    %esi
    3540:	5f                   	pop    %edi
    3541:	5d                   	pop    %ebp
    3542:	c3                   	ret    
    3543:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    354a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003550 <uio>:
{
    3550:	55                   	push   %ebp
    3551:	89 e5                	mov    %esp,%ebp
    3553:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3556:	68 da 4c 00 00       	push   $0x4cda
    355b:	6a 01                	push   $0x1
    355d:	e8 9e 04 00 00       	call   3a00 <printf>
  pid = fork();
    3562:	e8 34 03 00 00       	call   389b <fork>
  if(pid == 0){
    3567:	83 c4 10             	add    $0x10,%esp
    356a:	85 c0                	test   %eax,%eax
    356c:	74 1b                	je     3589 <uio+0x39>
  } else if(pid < 0){
    356e:	78 3d                	js     35ad <uio+0x5d>
  wait();
    3570:	e8 36 03 00 00       	call   38ab <wait>
  printf(1, "uio test done\n");
    3575:	83 ec 08             	sub    $0x8,%esp
    3578:	68 e4 4c 00 00       	push   $0x4ce4
    357d:	6a 01                	push   $0x1
    357f:	e8 7c 04 00 00       	call   3a00 <printf>
}
    3584:	83 c4 10             	add    $0x10,%esp
    3587:	c9                   	leave  
    3588:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3589:	b8 09 00 00 00       	mov    $0x9,%eax
    358e:	ba 70 00 00 00       	mov    $0x70,%edx
    3593:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3594:	ba 71 00 00 00       	mov    $0x71,%edx
    3599:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    359a:	52                   	push   %edx
    359b:	52                   	push   %edx
    359c:	68 40 54 00 00       	push   $0x5440
    35a1:	6a 01                	push   $0x1
    35a3:	e8 58 04 00 00       	call   3a00 <printf>
    exit();
    35a8:	e8 f6 02 00 00       	call   38a3 <exit>
    printf (1, "fork failed\n");
    35ad:	50                   	push   %eax
    35ae:	50                   	push   %eax
    35af:	68 69 4c 00 00       	push   $0x4c69
    35b4:	6a 01                	push   $0x1
    35b6:	e8 45 04 00 00       	call   3a00 <printf>
    exit();
    35bb:	e8 e3 02 00 00       	call   38a3 <exit>

000035c0 <argptest>:
{
    35c0:	55                   	push   %ebp
    35c1:	89 e5                	mov    %esp,%ebp
    35c3:	53                   	push   %ebx
    35c4:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    35c7:	6a 00                	push   $0x0
    35c9:	68 f3 4c 00 00       	push   $0x4cf3
    35ce:	e8 10 03 00 00       	call   38e3 <open>
  if (fd < 0) {
    35d3:	83 c4 10             	add    $0x10,%esp
    35d6:	85 c0                	test   %eax,%eax
    35d8:	78 39                	js     3613 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    35da:	83 ec 0c             	sub    $0xc,%esp
    35dd:	89 c3                	mov    %eax,%ebx
    35df:	6a 00                	push   $0x0
    35e1:	e8 45 03 00 00       	call   392b <sbrk>
    35e6:	83 c4 0c             	add    $0xc,%esp
    35e9:	83 e8 01             	sub    $0x1,%eax
    35ec:	6a ff                	push   $0xffffffff
    35ee:	50                   	push   %eax
    35ef:	53                   	push   %ebx
    35f0:	e8 c6 02 00 00       	call   38bb <read>
  close(fd);
    35f5:	89 1c 24             	mov    %ebx,(%esp)
    35f8:	e8 ce 02 00 00       	call   38cb <close>
  printf(1, "arg test passed\n");
    35fd:	58                   	pop    %eax
    35fe:	5a                   	pop    %edx
    35ff:	68 05 4d 00 00       	push   $0x4d05
    3604:	6a 01                	push   $0x1
    3606:	e8 f5 03 00 00       	call   3a00 <printf>
}
    360b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    360e:	83 c4 10             	add    $0x10,%esp
    3611:	c9                   	leave  
    3612:	c3                   	ret    
    printf(2, "open failed\n");
    3613:	51                   	push   %ecx
    3614:	51                   	push   %ecx
    3615:	68 f8 4c 00 00       	push   $0x4cf8
    361a:	6a 02                	push   $0x2
    361c:	e8 df 03 00 00       	call   3a00 <printf>
    exit();
    3621:	e8 7d 02 00 00       	call   38a3 <exit>
    3626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    362d:	8d 76 00             	lea    0x0(%esi),%esi

00003630 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3630:	69 05 e4 5d 00 00 0d 	imul   $0x19660d,0x5de4,%eax
    3637:	66 19 00 
    363a:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    363f:	a3 e4 5d 00 00       	mov    %eax,0x5de4
}
    3644:	c3                   	ret    
    3645:	66 90                	xchg   %ax,%ax
    3647:	66 90                	xchg   %ax,%ax
    3649:	66 90                	xchg   %ax,%ax
    364b:	66 90                	xchg   %ax,%ax
    364d:	66 90                	xchg   %ax,%ax
    364f:	90                   	nop

00003650 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3650:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3651:	31 c0                	xor    %eax,%eax
{
    3653:	89 e5                	mov    %esp,%ebp
    3655:	53                   	push   %ebx
    3656:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3659:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    365c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3660:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3664:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3667:	83 c0 01             	add    $0x1,%eax
    366a:	84 d2                	test   %dl,%dl
    366c:	75 f2                	jne    3660 <strcpy+0x10>
    ;
  return os;
}
    366e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3671:	89 c8                	mov    %ecx,%eax
    3673:	c9                   	leave  
    3674:	c3                   	ret    
    3675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    367c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003680 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3680:	55                   	push   %ebp
    3681:	89 e5                	mov    %esp,%ebp
    3683:	53                   	push   %ebx
    3684:	8b 55 08             	mov    0x8(%ebp),%edx
    3687:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    368a:	0f b6 02             	movzbl (%edx),%eax
    368d:	84 c0                	test   %al,%al
    368f:	75 17                	jne    36a8 <strcmp+0x28>
    3691:	eb 3a                	jmp    36cd <strcmp+0x4d>
    3693:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3697:	90                   	nop
    3698:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    369c:	83 c2 01             	add    $0x1,%edx
    369f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    36a2:	84 c0                	test   %al,%al
    36a4:	74 1a                	je     36c0 <strcmp+0x40>
    p++, q++;
    36a6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    36a8:	0f b6 19             	movzbl (%ecx),%ebx
    36ab:	38 c3                	cmp    %al,%bl
    36ad:	74 e9                	je     3698 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    36af:	29 d8                	sub    %ebx,%eax
}
    36b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36b4:	c9                   	leave  
    36b5:	c3                   	ret    
    36b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36bd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    36c0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    36c4:	31 c0                	xor    %eax,%eax
    36c6:	29 d8                	sub    %ebx,%eax
}
    36c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36cb:	c9                   	leave  
    36cc:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    36cd:	0f b6 19             	movzbl (%ecx),%ebx
    36d0:	31 c0                	xor    %eax,%eax
    36d2:	eb db                	jmp    36af <strcmp+0x2f>
    36d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    36df:	90                   	nop

000036e0 <strlen>:

uint
strlen(const char *s)
{
    36e0:	55                   	push   %ebp
    36e1:	89 e5                	mov    %esp,%ebp
    36e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    36e6:	80 3a 00             	cmpb   $0x0,(%edx)
    36e9:	74 15                	je     3700 <strlen+0x20>
    36eb:	31 c0                	xor    %eax,%eax
    36ed:	8d 76 00             	lea    0x0(%esi),%esi
    36f0:	83 c0 01             	add    $0x1,%eax
    36f3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    36f7:	89 c1                	mov    %eax,%ecx
    36f9:	75 f5                	jne    36f0 <strlen+0x10>
    ;
  return n;
}
    36fb:	89 c8                	mov    %ecx,%eax
    36fd:	5d                   	pop    %ebp
    36fe:	c3                   	ret    
    36ff:	90                   	nop
  for(n = 0; s[n]; n++)
    3700:	31 c9                	xor    %ecx,%ecx
}
    3702:	5d                   	pop    %ebp
    3703:	89 c8                	mov    %ecx,%eax
    3705:	c3                   	ret    
    3706:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    370d:	8d 76 00             	lea    0x0(%esi),%esi

00003710 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3710:	55                   	push   %ebp
    3711:	89 e5                	mov    %esp,%ebp
    3713:	57                   	push   %edi
    3714:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3717:	8b 4d 10             	mov    0x10(%ebp),%ecx
    371a:	8b 45 0c             	mov    0xc(%ebp),%eax
    371d:	89 d7                	mov    %edx,%edi
    371f:	fc                   	cld    
    3720:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3722:	8b 7d fc             	mov    -0x4(%ebp),%edi
    3725:	89 d0                	mov    %edx,%eax
    3727:	c9                   	leave  
    3728:	c3                   	ret    
    3729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003730 <strchr>:

char*
strchr(const char *s, char c)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	8b 45 08             	mov    0x8(%ebp),%eax
    3736:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    373a:	0f b6 10             	movzbl (%eax),%edx
    373d:	84 d2                	test   %dl,%dl
    373f:	75 12                	jne    3753 <strchr+0x23>
    3741:	eb 1d                	jmp    3760 <strchr+0x30>
    3743:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3747:	90                   	nop
    3748:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    374c:	83 c0 01             	add    $0x1,%eax
    374f:	84 d2                	test   %dl,%dl
    3751:	74 0d                	je     3760 <strchr+0x30>
    if(*s == c)
    3753:	38 d1                	cmp    %dl,%cl
    3755:	75 f1                	jne    3748 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3757:	5d                   	pop    %ebp
    3758:	c3                   	ret    
    3759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3760:	31 c0                	xor    %eax,%eax
}
    3762:	5d                   	pop    %ebp
    3763:	c3                   	ret    
    3764:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    376b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    376f:	90                   	nop

00003770 <gets>:

char*
gets(char *buf, int max)
{
    3770:	55                   	push   %ebp
    3771:	89 e5                	mov    %esp,%ebp
    3773:	57                   	push   %edi
    3774:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3775:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3778:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3779:	31 db                	xor    %ebx,%ebx
{
    377b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    377e:	eb 27                	jmp    37a7 <gets+0x37>
    cc = read(0, &c, 1);
    3780:	83 ec 04             	sub    $0x4,%esp
    3783:	6a 01                	push   $0x1
    3785:	57                   	push   %edi
    3786:	6a 00                	push   $0x0
    3788:	e8 2e 01 00 00       	call   38bb <read>
    if(cc < 1)
    378d:	83 c4 10             	add    $0x10,%esp
    3790:	85 c0                	test   %eax,%eax
    3792:	7e 1d                	jle    37b1 <gets+0x41>
      break;
    buf[i++] = c;
    3794:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3798:	8b 55 08             	mov    0x8(%ebp),%edx
    379b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    379f:	3c 0a                	cmp    $0xa,%al
    37a1:	74 1d                	je     37c0 <gets+0x50>
    37a3:	3c 0d                	cmp    $0xd,%al
    37a5:	74 19                	je     37c0 <gets+0x50>
  for(i=0; i+1 < max; ){
    37a7:	89 de                	mov    %ebx,%esi
    37a9:	83 c3 01             	add    $0x1,%ebx
    37ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    37af:	7c cf                	jl     3780 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    37b1:	8b 45 08             	mov    0x8(%ebp),%eax
    37b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    37b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37bb:	5b                   	pop    %ebx
    37bc:	5e                   	pop    %esi
    37bd:	5f                   	pop    %edi
    37be:	5d                   	pop    %ebp
    37bf:	c3                   	ret    
  buf[i] = '\0';
    37c0:	8b 45 08             	mov    0x8(%ebp),%eax
    37c3:	89 de                	mov    %ebx,%esi
    37c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    37c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37cc:	5b                   	pop    %ebx
    37cd:	5e                   	pop    %esi
    37ce:	5f                   	pop    %edi
    37cf:	5d                   	pop    %ebp
    37d0:	c3                   	ret    
    37d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37df:	90                   	nop

000037e0 <stat>:

int
stat(const char *n, struct stat *st)
{
    37e0:	55                   	push   %ebp
    37e1:	89 e5                	mov    %esp,%ebp
    37e3:	56                   	push   %esi
    37e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37e5:	83 ec 08             	sub    $0x8,%esp
    37e8:	6a 00                	push   $0x0
    37ea:	ff 75 08             	push   0x8(%ebp)
    37ed:	e8 f1 00 00 00       	call   38e3 <open>
  if(fd < 0)
    37f2:	83 c4 10             	add    $0x10,%esp
    37f5:	85 c0                	test   %eax,%eax
    37f7:	78 27                	js     3820 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    37f9:	83 ec 08             	sub    $0x8,%esp
    37fc:	ff 75 0c             	push   0xc(%ebp)
    37ff:	89 c3                	mov    %eax,%ebx
    3801:	50                   	push   %eax
    3802:	e8 f4 00 00 00       	call   38fb <fstat>
  close(fd);
    3807:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    380a:	89 c6                	mov    %eax,%esi
  close(fd);
    380c:	e8 ba 00 00 00       	call   38cb <close>
  return r;
    3811:	83 c4 10             	add    $0x10,%esp
}
    3814:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3817:	89 f0                	mov    %esi,%eax
    3819:	5b                   	pop    %ebx
    381a:	5e                   	pop    %esi
    381b:	5d                   	pop    %ebp
    381c:	c3                   	ret    
    381d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3820:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3825:	eb ed                	jmp    3814 <stat+0x34>
    3827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    382e:	66 90                	xchg   %ax,%ax

00003830 <atoi>:

int
atoi(const char *s)
{
    3830:	55                   	push   %ebp
    3831:	89 e5                	mov    %esp,%ebp
    3833:	53                   	push   %ebx
    3834:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3837:	0f be 02             	movsbl (%edx),%eax
    383a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    383d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3840:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3845:	77 1e                	ja     3865 <atoi+0x35>
    3847:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    384e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3850:	83 c2 01             	add    $0x1,%edx
    3853:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3856:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    385a:	0f be 02             	movsbl (%edx),%eax
    385d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3860:	80 fb 09             	cmp    $0x9,%bl
    3863:	76 eb                	jbe    3850 <atoi+0x20>
  return n;
}
    3865:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3868:	89 c8                	mov    %ecx,%eax
    386a:	c9                   	leave  
    386b:	c3                   	ret    
    386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003870 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3870:	55                   	push   %ebp
    3871:	89 e5                	mov    %esp,%ebp
    3873:	57                   	push   %edi
    3874:	8b 45 10             	mov    0x10(%ebp),%eax
    3877:	8b 55 08             	mov    0x8(%ebp),%edx
    387a:	56                   	push   %esi
    387b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    387e:	85 c0                	test   %eax,%eax
    3880:	7e 13                	jle    3895 <memmove+0x25>
    3882:	01 d0                	add    %edx,%eax
  dst = vdst;
    3884:	89 d7                	mov    %edx,%edi
    3886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    388d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3890:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3891:	39 f8                	cmp    %edi,%eax
    3893:	75 fb                	jne    3890 <memmove+0x20>
  return vdst;
}
    3895:	5e                   	pop    %esi
    3896:	89 d0                	mov    %edx,%eax
    3898:	5f                   	pop    %edi
    3899:	5d                   	pop    %ebp
    389a:	c3                   	ret    

0000389b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    389b:	b8 01 00 00 00       	mov    $0x1,%eax
    38a0:	cd 40                	int    $0x40
    38a2:	c3                   	ret    

000038a3 <exit>:
SYSCALL(exit)
    38a3:	b8 02 00 00 00       	mov    $0x2,%eax
    38a8:	cd 40                	int    $0x40
    38aa:	c3                   	ret    

000038ab <wait>:
SYSCALL(wait)
    38ab:	b8 03 00 00 00       	mov    $0x3,%eax
    38b0:	cd 40                	int    $0x40
    38b2:	c3                   	ret    

000038b3 <pipe>:
SYSCALL(pipe)
    38b3:	b8 04 00 00 00       	mov    $0x4,%eax
    38b8:	cd 40                	int    $0x40
    38ba:	c3                   	ret    

000038bb <read>:
SYSCALL(read)
    38bb:	b8 05 00 00 00       	mov    $0x5,%eax
    38c0:	cd 40                	int    $0x40
    38c2:	c3                   	ret    

000038c3 <write>:
SYSCALL(write)
    38c3:	b8 10 00 00 00       	mov    $0x10,%eax
    38c8:	cd 40                	int    $0x40
    38ca:	c3                   	ret    

000038cb <close>:
SYSCALL(close)
    38cb:	b8 15 00 00 00       	mov    $0x15,%eax
    38d0:	cd 40                	int    $0x40
    38d2:	c3                   	ret    

000038d3 <kill>:
SYSCALL(kill)
    38d3:	b8 06 00 00 00       	mov    $0x6,%eax
    38d8:	cd 40                	int    $0x40
    38da:	c3                   	ret    

000038db <exec>:
SYSCALL(exec)
    38db:	b8 07 00 00 00       	mov    $0x7,%eax
    38e0:	cd 40                	int    $0x40
    38e2:	c3                   	ret    

000038e3 <open>:
SYSCALL(open)
    38e3:	b8 0f 00 00 00       	mov    $0xf,%eax
    38e8:	cd 40                	int    $0x40
    38ea:	c3                   	ret    

000038eb <mknod>:
SYSCALL(mknod)
    38eb:	b8 11 00 00 00       	mov    $0x11,%eax
    38f0:	cd 40                	int    $0x40
    38f2:	c3                   	ret    

000038f3 <unlink>:
SYSCALL(unlink)
    38f3:	b8 12 00 00 00       	mov    $0x12,%eax
    38f8:	cd 40                	int    $0x40
    38fa:	c3                   	ret    

000038fb <fstat>:
SYSCALL(fstat)
    38fb:	b8 08 00 00 00       	mov    $0x8,%eax
    3900:	cd 40                	int    $0x40
    3902:	c3                   	ret    

00003903 <link>:
SYSCALL(link)
    3903:	b8 13 00 00 00       	mov    $0x13,%eax
    3908:	cd 40                	int    $0x40
    390a:	c3                   	ret    

0000390b <mkdir>:
SYSCALL(mkdir)
    390b:	b8 14 00 00 00       	mov    $0x14,%eax
    3910:	cd 40                	int    $0x40
    3912:	c3                   	ret    

00003913 <chdir>:
SYSCALL(chdir)
    3913:	b8 09 00 00 00       	mov    $0x9,%eax
    3918:	cd 40                	int    $0x40
    391a:	c3                   	ret    

0000391b <dup>:
SYSCALL(dup)
    391b:	b8 0a 00 00 00       	mov    $0xa,%eax
    3920:	cd 40                	int    $0x40
    3922:	c3                   	ret    

00003923 <getpid>:
SYSCALL(getpid)
    3923:	b8 0b 00 00 00       	mov    $0xb,%eax
    3928:	cd 40                	int    $0x40
    392a:	c3                   	ret    

0000392b <sbrk>:
SYSCALL(sbrk)
    392b:	b8 0c 00 00 00       	mov    $0xc,%eax
    3930:	cd 40                	int    $0x40
    3932:	c3                   	ret    

00003933 <sleep>:
SYSCALL(sleep)
    3933:	b8 0d 00 00 00       	mov    $0xd,%eax
    3938:	cd 40                	int    $0x40
    393a:	c3                   	ret    

0000393b <uptime>:
SYSCALL(uptime)
    393b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3940:	cd 40                	int    $0x40
    3942:	c3                   	ret    
    3943:	66 90                	xchg   %ax,%ax
    3945:	66 90                	xchg   %ax,%ax
    3947:	66 90                	xchg   %ax,%ax
    3949:	66 90                	xchg   %ax,%ax
    394b:	66 90                	xchg   %ax,%ax
    394d:	66 90                	xchg   %ax,%ax
    394f:	90                   	nop

00003950 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3950:	55                   	push   %ebp
    3951:	89 e5                	mov    %esp,%ebp
    3953:	57                   	push   %edi
    3954:	56                   	push   %esi
    3955:	53                   	push   %ebx
    3956:	83 ec 3c             	sub    $0x3c,%esp
    3959:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    395c:	89 d1                	mov    %edx,%ecx
{
    395e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3961:	85 d2                	test   %edx,%edx
    3963:	0f 89 7f 00 00 00    	jns    39e8 <printint+0x98>
    3969:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    396d:	74 79                	je     39e8 <printint+0x98>
    neg = 1;
    396f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3976:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3978:	31 db                	xor    %ebx,%ebx
    397a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    397d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3980:	89 c8                	mov    %ecx,%eax
    3982:	31 d2                	xor    %edx,%edx
    3984:	89 cf                	mov    %ecx,%edi
    3986:	f7 75 c4             	divl   -0x3c(%ebp)
    3989:	0f b6 92 f0 54 00 00 	movzbl 0x54f0(%edx),%edx
    3990:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3993:	89 d8                	mov    %ebx,%eax
    3995:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3998:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    399b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    399e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    39a1:	76 dd                	jbe    3980 <printint+0x30>
  if(neg)
    39a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    39a6:	85 c9                	test   %ecx,%ecx
    39a8:	74 0c                	je     39b6 <printint+0x66>
    buf[i++] = '-';
    39aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    39af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    39b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    39b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    39b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    39bd:	eb 07                	jmp    39c6 <printint+0x76>
    39bf:	90                   	nop
    putc(fd, buf[i]);
    39c0:	0f b6 13             	movzbl (%ebx),%edx
    39c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    39c6:	83 ec 04             	sub    $0x4,%esp
    39c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    39cc:	6a 01                	push   $0x1
    39ce:	56                   	push   %esi
    39cf:	57                   	push   %edi
    39d0:	e8 ee fe ff ff       	call   38c3 <write>
  while(--i >= 0)
    39d5:	83 c4 10             	add    $0x10,%esp
    39d8:	39 de                	cmp    %ebx,%esi
    39da:	75 e4                	jne    39c0 <printint+0x70>
}
    39dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    39df:	5b                   	pop    %ebx
    39e0:	5e                   	pop    %esi
    39e1:	5f                   	pop    %edi
    39e2:	5d                   	pop    %ebp
    39e3:	c3                   	ret    
    39e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    39e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    39ef:	eb 87                	jmp    3978 <printint+0x28>
    39f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    39ff:	90                   	nop

00003a00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3a00:	55                   	push   %ebp
    3a01:	89 e5                	mov    %esp,%ebp
    3a03:	57                   	push   %edi
    3a04:	56                   	push   %esi
    3a05:	53                   	push   %ebx
    3a06:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3a09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3a0c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3a0f:	0f b6 13             	movzbl (%ebx),%edx
    3a12:	84 d2                	test   %dl,%dl
    3a14:	74 6a                	je     3a80 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3a16:	8d 45 10             	lea    0x10(%ebp),%eax
    3a19:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3a1c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3a1f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3a21:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3a24:	eb 36                	jmp    3a5c <printf+0x5c>
    3a26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a2d:	8d 76 00             	lea    0x0(%esi),%esi
    3a30:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3a33:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3a38:	83 f8 25             	cmp    $0x25,%eax
    3a3b:	74 15                	je     3a52 <printf+0x52>
  write(fd, &c, 1);
    3a3d:	83 ec 04             	sub    $0x4,%esp
    3a40:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3a43:	6a 01                	push   $0x1
    3a45:	57                   	push   %edi
    3a46:	56                   	push   %esi
    3a47:	e8 77 fe ff ff       	call   38c3 <write>
    3a4c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3a4f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a52:	0f b6 13             	movzbl (%ebx),%edx
    3a55:	83 c3 01             	add    $0x1,%ebx
    3a58:	84 d2                	test   %dl,%dl
    3a5a:	74 24                	je     3a80 <printf+0x80>
    c = fmt[i] & 0xff;
    3a5c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3a5f:	85 c9                	test   %ecx,%ecx
    3a61:	74 cd                	je     3a30 <printf+0x30>
      }
    } else if(state == '%'){
    3a63:	83 f9 25             	cmp    $0x25,%ecx
    3a66:	75 ea                	jne    3a52 <printf+0x52>
      if(c == 'd'){
    3a68:	83 f8 25             	cmp    $0x25,%eax
    3a6b:	0f 84 07 01 00 00    	je     3b78 <printf+0x178>
    3a71:	83 e8 63             	sub    $0x63,%eax
    3a74:	83 f8 15             	cmp    $0x15,%eax
    3a77:	77 17                	ja     3a90 <printf+0x90>
    3a79:	ff 24 85 98 54 00 00 	jmp    *0x5498(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3a80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a83:	5b                   	pop    %ebx
    3a84:	5e                   	pop    %esi
    3a85:	5f                   	pop    %edi
    3a86:	5d                   	pop    %ebp
    3a87:	c3                   	ret    
    3a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a8f:	90                   	nop
  write(fd, &c, 1);
    3a90:	83 ec 04             	sub    $0x4,%esp
    3a93:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3a96:	6a 01                	push   $0x1
    3a98:	57                   	push   %edi
    3a99:	56                   	push   %esi
    3a9a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3a9e:	e8 20 fe ff ff       	call   38c3 <write>
        putc(fd, c);
    3aa3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3aa7:	83 c4 0c             	add    $0xc,%esp
    3aaa:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3aad:	6a 01                	push   $0x1
    3aaf:	57                   	push   %edi
    3ab0:	56                   	push   %esi
    3ab1:	e8 0d fe ff ff       	call   38c3 <write>
        putc(fd, c);
    3ab6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3ab9:	31 c9                	xor    %ecx,%ecx
    3abb:	eb 95                	jmp    3a52 <printf+0x52>
    3abd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3ac0:	83 ec 0c             	sub    $0xc,%esp
    3ac3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3ac8:	6a 00                	push   $0x0
    3aca:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3acd:	8b 10                	mov    (%eax),%edx
    3acf:	89 f0                	mov    %esi,%eax
    3ad1:	e8 7a fe ff ff       	call   3950 <printint>
        ap++;
    3ad6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3ada:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3add:	31 c9                	xor    %ecx,%ecx
    3adf:	e9 6e ff ff ff       	jmp    3a52 <printf+0x52>
    3ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3ae8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3aeb:	8b 10                	mov    (%eax),%edx
        ap++;
    3aed:	83 c0 04             	add    $0x4,%eax
    3af0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3af3:	85 d2                	test   %edx,%edx
    3af5:	0f 84 8d 00 00 00    	je     3b88 <printf+0x188>
        while(*s != 0){
    3afb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3afe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3b00:	84 c0                	test   %al,%al
    3b02:	0f 84 4a ff ff ff    	je     3a52 <printf+0x52>
    3b08:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3b0b:	89 d3                	mov    %edx,%ebx
    3b0d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b10:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b13:	83 c3 01             	add    $0x1,%ebx
    3b16:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b19:	6a 01                	push   $0x1
    3b1b:	57                   	push   %edi
    3b1c:	56                   	push   %esi
    3b1d:	e8 a1 fd ff ff       	call   38c3 <write>
        while(*s != 0){
    3b22:	0f b6 03             	movzbl (%ebx),%eax
    3b25:	83 c4 10             	add    $0x10,%esp
    3b28:	84 c0                	test   %al,%al
    3b2a:	75 e4                	jne    3b10 <printf+0x110>
      state = 0;
    3b2c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3b2f:	31 c9                	xor    %ecx,%ecx
    3b31:	e9 1c ff ff ff       	jmp    3a52 <printf+0x52>
    3b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b3d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3b40:	83 ec 0c             	sub    $0xc,%esp
    3b43:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b48:	6a 01                	push   $0x1
    3b4a:	e9 7b ff ff ff       	jmp    3aca <printf+0xca>
    3b4f:	90                   	nop
        putc(fd, *ap);
    3b50:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3b53:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b56:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3b58:	6a 01                	push   $0x1
    3b5a:	57                   	push   %edi
    3b5b:	56                   	push   %esi
        putc(fd, *ap);
    3b5c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3b5f:	e8 5f fd ff ff       	call   38c3 <write>
        ap++;
    3b64:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3b68:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b6b:	31 c9                	xor    %ecx,%ecx
    3b6d:	e9 e0 fe ff ff       	jmp    3a52 <printf+0x52>
    3b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3b78:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3b7b:	83 ec 04             	sub    $0x4,%esp
    3b7e:	e9 2a ff ff ff       	jmp    3aad <printf+0xad>
    3b83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3b87:	90                   	nop
          s = "(null)";
    3b88:	ba 8e 54 00 00       	mov    $0x548e,%edx
        while(*s != 0){
    3b8d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3b90:	b8 28 00 00 00       	mov    $0x28,%eax
    3b95:	89 d3                	mov    %edx,%ebx
    3b97:	e9 74 ff ff ff       	jmp    3b10 <printf+0x110>
    3b9c:	66 90                	xchg   %ax,%ax
    3b9e:	66 90                	xchg   %ax,%ax

00003ba0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3ba0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3ba1:	a1 a0 a5 00 00       	mov    0xa5a0,%eax
{
    3ba6:	89 e5                	mov    %esp,%ebp
    3ba8:	57                   	push   %edi
    3ba9:	56                   	push   %esi
    3baa:	53                   	push   %ebx
    3bab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3bb8:	89 c2                	mov    %eax,%edx
    3bba:	8b 00                	mov    (%eax),%eax
    3bbc:	39 ca                	cmp    %ecx,%edx
    3bbe:	73 30                	jae    3bf0 <free+0x50>
    3bc0:	39 c1                	cmp    %eax,%ecx
    3bc2:	72 04                	jb     3bc8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bc4:	39 c2                	cmp    %eax,%edx
    3bc6:	72 f0                	jb     3bb8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3bc8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3bcb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bce:	39 f8                	cmp    %edi,%eax
    3bd0:	74 30                	je     3c02 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3bd2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3bd5:	8b 42 04             	mov    0x4(%edx),%eax
    3bd8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3bdb:	39 f1                	cmp    %esi,%ecx
    3bdd:	74 3a                	je     3c19 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3bdf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3be1:	5b                   	pop    %ebx
  freep = p;
    3be2:	89 15 a0 a5 00 00    	mov    %edx,0xa5a0
}
    3be8:	5e                   	pop    %esi
    3be9:	5f                   	pop    %edi
    3bea:	5d                   	pop    %ebp
    3beb:	c3                   	ret    
    3bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bf0:	39 c2                	cmp    %eax,%edx
    3bf2:	72 c4                	jb     3bb8 <free+0x18>
    3bf4:	39 c1                	cmp    %eax,%ecx
    3bf6:	73 c0                	jae    3bb8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3bf8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3bfb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bfe:	39 f8                	cmp    %edi,%eax
    3c00:	75 d0                	jne    3bd2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3c02:	03 70 04             	add    0x4(%eax),%esi
    3c05:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c08:	8b 02                	mov    (%edx),%eax
    3c0a:	8b 00                	mov    (%eax),%eax
    3c0c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c0f:	8b 42 04             	mov    0x4(%edx),%eax
    3c12:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3c15:	39 f1                	cmp    %esi,%ecx
    3c17:	75 c6                	jne    3bdf <free+0x3f>
    p->s.size += bp->s.size;
    3c19:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3c1c:	89 15 a0 a5 00 00    	mov    %edx,0xa5a0
    p->s.size += bp->s.size;
    3c22:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3c25:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3c28:	89 0a                	mov    %ecx,(%edx)
}
    3c2a:	5b                   	pop    %ebx
    3c2b:	5e                   	pop    %esi
    3c2c:	5f                   	pop    %edi
    3c2d:	5d                   	pop    %ebp
    3c2e:	c3                   	ret    
    3c2f:	90                   	nop

00003c30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c30:	55                   	push   %ebp
    3c31:	89 e5                	mov    %esp,%ebp
    3c33:	57                   	push   %edi
    3c34:	56                   	push   %esi
    3c35:	53                   	push   %ebx
    3c36:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c3c:	8b 3d a0 a5 00 00    	mov    0xa5a0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c42:	8d 70 07             	lea    0x7(%eax),%esi
    3c45:	c1 ee 03             	shr    $0x3,%esi
    3c48:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3c4b:	85 ff                	test   %edi,%edi
    3c4d:	0f 84 9d 00 00 00    	je     3cf0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c53:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3c55:	8b 4a 04             	mov    0x4(%edx),%ecx
    3c58:	39 f1                	cmp    %esi,%ecx
    3c5a:	73 6a                	jae    3cc6 <malloc+0x96>
    3c5c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c61:	39 de                	cmp    %ebx,%esi
    3c63:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3c66:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3c6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3c70:	eb 17                	jmp    3c89 <malloc+0x59>
    3c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3c7a:	8b 48 04             	mov    0x4(%eax),%ecx
    3c7d:	39 f1                	cmp    %esi,%ecx
    3c7f:	73 4f                	jae    3cd0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3c81:	8b 3d a0 a5 00 00    	mov    0xa5a0,%edi
    3c87:	89 c2                	mov    %eax,%edx
    3c89:	39 d7                	cmp    %edx,%edi
    3c8b:	75 eb                	jne    3c78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3c8d:	83 ec 0c             	sub    $0xc,%esp
    3c90:	ff 75 e4             	push   -0x1c(%ebp)
    3c93:	e8 93 fc ff ff       	call   392b <sbrk>
  if(p == (char*)-1)
    3c98:	83 c4 10             	add    $0x10,%esp
    3c9b:	83 f8 ff             	cmp    $0xffffffff,%eax
    3c9e:	74 1c                	je     3cbc <malloc+0x8c>
  hp->s.size = nu;
    3ca0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3ca3:	83 ec 0c             	sub    $0xc,%esp
    3ca6:	83 c0 08             	add    $0x8,%eax
    3ca9:	50                   	push   %eax
    3caa:	e8 f1 fe ff ff       	call   3ba0 <free>
  return freep;
    3caf:	8b 15 a0 a5 00 00    	mov    0xa5a0,%edx
      if((p = morecore(nunits)) == 0)
    3cb5:	83 c4 10             	add    $0x10,%esp
    3cb8:	85 d2                	test   %edx,%edx
    3cba:	75 bc                	jne    3c78 <malloc+0x48>
        return 0;
  }
}
    3cbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3cbf:	31 c0                	xor    %eax,%eax
}
    3cc1:	5b                   	pop    %ebx
    3cc2:	5e                   	pop    %esi
    3cc3:	5f                   	pop    %edi
    3cc4:	5d                   	pop    %ebp
    3cc5:	c3                   	ret    
    if(p->s.size >= nunits){
    3cc6:	89 d0                	mov    %edx,%eax
    3cc8:	89 fa                	mov    %edi,%edx
    3cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3cd0:	39 ce                	cmp    %ecx,%esi
    3cd2:	74 4c                	je     3d20 <malloc+0xf0>
        p->s.size -= nunits;
    3cd4:	29 f1                	sub    %esi,%ecx
    3cd6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3cd9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3cdc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    3cdf:	89 15 a0 a5 00 00    	mov    %edx,0xa5a0
}
    3ce5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3ce8:	83 c0 08             	add    $0x8,%eax
}
    3ceb:	5b                   	pop    %ebx
    3cec:	5e                   	pop    %esi
    3ced:	5f                   	pop    %edi
    3cee:	5d                   	pop    %ebp
    3cef:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3cf0:	c7 05 a0 a5 00 00 a4 	movl   $0xa5a4,0xa5a0
    3cf7:	a5 00 00 
    base.s.size = 0;
    3cfa:	bf a4 a5 00 00       	mov    $0xa5a4,%edi
    base.s.ptr = freep = prevp = &base;
    3cff:	c7 05 a4 a5 00 00 a4 	movl   $0xa5a4,0xa5a4
    3d06:	a5 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d09:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    3d0b:	c7 05 a8 a5 00 00 00 	movl   $0x0,0xa5a8
    3d12:	00 00 00 
    if(p->s.size >= nunits){
    3d15:	e9 42 ff ff ff       	jmp    3c5c <malloc+0x2c>
    3d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3d20:	8b 08                	mov    (%eax),%ecx
    3d22:	89 0a                	mov    %ecx,(%edx)
    3d24:	eb b9                	jmp    3cdf <malloc+0xaf>
