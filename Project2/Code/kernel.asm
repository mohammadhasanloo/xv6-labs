
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 10 62 11 80       	mov    $0x80116210,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 90 3a 10 80       	mov    $0x80103a90,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb 54 62 11 80       	mov    $0x80116254,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 80 7f 10 80       	push   $0x80107f80
80100055:	68 20 62 11 80       	push   $0x80116220
8010005a:	e8 91 50 00 00       	call   801050f0 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 1c a9 11 80       	mov    $0x8011a91c,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 6c a9 11 80 1c 	movl   $0x8011a91c,0x8011a96c
8010006e:	a9 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 70 a9 11 80 1c 	movl   $0x8011a91c,0x8011a970
80100078:	a9 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c a9 11 80 	movl   $0x8011a91c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 7f 10 80       	push   $0x80107f87
80100097:	50                   	push   %eax
80100098:	e8 13 4f 00 00       	call   80104fb0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 a9 11 80       	mov    0x8011a970,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 a9 11 80    	mov    %ebx,0x8011a970
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 a6 11 80    	cmp    $0x8011a6c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 20 62 11 80       	push   $0x80116220
801000e8:	e8 83 51 00 00       	call   80105270 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 70 a9 11 80    	mov    0x8011a970,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb 1c a9 11 80    	cmp    $0x8011a91c,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c a9 11 80    	cmp    $0x8011a91c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c a9 11 80    	mov    0x8011a96c,%ebx
80100126:	81 fb 1c a9 11 80    	cmp    $0x8011a91c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c a9 11 80    	cmp    $0x8011a91c,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 62 11 80       	push   $0x80116220
80100162:	e8 c9 51 00 00       	call   80105330 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 4e 00 00       	call   80104ff0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 3f 2b 00 00       	call   80102cd0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 8e 7f 10 80       	push   $0x80107f8e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 c9 4e 00 00       	call   80105090 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 f3 2a 00 00       	jmp    80102cd0 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 9f 7f 10 80       	push   $0x80107f9f
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 88 4e 00 00       	call   80105090 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 38 4e 00 00       	call   80105050 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 20 62 11 80 	movl   $0x80116220,(%esp)
8010021f:	e8 4c 50 00 00       	call   80105270 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 70 a9 11 80       	mov    0x8011a970,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 1c a9 11 80 	movl   $0x8011a91c,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 70 a9 11 80       	mov    0x8011a970,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 70 a9 11 80    	mov    %ebx,0x8011a970
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 20 62 11 80 	movl   $0x80116220,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 bb 50 00 00       	jmp    80105330 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 a6 7f 10 80       	push   $0x80107fa6
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
8010029d:	ff 75 08             	pushl  0x8(%ebp)
{
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
801002a3:	89 de                	mov    %ebx,%esi
  iunlock(ip);
801002a5:	e8 e6 1f 00 00       	call   80102290 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801002b1:	e8 ba 4f 00 00       	call   80105270 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002bc:	01 df                	add    %ebx,%edi
  while(n > 0){
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
    while(input.r == input.w){
801002c6:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
801002cb:	3b 05 84 ac 11 80    	cmp    0x8011ac84,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 20 b5 10 80       	push   $0x8010b520
801002e0:	68 80 ac 11 80       	push   $0x8011ac80
801002e5:	e8 16 47 00 00       	call   80104a00 <sleep>
    while(input.r == input.w){
801002ea:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 84 ac 11 80    	cmp    0x8011ac84,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 01 41 00 00       	call   80104400 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 20 b5 10 80       	push   $0x8010b520
8010030e:	e8 1d 50 00 00       	call   80105330 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 94 1e 00 00       	call   801021b0 <ilock>
        return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 80 ac 11 80    	mov    %edx,0x8011ac80
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 00 ac 11 80 	movsbl -0x7fee5400(%edx),%ecx
    if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
    *dst++ = c;
8010034a:	89 d8                	mov    %ebx,%eax
    --n;
8010034c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
  release(&cons.lock);
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 20 b5 10 80       	push   $0x8010b520
80100365:	e8 c6 4f 00 00       	call   80105330 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 3d 1e 00 00       	call   801021b0 <ilock>
  return target - n;
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
}
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037b:	29 d8                	sub    %ebx,%eax
}
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
      if(n < target){
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
        input.r--;
80100386:	a3 80 ac 11 80       	mov    %eax,0x8011ac80
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
  cons.locking = 0;
8010039d:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 3e 2f 00 00       	call   801032f0 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 ad 7f 10 80       	push   $0x80107fad
801003bb:	e8 30 03 00 00       	call   801006f0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 27 03 00 00       	call   801006f0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 37 89 10 80 	movl   $0x80108937,(%esp)
801003d0:	e8 1b 03 00 00       	call   801006f0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 2f 4d 00 00       	call   80105110 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 c1 7f 10 80       	push   $0x80107fc1
801003f1:	e8 fa 02 00 00       	call   801006f0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100404:	00 00 00 
  for(;;)
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	89 c6                	mov    %eax,%esi
80100417:	53                   	push   %ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  switch (c) {
8010041b:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100420:	0f 84 52 01 00 00    	je     80100578 <consputc.part.0+0x168>
80100426:	3d 00 01 00 00       	cmp    $0x100,%eax
8010042b:	0f 85 5f 01 00 00    	jne    80100590 <consputc.part.0+0x180>
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
80100431:	83 ec 0c             	sub    $0xc,%esp
80100434:	6a 08                	push   $0x8
80100436:	e8 35 67 00 00       	call   80106b70 <uartputc>
8010043b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100442:	e8 29 67 00 00       	call   80106b70 <uartputc>
80100447:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010044e:	e8 1d 67 00 00       	call   80106b70 <uartputc>
      break;
80100453:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100456:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010045b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100460:	89 da                	mov    %ebx,%edx
80100462:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100463:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100468:	89 ca                	mov    %ecx,%edx
8010046a:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
8010046b:	0f b6 f8             	movzbl %al,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010046e:	89 da                	mov    %ebx,%edx
80100470:	b8 0f 00 00 00       	mov    $0xf,%eax
80100475:	c1 e7 08             	shl    $0x8,%edi
80100478:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100479:	89 ca                	mov    %ecx,%edx
8010047b:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010047c:	0f b6 d8             	movzbl %al,%ebx
8010047f:	09 fb                	or     %edi,%ebx
  switch(c) {
80100481:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100487:	0f 84 db 00 00 00    	je     80100568 <consputc.part.0+0x158>
8010048d:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100493:	0f 84 cf 00 00 00    	je     80100568 <consputc.part.0+0x158>
80100499:	83 fe 0a             	cmp    $0xa,%esi
8010049c:	0f 84 16 01 00 00    	je     801005b8 <consputc.part.0+0x1a8>
      crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004a2:	89 f0                	mov    %esi,%eax
801004a4:	0f b6 c0             	movzbl %al,%eax
801004a7:	80 cc 07             	or     $0x7,%ah
801004aa:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004b1:	80 
801004b2:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
801004b5:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004bb:	0f 8f 11 01 00 00    	jg     801005d2 <consputc.part.0+0x1c2>
  if((pos/80) >= 24){  // Scroll up.
801004c1:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004c7:	7f 57                	jg     80100520 <consputc.part.0+0x110>
801004c9:	0f b6 c7             	movzbl %bh,%eax
801004cc:	88 5d e7             	mov    %bl,-0x19(%ebp)
801004cf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004d2:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004d7:	b8 0e 00 00 00       	mov    $0xe,%eax
801004dc:	89 fa                	mov    %edi,%edx
801004de:	ee                   	out    %al,(%dx)
801004df:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004e4:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
801004e8:	89 ca                	mov    %ecx,%edx
801004ea:	ee                   	out    %al,(%dx)
801004eb:	b8 0f 00 00 00       	mov    $0xf,%eax
801004f0:	89 fa                	mov    %edi,%edx
801004f2:	ee                   	out    %al,(%dx)
801004f3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004f7:	89 ca                	mov    %ecx,%edx
801004f9:	ee                   	out    %al,(%dx)
  if (c == BACKSPACE)
801004fa:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100500:	75 0d                	jne    8010050f <consputc.part.0+0xff>
    crt[pos] = ' ' | 0x0700;
80100502:	b8 20 07 00 00       	mov    $0x720,%eax
80100507:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
8010050e:	80 
}
8010050f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100512:	5b                   	pop    %ebx
80100513:	5e                   	pop    %esi
80100514:	5f                   	pop    %edi
80100515:	5d                   	pop    %ebp
80100516:	c3                   	ret    
80100517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010051e:	66 90                	xchg   %ax,%ax
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100520:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100523:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100526:	68 60 0e 00 00       	push   $0xe60
8010052b:	68 a0 80 0b 80       	push   $0x800b80a0
80100530:	68 00 80 0b 80       	push   $0x800b8000
80100535:	e8 e6 4e 00 00       	call   80105420 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010053a:	b8 80 07 00 00       	mov    $0x780,%eax
8010053f:	83 c4 0c             	add    $0xc,%esp
80100542:	29 d8                	sub    %ebx,%eax
80100544:	01 c0                	add    %eax,%eax
80100546:	50                   	push   %eax
80100547:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
8010054e:	6a 00                	push   $0x0
80100550:	50                   	push   %eax
80100551:	e8 2a 4e 00 00       	call   80105380 <memset>
80100556:	88 5d e7             	mov    %bl,-0x19(%ebp)
80100559:	83 c4 10             	add    $0x10,%esp
8010055c:	c6 45 e0 07          	movb   $0x7,-0x20(%ebp)
80100560:	e9 6d ff ff ff       	jmp    801004d2 <consputc.part.0+0xc2>
80100565:	8d 76 00             	lea    0x0(%esi),%esi
      if(pos > 0) --pos;
80100568:	85 db                	test   %ebx,%ebx
8010056a:	74 3c                	je     801005a8 <consputc.part.0+0x198>
8010056c:	83 eb 01             	sub    $0x1,%ebx
8010056f:	e9 41 ff ff ff       	jmp    801004b5 <consputc.part.0+0xa5>
80100574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      uartputc('\b');
80100578:	83 ec 0c             	sub    $0xc,%esp
8010057b:	6a 08                	push   $0x8
8010057d:	e8 ee 65 00 00       	call   80106b70 <uartputc>
      break;
80100582:	83 c4 10             	add    $0x10,%esp
80100585:	e9 cc fe ff ff       	jmp    80100456 <consputc.part.0+0x46>
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      uartputc(c);
80100590:	83 ec 0c             	sub    $0xc,%esp
80100593:	50                   	push   %eax
80100594:	e8 d7 65 00 00       	call   80106b70 <uartputc>
80100599:	83 c4 10             	add    $0x10,%esp
8010059c:	e9 b5 fe ff ff       	jmp    80100456 <consputc.part.0+0x46>
801005a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801005a8:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801005ac:	c6 45 e0 00          	movb   $0x0,-0x20(%ebp)
801005b0:	e9 1d ff ff ff       	jmp    801004d2 <consputc.part.0+0xc2>
801005b5:	8d 76 00             	lea    0x0(%esi),%esi
      pos += 80 - pos%80;
801005b8:	89 d8                	mov    %ebx,%eax
801005ba:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801005bf:	f7 e2                	mul    %edx
801005c1:	c1 ea 06             	shr    $0x6,%edx
801005c4:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005c7:	c1 e0 04             	shl    $0x4,%eax
801005ca:	8d 58 50             	lea    0x50(%eax),%ebx
      break;
801005cd:	e9 e3 fe ff ff       	jmp    801004b5 <consputc.part.0+0xa5>
    panic("pos under/overflow");
801005d2:	83 ec 0c             	sub    $0xc,%esp
801005d5:	68 c5 7f 10 80       	push   $0x80107fc5
801005da:	e8 b1 fd ff ff       	call   80100390 <panic>
801005df:	90                   	nop

801005e0 <printint>:
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	57                   	push   %edi
801005e4:	56                   	push   %esi
801005e5:	53                   	push   %ebx
801005e6:	83 ec 2c             	sub    $0x2c,%esp
801005e9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ec:	85 c9                	test   %ecx,%ecx
801005ee:	74 04                	je     801005f4 <printint+0x14>
801005f0:	85 c0                	test   %eax,%eax
801005f2:	78 6d                	js     80100661 <printint+0x81>
    x = xx;
801005f4:	89 c1                	mov    %eax,%ecx
801005f6:	31 f6                	xor    %esi,%esi
  i = 0;
801005f8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005fb:	31 db                	xor    %ebx,%ebx
801005fd:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
80100600:	89 c8                	mov    %ecx,%eax
80100602:	31 d2                	xor    %edx,%edx
80100604:	89 ce                	mov    %ecx,%esi
80100606:	f7 75 d4             	divl   -0x2c(%ebp)
80100609:	0f b6 92 f0 7f 10 80 	movzbl -0x7fef8010(%edx),%edx
80100610:	89 45 d0             	mov    %eax,-0x30(%ebp)
80100613:	89 d8                	mov    %ebx,%eax
80100615:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
80100618:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010061b:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
8010061e:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
80100621:	8b 75 d4             	mov    -0x2c(%ebp),%esi
80100624:	39 75 d0             	cmp    %esi,-0x30(%ebp)
80100627:	73 d7                	jae    80100600 <printint+0x20>
80100629:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
8010062c:	85 f6                	test   %esi,%esi
8010062e:	74 0c                	je     8010063c <printint+0x5c>
    buf[i++] = '-';
80100630:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100635:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
80100637:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010063c:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100640:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100643:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100649:	85 d2                	test   %edx,%edx
8010064b:	74 03                	je     80100650 <printint+0x70>
  asm volatile("cli");
8010064d:	fa                   	cli    
    for(;;)
8010064e:	eb fe                	jmp    8010064e <printint+0x6e>
80100650:	e8 bb fd ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
80100655:	39 fb                	cmp    %edi,%ebx
80100657:	74 10                	je     80100669 <printint+0x89>
80100659:	0f be 03             	movsbl (%ebx),%eax
8010065c:	83 eb 01             	sub    $0x1,%ebx
8010065f:	eb e2                	jmp    80100643 <printint+0x63>
    x = -xx;
80100661:	f7 d8                	neg    %eax
80100663:	89 ce                	mov    %ecx,%esi
80100665:	89 c1                	mov    %eax,%ecx
80100667:	eb 8f                	jmp    801005f8 <printint+0x18>
}
80100669:	83 c4 2c             	add    $0x2c,%esp
8010066c:	5b                   	pop    %ebx
8010066d:	5e                   	pop    %esi
8010066e:	5f                   	pop    %edi
8010066f:	5d                   	pop    %ebp
80100670:	c3                   	ret    
80100671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010067f:	90                   	nop

80100680 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100680:	f3 0f 1e fb          	endbr32 
80100684:	55                   	push   %ebp
80100685:	89 e5                	mov    %esp,%ebp
80100687:	57                   	push   %edi
80100688:	56                   	push   %esi
80100689:	53                   	push   %ebx
8010068a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010068d:	ff 75 08             	pushl  0x8(%ebp)
{
80100690:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100693:	e8 f8 1b 00 00       	call   80102290 <iunlock>
  acquire(&cons.lock);
80100698:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010069f:	e8 cc 4b 00 00       	call   80105270 <acquire>
  for(i = 0; i < n; i++)
801006a4:	83 c4 10             	add    $0x10,%esp
801006a7:	85 db                	test   %ebx,%ebx
801006a9:	7e 24                	jle    801006cf <consolewrite+0x4f>
801006ab:	8b 7d 0c             	mov    0xc(%ebp),%edi
801006ae:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
801006b1:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801006b7:	85 d2                	test   %edx,%edx
801006b9:	74 05                	je     801006c0 <consolewrite+0x40>
801006bb:	fa                   	cli    
    for(;;)
801006bc:	eb fe                	jmp    801006bc <consolewrite+0x3c>
801006be:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
801006c0:	0f b6 07             	movzbl (%edi),%eax
801006c3:	83 c7 01             	add    $0x1,%edi
801006c6:	e8 45 fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
801006cb:	39 fe                	cmp    %edi,%esi
801006cd:	75 e2                	jne    801006b1 <consolewrite+0x31>
  release(&cons.lock);
801006cf:	83 ec 0c             	sub    $0xc,%esp
801006d2:	68 20 b5 10 80       	push   $0x8010b520
801006d7:	e8 54 4c 00 00       	call   80105330 <release>
  ilock(ip);
801006dc:	58                   	pop    %eax
801006dd:	ff 75 08             	pushl  0x8(%ebp)
801006e0:	e8 cb 1a 00 00       	call   801021b0 <ilock>

  return n;
}
801006e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006e8:	89 d8                	mov    %ebx,%eax
801006ea:	5b                   	pop    %ebx
801006eb:	5e                   	pop    %esi
801006ec:	5f                   	pop    %edi
801006ed:	5d                   	pop    %ebp
801006ee:	c3                   	ret    
801006ef:	90                   	nop

801006f0 <cprintf>:
{
801006f0:	f3 0f 1e fb          	endbr32 
801006f4:	55                   	push   %ebp
801006f5:	89 e5                	mov    %esp,%ebp
801006f7:	57                   	push   %edi
801006f8:	56                   	push   %esi
801006f9:	53                   	push   %ebx
801006fa:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006fd:	a1 54 b5 10 80       	mov    0x8010b554,%eax
80100702:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100705:	85 c0                	test   %eax,%eax
80100707:	0f 85 e8 00 00 00    	jne    801007f5 <cprintf+0x105>
  if (fmt == 0)
8010070d:	8b 45 08             	mov    0x8(%ebp),%eax
80100710:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100713:	85 c0                	test   %eax,%eax
80100715:	0f 84 5a 01 00 00    	je     80100875 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	0f b6 00             	movzbl (%eax),%eax
8010071e:	85 c0                	test   %eax,%eax
80100720:	74 36                	je     80100758 <cprintf+0x68>
  argp = (uint*)(void*)(&fmt + 1);
80100722:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100725:	31 f6                	xor    %esi,%esi
    if(c != '%'){
80100727:	83 f8 25             	cmp    $0x25,%eax
8010072a:	74 44                	je     80100770 <cprintf+0x80>
  if(panicked){
8010072c:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80100732:	85 c9                	test   %ecx,%ecx
80100734:	74 0f                	je     80100745 <cprintf+0x55>
80100736:	fa                   	cli    
    for(;;)
80100737:	eb fe                	jmp    80100737 <cprintf+0x47>
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100740:	b8 25 00 00 00       	mov    $0x25,%eax
80100745:	e8 c6 fc ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010074a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010074d:	83 c6 01             	add    $0x1,%esi
80100750:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100754:	85 c0                	test   %eax,%eax
80100756:	75 cf                	jne    80100727 <cprintf+0x37>
  if(locking)
80100758:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010075b:	85 c0                	test   %eax,%eax
8010075d:	0f 85 fd 00 00 00    	jne    80100860 <cprintf+0x170>
}
80100763:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100766:	5b                   	pop    %ebx
80100767:	5e                   	pop    %esi
80100768:	5f                   	pop    %edi
80100769:	5d                   	pop    %ebp
8010076a:	c3                   	ret    
8010076b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010076f:	90                   	nop
    c = fmt[++i] & 0xff;
80100770:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100773:	83 c6 01             	add    $0x1,%esi
80100776:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
8010077a:	85 ff                	test   %edi,%edi
8010077c:	74 da                	je     80100758 <cprintf+0x68>
    switch(c){
8010077e:	83 ff 70             	cmp    $0x70,%edi
80100781:	74 5a                	je     801007dd <cprintf+0xed>
80100783:	7f 2a                	jg     801007af <cprintf+0xbf>
80100785:	83 ff 25             	cmp    $0x25,%edi
80100788:	0f 84 92 00 00 00    	je     80100820 <cprintf+0x130>
8010078e:	83 ff 64             	cmp    $0x64,%edi
80100791:	0f 85 a1 00 00 00    	jne    80100838 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100797:	8b 03                	mov    (%ebx),%eax
80100799:	8d 7b 04             	lea    0x4(%ebx),%edi
8010079c:	b9 01 00 00 00       	mov    $0x1,%ecx
801007a1:	ba 0a 00 00 00       	mov    $0xa,%edx
801007a6:	89 fb                	mov    %edi,%ebx
801007a8:	e8 33 fe ff ff       	call   801005e0 <printint>
      break;
801007ad:	eb 9b                	jmp    8010074a <cprintf+0x5a>
    switch(c){
801007af:	83 ff 73             	cmp    $0x73,%edi
801007b2:	75 24                	jne    801007d8 <cprintf+0xe8>
      if((s = (char*)*argp++) == 0)
801007b4:	8d 7b 04             	lea    0x4(%ebx),%edi
801007b7:	8b 1b                	mov    (%ebx),%ebx
801007b9:	85 db                	test   %ebx,%ebx
801007bb:	75 55                	jne    80100812 <cprintf+0x122>
        s = "(null)";
801007bd:	bb d8 7f 10 80       	mov    $0x80107fd8,%ebx
      for(; *s; s++)
801007c2:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
801007c7:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801007cd:	85 d2                	test   %edx,%edx
801007cf:	74 39                	je     8010080a <cprintf+0x11a>
801007d1:	fa                   	cli    
    for(;;)
801007d2:	eb fe                	jmp    801007d2 <cprintf+0xe2>
801007d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801007d8:	83 ff 78             	cmp    $0x78,%edi
801007db:	75 5b                	jne    80100838 <cprintf+0x148>
      printint(*argp++, 16, 0);
801007dd:	8b 03                	mov    (%ebx),%eax
801007df:	8d 7b 04             	lea    0x4(%ebx),%edi
801007e2:	31 c9                	xor    %ecx,%ecx
801007e4:	ba 10 00 00 00       	mov    $0x10,%edx
801007e9:	89 fb                	mov    %edi,%ebx
801007eb:	e8 f0 fd ff ff       	call   801005e0 <printint>
      break;
801007f0:	e9 55 ff ff ff       	jmp    8010074a <cprintf+0x5a>
    acquire(&cons.lock);
801007f5:	83 ec 0c             	sub    $0xc,%esp
801007f8:	68 20 b5 10 80       	push   $0x8010b520
801007fd:	e8 6e 4a 00 00       	call   80105270 <acquire>
80100802:	83 c4 10             	add    $0x10,%esp
80100805:	e9 03 ff ff ff       	jmp    8010070d <cprintf+0x1d>
8010080a:	e8 01 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
8010080f:	83 c3 01             	add    $0x1,%ebx
80100812:	0f be 03             	movsbl (%ebx),%eax
80100815:	84 c0                	test   %al,%al
80100817:	75 ae                	jne    801007c7 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
80100819:	89 fb                	mov    %edi,%ebx
8010081b:	e9 2a ff ff ff       	jmp    8010074a <cprintf+0x5a>
  if(panicked){
80100820:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
80100826:	85 ff                	test   %edi,%edi
80100828:	0f 84 12 ff ff ff    	je     80100740 <cprintf+0x50>
8010082e:	fa                   	cli    
    for(;;)
8010082f:	eb fe                	jmp    8010082f <cprintf+0x13f>
80100831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
80100838:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
8010083e:	85 c9                	test   %ecx,%ecx
80100840:	74 06                	je     80100848 <cprintf+0x158>
80100842:	fa                   	cli    
    for(;;)
80100843:	eb fe                	jmp    80100843 <cprintf+0x153>
80100845:	8d 76 00             	lea    0x0(%esi),%esi
80100848:	b8 25 00 00 00       	mov    $0x25,%eax
8010084d:	e8 be fb ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100852:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100858:	85 d2                	test   %edx,%edx
8010085a:	74 2c                	je     80100888 <cprintf+0x198>
8010085c:	fa                   	cli    
    for(;;)
8010085d:	eb fe                	jmp    8010085d <cprintf+0x16d>
8010085f:	90                   	nop
    release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 b5 10 80       	push   $0x8010b520
80100868:	e8 c3 4a 00 00       	call   80105330 <release>
8010086d:	83 c4 10             	add    $0x10,%esp
}
80100870:	e9 ee fe ff ff       	jmp    80100763 <cprintf+0x73>
    panic("null fmt");
80100875:	83 ec 0c             	sub    $0xc,%esp
80100878:	68 df 7f 10 80       	push   $0x80107fdf
8010087d:	e8 0e fb ff ff       	call   80100390 <panic>
80100882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100888:	89 f8                	mov    %edi,%eax
8010088a:	e8 81 fb ff ff       	call   80100410 <consputc.part.0>
8010088f:	e9 b6 fe ff ff       	jmp    8010074a <cprintf+0x5a>
80100894:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010089b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010089f:	90                   	nop

801008a0 <copyCharsToBeMoved>:
void copyCharsToBeMoved() {
801008a0:	f3 0f 1e fb          	endbr32 
  uint n = input.rightmost - input.r;
801008a4:	8b 0d 8c ac 11 80    	mov    0x8011ac8c,%ecx
  for (i = 0; i < n; i++)
801008aa:	2b 0d 80 ac 11 80    	sub    0x8011ac80,%ecx
801008b0:	74 2e                	je     801008e0 <copyCharsToBeMoved+0x40>
void copyCharsToBeMoved() {
801008b2:	55                   	push   %ebp
  for (i = 0; i < n; i++)
801008b3:	31 c0                	xor    %eax,%eax
void copyCharsToBeMoved() {
801008b5:	89 e5                	mov    %esp,%ebp
801008b7:	53                   	push   %ebx
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801008b8:	8b 1d 88 ac 11 80    	mov    0x8011ac88,%ebx
801008be:	66 90                	xchg   %ax,%ax
801008c0:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  for (i = 0; i < n; i++)
801008c3:	83 c0 01             	add    $0x1,%eax
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801008c6:	83 e2 7f             	and    $0x7f,%edx
801008c9:	0f b6 92 00 ac 11 80 	movzbl -0x7fee5400(%edx),%edx
801008d0:	88 90 3f ad 11 80    	mov    %dl,-0x7fee52c1(%eax)
  for (i = 0; i < n; i++)
801008d6:	39 c1                	cmp    %eax,%ecx
801008d8:	75 e6                	jne    801008c0 <copyCharsToBeMoved+0x20>
}
801008da:	5b                   	pop    %ebx
801008db:	5d                   	pop    %ebp
801008dc:	c3                   	ret    
801008dd:	8d 76 00             	lea    0x0(%esi),%esi
801008e0:	c3                   	ret    
801008e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008ef:	90                   	nop

801008f0 <shiftbufleft>:
void shiftbufleft() {
801008f0:	f3 0f 1e fb          	endbr32 
  if(panicked){
801008f4:	a1 58 b5 10 80       	mov    0x8010b558,%eax
801008f9:	85 c0                	test   %eax,%eax
801008fb:	74 03                	je     80100900 <shiftbufleft+0x10>
801008fd:	fa                   	cli    
    for(;;)
801008fe:	eb fe                	jmp    801008fe <shiftbufleft+0xe>
void shiftbufleft() {
80100900:	55                   	push   %ebp
80100901:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100906:	89 e5                	mov    %esp,%ebp
80100908:	56                   	push   %esi
80100909:	53                   	push   %ebx
  uint n = input.rightmost - input.e;
8010090a:	8b 1d 8c ac 11 80    	mov    0x8011ac8c,%ebx
80100910:	2b 1d 88 ac 11 80    	sub    0x8011ac88,%ebx
80100916:	e8 f5 fa ff ff       	call   80100410 <consputc.part.0>
  input.e--;
8010091b:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
80100920:	83 e8 01             	sub    $0x1,%eax
80100923:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
  for (i = 0; i < n; i++) {
80100928:	85 db                	test   %ebx,%ebx
8010092a:	74 42                	je     8010096e <shiftbufleft+0x7e>
8010092c:	31 f6                	xor    %esi,%esi
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
8010092e:	01 f0                	add    %esi,%eax
  if(panicked){
80100930:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
80100936:	8d 50 01             	lea    0x1(%eax),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100939:	83 e0 7f             	and    $0x7f,%eax
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
8010093c:	83 e2 7f             	and    $0x7f,%edx
8010093f:	0f b6 92 00 ac 11 80 	movzbl -0x7fee5400(%edx),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100946:	88 90 00 ac 11 80    	mov    %dl,-0x7fee5400(%eax)
  if(panicked){
8010094c:	85 c9                	test   %ecx,%ecx
8010094e:	74 08                	je     80100958 <shiftbufleft+0x68>
80100950:	fa                   	cli    
    for(;;)
80100951:	eb fe                	jmp    80100951 <shiftbufleft+0x61>
80100953:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100957:	90                   	nop
    consputc(c);
80100958:	0f be c2             	movsbl %dl,%eax
  for (i = 0; i < n; i++) {
8010095b:	83 c6 01             	add    $0x1,%esi
8010095e:	e8 ad fa ff ff       	call   80100410 <consputc.part.0>
80100963:	39 f3                	cmp    %esi,%ebx
80100965:	74 07                	je     8010096e <shiftbufleft+0x7e>
80100967:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
8010096c:	eb c0                	jmp    8010092e <shiftbufleft+0x3e>
  if(panicked){
8010096e:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
  input.rightmost--;
80100974:	83 2d 8c ac 11 80 01 	subl   $0x1,0x8011ac8c
  if(panicked){
8010097b:	85 d2                	test   %edx,%edx
8010097d:	75 21                	jne    801009a0 <shiftbufleft+0xb0>
8010097f:	b8 20 00 00 00       	mov    $0x20,%eax
  for (i = 0; i <= n; i++) {
80100984:	31 f6                	xor    %esi,%esi
80100986:	e8 85 fa ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
8010098b:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100990:	85 c0                	test   %eax,%eax
80100992:	74 14                	je     801009a8 <shiftbufleft+0xb8>
80100994:	fa                   	cli    
    for(;;)
80100995:	eb fe                	jmp    80100995 <shiftbufleft+0xa5>
80100997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010099e:	66 90                	xchg   %ax,%ax
801009a0:	fa                   	cli    
801009a1:	eb fe                	jmp    801009a1 <shiftbufleft+0xb1>
801009a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009a7:	90                   	nop
801009a8:	b8 e4 00 00 00       	mov    $0xe4,%eax
  for (i = 0; i <= n; i++) {
801009ad:	83 c6 01             	add    $0x1,%esi
801009b0:	e8 5b fa ff ff       	call   80100410 <consputc.part.0>
801009b5:	39 f3                	cmp    %esi,%ebx
801009b7:	73 d2                	jae    8010098b <shiftbufleft+0x9b>
}
801009b9:	5b                   	pop    %ebx
801009ba:	5e                   	pop    %esi
801009bb:	5d                   	pop    %ebp
801009bc:	c3                   	ret    
801009bd:	8d 76 00             	lea    0x0(%esi),%esi

801009c0 <shiftbufright>:
void shiftbufright() {
801009c0:	f3 0f 1e fb          	endbr32 
801009c4:	55                   	push   %ebp
801009c5:	89 e5                	mov    %esp,%ebp
801009c7:	57                   	push   %edi
801009c8:	56                   	push   %esi
801009c9:	53                   	push   %ebx
801009ca:	83 ec 0c             	sub    $0xc,%esp
  uint n = input.rightmost - input.e;
801009cd:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
  for (i = 0; i < n; i++) {
801009d2:	8b 3d 8c ac 11 80    	mov    0x8011ac8c,%edi
801009d8:	29 c7                	sub    %eax,%edi
801009da:	74 79                	je     80100a55 <shiftbufright+0x95>
801009dc:	31 db                	xor    %ebx,%ebx
    char c = charsToBeMoved[i];
801009de:	0f b6 93 40 ad 11 80 	movzbl -0x7fee52c0(%ebx),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
801009e5:	01 d8                	add    %ebx,%eax
  if(panicked){
801009e7:	8b 35 58 b5 10 80    	mov    0x8010b558,%esi
    input.buf[(input.e + i) % INPUT_BUF] = c;
801009ed:	83 e0 7f             	and    $0x7f,%eax
801009f0:	88 90 00 ac 11 80    	mov    %dl,-0x7fee5400(%eax)
  if(panicked){
801009f6:	85 f6                	test   %esi,%esi
801009f8:	74 06                	je     80100a00 <shiftbufright+0x40>
801009fa:	fa                   	cli    
    for(;;)
801009fb:	eb fe                	jmp    801009fb <shiftbufright+0x3b>
801009fd:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(c);
80100a00:	0f be c2             	movsbl %dl,%eax
80100a03:	e8 08 fa ff ff       	call   80100410 <consputc.part.0>
  for (i = 0; i < n; i++) {
80100a08:	8d 53 01             	lea    0x1(%ebx),%edx
80100a0b:	39 d7                	cmp    %edx,%edi
80100a0d:	74 09                	je     80100a18 <shiftbufright+0x58>
80100a0f:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
80100a14:	89 d3                	mov    %edx,%ebx
80100a16:	eb c6                	jmp    801009de <shiftbufright+0x1e>
  memset(charsToBeMoved, '\0', INPUT_BUF);
80100a18:	83 ec 04             	sub    $0x4,%esp
80100a1b:	68 80 00 00 00       	push   $0x80
80100a20:	6a 00                	push   $0x0
80100a22:	68 40 ad 11 80       	push   $0x8011ad40
80100a27:	e8 54 49 00 00       	call   80105380 <memset>
80100a2c:	83 c4 10             	add    $0x10,%esp
  if(panicked){
80100a2f:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100a34:	85 c0                	test   %eax,%eax
80100a36:	74 08                	je     80100a40 <shiftbufright+0x80>
80100a38:	fa                   	cli    
    for(;;)
80100a39:	eb fe                	jmp    80100a39 <shiftbufright+0x79>
80100a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a3f:	90                   	nop
80100a40:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100a45:	e8 c6 f9 ff ff       	call   80100410 <consputc.part.0>
  for (i = 0; i < n; i++) {
80100a4a:	8d 46 01             	lea    0x1(%esi),%eax
80100a4d:	39 f3                	cmp    %esi,%ebx
80100a4f:	74 1b                	je     80100a6c <shiftbufright+0xac>
80100a51:	89 c6                	mov    %eax,%esi
80100a53:	eb da                	jmp    80100a2f <shiftbufright+0x6f>
  memset(charsToBeMoved, '\0', INPUT_BUF);
80100a55:	83 ec 04             	sub    $0x4,%esp
80100a58:	68 80 00 00 00       	push   $0x80
80100a5d:	6a 00                	push   $0x0
80100a5f:	68 40 ad 11 80       	push   $0x8011ad40
80100a64:	e8 17 49 00 00       	call   80105380 <memset>
80100a69:	83 c4 10             	add    $0x10,%esp
}
80100a6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a6f:	5b                   	pop    %ebx
80100a70:	5e                   	pop    %esi
80100a71:	5f                   	pop    %edi
80100a72:	5d                   	pop    %ebp
80100a73:	c3                   	ret    
80100a74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a7f:	90                   	nop

80100a80 <earaseCurrentLineOnScreen>:
earaseCurrentLineOnScreen(void){
80100a80:	f3 0f 1e fb          	endbr32 
    uint numToEarase = input.rightmost - input.r;
80100a84:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
    for (i = 0; i < numToEarase; i++) {
80100a89:	2b 05 80 ac 11 80    	sub    0x8011ac80,%eax
80100a8f:	74 34                	je     80100ac5 <earaseCurrentLineOnScreen+0x45>
earaseCurrentLineOnScreen(void){
80100a91:	55                   	push   %ebp
80100a92:	89 e5                	mov    %esp,%ebp
80100a94:	56                   	push   %esi
    for (i = 0; i < numToEarase; i++) {
80100a95:	31 f6                	xor    %esi,%esi
earaseCurrentLineOnScreen(void){
80100a97:	53                   	push   %ebx
80100a98:	89 c3                	mov    %eax,%ebx
  if(panicked){
80100a9a:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100a9f:	85 c0                	test   %eax,%eax
80100aa1:	74 0d                	je     80100ab0 <earaseCurrentLineOnScreen+0x30>
80100aa3:	fa                   	cli    
    for(;;)
80100aa4:	eb fe                	jmp    80100aa4 <earaseCurrentLineOnScreen+0x24>
80100aa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100aad:	8d 76 00             	lea    0x0(%esi),%esi
80100ab0:	b8 00 01 00 00       	mov    $0x100,%eax
    for (i = 0; i < numToEarase; i++) {
80100ab5:	83 c6 01             	add    $0x1,%esi
80100ab8:	e8 53 f9 ff ff       	call   80100410 <consputc.part.0>
80100abd:	39 f3                	cmp    %esi,%ebx
80100abf:	75 d9                	jne    80100a9a <earaseCurrentLineOnScreen+0x1a>
}
80100ac1:	5b                   	pop    %ebx
80100ac2:	5e                   	pop    %esi
80100ac3:	5d                   	pop    %ebp
80100ac4:	c3                   	ret    
80100ac5:	c3                   	ret    
80100ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100acd:	8d 76 00             	lea    0x0(%esi),%esi

80100ad0 <copyCharsToBeMovedToOldBuf>:
copyCharsToBeMovedToOldBuf(void){
80100ad0:	f3 0f 1e fb          	endbr32 
80100ad4:	55                   	push   %ebp
    lengthOfOldBuf = input.rightmost - input.r;
80100ad5:	8b 0d 8c ac 11 80    	mov    0x8011ac8c,%ecx
copyCharsToBeMovedToOldBuf(void){
80100adb:	89 e5                	mov    %esp,%ebp
80100add:	53                   	push   %ebx
    lengthOfOldBuf = input.rightmost - input.r;
80100ade:	8b 1d 80 ac 11 80    	mov    0x8011ac80,%ebx
80100ae4:	29 d9                	sub    %ebx,%ecx
80100ae6:	89 0d 20 ad 11 80    	mov    %ecx,0x8011ad20
    for (i = 0; i < lengthOfOldBuf; i++) {
80100aec:	74 1c                	je     80100b0a <copyCharsToBeMovedToOldBuf+0x3a>
80100aee:	31 c0                	xor    %eax,%eax
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
80100af0:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    for (i = 0; i < lengthOfOldBuf; i++) {
80100af3:	83 c0 01             	add    $0x1,%eax
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
80100af6:	83 e2 7f             	and    $0x7f,%edx
80100af9:	0f b6 92 00 ac 11 80 	movzbl -0x7fee5400(%edx),%edx
80100b00:	88 90 7f ab 11 80    	mov    %dl,-0x7fee5481(%eax)
    for (i = 0; i < lengthOfOldBuf; i++) {
80100b06:	39 c1                	cmp    %eax,%ecx
80100b08:	75 e6                	jne    80100af0 <copyCharsToBeMovedToOldBuf+0x20>
}
80100b0a:	5b                   	pop    %ebx
80100b0b:	5d                   	pop    %ebp
80100b0c:	c3                   	ret    
80100b0d:	8d 76 00             	lea    0x0(%esi),%esi

80100b10 <earaseContentOnInputBuf>:
earaseContentOnInputBuf(){
80100b10:	f3 0f 1e fb          	endbr32 
  input.rightmost = input.r;
80100b14:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
80100b19:	a3 8c ac 11 80       	mov    %eax,0x8011ac8c
  input.e = input.r;
80100b1e:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
}
80100b23:	c3                   	ret    
80100b24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b2f:	90                   	nop

80100b30 <copyBufferToScreen>:
copyBufferToScreen(char * bufToPrintOnScreen, uint length){
80100b30:	f3 0f 1e fb          	endbr32 
80100b34:	55                   	push   %ebp
80100b35:	89 e5                	mov    %esp,%ebp
80100b37:	56                   	push   %esi
80100b38:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b3b:	53                   	push   %ebx
  for (i = 0; i < length; i++) {
80100b3c:	85 c0                	test   %eax,%eax
80100b3e:	74 27                	je     80100b67 <copyBufferToScreen+0x37>
80100b40:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100b43:	8d 34 03             	lea    (%ebx,%eax,1),%esi
  if(panicked){
80100b46:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100b4b:	85 c0                	test   %eax,%eax
80100b4d:	74 09                	je     80100b58 <copyBufferToScreen+0x28>
80100b4f:	fa                   	cli    
    for(;;)
80100b50:	eb fe                	jmp    80100b50 <copyBufferToScreen+0x20>
80100b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(bufToPrintOnScreen[i]);
80100b58:	0f be 03             	movsbl (%ebx),%eax
80100b5b:	83 c3 01             	add    $0x1,%ebx
80100b5e:	e8 ad f8 ff ff       	call   80100410 <consputc.part.0>
  for (i = 0; i < length; i++) {
80100b63:	39 f3                	cmp    %esi,%ebx
80100b65:	75 df                	jne    80100b46 <copyBufferToScreen+0x16>
}
80100b67:	5b                   	pop    %ebx
80100b68:	5e                   	pop    %esi
80100b69:	5d                   	pop    %ebp
80100b6a:	c3                   	ret    
80100b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop

80100b70 <copyBufferToInputBuf>:
copyBufferToInputBuf(char * bufToSaveInInput, uint length){
80100b70:	f3 0f 1e fb          	endbr32 
80100b74:	55                   	push   %ebp
80100b75:	8b 15 80 ac 11 80    	mov    0x8011ac80,%edx
80100b7b:	89 d0                	mov    %edx,%eax
80100b7d:	89 e5                	mov    %esp,%ebp
80100b7f:	56                   	push   %esi
80100b80:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b83:	8b 75 08             	mov    0x8(%ebp),%esi
copyBufferToInputBuf(char * bufToSaveInInput, uint length){
80100b86:	53                   	push   %ebx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b87:	29 d6                	sub    %edx,%esi
80100b89:	8d 1c 11             	lea    (%ecx,%edx,1),%ebx
  for (i = 0; i < length; i++) {
80100b8c:	85 c9                	test   %ecx,%ecx
80100b8e:	74 30                	je     80100bc0 <copyBufferToInputBuf+0x50>
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b90:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80100b94:	89 c2                	mov    %eax,%edx
80100b96:	83 c0 01             	add    $0x1,%eax
80100b99:	83 e2 7f             	and    $0x7f,%edx
80100b9c:	88 8a 00 ac 11 80    	mov    %cl,-0x7fee5400(%edx)
  for (i = 0; i < length; i++) {
80100ba2:	39 d8                	cmp    %ebx,%eax
80100ba4:	75 ea                	jne    80100b90 <copyBufferToInputBuf+0x20>
  input.e = input.r+length;
80100ba6:	89 1d 88 ac 11 80    	mov    %ebx,0x8011ac88
  input.rightmost = input.e;
80100bac:	89 1d 8c ac 11 80    	mov    %ebx,0x8011ac8c
}
80100bb2:	5b                   	pop    %ebx
80100bb3:	5e                   	pop    %esi
80100bb4:	5d                   	pop    %ebp
80100bb5:	c3                   	ret    
80100bb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bbd:	8d 76 00             	lea    0x0(%esi),%esi
80100bc0:	89 d3                	mov    %edx,%ebx
80100bc2:	eb e2                	jmp    80100ba6 <copyBufferToInputBuf+0x36>
80100bc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100bcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100bcf:	90                   	nop

80100bd0 <saveCommandInHistory>:
saveCommandInHistory(){
80100bd0:	f3 0f 1e fb          	endbr32 
80100bd4:	55                   	push   %ebp
  if (historyBufferArray.numOfCommmandsInMem < MAX_HISTORY)
80100bd5:	a1 14 b8 11 80       	mov    0x8011b814,%eax
  historyBufferArray.currentHistory= -1;//reseting the users history current viewed
80100bda:	c7 05 18 b8 11 80 ff 	movl   $0xffffffff,0x8011b818
80100be1:	ff ff ff 
saveCommandInHistory(){
80100be4:	89 e5                	mov    %esp,%ebp
80100be6:	57                   	push   %edi
80100be7:	56                   	push   %esi
80100be8:	53                   	push   %ebx
  if (historyBufferArray.numOfCommmandsInMem < MAX_HISTORY)
80100be9:	83 f8 13             	cmp    $0x13,%eax
80100bec:	7f 08                	jg     80100bf6 <saveCommandInHistory+0x26>
    historyBufferArray.numOfCommmandsInMem++; //when we get to MAX_HISTORY commands in memory we keep on inserting to the array in a circular mution
80100bee:	83 c0 01             	add    $0x1,%eax
80100bf1:	a3 14 b8 11 80       	mov    %eax,0x8011b814
  uint l = input.rightmost-input.r -1;
80100bf6:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100bfb:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  uint l = input.rightmost-input.r -1;
80100c00:	8b 0d 80 ac 11 80    	mov    0x8011ac80,%ecx
80100c06:	8d 58 ff             	lea    -0x1(%eax),%ebx
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c09:	a1 10 b8 11 80       	mov    0x8011b810,%eax
  uint l = input.rightmost-input.r -1;
80100c0e:	89 df                	mov    %ebx,%edi
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c10:	8d 70 ff             	lea    -0x1(%eax),%esi
  uint l = input.rightmost-input.r -1;
80100c13:	29 cf                	sub    %ecx,%edi
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c15:	89 f0                	mov    %esi,%eax
80100c17:	f7 e2                	mul    %edx
80100c19:	c1 ea 04             	shr    $0x4,%edx
80100c1c:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100c1f:	c1 e0 02             	shl    $0x2,%eax
80100c22:	29 c6                	sub    %eax,%esi
80100c24:	89 35 10 b8 11 80    	mov    %esi,0x8011b810
80100c2a:	89 f2                	mov    %esi,%edx
  historyBufferArray.lengthsArr[historyBufferArray.lastCommandIndex] = l;
80100c2c:	89 3c b5 c0 b7 11 80 	mov    %edi,-0x7fee4840(,%esi,4)
  for (i = 0; i < l; i++) { //do not want to save in memory the last char '/n'
80100c33:	85 ff                	test   %edi,%edi
80100c35:	74 23                	je     80100c5a <saveCommandInHistory+0x8a>
80100c37:	c1 e2 07             	shl    $0x7,%edx
80100c3a:	29 ca                	sub    %ecx,%edx
80100c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    historyBufferArray.bufferArr[historyBufferArray.lastCommandIndex][i] =  input.buf[(input.r+i)%INPUT_BUF];
80100c40:	89 c8                	mov    %ecx,%eax
80100c42:	83 e0 7f             	and    $0x7f,%eax
80100c45:	0f b6 80 00 ac 11 80 	movzbl -0x7fee5400(%eax),%eax
80100c4c:	88 84 0a c0 ad 11 80 	mov    %al,-0x7fee5240(%edx,%ecx,1)
  for (i = 0; i < l; i++) { //do not want to save in memory the last char '/n'
80100c53:	83 c1 01             	add    $0x1,%ecx
80100c56:	39 cb                	cmp    %ecx,%ebx
80100c58:	75 e6                	jne    80100c40 <saveCommandInHistory+0x70>
}
80100c5a:	5b                   	pop    %ebx
80100c5b:	5e                   	pop    %esi
80100c5c:	5f                   	pop    %edi
80100c5d:	5d                   	pop    %ebp
80100c5e:	c3                   	ret    
80100c5f:	90                   	nop

80100c60 <history>:
int history(char *buffer, int historyId) {
80100c60:	f3 0f 1e fb          	endbr32 
80100c64:	55                   	push   %ebp
80100c65:	89 e5                	mov    %esp,%ebp
80100c67:	56                   	push   %esi
80100c68:	8b 75 0c             	mov    0xc(%ebp),%esi
80100c6b:	53                   	push   %ebx
80100c6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (historyId < 0 || historyId > MAX_HISTORY - 1)
80100c6f:	83 fe 13             	cmp    $0x13,%esi
80100c72:	77 6c                	ja     80100ce0 <history+0x80>
  if (historyId >= historyBufferArray.numOfCommmandsInMem )
80100c74:	39 35 14 b8 11 80    	cmp    %esi,0x8011b814
80100c7a:	7e 54                	jle    80100cd0 <history+0x70>
  memset(buffer, '\0', INPUT_BUF);
80100c7c:	83 ec 04             	sub    $0x4,%esp
80100c7f:	68 80 00 00 00       	push   $0x80
80100c84:	6a 00                	push   $0x0
80100c86:	53                   	push   %ebx
80100c87:	e8 f4 46 00 00       	call   80105380 <memset>
  int tempIndex = (historyBufferArray.lastCommandIndex + historyId) % MAX_HISTORY;
80100c8c:	8b 0d 10 b8 11 80    	mov    0x8011b810,%ecx
80100c92:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  memmove(buffer, historyBufferArray.bufferArr[tempIndex], historyBufferArray.lengthsArr[tempIndex]);
80100c97:	83 c4 0c             	add    $0xc,%esp
  int tempIndex = (historyBufferArray.lastCommandIndex + historyId) % MAX_HISTORY;
80100c9a:	01 f1                	add    %esi,%ecx
80100c9c:	89 c8                	mov    %ecx,%eax
80100c9e:	f7 e2                	mul    %edx
80100ca0:	c1 ea 04             	shr    $0x4,%edx
80100ca3:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100ca6:	c1 e0 02             	shl    $0x2,%eax
80100ca9:	29 c1                	sub    %eax,%ecx
80100cab:	89 ca                	mov    %ecx,%edx
  memmove(buffer, historyBufferArray.bufferArr[tempIndex], historyBufferArray.lengthsArr[tempIndex]);
80100cad:	ff 34 8d c0 b7 11 80 	pushl  -0x7fee4840(,%ecx,4)
80100cb4:	c1 e2 07             	shl    $0x7,%edx
80100cb7:	81 c2 c0 ad 11 80    	add    $0x8011adc0,%edx
80100cbd:	52                   	push   %edx
80100cbe:	53                   	push   %ebx
80100cbf:	e8 5c 47 00 00       	call   80105420 <memmove>
  return 0;
80100cc4:	83 c4 10             	add    $0x10,%esp
80100cc7:	31 c0                	xor    %eax,%eax
}
80100cc9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100ccc:	5b                   	pop    %ebx
80100ccd:	5e                   	pop    %esi
80100cce:	5d                   	pop    %ebp
80100ccf:	c3                   	ret    
    return -1;
80100cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cd5:	eb f2                	jmp    80100cc9 <history+0x69>
80100cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cde:	66 90                	xchg   %ax,%ax
    return -2;
80100ce0:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80100ce5:	eb e2                	jmp    80100cc9 <history+0x69>
80100ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cee:	66 90                	xchg   %ax,%ax

80100cf0 <consoleintr>:
{
80100cf0:	f3 0f 1e fb          	endbr32 
80100cf4:	55                   	push   %ebp
80100cf5:	89 e5                	mov    %esp,%ebp
80100cf7:	57                   	push   %edi
80100cf8:	56                   	push   %esi
80100cf9:	53                   	push   %ebx
80100cfa:	83 ec 38             	sub    $0x38,%esp
80100cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
80100d00:	68 20 b5 10 80       	push   $0x8010b520
{
80100d05:	89 45 d8             	mov    %eax,-0x28(%ebp)
  acquire(&cons.lock);
80100d08:	e8 63 45 00 00       	call   80105270 <acquire>
  int c, doprocdump = 0;
80100d0d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  while((c = getc()) >= 0){
80100d14:	83 c4 10             	add    $0x10,%esp
80100d17:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100d1a:	ff d0                	call   *%eax
80100d1c:	89 c3                	mov    %eax,%ebx
80100d1e:	85 c0                	test   %eax,%eax
80100d20:	0f 88 73 05 00 00    	js     80101299 <consoleintr+0x5a9>
    switch(c){
80100d26:	83 fb 7f             	cmp    $0x7f,%ebx
80100d29:	0f 84 69 02 00 00    	je     80100f98 <consoleintr+0x2a8>
80100d2f:	0f 8e 9b 00 00 00    	jle    80100dd0 <consoleintr+0xe0>
80100d35:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100d3b:	0f 84 27 02 00 00    	je     80100f68 <consoleintr+0x278>
80100d41:	0f 8f e9 00 00 00    	jg     80100e30 <consoleintr+0x140>
80100d47:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100d4d:	0f 84 70 02 00 00    	je     80100fc3 <consoleintr+0x2d3>
80100d53:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100d59:	0f 85 34 03 00 00    	jne    80101093 <consoleintr+0x3a3>
        switch(historyBufferArray.currentHistory){
80100d5f:	a1 18 b8 11 80       	mov    0x8011b818,%eax
80100d64:	83 f8 ff             	cmp    $0xffffffff,%eax
80100d67:	74 ae                	je     80100d17 <consoleintr+0x27>
80100d69:	85 c0                	test   %eax,%eax
80100d6b:	0f 85 97 04 00 00    	jne    80101208 <consoleintr+0x518>
            earaseCurrentLineOnScreen();
80100d71:	e8 0a fd ff ff       	call   80100a80 <earaseCurrentLineOnScreen>
            copyBufferToInputBuf(oldBuf, lengthOfOldBuf);
80100d76:	8b 0d 20 ad 11 80    	mov    0x8011ad20,%ecx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100d7c:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
  for (i = 0; i < length; i++) {
80100d81:	85 c9                	test   %ecx,%ecx
80100d83:	74 20                	je     80100da5 <consoleintr+0xb5>
80100d85:	31 d2                	xor    %edx,%edx
80100d87:	89 c7                	mov    %eax,%edi
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100d89:	0f b6 82 80 ab 11 80 	movzbl -0x7fee5480(%edx),%eax
80100d90:	8d 1c 17             	lea    (%edi,%edx,1),%ebx
  for (i = 0; i < length; i++) {
80100d93:	83 c2 01             	add    $0x1,%edx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100d96:	83 e3 7f             	and    $0x7f,%ebx
80100d99:	88 83 00 ac 11 80    	mov    %al,-0x7fee5400(%ebx)
  for (i = 0; i < length; i++) {
80100d9f:	39 d1                	cmp    %edx,%ecx
80100da1:	75 e6                	jne    80100d89 <consoleintr+0x99>
80100da3:	89 f8                	mov    %edi,%eax
            copyBufferToScreen(oldBuf, lengthOfOldBuf);
80100da5:	83 ec 08             	sub    $0x8,%esp
  input.e = input.r+length;
80100da8:	01 c8                	add    %ecx,%eax
            copyBufferToScreen(oldBuf, lengthOfOldBuf);
80100daa:	51                   	push   %ecx
80100dab:	68 80 ab 11 80       	push   $0x8011ab80
  input.e = input.r+length;
80100db0:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
  input.rightmost = input.e;
80100db5:	a3 8c ac 11 80       	mov    %eax,0x8011ac8c
            copyBufferToScreen(oldBuf, lengthOfOldBuf);
80100dba:	e8 71 fd ff ff       	call   80100b30 <copyBufferToScreen>
            historyBufferArray.currentHistory--;
80100dbf:	83 2d 18 b8 11 80 01 	subl   $0x1,0x8011b818
            break;
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	e9 49 ff ff ff       	jmp    80100d17 <consoleintr+0x27>
80100dce:	66 90                	xchg   %ax,%ax
    switch(c){
80100dd0:	83 fb 10             	cmp    $0x10,%ebx
80100dd3:	0f 84 0f 01 00 00    	je     80100ee8 <consoleintr+0x1f8>
80100dd9:	0f 8e 81 00 00 00    	jle    80100e60 <consoleintr+0x170>
80100ddf:	83 fb 15             	cmp    $0x15,%ebx
80100de2:	0f 85 ab 02 00 00    	jne    80101093 <consoleintr+0x3a3>
     if (input.rightmost > input.e) { // caret isn't at the end of the line
80100de8:	8b 1d 8c ac 11 80    	mov    0x8011ac8c,%ebx
80100dee:	8b 15 88 ac 11 80    	mov    0x8011ac88,%edx
80100df4:	8b 35 84 ac 11 80    	mov    0x8011ac84,%esi
80100dfa:	39 d3                	cmp    %edx,%ebx
80100dfc:	0f 86 26 01 00 00    	jbe    80100f28 <consoleintr+0x238>
          for (i = 0; i < placestoshift; i++) {
80100e02:	89 d7                	mov    %edx,%edi
80100e04:	31 c9                	xor    %ecx,%ecx
80100e06:	29 f7                	sub    %esi,%edi
80100e08:	0f 84 fe 02 00 00    	je     8010110c <consoleintr+0x41c>
80100e0e:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80100e11:	89 de                	mov    %ebx,%esi
80100e13:	89 cb                	mov    %ecx,%ebx
  if(panicked){
80100e15:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80100e1b:	85 c9                	test   %ecx,%ecx
80100e1d:	0f 84 c9 02 00 00    	je     801010ec <consoleintr+0x3fc>
80100e23:	fa                   	cli    
    for(;;)
80100e24:	eb fe                	jmp    80100e24 <consoleintr+0x134>
80100e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e2d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100e30:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100e36:	0f 85 57 02 00 00    	jne    80101093 <consoleintr+0x3a3>
        if (input.e < input.rightmost) {
80100e3c:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
80100e41:	3b 05 8c ac 11 80    	cmp    0x8011ac8c,%eax
80100e47:	0f 83 a7 00 00 00    	jae    80100ef4 <consoleintr+0x204>
  if(panicked){
80100e4d:	8b 3d 58 b5 10 80    	mov    0x8010b558,%edi
80100e53:	85 ff                	test   %edi,%edi
80100e55:	0f 84 76 02 00 00    	je     801010d1 <consoleintr+0x3e1>
80100e5b:	fa                   	cli    
    for(;;)
80100e5c:	eb fe                	jmp    80100e5c <consoleintr+0x16c>
80100e5e:	66 90                	xchg   %ax,%ax
    switch(c){
80100e60:	83 fb 08             	cmp    $0x8,%ebx
80100e63:	0f 84 2f 01 00 00    	je     80100f98 <consoleintr+0x2a8>
80100e69:	83 fb 0d             	cmp    $0xd,%ebx
80100e6c:	0f 85 19 02 00 00    	jne    8010108b <consoleintr+0x39b>
          input.e = input.rightmost;
80100e72:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100e77:	8b 35 80 ac 11 80    	mov    0x8011ac80,%esi
80100e7d:	89 c2                	mov    %eax,%edx
          input.e = input.rightmost;
80100e7f:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
80100e84:	89 c1                	mov    %eax,%ecx
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100e86:	29 f2                	sub    %esi,%edx
80100e88:	83 fa 7f             	cmp    $0x7f,%edx
80100e8b:	0f 87 86 fe ff ff    	ja     80100d17 <consoleintr+0x27>
80100e91:	c6 45 e4 0a          	movb   $0xa,-0x1c(%ebp)
          c = (c == '\r') ? '\n' : c;
80100e95:	bb 0a 00 00 00       	mov    $0xa,%ebx
          if (input.rightmost > input.e) { // caret isn't at the end of the line
80100e9a:	89 cf                	mov    %ecx,%edi
80100e9c:	8d 51 01             	lea    0x1(%ecx),%edx
80100e9f:	83 e7 7f             	and    $0x7f,%edi
80100ea2:	89 7d dc             	mov    %edi,-0x24(%ebp)
80100ea5:	39 c8                	cmp    %ecx,%eax
80100ea7:	0f 87 67 04 00 00    	ja     80101314 <consoleintr+0x624>
            input.buf[input.e++ % INPUT_BUF] = c;
80100ead:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
80100eb1:	8b 7d dc             	mov    -0x24(%ebp),%edi
80100eb4:	89 15 88 ac 11 80    	mov    %edx,0x8011ac88
80100eba:	88 8f 00 ac 11 80    	mov    %cl,-0x7fee5400(%edi)
            input.rightmost = input.e - input.rightmost == 1 ? input.e : input.rightmost;
80100ec0:	89 d1                	mov    %edx,%ecx
80100ec2:	29 c1                	sub    %eax,%ecx
80100ec4:	83 f9 01             	cmp    $0x1,%ecx
80100ec7:	0f 45 d0             	cmovne %eax,%edx
80100eca:	89 15 8c ac 11 80    	mov    %edx,0x8011ac8c
  if(panicked){
80100ed0:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
80100ed6:	85 d2                	test   %edx,%edx
80100ed8:	0f 84 ed 03 00 00    	je     801012cb <consoleintr+0x5db>
80100ede:	fa                   	cli    
    for(;;)
80100edf:	eb fe                	jmp    80100edf <consoleintr+0x1ef>
80100ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100ee8:	c7 45 e0 01 00 00 00 	movl   $0x1,-0x20(%ebp)
80100eef:	e9 23 fe ff ff       	jmp    80100d17 <consoleintr+0x27>
        else if (input.e == input.rightmost){
80100ef4:	0f 85 1d fe ff ff    	jne    80100d17 <consoleintr+0x27>
  if(panicked){
80100efa:	8b 35 58 b5 10 80    	mov    0x8010b558,%esi
80100f00:	85 f6                	test   %esi,%esi
80100f02:	0f 85 79 04 00 00    	jne    80101381 <consoleintr+0x691>
80100f08:	b8 20 00 00 00       	mov    $0x20,%eax
80100f0d:	e8 fe f4 ff ff       	call   80100410 <consputc.part.0>
80100f12:	8b 1d 58 b5 10 80    	mov    0x8010b558,%ebx
80100f18:	85 db                	test   %ebx,%ebx
80100f1a:	0f 84 a2 01 00 00    	je     801010c2 <consoleintr+0x3d2>
80100f20:	fa                   	cli    
    for(;;)
80100f21:	eb fe                	jmp    80100f21 <consoleintr+0x231>
80100f23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f27:	90                   	nop
          while(input.e != input.w &&
80100f28:	39 f2                	cmp    %esi,%edx
80100f2a:	0f 84 e7 fd ff ff    	je     80100d17 <consoleintr+0x27>
                input.buf[(input.e - 1) % INPUT_BUF] != '\n'){
80100f30:	83 ea 01             	sub    $0x1,%edx
80100f33:	89 d0                	mov    %edx,%eax
80100f35:	83 e0 7f             	and    $0x7f,%eax
          while(input.e != input.w &&
80100f38:	80 b8 00 ac 11 80 0a 	cmpb   $0xa,-0x7fee5400(%eax)
80100f3f:	0f 84 d2 fd ff ff    	je     80100d17 <consoleintr+0x27>
  if(panicked){
80100f45:	a1 58 b5 10 80       	mov    0x8010b558,%eax
            input.rightmost--;
80100f4a:	83 2d 8c ac 11 80 01 	subl   $0x1,0x8011ac8c
            input.e--;
80100f51:	89 15 88 ac 11 80    	mov    %edx,0x8011ac88
  if(panicked){
80100f57:	85 c0                	test   %eax,%eax
80100f59:	0f 84 59 02 00 00    	je     801011b8 <consoleintr+0x4c8>
80100f5f:	fa                   	cli    
    for(;;)
80100f60:	eb fe                	jmp    80100f60 <consoleintr+0x270>
80100f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (input.e != input.w) {
80100f68:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
80100f6d:	3b 05 84 ac 11 80    	cmp    0x8011ac84,%eax
80100f73:	0f 84 9e fd ff ff    	je     80100d17 <consoleintr+0x27>
          input.e--;
80100f79:	83 e8 01             	sub    $0x1,%eax
80100f7c:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
  if(panicked){
80100f81:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80100f86:	85 c0                	test   %eax,%eax
80100f88:	0f 84 34 01 00 00    	je     801010c2 <consoleintr+0x3d2>
80100f8e:	fa                   	cli    
    for(;;)
80100f8f:	eb fe                	jmp    80100f8f <consoleintr+0x29f>
80100f91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if (input.rightmost != input.e && input.e != input.w) { // caret isn't at the end of the line
80100f98:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
80100f9d:	8b 0d 88 ac 11 80    	mov    0x8011ac88,%ecx
80100fa3:	8b 15 84 ac 11 80    	mov    0x8011ac84,%edx
80100fa9:	39 c8                	cmp    %ecx,%eax
80100fab:	0f 84 2f 02 00 00    	je     801011e0 <consoleintr+0x4f0>
80100fb1:	39 d1                	cmp    %edx,%ecx
80100fb3:	0f 84 5e fd ff ff    	je     80100d17 <consoleintr+0x27>
          shiftbufleft();
80100fb9:	e8 32 f9 ff ff       	call   801008f0 <shiftbufleft>
          break;
80100fbe:	e9 54 fd ff ff       	jmp    80100d17 <consoleintr+0x27>
       if (historyBufferArray.currentHistory < historyBufferArray.numOfCommmandsInMem-1 ){ // current history means the oldest possible will be MAX_HISTORY-1
80100fc3:	a1 14 b8 11 80       	mov    0x8011b814,%eax
80100fc8:	83 e8 01             	sub    $0x1,%eax
80100fcb:	39 05 18 b8 11 80    	cmp    %eax,0x8011b818
80100fd1:	0f 8d 40 fd ff ff    	jge    80100d17 <consoleintr+0x27>
          earaseCurrentLineOnScreen();
80100fd7:	e8 a4 fa ff ff       	call   80100a80 <earaseCurrentLineOnScreen>
          if (historyBufferArray.currentHistory == -1)
80100fdc:	8b 0d 18 b8 11 80    	mov    0x8011b818,%ecx
80100fe2:	8b 35 80 ac 11 80    	mov    0x8011ac80,%esi
80100fe8:	83 f9 ff             	cmp    $0xffffffff,%ecx
80100feb:	0f 84 ba 03 00 00    	je     801013ab <consoleintr+0x6bb>
          historyBufferArray.currentHistory++;
80100ff1:	83 c1 01             	add    $0x1,%ecx
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
80100ff4:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
          copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80100ff9:	83 ec 08             	sub    $0x8,%esp
  input.rightmost = input.r;
80100ffc:	89 35 8c ac 11 80    	mov    %esi,0x8011ac8c
          historyBufferArray.currentHistory++;
80101002:	89 0d 18 b8 11 80    	mov    %ecx,0x8011b818
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
80101008:	03 0d 10 b8 11 80    	add    0x8011b810,%ecx
8010100e:	89 c8                	mov    %ecx,%eax
  input.e = input.r;
80101010:	89 35 88 ac 11 80    	mov    %esi,0x8011ac88
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
80101016:	f7 e2                	mul    %edx
80101018:	89 d0                	mov    %edx,%eax
8010101a:	c1 e8 04             	shr    $0x4,%eax
8010101d:	8d 04 80             	lea    (%eax,%eax,4),%eax
80101020:	c1 e0 02             	shl    $0x2,%eax
80101023:	29 c1                	sub    %eax,%ecx
80101025:	89 c8                	mov    %ecx,%eax
          copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101027:	c1 e1 07             	shl    $0x7,%ecx
8010102a:	8d 98 80 02 00 00    	lea    0x280(%eax),%ebx
80101030:	8d b1 c0 ad 11 80    	lea    -0x7fee5240(%ecx),%esi
80101036:	ff 34 9d c0 ad 11 80 	pushl  -0x7fee5240(,%ebx,4)
8010103d:	56                   	push   %esi
8010103e:	e8 ed fa ff ff       	call   80100b30 <copyBufferToScreen>
          copyBufferToInputBuf(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101043:	8b 14 9d c0 ad 11 80 	mov    -0x7fee5240(,%ebx,4),%edx
  for (i = 0; i < length; i++) {
8010104a:	83 c4 10             	add    $0x10,%esp
8010104d:	85 d2                	test   %edx,%edx
8010104f:	0f 84 fb 03 00 00    	je     80101450 <consoleintr+0x760>
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80101055:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
8010105a:	01 c2                	add    %eax,%edx
8010105c:	29 c6                	sub    %eax,%esi
8010105e:	89 f1                	mov    %esi,%ecx
80101060:	89 d7                	mov    %edx,%edi
80101062:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
80101066:	89 c3                	mov    %eax,%ebx
80101068:	83 c0 01             	add    $0x1,%eax
8010106b:	83 e3 7f             	and    $0x7f,%ebx
8010106e:	88 93 00 ac 11 80    	mov    %dl,-0x7fee5400(%ebx)
  for (i = 0; i < length; i++) {
80101074:	39 c7                	cmp    %eax,%edi
80101076:	75 ea                	jne    80101062 <consoleintr+0x372>
80101078:	89 fa                	mov    %edi,%edx
  input.e = input.r+length;
8010107a:	89 15 88 ac 11 80    	mov    %edx,0x8011ac88
  input.rightmost = input.e;
80101080:	89 15 8c ac 11 80    	mov    %edx,0x8011ac8c
}
80101086:	e9 8c fc ff ff       	jmp    80100d17 <consoleintr+0x27>
        if(c != 0 && input.e-input.r < INPUT_BUF){
8010108b:	85 db                	test   %ebx,%ebx
8010108d:	0f 84 84 fc ff ff    	je     80100d17 <consoleintr+0x27>
80101093:	8b 0d 88 ac 11 80    	mov    0x8011ac88,%ecx
80101099:	8b 35 80 ac 11 80    	mov    0x8011ac80,%esi
8010109f:	89 c8                	mov    %ecx,%eax
801010a1:	29 f0                	sub    %esi,%eax
801010a3:	83 f8 7f             	cmp    $0x7f,%eax
801010a6:	0f 87 6b fc ff ff    	ja     80100d17 <consoleintr+0x27>
          c = (c == '\r') ? '\n' : c;
801010ac:	83 fb 0d             	cmp    $0xd,%ebx
801010af:	0f 84 a6 03 00 00    	je     8010145b <consoleintr+0x76b>
801010b5:	88 5d e4             	mov    %bl,-0x1c(%ebp)
801010b8:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
801010bd:	e9 d8 fd ff ff       	jmp    80100e9a <consoleintr+0x1aa>
801010c2:	b8 e4 00 00 00       	mov    $0xe4,%eax
801010c7:	e8 44 f3 ff ff       	call   80100410 <consputc.part.0>
801010cc:	e9 46 fc ff ff       	jmp    80100d17 <consoleintr+0x27>
          consputc(input.buf[input.e % INPUT_BUF]);
801010d1:	83 e0 7f             	and    $0x7f,%eax
801010d4:	0f be 80 00 ac 11 80 	movsbl -0x7fee5400(%eax),%eax
801010db:	e8 30 f3 ff ff       	call   80100410 <consputc.part.0>
          input.e++;
801010e0:	83 05 88 ac 11 80 01 	addl   $0x1,0x8011ac88
801010e7:	e9 2b fc ff ff       	jmp    80100d17 <consoleintr+0x27>
801010ec:	b8 e4 00 00 00       	mov    $0xe4,%eax
          for (i = 0; i < placestoshift; i++) {
801010f1:	83 c3 01             	add    $0x1,%ebx
801010f4:	89 55 dc             	mov    %edx,-0x24(%ebp)
801010f7:	e8 14 f3 ff ff       	call   80100410 <consputc.part.0>
801010fc:	39 df                	cmp    %ebx,%edi
801010fe:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101101:	0f 85 0e fd ff ff    	jne    80100e15 <consoleintr+0x125>
80101107:	89 f3                	mov    %esi,%ebx
80101109:	8b 75 e4             	mov    -0x1c(%ebp),%esi
          memset(buf2, '\0', INPUT_BUF);
8010110c:	83 ec 04             	sub    $0x4,%esp
          uint numtoshift = input.rightmost - input.e;
8010110f:	89 d8                	mov    %ebx,%eax
80101111:	89 55 d0             	mov    %edx,-0x30(%ebp)
          memset(buf2, '\0', INPUT_BUF);
80101114:	68 80 00 00 00       	push   $0x80
          uint numtoshift = input.rightmost - input.e;
80101119:	29 d0                	sub    %edx,%eax
          memset(buf2, '\0', INPUT_BUF);
8010111b:	6a 00                	push   $0x0
8010111d:	68 a0 ac 11 80       	push   $0x8011aca0
          uint numtoshift = input.rightmost - input.e;
80101122:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          memset(buf2, '\0', INPUT_BUF);
80101125:	e8 56 42 00 00       	call   80105380 <memset>
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
8010112a:	a1 84 ac 11 80       	mov    0x8011ac84,%eax
8010112f:	8b 55 d0             	mov    -0x30(%ebp),%edx
80101132:	83 c4 10             	add    $0x10,%esp
80101135:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101138:	01 f8                	add    %edi,%eax
8010113a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
          for (i = 0; i < numtoshift; i++) {
8010113d:	31 c0                	xor    %eax,%eax
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
8010113f:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80101142:	01 c1                	add    %eax,%ecx
          for (i = 0; i < numtoshift; i++) {
80101144:	83 c0 01             	add    $0x1,%eax
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
80101147:	83 e1 7f             	and    $0x7f,%ecx
8010114a:	0f b6 89 00 ac 11 80 	movzbl -0x7fee5400(%ecx),%ecx
80101151:	88 88 9f ac 11 80    	mov    %cl,-0x7fee5361(%eax)
          for (i = 0; i < numtoshift; i++) {
80101157:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
8010115a:	75 e3                	jne    8010113f <consoleintr+0x44f>
          for (i = 0; i < numtoshift; i++) {
8010115c:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010115f:	31 c0                	xor    %eax,%eax
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
80101161:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101164:	0f b6 90 a0 ac 11 80 	movzbl -0x7fee5360(%eax),%edx
8010116b:	01 c1                	add    %eax,%ecx
          for (i = 0; i < numtoshift; i++) {
8010116d:	83 c0 01             	add    $0x1,%eax
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
80101170:	83 e1 7f             	and    $0x7f,%ecx
80101173:	88 91 00 ac 11 80    	mov    %dl,-0x7fee5400(%ecx)
          for (i = 0; i < numtoshift; i++) {
80101179:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
8010117c:	75 e3                	jne    80101161 <consoleintr+0x471>
8010117e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
          input.e -= placestoshift;
80101181:	89 f0                	mov    %esi,%eax
          for (i = 0; i < numtoshift; i++) { // repaint the chars
80101183:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101186:	89 de                	mov    %ebx,%esi
80101188:	29 d0                	sub    %edx,%eax
8010118a:	89 c2                	mov    %eax,%edx
          input.e -= placestoshift;
8010118c:	03 05 88 ac 11 80    	add    0x8011ac88,%eax
          input.rightmost -= placestoshift;
80101192:	01 15 8c ac 11 80    	add    %edx,0x8011ac8c
          for (i = 0; i < numtoshift; i++) { // repaint the chars
80101198:	31 d2                	xor    %edx,%edx
          input.e -= placestoshift;
8010119a:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
          for (i = 0; i < numtoshift; i++) { // repaint the chars
8010119f:	89 d3                	mov    %edx,%ebx
  if(panicked){
801011a1:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801011a7:	85 d2                	test   %edx,%edx
801011a9:	0f 84 d9 01 00 00    	je     80101388 <consoleintr+0x698>
801011af:	fa                   	cli    
    for(;;)
801011b0:	eb fe                	jmp    801011b0 <consoleintr+0x4c0>
801011b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011b8:	b8 00 01 00 00       	mov    $0x100,%eax
801011bd:	e8 4e f2 ff ff       	call   80100410 <consputc.part.0>
          while(input.e != input.w &&
801011c2:	8b 15 88 ac 11 80    	mov    0x8011ac88,%edx
801011c8:	3b 15 84 ac 11 80    	cmp    0x8011ac84,%edx
801011ce:	0f 85 5c fd ff ff    	jne    80100f30 <consoleintr+0x240>
801011d4:	e9 3e fb ff ff       	jmp    80100d17 <consoleintr+0x27>
801011d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if(input.e != input.w){ // caret is at the end of the line - deleting last char
801011e0:	39 d0                	cmp    %edx,%eax
801011e2:	0f 84 2f fb ff ff    	je     80100d17 <consoleintr+0x27>
          input.e--;
801011e8:	83 e8 01             	sub    $0x1,%eax
801011eb:	a3 88 ac 11 80       	mov    %eax,0x8011ac88
          input.rightmost--;
801011f0:	a3 8c ac 11 80       	mov    %eax,0x8011ac8c
  if(panicked){
801011f5:	a1 58 b5 10 80       	mov    0x8010b558,%eax
801011fa:	85 c0                	test   %eax,%eax
801011fc:	0f 84 ba 00 00 00    	je     801012bc <consoleintr+0x5cc>
80101202:	fa                   	cli    
    for(;;)
80101203:	eb fe                	jmp    80101203 <consoleintr+0x513>
80101205:	8d 76 00             	lea    0x0(%esi),%esi
            earaseCurrentLineOnScreen();
80101208:	e8 73 f8 ff ff       	call   80100a80 <earaseCurrentLineOnScreen>
            historyBufferArray.currentHistory--;
8010120d:	a1 18 b8 11 80       	mov    0x8011b818,%eax
            tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory)%MAX_HISTORY;
80101212:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
            copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101217:	83 ec 08             	sub    $0x8,%esp
            historyBufferArray.currentHistory--;
8010121a:	83 e8 01             	sub    $0x1,%eax
8010121d:	a3 18 b8 11 80       	mov    %eax,0x8011b818
            tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory)%MAX_HISTORY;
80101222:	03 05 10 b8 11 80    	add    0x8011b810,%eax
80101228:	89 c1                	mov    %eax,%ecx
8010122a:	f7 e2                	mul    %edx
8010122c:	89 d0                	mov    %edx,%eax
8010122e:	c1 e8 04             	shr    $0x4,%eax
80101231:	8d 04 80             	lea    (%eax,%eax,4),%eax
80101234:	c1 e0 02             	shl    $0x2,%eax
80101237:	29 c1                	sub    %eax,%ecx
            copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101239:	89 ce                	mov    %ecx,%esi
8010123b:	8d 99 80 02 00 00    	lea    0x280(%ecx),%ebx
80101241:	c1 e6 07             	shl    $0x7,%esi
80101244:	ff 34 9d c0 ad 11 80 	pushl  -0x7fee5240(,%ebx,4)
8010124b:	81 c6 c0 ad 11 80    	add    $0x8011adc0,%esi
80101251:	56                   	push   %esi
80101252:	e8 d9 f8 ff ff       	call   80100b30 <copyBufferToScreen>
            copyBufferToInputBuf(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101257:	8b 14 9d c0 ad 11 80 	mov    -0x7fee5240(,%ebx,4),%edx
  for (i = 0; i < length; i++) {
8010125e:	83 c4 10             	add    $0x10,%esp
80101261:	85 d2                	test   %edx,%edx
80101263:	0f 84 e7 01 00 00    	je     80101450 <consoleintr+0x760>
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80101269:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
8010126e:	01 c2                	add    %eax,%edx
80101270:	29 c6                	sub    %eax,%esi
80101272:	0f b6 1c 06          	movzbl (%esi,%eax,1),%ebx
80101276:	89 c1                	mov    %eax,%ecx
80101278:	83 c0 01             	add    $0x1,%eax
8010127b:	83 e1 7f             	and    $0x7f,%ecx
8010127e:	88 99 00 ac 11 80    	mov    %bl,-0x7fee5400(%ecx)
  for (i = 0; i < length; i++) {
80101284:	39 c2                	cmp    %eax,%edx
80101286:	75 ea                	jne    80101272 <consoleintr+0x582>
  input.e = input.r+length;
80101288:	89 15 88 ac 11 80    	mov    %edx,0x8011ac88
  input.rightmost = input.e;
8010128e:	89 15 8c ac 11 80    	mov    %edx,0x8011ac8c
80101294:	e9 7e fa ff ff       	jmp    80100d17 <consoleintr+0x27>
  release(&cons.lock);
80101299:	83 ec 0c             	sub    $0xc,%esp
8010129c:	68 20 b5 10 80       	push   $0x8010b520
801012a1:	e8 8a 40 00 00       	call   80105330 <release>
  if(doprocdump) {
801012a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012a9:	83 c4 10             	add    $0x10,%esp
801012ac:	85 c0                	test   %eax,%eax
801012ae:	0f 85 2c 01 00 00    	jne    801013e0 <consoleintr+0x6f0>
}
801012b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012b7:	5b                   	pop    %ebx
801012b8:	5e                   	pop    %esi
801012b9:	5f                   	pop    %edi
801012ba:	5d                   	pop    %ebp
801012bb:	c3                   	ret    
801012bc:	b8 00 01 00 00       	mov    $0x100,%eax
801012c1:	e8 4a f1 ff ff       	call   80100410 <consputc.part.0>
801012c6:	e9 4c fa ff ff       	jmp    80100d17 <consoleintr+0x27>
801012cb:	89 d8                	mov    %ebx,%eax
801012cd:	e8 3e f1 ff ff       	call   80100410 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.rightmost == input.r + INPUT_BUF){
801012d2:	83 fb 0a             	cmp    $0xa,%ebx
801012d5:	74 19                	je     801012f0 <consoleintr+0x600>
801012d7:	83 fb 04             	cmp    $0x4,%ebx
801012da:	74 14                	je     801012f0 <consoleintr+0x600>
801012dc:	a1 80 ac 11 80       	mov    0x8011ac80,%eax
801012e1:	83 e8 80             	sub    $0xffffff80,%eax
801012e4:	39 05 8c ac 11 80    	cmp    %eax,0x8011ac8c
801012ea:	0f 85 27 fa ff ff    	jne    80100d17 <consoleintr+0x27>
            saveCommandInHistory();
801012f0:	e8 db f8 ff ff       	call   80100bd0 <saveCommandInHistory>
            wakeup(&input.r);
801012f5:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.rightmost;
801012f8:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
            wakeup(&input.r);
801012fd:	68 80 ac 11 80       	push   $0x8011ac80
            input.w = input.rightmost;
80101302:	a3 84 ac 11 80       	mov    %eax,0x8011ac84
            wakeup(&input.r);
80101307:	e8 b4 38 00 00       	call   80104bc0 <wakeup>
8010130c:	83 c4 10             	add    $0x10,%esp
8010130f:	e9 03 fa ff ff       	jmp    80100d17 <consoleintr+0x27>
  for (i = 0; i < n; i++)
80101314:	89 c7                	mov    %eax,%edi
80101316:	29 f7                	sub    %esi,%edi
80101318:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010131b:	74 23                	je     80101340 <consoleintr+0x650>
8010131d:	89 45 d0             	mov    %eax,-0x30(%ebp)
80101320:	31 ff                	xor    %edi,%edi
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
80101322:	8d 34 39             	lea    (%ecx,%edi,1),%esi
  for (i = 0; i < n; i++)
80101325:	83 c7 01             	add    $0x1,%edi
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
80101328:	83 e6 7f             	and    $0x7f,%esi
8010132b:	0f b6 86 00 ac 11 80 	movzbl -0x7fee5400(%esi),%eax
80101332:	88 87 3f ad 11 80    	mov    %al,-0x7fee52c1(%edi)
  for (i = 0; i < n; i++)
80101338:	39 7d d4             	cmp    %edi,-0x2c(%ebp)
8010133b:	75 e5                	jne    80101322 <consoleintr+0x632>
8010133d:	8b 45 d0             	mov    -0x30(%ebp),%eax
            input.buf[input.e++ % INPUT_BUF] = c;
80101340:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx
80101344:	8b 7d dc             	mov    -0x24(%ebp),%edi
            input.rightmost++;
80101347:	83 c0 01             	add    $0x1,%eax
            input.buf[input.e++ % INPUT_BUF] = c;
8010134a:	89 15 88 ac 11 80    	mov    %edx,0x8011ac88
            input.rightmost++;
80101350:	a3 8c ac 11 80       	mov    %eax,0x8011ac8c
            input.buf[input.e++ % INPUT_BUF] = c;
80101355:	88 8f 00 ac 11 80    	mov    %cl,-0x7fee5400(%edi)
  if(panicked){
8010135b:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
80101361:	85 c9                	test   %ecx,%ecx
80101363:	74 0b                	je     80101370 <consoleintr+0x680>
80101365:	fa                   	cli    
    for(;;)
80101366:	eb fe                	jmp    80101366 <consoleintr+0x676>
80101368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010136f:	90                   	nop
80101370:	89 d8                	mov    %ebx,%eax
80101372:	e8 99 f0 ff ff       	call   80100410 <consputc.part.0>
            shiftbufright();
80101377:	e8 44 f6 ff ff       	call   801009c0 <shiftbufright>
8010137c:	e9 51 ff ff ff       	jmp    801012d2 <consoleintr+0x5e2>
80101381:	fa                   	cli    
    for(;;)
80101382:	eb fe                	jmp    80101382 <consoleintr+0x692>
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
80101388:	01 d8                	add    %ebx,%eax
          for (i = 0; i < numtoshift; i++) { // repaint the chars
8010138a:	83 c3 01             	add    $0x1,%ebx
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
8010138d:	83 e0 7f             	and    $0x7f,%eax
80101390:	0f be 80 00 ac 11 80 	movsbl -0x7fee5400(%eax),%eax
80101397:	e8 74 f0 ff ff       	call   80100410 <consputc.part.0>
          for (i = 0; i < numtoshift; i++) { // repaint the chars
8010139c:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010139f:	74 4b                	je     801013ec <consoleintr+0x6fc>
801013a1:	a1 88 ac 11 80       	mov    0x8011ac88,%eax
801013a6:	e9 f6 fd ff ff       	jmp    801011a1 <consoleintr+0x4b1>
    lengthOfOldBuf = input.rightmost - input.r;
801013ab:	8b 15 8c ac 11 80    	mov    0x8011ac8c,%edx
801013b1:	29 f2                	sub    %esi,%edx
801013b3:	89 15 20 ad 11 80    	mov    %edx,0x8011ad20
    for (i = 0; i < lengthOfOldBuf; i++) {
801013b9:	0f 84 32 fc ff ff    	je     80100ff1 <consoleintr+0x301>
801013bf:	31 c0                	xor    %eax,%eax
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
801013c1:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
    for (i = 0; i < lengthOfOldBuf; i++) {
801013c4:	83 c0 01             	add    $0x1,%eax
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
801013c7:	83 e3 7f             	and    $0x7f,%ebx
801013ca:	0f b6 9b 00 ac 11 80 	movzbl -0x7fee5400(%ebx),%ebx
801013d1:	88 98 7f ab 11 80    	mov    %bl,-0x7fee5481(%eax)
    for (i = 0; i < lengthOfOldBuf; i++) {
801013d7:	39 c2                	cmp    %eax,%edx
801013d9:	75 e6                	jne    801013c1 <consoleintr+0x6d1>
801013db:	e9 11 fc ff ff       	jmp    80100ff1 <consoleintr+0x301>
}
801013e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e3:	5b                   	pop    %ebx
801013e4:	5e                   	pop    %esi
801013e5:	5f                   	pop    %edi
801013e6:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
801013e7:	e9 d4 38 00 00       	jmp    80104cc0 <procdump>
801013ec:	89 f3                	mov    %esi,%ebx
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
801013ee:	31 d2                	xor    %edx,%edx
801013f0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801013f3:	85 ff                	test   %edi,%edi
801013f5:	74 2f                	je     80101426 <consoleintr+0x736>
801013f7:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801013fa:	89 de                	mov    %ebx,%esi
801013fc:	89 d3                	mov    %edx,%ebx
  if(panicked){
801013fe:	a1 58 b5 10 80       	mov    0x8010b558,%eax
80101403:	85 c0                	test   %eax,%eax
80101405:	74 09                	je     80101410 <consoleintr+0x720>
80101407:	fa                   	cli    
    for(;;)
80101408:	eb fe                	jmp    80101408 <consoleintr+0x718>
8010140a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101410:	b8 20 00 00 00       	mov    $0x20,%eax
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
80101415:	83 c3 01             	add    $0x1,%ebx
80101418:	e8 f3 ef ff ff       	call   80100410 <consputc.part.0>
8010141d:	39 df                	cmp    %ebx,%edi
8010141f:	75 dd                	jne    801013fe <consoleintr+0x70e>
80101421:	89 f3                	mov    %esi,%ebx
80101423:	8b 75 e4             	mov    -0x1c(%ebp),%esi
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
80101426:	31 ff                	xor    %edi,%edi
80101428:	29 f3                	sub    %esi,%ebx
8010142a:	39 fb                	cmp    %edi,%ebx
8010142c:	0f 86 e5 f8 ff ff    	jbe    80100d17 <consoleintr+0x27>
  if(panicked){
80101432:	83 3d 58 b5 10 80 00 	cmpl   $0x0,0x8010b558
80101439:	74 03                	je     8010143e <consoleintr+0x74e>
8010143b:	fa                   	cli    
    for(;;)
8010143c:	eb fe                	jmp    8010143c <consoleintr+0x74c>
8010143e:	b8 e4 00 00 00       	mov    $0xe4,%eax
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
80101443:	83 c7 01             	add    $0x1,%edi
80101446:	e8 c5 ef ff ff       	call   80100410 <consputc.part.0>
8010144b:	eb dd                	jmp    8010142a <consoleintr+0x73a>
8010144d:	8d 76 00             	lea    0x0(%esi),%esi
80101450:	8b 15 80 ac 11 80    	mov    0x8011ac80,%edx
80101456:	e9 1f fc ff ff       	jmp    8010107a <consoleintr+0x38a>
8010145b:	c6 45 e4 0a          	movb   $0xa,-0x1c(%ebp)
8010145f:	a1 8c ac 11 80       	mov    0x8011ac8c,%eax
          c = (c == '\r') ? '\n' : c;
80101464:	bb 0a 00 00 00       	mov    $0xa,%ebx
80101469:	e9 2c fa ff ff       	jmp    80100e9a <consoleintr+0x1aa>
8010146e:	66 90                	xchg   %ax,%ax

80101470 <consoleinit>:

void
consoleinit(void)
{
80101470:	f3 0f 1e fb          	endbr32 
80101474:	55                   	push   %ebp
80101475:	89 e5                	mov    %esp,%ebp
80101477:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
8010147a:	68 e8 7f 10 80       	push   $0x80107fe8
8010147f:	68 20 b5 10 80       	push   $0x8010b520
80101484:	e8 67 3c 00 00       	call   801050f0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101489:	58                   	pop    %eax
8010148a:	5a                   	pop    %edx
8010148b:	6a 00                	push   $0x0
8010148d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010148f:	c7 05 cc c1 11 80 80 	movl   $0x80100680,0x8011c1cc
80101496:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80101499:	c7 05 c8 c1 11 80 90 	movl   $0x80100290,0x8011c1c8
801014a0:	02 10 80 
  cons.locking = 1;
801014a3:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801014aa:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801014ad:	e8 ce 19 00 00       	call   80102e80 <ioapicenable>

  historyBufferArray.numOfCommmandsInMem=0;
  historyBufferArray.lastCommandIndex=0;
}
801014b2:	83 c4 10             	add    $0x10,%esp
  historyBufferArray.numOfCommmandsInMem=0;
801014b5:	c7 05 14 b8 11 80 00 	movl   $0x0,0x8011b814
801014bc:	00 00 00 
  historyBufferArray.lastCommandIndex=0;
801014bf:	c7 05 10 b8 11 80 00 	movl   $0x0,0x8011b810
801014c6:	00 00 00 
}
801014c9:	c9                   	leave  
801014ca:	c3                   	ret    
801014cb:	66 90                	xchg   %ax,%ax
801014cd:	66 90                	xchg   %ax,%ax
801014cf:	90                   	nop

801014d0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801014d0:	f3 0f 1e fb          	endbr32 
801014d4:	55                   	push   %ebp
801014d5:	89 e5                	mov    %esp,%ebp
801014d7:	57                   	push   %edi
801014d8:	56                   	push   %esi
801014d9:	53                   	push   %ebx
801014da:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801014e0:	e8 1b 2f 00 00       	call   80104400 <myproc>
801014e5:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
801014eb:	e8 90 22 00 00       	call   80103780 <begin_op>

  if((ip = namei(path)) == 0){
801014f0:	83 ec 0c             	sub    $0xc,%esp
801014f3:	ff 75 08             	pushl  0x8(%ebp)
801014f6:	e8 85 15 00 00       	call   80102a80 <namei>
801014fb:	83 c4 10             	add    $0x10,%esp
801014fe:	85 c0                	test   %eax,%eax
80101500:	0f 84 fe 02 00 00    	je     80101804 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101506:	83 ec 0c             	sub    $0xc,%esp
80101509:	89 c3                	mov    %eax,%ebx
8010150b:	50                   	push   %eax
8010150c:	e8 9f 0c 00 00       	call   801021b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80101511:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101517:	6a 34                	push   $0x34
80101519:	6a 00                	push   $0x0
8010151b:	50                   	push   %eax
8010151c:	53                   	push   %ebx
8010151d:	e8 8e 0f 00 00       	call   801024b0 <readi>
80101522:	83 c4 20             	add    $0x20,%esp
80101525:	83 f8 34             	cmp    $0x34,%eax
80101528:	74 26                	je     80101550 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
8010152a:	83 ec 0c             	sub    $0xc,%esp
8010152d:	53                   	push   %ebx
8010152e:	e8 1d 0f 00 00       	call   80102450 <iunlockput>
    end_op();
80101533:	e8 b8 22 00 00       	call   801037f0 <end_op>
80101538:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
8010153b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101540:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101543:	5b                   	pop    %ebx
80101544:	5e                   	pop    %esi
80101545:	5f                   	pop    %edi
80101546:	5d                   	pop    %ebp
80101547:	c3                   	ret    
80101548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010154f:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80101550:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101557:	45 4c 46 
8010155a:	75 ce                	jne    8010152a <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
8010155c:	e8 7f 67 00 00       	call   80107ce0 <setupkvm>
80101561:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80101567:	85 c0                	test   %eax,%eax
80101569:	74 bf                	je     8010152a <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010156b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80101572:	00 
80101573:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101579:	0f 84 a4 02 00 00    	je     80101823 <exec+0x353>
  sz = 0;
8010157f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101586:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101589:	31 ff                	xor    %edi,%edi
8010158b:	e9 86 00 00 00       	jmp    80101616 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80101590:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101597:	75 6c                	jne    80101605 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101599:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010159f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801015a5:	0f 82 87 00 00 00    	jb     80101632 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
801015ab:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801015b1:	72 7f                	jb     80101632 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801015b3:	83 ec 04             	sub    $0x4,%esp
801015b6:	50                   	push   %eax
801015b7:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801015bd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801015c3:	e8 38 65 00 00       	call   80107b00 <allocuvm>
801015c8:	83 c4 10             	add    $0x10,%esp
801015cb:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801015d1:	85 c0                	test   %eax,%eax
801015d3:	74 5d                	je     80101632 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
801015d5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801015db:	a9 ff 0f 00 00       	test   $0xfff,%eax
801015e0:	75 50                	jne    80101632 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801015e2:	83 ec 0c             	sub    $0xc,%esp
801015e5:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
801015eb:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
801015f1:	53                   	push   %ebx
801015f2:	50                   	push   %eax
801015f3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801015f9:	e8 32 64 00 00       	call   80107a30 <loaduvm>
801015fe:	83 c4 20             	add    $0x20,%esp
80101601:	85 c0                	test   %eax,%eax
80101603:	78 2d                	js     80101632 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101605:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010160c:	83 c7 01             	add    $0x1,%edi
8010160f:	83 c6 20             	add    $0x20,%esi
80101612:	39 f8                	cmp    %edi,%eax
80101614:	7e 3a                	jle    80101650 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101616:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010161c:	6a 20                	push   $0x20
8010161e:	56                   	push   %esi
8010161f:	50                   	push   %eax
80101620:	53                   	push   %ebx
80101621:	e8 8a 0e 00 00       	call   801024b0 <readi>
80101626:	83 c4 10             	add    $0x10,%esp
80101629:	83 f8 20             	cmp    $0x20,%eax
8010162c:	0f 84 5e ff ff ff    	je     80101590 <exec+0xc0>
    freevm(pgdir);
80101632:	83 ec 0c             	sub    $0xc,%esp
80101635:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
8010163b:	e8 20 66 00 00       	call   80107c60 <freevm>
  if(ip){
80101640:	83 c4 10             	add    $0x10,%esp
80101643:	e9 e2 fe ff ff       	jmp    8010152a <exec+0x5a>
80101648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010164f:	90                   	nop
80101650:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80101656:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
8010165c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80101662:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101668:	83 ec 0c             	sub    $0xc,%esp
8010166b:	53                   	push   %ebx
8010166c:	e8 df 0d 00 00       	call   80102450 <iunlockput>
  end_op();
80101671:	e8 7a 21 00 00       	call   801037f0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101676:	83 c4 0c             	add    $0xc,%esp
80101679:	56                   	push   %esi
8010167a:	57                   	push   %edi
8010167b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101681:	57                   	push   %edi
80101682:	e8 79 64 00 00       	call   80107b00 <allocuvm>
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	89 c6                	mov    %eax,%esi
8010168c:	85 c0                	test   %eax,%eax
8010168e:	0f 84 94 00 00 00    	je     80101728 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101694:	83 ec 08             	sub    $0x8,%esp
80101697:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010169d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010169f:	50                   	push   %eax
801016a0:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
801016a1:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801016a3:	e8 d8 66 00 00       	call   80107d80 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
801016a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801016ab:	83 c4 10             	add    $0x10,%esp
801016ae:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801016b4:	8b 00                	mov    (%eax),%eax
801016b6:	85 c0                	test   %eax,%eax
801016b8:	0f 84 8b 00 00 00    	je     80101749 <exec+0x279>
801016be:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
801016c4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801016ca:	eb 23                	jmp    801016ef <exec+0x21f>
801016cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801016d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
801016d3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
801016da:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
801016dd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
801016e3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
801016e6:	85 c0                	test   %eax,%eax
801016e8:	74 59                	je     80101743 <exec+0x273>
    if(argc >= MAXARG)
801016ea:	83 ff 20             	cmp    $0x20,%edi
801016ed:	74 39                	je     80101728 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801016ef:	83 ec 0c             	sub    $0xc,%esp
801016f2:	50                   	push   %eax
801016f3:	e8 88 3e 00 00       	call   80105580 <strlen>
801016f8:	f7 d0                	not    %eax
801016fa:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801016fc:	58                   	pop    %eax
801016fd:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101700:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101703:	ff 34 b8             	pushl  (%eax,%edi,4)
80101706:	e8 75 3e 00 00       	call   80105580 <strlen>
8010170b:	83 c0 01             	add    $0x1,%eax
8010170e:	50                   	push   %eax
8010170f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101712:	ff 34 b8             	pushl  (%eax,%edi,4)
80101715:	53                   	push   %ebx
80101716:	56                   	push   %esi
80101717:	e8 c4 67 00 00       	call   80107ee0 <copyout>
8010171c:	83 c4 20             	add    $0x20,%esp
8010171f:	85 c0                	test   %eax,%eax
80101721:	79 ad                	jns    801016d0 <exec+0x200>
80101723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101727:	90                   	nop
    freevm(pgdir);
80101728:	83 ec 0c             	sub    $0xc,%esp
8010172b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101731:	e8 2a 65 00 00       	call   80107c60 <freevm>
80101736:	83 c4 10             	add    $0x10,%esp
  return -1;
80101739:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010173e:	e9 fd fd ff ff       	jmp    80101540 <exec+0x70>
80101743:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101749:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101750:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80101752:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101759:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010175d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
8010175f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101762:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101768:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010176a:	50                   	push   %eax
8010176b:	52                   	push   %edx
8010176c:	53                   	push   %ebx
8010176d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101773:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010177a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010177d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101783:	e8 58 67 00 00       	call   80107ee0 <copyout>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	78 99                	js     80101728 <exec+0x258>
  for(last=s=path; *s; s++)
8010178f:	8b 45 08             	mov    0x8(%ebp),%eax
80101792:	8b 55 08             	mov    0x8(%ebp),%edx
80101795:	0f b6 00             	movzbl (%eax),%eax
80101798:	84 c0                	test   %al,%al
8010179a:	74 13                	je     801017af <exec+0x2df>
8010179c:	89 d1                	mov    %edx,%ecx
8010179e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
801017a0:	83 c1 01             	add    $0x1,%ecx
801017a3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
801017a5:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
801017a8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
801017ab:	84 c0                	test   %al,%al
801017ad:	75 f1                	jne    801017a0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
801017af:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
801017b5:	83 ec 04             	sub    $0x4,%esp
801017b8:	6a 10                	push   $0x10
801017ba:	89 f8                	mov    %edi,%eax
801017bc:	52                   	push   %edx
801017bd:	83 c0 6c             	add    $0x6c,%eax
801017c0:	50                   	push   %eax
801017c1:	e8 7a 3d 00 00       	call   80105540 <safestrcpy>
  curproc->pgdir = pgdir;
801017c6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
801017cc:	89 f8                	mov    %edi,%eax
801017ce:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
801017d1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
801017d3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
801017d6:	89 c1                	mov    %eax,%ecx
801017d8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
801017de:	8b 40 18             	mov    0x18(%eax),%eax
801017e1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
801017e4:	8b 41 18             	mov    0x18(%ecx),%eax
801017e7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
801017ea:	89 0c 24             	mov    %ecx,(%esp)
801017ed:	e8 ae 60 00 00       	call   801078a0 <switchuvm>
  freevm(oldpgdir);
801017f2:	89 3c 24             	mov    %edi,(%esp)
801017f5:	e8 66 64 00 00       	call   80107c60 <freevm>
  return 0;
801017fa:	83 c4 10             	add    $0x10,%esp
801017fd:	31 c0                	xor    %eax,%eax
801017ff:	e9 3c fd ff ff       	jmp    80101540 <exec+0x70>
    end_op();
80101804:	e8 e7 1f 00 00       	call   801037f0 <end_op>
    cprintf("exec: fail\n");
80101809:	83 ec 0c             	sub    $0xc,%esp
8010180c:	68 01 80 10 80       	push   $0x80108001
80101811:	e8 da ee ff ff       	call   801006f0 <cprintf>
    return -1;
80101816:	83 c4 10             	add    $0x10,%esp
80101819:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010181e:	e9 1d fd ff ff       	jmp    80101540 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101823:	31 ff                	xor    %edi,%edi
80101825:	be 00 20 00 00       	mov    $0x2000,%esi
8010182a:	e9 39 fe ff ff       	jmp    80101668 <exec+0x198>
8010182f:	90                   	nop

80101830 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101830:	f3 0f 1e fb          	endbr32 
80101834:	55                   	push   %ebp
80101835:	89 e5                	mov    %esp,%ebp
80101837:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
8010183a:	68 0d 80 10 80       	push   $0x8010800d
8010183f:	68 20 b8 11 80       	push   $0x8011b820
80101844:	e8 a7 38 00 00       	call   801050f0 <initlock>
}
80101849:	83 c4 10             	add    $0x10,%esp
8010184c:	c9                   	leave  
8010184d:	c3                   	ret    
8010184e:	66 90                	xchg   %ax,%ax

80101850 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101850:	f3 0f 1e fb          	endbr32 
80101854:	55                   	push   %ebp
80101855:	89 e5                	mov    %esp,%ebp
80101857:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101858:	bb 54 b8 11 80       	mov    $0x8011b854,%ebx
{
8010185d:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80101860:	68 20 b8 11 80       	push   $0x8011b820
80101865:	e8 06 3a 00 00       	call   80105270 <acquire>
8010186a:	83 c4 10             	add    $0x10,%esp
8010186d:	eb 0c                	jmp    8010187b <filealloc+0x2b>
8010186f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101870:	83 c3 18             	add    $0x18,%ebx
80101873:	81 fb b4 c1 11 80    	cmp    $0x8011c1b4,%ebx
80101879:	74 25                	je     801018a0 <filealloc+0x50>
    if(f->ref == 0){
8010187b:	8b 43 04             	mov    0x4(%ebx),%eax
8010187e:	85 c0                	test   %eax,%eax
80101880:	75 ee                	jne    80101870 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101882:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101885:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010188c:	68 20 b8 11 80       	push   $0x8011b820
80101891:	e8 9a 3a 00 00       	call   80105330 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101896:	89 d8                	mov    %ebx,%eax
      return f;
80101898:	83 c4 10             	add    $0x10,%esp
}
8010189b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010189e:	c9                   	leave  
8010189f:	c3                   	ret    
  release(&ftable.lock);
801018a0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801018a3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
801018a5:	68 20 b8 11 80       	push   $0x8011b820
801018aa:	e8 81 3a 00 00       	call   80105330 <release>
}
801018af:	89 d8                	mov    %ebx,%eax
  return 0;
801018b1:	83 c4 10             	add    $0x10,%esp
}
801018b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018b7:	c9                   	leave  
801018b8:	c3                   	ret    
801018b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801018c0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801018c0:	f3 0f 1e fb          	endbr32 
801018c4:	55                   	push   %ebp
801018c5:	89 e5                	mov    %esp,%ebp
801018c7:	53                   	push   %ebx
801018c8:	83 ec 10             	sub    $0x10,%esp
801018cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801018ce:	68 20 b8 11 80       	push   $0x8011b820
801018d3:	e8 98 39 00 00       	call   80105270 <acquire>
  if(f->ref < 1)
801018d8:	8b 43 04             	mov    0x4(%ebx),%eax
801018db:	83 c4 10             	add    $0x10,%esp
801018de:	85 c0                	test   %eax,%eax
801018e0:	7e 1a                	jle    801018fc <filedup+0x3c>
    panic("filedup");
  f->ref++;
801018e2:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801018e5:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801018e8:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801018eb:	68 20 b8 11 80       	push   $0x8011b820
801018f0:	e8 3b 3a 00 00       	call   80105330 <release>
  return f;
}
801018f5:	89 d8                	mov    %ebx,%eax
801018f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018fa:	c9                   	leave  
801018fb:	c3                   	ret    
    panic("filedup");
801018fc:	83 ec 0c             	sub    $0xc,%esp
801018ff:	68 14 80 10 80       	push   $0x80108014
80101904:	e8 87 ea ff ff       	call   80100390 <panic>
80101909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101910 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101910:	f3 0f 1e fb          	endbr32 
80101914:	55                   	push   %ebp
80101915:	89 e5                	mov    %esp,%ebp
80101917:	57                   	push   %edi
80101918:	56                   	push   %esi
80101919:	53                   	push   %ebx
8010191a:	83 ec 28             	sub    $0x28,%esp
8010191d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101920:	68 20 b8 11 80       	push   $0x8011b820
80101925:	e8 46 39 00 00       	call   80105270 <acquire>
  if(f->ref < 1)
8010192a:	8b 53 04             	mov    0x4(%ebx),%edx
8010192d:	83 c4 10             	add    $0x10,%esp
80101930:	85 d2                	test   %edx,%edx
80101932:	0f 8e a1 00 00 00    	jle    801019d9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101938:	83 ea 01             	sub    $0x1,%edx
8010193b:	89 53 04             	mov    %edx,0x4(%ebx)
8010193e:	75 40                	jne    80101980 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101940:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101944:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101947:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101949:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010194f:	8b 73 0c             	mov    0xc(%ebx),%esi
80101952:	88 45 e7             	mov    %al,-0x19(%ebp)
80101955:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101958:	68 20 b8 11 80       	push   $0x8011b820
  ff = *f;
8010195d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101960:	e8 cb 39 00 00       	call   80105330 <release>

  if(ff.type == FD_PIPE)
80101965:	83 c4 10             	add    $0x10,%esp
80101968:	83 ff 01             	cmp    $0x1,%edi
8010196b:	74 53                	je     801019c0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
8010196d:	83 ff 02             	cmp    $0x2,%edi
80101970:	74 26                	je     80101998 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101972:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101975:	5b                   	pop    %ebx
80101976:	5e                   	pop    %esi
80101977:	5f                   	pop    %edi
80101978:	5d                   	pop    %ebp
80101979:	c3                   	ret    
8010197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101980:	c7 45 08 20 b8 11 80 	movl   $0x8011b820,0x8(%ebp)
}
80101987:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010198a:	5b                   	pop    %ebx
8010198b:	5e                   	pop    %esi
8010198c:	5f                   	pop    %edi
8010198d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010198e:	e9 9d 39 00 00       	jmp    80105330 <release>
80101993:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101997:	90                   	nop
    begin_op();
80101998:	e8 e3 1d 00 00       	call   80103780 <begin_op>
    iput(ff.ip);
8010199d:	83 ec 0c             	sub    $0xc,%esp
801019a0:	ff 75 e0             	pushl  -0x20(%ebp)
801019a3:	e8 38 09 00 00       	call   801022e0 <iput>
    end_op();
801019a8:	83 c4 10             	add    $0x10,%esp
}
801019ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ae:	5b                   	pop    %ebx
801019af:	5e                   	pop    %esi
801019b0:	5f                   	pop    %edi
801019b1:	5d                   	pop    %ebp
    end_op();
801019b2:	e9 39 1e 00 00       	jmp    801037f0 <end_op>
801019b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019be:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
801019c0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801019c4:	83 ec 08             	sub    $0x8,%esp
801019c7:	53                   	push   %ebx
801019c8:	56                   	push   %esi
801019c9:	e8 82 25 00 00       	call   80103f50 <pipeclose>
801019ce:	83 c4 10             	add    $0x10,%esp
}
801019d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019d4:	5b                   	pop    %ebx
801019d5:	5e                   	pop    %esi
801019d6:	5f                   	pop    %edi
801019d7:	5d                   	pop    %ebp
801019d8:	c3                   	ret    
    panic("fileclose");
801019d9:	83 ec 0c             	sub    $0xc,%esp
801019dc:	68 1c 80 10 80       	push   $0x8010801c
801019e1:	e8 aa e9 ff ff       	call   80100390 <panic>
801019e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ed:	8d 76 00             	lea    0x0(%esi),%esi

801019f0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801019f0:	f3 0f 1e fb          	endbr32 
801019f4:	55                   	push   %ebp
801019f5:	89 e5                	mov    %esp,%ebp
801019f7:	53                   	push   %ebx
801019f8:	83 ec 04             	sub    $0x4,%esp
801019fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801019fe:	83 3b 02             	cmpl   $0x2,(%ebx)
80101a01:	75 2d                	jne    80101a30 <filestat+0x40>
    ilock(f->ip);
80101a03:	83 ec 0c             	sub    $0xc,%esp
80101a06:	ff 73 10             	pushl  0x10(%ebx)
80101a09:	e8 a2 07 00 00       	call   801021b0 <ilock>
    stati(f->ip, st);
80101a0e:	58                   	pop    %eax
80101a0f:	5a                   	pop    %edx
80101a10:	ff 75 0c             	pushl  0xc(%ebp)
80101a13:	ff 73 10             	pushl  0x10(%ebx)
80101a16:	e8 65 0a 00 00       	call   80102480 <stati>
    iunlock(f->ip);
80101a1b:	59                   	pop    %ecx
80101a1c:	ff 73 10             	pushl  0x10(%ebx)
80101a1f:	e8 6c 08 00 00       	call   80102290 <iunlock>
    return 0;
  }
  return -1;
}
80101a24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101a27:	83 c4 10             	add    $0x10,%esp
80101a2a:	31 c0                	xor    %eax,%eax
}
80101a2c:	c9                   	leave  
80101a2d:	c3                   	ret    
80101a2e:	66 90                	xchg   %ax,%ax
80101a30:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101a33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101a38:	c9                   	leave  
80101a39:	c3                   	ret    
80101a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101a40:	f3 0f 1e fb          	endbr32 
80101a44:	55                   	push   %ebp
80101a45:	89 e5                	mov    %esp,%ebp
80101a47:	57                   	push   %edi
80101a48:	56                   	push   %esi
80101a49:	53                   	push   %ebx
80101a4a:	83 ec 0c             	sub    $0xc,%esp
80101a4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101a50:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a53:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101a56:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101a5a:	74 64                	je     80101ac0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80101a5c:	8b 03                	mov    (%ebx),%eax
80101a5e:	83 f8 01             	cmp    $0x1,%eax
80101a61:	74 45                	je     80101aa8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101a63:	83 f8 02             	cmp    $0x2,%eax
80101a66:	75 5f                	jne    80101ac7 <fileread+0x87>
    ilock(f->ip);
80101a68:	83 ec 0c             	sub    $0xc,%esp
80101a6b:	ff 73 10             	pushl  0x10(%ebx)
80101a6e:	e8 3d 07 00 00       	call   801021b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101a73:	57                   	push   %edi
80101a74:	ff 73 14             	pushl  0x14(%ebx)
80101a77:	56                   	push   %esi
80101a78:	ff 73 10             	pushl  0x10(%ebx)
80101a7b:	e8 30 0a 00 00       	call   801024b0 <readi>
80101a80:	83 c4 20             	add    $0x20,%esp
80101a83:	89 c6                	mov    %eax,%esi
80101a85:	85 c0                	test   %eax,%eax
80101a87:	7e 03                	jle    80101a8c <fileread+0x4c>
      f->off += r;
80101a89:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101a8c:	83 ec 0c             	sub    $0xc,%esp
80101a8f:	ff 73 10             	pushl  0x10(%ebx)
80101a92:	e8 f9 07 00 00       	call   80102290 <iunlock>
    return r;
80101a97:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101a9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a9d:	89 f0                	mov    %esi,%eax
80101a9f:	5b                   	pop    %ebx
80101aa0:	5e                   	pop    %esi
80101aa1:	5f                   	pop    %edi
80101aa2:	5d                   	pop    %ebp
80101aa3:	c3                   	ret    
80101aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101aa8:	8b 43 0c             	mov    0xc(%ebx),%eax
80101aab:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101aae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ab1:	5b                   	pop    %ebx
80101ab2:	5e                   	pop    %esi
80101ab3:	5f                   	pop    %edi
80101ab4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101ab5:	e9 36 26 00 00       	jmp    801040f0 <piperead>
80101aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101ac0:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101ac5:	eb d3                	jmp    80101a9a <fileread+0x5a>
  panic("fileread");
80101ac7:	83 ec 0c             	sub    $0xc,%esp
80101aca:	68 26 80 10 80       	push   $0x80108026
80101acf:	e8 bc e8 ff ff       	call   80100390 <panic>
80101ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101adf:	90                   	nop

80101ae0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101ae0:	f3 0f 1e fb          	endbr32 
80101ae4:	55                   	push   %ebp
80101ae5:	89 e5                	mov    %esp,%ebp
80101ae7:	57                   	push   %edi
80101ae8:	56                   	push   %esi
80101ae9:	53                   	push   %ebx
80101aea:	83 ec 1c             	sub    $0x1c,%esp
80101aed:	8b 45 0c             	mov    0xc(%ebp),%eax
80101af0:	8b 75 08             	mov    0x8(%ebp),%esi
80101af3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101af6:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101af9:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101afd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101b00:	0f 84 c1 00 00 00    	je     80101bc7 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101b06:	8b 06                	mov    (%esi),%eax
80101b08:	83 f8 01             	cmp    $0x1,%eax
80101b0b:	0f 84 c3 00 00 00    	je     80101bd4 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101b11:	83 f8 02             	cmp    $0x2,%eax
80101b14:	0f 85 cc 00 00 00    	jne    80101be6 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101b1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101b1d:	31 ff                	xor    %edi,%edi
    while(i < n){
80101b1f:	85 c0                	test   %eax,%eax
80101b21:	7f 34                	jg     80101b57 <filewrite+0x77>
80101b23:	e9 98 00 00 00       	jmp    80101bc0 <filewrite+0xe0>
80101b28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b2f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101b30:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101b33:	83 ec 0c             	sub    $0xc,%esp
80101b36:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101b39:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101b3c:	e8 4f 07 00 00       	call   80102290 <iunlock>
      end_op();
80101b41:	e8 aa 1c 00 00       	call   801037f0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101b46:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b49:	83 c4 10             	add    $0x10,%esp
80101b4c:	39 c3                	cmp    %eax,%ebx
80101b4e:	75 60                	jne    80101bb0 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
80101b50:	01 df                	add    %ebx,%edi
    while(i < n){
80101b52:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b55:	7e 69                	jle    80101bc0 <filewrite+0xe0>
      int n1 = n - i;
80101b57:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b5a:	b8 00 06 00 00       	mov    $0x600,%eax
80101b5f:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
80101b61:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101b67:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101b6a:	e8 11 1c 00 00       	call   80103780 <begin_op>
      ilock(f->ip);
80101b6f:	83 ec 0c             	sub    $0xc,%esp
80101b72:	ff 76 10             	pushl  0x10(%esi)
80101b75:	e8 36 06 00 00       	call   801021b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101b7a:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b7d:	53                   	push   %ebx
80101b7e:	ff 76 14             	pushl  0x14(%esi)
80101b81:	01 f8                	add    %edi,%eax
80101b83:	50                   	push   %eax
80101b84:	ff 76 10             	pushl  0x10(%esi)
80101b87:	e8 24 0a 00 00       	call   801025b0 <writei>
80101b8c:	83 c4 20             	add    $0x20,%esp
80101b8f:	85 c0                	test   %eax,%eax
80101b91:	7f 9d                	jg     80101b30 <filewrite+0x50>
      iunlock(f->ip);
80101b93:	83 ec 0c             	sub    $0xc,%esp
80101b96:	ff 76 10             	pushl  0x10(%esi)
80101b99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b9c:	e8 ef 06 00 00       	call   80102290 <iunlock>
      end_op();
80101ba1:	e8 4a 1c 00 00       	call   801037f0 <end_op>
      if(r < 0)
80101ba6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ba9:	83 c4 10             	add    $0x10,%esp
80101bac:	85 c0                	test   %eax,%eax
80101bae:	75 17                	jne    80101bc7 <filewrite+0xe7>
        panic("short filewrite");
80101bb0:	83 ec 0c             	sub    $0xc,%esp
80101bb3:	68 2f 80 10 80       	push   $0x8010802f
80101bb8:	e8 d3 e7 ff ff       	call   80100390 <panic>
80101bbd:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101bc0:	89 f8                	mov    %edi,%eax
80101bc2:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101bc5:	74 05                	je     80101bcc <filewrite+0xec>
80101bc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101bcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bcf:	5b                   	pop    %ebx
80101bd0:	5e                   	pop    %esi
80101bd1:	5f                   	pop    %edi
80101bd2:	5d                   	pop    %ebp
80101bd3:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101bd4:	8b 46 0c             	mov    0xc(%esi),%eax
80101bd7:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101bda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bdd:	5b                   	pop    %ebx
80101bde:	5e                   	pop    %esi
80101bdf:	5f                   	pop    %edi
80101be0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101be1:	e9 0a 24 00 00       	jmp    80103ff0 <pipewrite>
  panic("filewrite");
80101be6:	83 ec 0c             	sub    $0xc,%esp
80101be9:	68 35 80 10 80       	push   $0x80108035
80101bee:	e8 9d e7 ff ff       	call   80100390 <panic>
80101bf3:	66 90                	xchg   %ax,%ax
80101bf5:	66 90                	xchg   %ax,%ax
80101bf7:	66 90                	xchg   %ax,%ax
80101bf9:	66 90                	xchg   %ax,%ax
80101bfb:	66 90                	xchg   %ax,%ax
80101bfd:	66 90                	xchg   %ax,%ax
80101bff:	90                   	nop

80101c00 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101c00:	55                   	push   %ebp
80101c01:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101c03:	89 d0                	mov    %edx,%eax
80101c05:	c1 e8 0c             	shr    $0xc,%eax
80101c08:	03 05 38 c2 11 80    	add    0x8011c238,%eax
{
80101c0e:	89 e5                	mov    %esp,%ebp
80101c10:	56                   	push   %esi
80101c11:	53                   	push   %ebx
80101c12:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101c14:	83 ec 08             	sub    $0x8,%esp
80101c17:	50                   	push   %eax
80101c18:	51                   	push   %ecx
80101c19:	e8 b2 e4 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101c1e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101c20:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101c23:	ba 01 00 00 00       	mov    $0x1,%edx
80101c28:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101c2b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101c31:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101c34:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101c36:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101c3b:	85 d1                	test   %edx,%ecx
80101c3d:	74 25                	je     80101c64 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101c3f:	f7 d2                	not    %edx
  log_write(bp);
80101c41:	83 ec 0c             	sub    $0xc,%esp
80101c44:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
80101c46:	21 ca                	and    %ecx,%edx
80101c48:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
80101c4c:	50                   	push   %eax
80101c4d:	e8 0e 1d 00 00       	call   80103960 <log_write>
  brelse(bp);
80101c52:	89 34 24             	mov    %esi,(%esp)
80101c55:	e8 96 e5 ff ff       	call   801001f0 <brelse>
}
80101c5a:	83 c4 10             	add    $0x10,%esp
80101c5d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c60:	5b                   	pop    %ebx
80101c61:	5e                   	pop    %esi
80101c62:	5d                   	pop    %ebp
80101c63:	c3                   	ret    
    panic("freeing free block");
80101c64:	83 ec 0c             	sub    $0xc,%esp
80101c67:	68 3f 80 10 80       	push   $0x8010803f
80101c6c:	e8 1f e7 ff ff       	call   80100390 <panic>
80101c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c7f:	90                   	nop

80101c80 <balloc>:
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101c89:	8b 0d 20 c2 11 80    	mov    0x8011c220,%ecx
{
80101c8f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101c92:	85 c9                	test   %ecx,%ecx
80101c94:	0f 84 87 00 00 00    	je     80101d21 <balloc+0xa1>
80101c9a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101ca1:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101ca4:	83 ec 08             	sub    $0x8,%esp
80101ca7:	89 f0                	mov    %esi,%eax
80101ca9:	c1 f8 0c             	sar    $0xc,%eax
80101cac:	03 05 38 c2 11 80    	add    0x8011c238,%eax
80101cb2:	50                   	push   %eax
80101cb3:	ff 75 d8             	pushl  -0x28(%ebp)
80101cb6:	e8 15 e4 ff ff       	call   801000d0 <bread>
80101cbb:	83 c4 10             	add    $0x10,%esp
80101cbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101cc1:	a1 20 c2 11 80       	mov    0x8011c220,%eax
80101cc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101cc9:	31 c0                	xor    %eax,%eax
80101ccb:	eb 2f                	jmp    80101cfc <balloc+0x7c>
80101ccd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101cd0:	89 c1                	mov    %eax,%ecx
80101cd2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101cd7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101cda:	83 e1 07             	and    $0x7,%ecx
80101cdd:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101cdf:	89 c1                	mov    %eax,%ecx
80101ce1:	c1 f9 03             	sar    $0x3,%ecx
80101ce4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101ce9:	89 fa                	mov    %edi,%edx
80101ceb:	85 df                	test   %ebx,%edi
80101ced:	74 41                	je     80101d30 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101cef:	83 c0 01             	add    $0x1,%eax
80101cf2:	83 c6 01             	add    $0x1,%esi
80101cf5:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101cfa:	74 05                	je     80101d01 <balloc+0x81>
80101cfc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101cff:	77 cf                	ja     80101cd0 <balloc+0x50>
    brelse(bp);
80101d01:	83 ec 0c             	sub    $0xc,%esp
80101d04:	ff 75 e4             	pushl  -0x1c(%ebp)
80101d07:	e8 e4 e4 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101d0c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101d13:	83 c4 10             	add    $0x10,%esp
80101d16:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101d19:	39 05 20 c2 11 80    	cmp    %eax,0x8011c220
80101d1f:	77 80                	ja     80101ca1 <balloc+0x21>
  panic("balloc: out of blocks");
80101d21:	83 ec 0c             	sub    $0xc,%esp
80101d24:	68 52 80 10 80       	push   $0x80108052
80101d29:	e8 62 e6 ff ff       	call   80100390 <panic>
80101d2e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101d30:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101d33:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101d36:	09 da                	or     %ebx,%edx
80101d38:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101d3c:	57                   	push   %edi
80101d3d:	e8 1e 1c 00 00       	call   80103960 <log_write>
        brelse(bp);
80101d42:	89 3c 24             	mov    %edi,(%esp)
80101d45:	e8 a6 e4 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101d4a:	58                   	pop    %eax
80101d4b:	5a                   	pop    %edx
80101d4c:	56                   	push   %esi
80101d4d:	ff 75 d8             	pushl  -0x28(%ebp)
80101d50:	e8 7b e3 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101d55:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101d58:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101d5a:	8d 40 5c             	lea    0x5c(%eax),%eax
80101d5d:	68 00 02 00 00       	push   $0x200
80101d62:	6a 00                	push   $0x0
80101d64:	50                   	push   %eax
80101d65:	e8 16 36 00 00       	call   80105380 <memset>
  log_write(bp);
80101d6a:	89 1c 24             	mov    %ebx,(%esp)
80101d6d:	e8 ee 1b 00 00       	call   80103960 <log_write>
  brelse(bp);
80101d72:	89 1c 24             	mov    %ebx,(%esp)
80101d75:	e8 76 e4 ff ff       	call   801001f0 <brelse>
}
80101d7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7d:	89 f0                	mov    %esi,%eax
80101d7f:	5b                   	pop    %ebx
80101d80:	5e                   	pop    %esi
80101d81:	5f                   	pop    %edi
80101d82:	5d                   	pop    %ebp
80101d83:	c3                   	ret    
80101d84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d8f:	90                   	nop

80101d90 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	89 c7                	mov    %eax,%edi
80101d96:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101d97:	31 f6                	xor    %esi,%esi
{
80101d99:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101d9a:	bb 74 c2 11 80       	mov    $0x8011c274,%ebx
{
80101d9f:	83 ec 28             	sub    $0x28,%esp
80101da2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101da5:	68 40 c2 11 80       	push   $0x8011c240
80101daa:	e8 c1 34 00 00       	call   80105270 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101daf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101db2:	83 c4 10             	add    $0x10,%esp
80101db5:	eb 1b                	jmp    80101dd2 <iget+0x42>
80101db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dbe:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101dc0:	39 3b                	cmp    %edi,(%ebx)
80101dc2:	74 6c                	je     80101e30 <iget+0xa0>
80101dc4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101dca:	81 fb 94 de 11 80    	cmp    $0x8011de94,%ebx
80101dd0:	73 26                	jae    80101df8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101dd2:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101dd5:	85 c9                	test   %ecx,%ecx
80101dd7:	7f e7                	jg     80101dc0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101dd9:	85 f6                	test   %esi,%esi
80101ddb:	75 e7                	jne    80101dc4 <iget+0x34>
80101ddd:	89 d8                	mov    %ebx,%eax
80101ddf:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101de5:	85 c9                	test   %ecx,%ecx
80101de7:	75 6e                	jne    80101e57 <iget+0xc7>
80101de9:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101deb:	81 fb 94 de 11 80    	cmp    $0x8011de94,%ebx
80101df1:	72 df                	jb     80101dd2 <iget+0x42>
80101df3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101df7:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101df8:	85 f6                	test   %esi,%esi
80101dfa:	74 73                	je     80101e6f <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101dfc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101dff:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101e01:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101e04:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101e0b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101e12:	68 40 c2 11 80       	push   $0x8011c240
80101e17:	e8 14 35 00 00       	call   80105330 <release>

  return ip;
80101e1c:	83 c4 10             	add    $0x10,%esp
}
80101e1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e22:	89 f0                	mov    %esi,%eax
80101e24:	5b                   	pop    %ebx
80101e25:	5e                   	pop    %esi
80101e26:	5f                   	pop    %edi
80101e27:	5d                   	pop    %ebp
80101e28:	c3                   	ret    
80101e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101e30:	39 53 04             	cmp    %edx,0x4(%ebx)
80101e33:	75 8f                	jne    80101dc4 <iget+0x34>
      release(&icache.lock);
80101e35:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101e38:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101e3b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101e3d:	68 40 c2 11 80       	push   $0x8011c240
      ip->ref++;
80101e42:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101e45:	e8 e6 34 00 00       	call   80105330 <release>
      return ip;
80101e4a:	83 c4 10             	add    $0x10,%esp
}
80101e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e50:	89 f0                	mov    %esi,%eax
80101e52:	5b                   	pop    %ebx
80101e53:	5e                   	pop    %esi
80101e54:	5f                   	pop    %edi
80101e55:	5d                   	pop    %ebp
80101e56:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101e57:	81 fb 94 de 11 80    	cmp    $0x8011de94,%ebx
80101e5d:	73 10                	jae    80101e6f <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101e5f:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101e62:	85 c9                	test   %ecx,%ecx
80101e64:	0f 8f 56 ff ff ff    	jg     80101dc0 <iget+0x30>
80101e6a:	e9 6e ff ff ff       	jmp    80101ddd <iget+0x4d>
    panic("iget: no inodes");
80101e6f:	83 ec 0c             	sub    $0xc,%esp
80101e72:	68 68 80 10 80       	push   $0x80108068
80101e77:	e8 14 e5 ff ff       	call   80100390 <panic>
80101e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e80 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101e80:	55                   	push   %ebp
80101e81:	89 e5                	mov    %esp,%ebp
80101e83:	57                   	push   %edi
80101e84:	56                   	push   %esi
80101e85:	89 c6                	mov    %eax,%esi
80101e87:	53                   	push   %ebx
80101e88:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101e8b:	83 fa 0b             	cmp    $0xb,%edx
80101e8e:	0f 86 84 00 00 00    	jbe    80101f18 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101e94:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101e97:	83 fb 7f             	cmp    $0x7f,%ebx
80101e9a:	0f 87 98 00 00 00    	ja     80101f38 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101ea0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101ea6:	8b 16                	mov    (%esi),%edx
80101ea8:	85 c0                	test   %eax,%eax
80101eaa:	74 54                	je     80101f00 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101eac:	83 ec 08             	sub    $0x8,%esp
80101eaf:	50                   	push   %eax
80101eb0:	52                   	push   %edx
80101eb1:	e8 1a e2 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101eb6:	83 c4 10             	add    $0x10,%esp
80101eb9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
80101ebd:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101ebf:	8b 1a                	mov    (%edx),%ebx
80101ec1:	85 db                	test   %ebx,%ebx
80101ec3:	74 1b                	je     80101ee0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	57                   	push   %edi
80101ec9:	e8 22 e3 ff ff       	call   801001f0 <brelse>
    return addr;
80101ece:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101ed1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed4:	89 d8                	mov    %ebx,%eax
80101ed6:	5b                   	pop    %ebx
80101ed7:	5e                   	pop    %esi
80101ed8:	5f                   	pop    %edi
80101ed9:	5d                   	pop    %ebp
80101eda:	c3                   	ret    
80101edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101edf:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101ee0:	8b 06                	mov    (%esi),%eax
80101ee2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101ee5:	e8 96 fd ff ff       	call   80101c80 <balloc>
80101eea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101eed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101ef0:	89 c3                	mov    %eax,%ebx
80101ef2:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101ef4:	57                   	push   %edi
80101ef5:	e8 66 1a 00 00       	call   80103960 <log_write>
80101efa:	83 c4 10             	add    $0x10,%esp
80101efd:	eb c6                	jmp    80101ec5 <bmap+0x45>
80101eff:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101f00:	89 d0                	mov    %edx,%eax
80101f02:	e8 79 fd ff ff       	call   80101c80 <balloc>
80101f07:	8b 16                	mov    (%esi),%edx
80101f09:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101f0f:	eb 9b                	jmp    80101eac <bmap+0x2c>
80101f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101f18:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80101f1b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101f1e:	85 db                	test   %ebx,%ebx
80101f20:	75 af                	jne    80101ed1 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101f22:	8b 00                	mov    (%eax),%eax
80101f24:	e8 57 fd ff ff       	call   80101c80 <balloc>
80101f29:	89 47 5c             	mov    %eax,0x5c(%edi)
80101f2c:	89 c3                	mov    %eax,%ebx
}
80101f2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f31:	89 d8                	mov    %ebx,%eax
80101f33:	5b                   	pop    %ebx
80101f34:	5e                   	pop    %esi
80101f35:	5f                   	pop    %edi
80101f36:	5d                   	pop    %ebp
80101f37:	c3                   	ret    
  panic("bmap: out of range");
80101f38:	83 ec 0c             	sub    $0xc,%esp
80101f3b:	68 78 80 10 80       	push   $0x80108078
80101f40:	e8 4b e4 ff ff       	call   80100390 <panic>
80101f45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f50 <readsb>:
{
80101f50:	f3 0f 1e fb          	endbr32 
80101f54:	55                   	push   %ebp
80101f55:	89 e5                	mov    %esp,%ebp
80101f57:	56                   	push   %esi
80101f58:	53                   	push   %ebx
80101f59:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101f5c:	83 ec 08             	sub    $0x8,%esp
80101f5f:	6a 01                	push   $0x1
80101f61:	ff 75 08             	pushl  0x8(%ebp)
80101f64:	e8 67 e1 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101f69:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101f6c:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101f6e:	8d 40 5c             	lea    0x5c(%eax),%eax
80101f71:	6a 1c                	push   $0x1c
80101f73:	50                   	push   %eax
80101f74:	56                   	push   %esi
80101f75:	e8 a6 34 00 00       	call   80105420 <memmove>
  brelse(bp);
80101f7a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101f7d:	83 c4 10             	add    $0x10,%esp
}
80101f80:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f83:	5b                   	pop    %ebx
80101f84:	5e                   	pop    %esi
80101f85:	5d                   	pop    %ebp
  brelse(bp);
80101f86:	e9 65 e2 ff ff       	jmp    801001f0 <brelse>
80101f8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f8f:	90                   	nop

80101f90 <iinit>:
{
80101f90:	f3 0f 1e fb          	endbr32 
80101f94:	55                   	push   %ebp
80101f95:	89 e5                	mov    %esp,%ebp
80101f97:	53                   	push   %ebx
80101f98:	bb 80 c2 11 80       	mov    $0x8011c280,%ebx
80101f9d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101fa0:	68 8b 80 10 80       	push   $0x8010808b
80101fa5:	68 40 c2 11 80       	push   $0x8011c240
80101faa:	e8 41 31 00 00       	call   801050f0 <initlock>
  for(i = 0; i < NINODE; i++) {
80101faf:	83 c4 10             	add    $0x10,%esp
80101fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101fb8:	83 ec 08             	sub    $0x8,%esp
80101fbb:	68 92 80 10 80       	push   $0x80108092
80101fc0:	53                   	push   %ebx
80101fc1:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101fc7:	e8 e4 2f 00 00       	call   80104fb0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101fcc:	83 c4 10             	add    $0x10,%esp
80101fcf:	81 fb a0 de 11 80    	cmp    $0x8011dea0,%ebx
80101fd5:	75 e1                	jne    80101fb8 <iinit+0x28>
  readsb(dev, &sb);
80101fd7:	83 ec 08             	sub    $0x8,%esp
80101fda:	68 20 c2 11 80       	push   $0x8011c220
80101fdf:	ff 75 08             	pushl  0x8(%ebp)
80101fe2:	e8 69 ff ff ff       	call   80101f50 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101fe7:	ff 35 38 c2 11 80    	pushl  0x8011c238
80101fed:	ff 35 34 c2 11 80    	pushl  0x8011c234
80101ff3:	ff 35 30 c2 11 80    	pushl  0x8011c230
80101ff9:	ff 35 2c c2 11 80    	pushl  0x8011c22c
80101fff:	ff 35 28 c2 11 80    	pushl  0x8011c228
80102005:	ff 35 24 c2 11 80    	pushl  0x8011c224
8010200b:	ff 35 20 c2 11 80    	pushl  0x8011c220
80102011:	68 f8 80 10 80       	push   $0x801080f8
80102016:	e8 d5 e6 ff ff       	call   801006f0 <cprintf>
}
8010201b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010201e:	83 c4 30             	add    $0x30,%esp
80102021:	c9                   	leave  
80102022:	c3                   	ret    
80102023:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010202a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102030 <ialloc>:
{
80102030:	f3 0f 1e fb          	endbr32 
80102034:	55                   	push   %ebp
80102035:	89 e5                	mov    %esp,%ebp
80102037:	57                   	push   %edi
80102038:	56                   	push   %esi
80102039:	53                   	push   %ebx
8010203a:	83 ec 1c             	sub    $0x1c,%esp
8010203d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80102040:	83 3d 28 c2 11 80 01 	cmpl   $0x1,0x8011c228
{
80102047:	8b 75 08             	mov    0x8(%ebp),%esi
8010204a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
8010204d:	0f 86 8d 00 00 00    	jbe    801020e0 <ialloc+0xb0>
80102053:	bf 01 00 00 00       	mov    $0x1,%edi
80102058:	eb 1d                	jmp    80102077 <ialloc+0x47>
8010205a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80102060:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102063:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102066:	53                   	push   %ebx
80102067:	e8 84 e1 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010206c:	83 c4 10             	add    $0x10,%esp
8010206f:	3b 3d 28 c2 11 80    	cmp    0x8011c228,%edi
80102075:	73 69                	jae    801020e0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102077:	89 f8                	mov    %edi,%eax
80102079:	83 ec 08             	sub    $0x8,%esp
8010207c:	c1 e8 03             	shr    $0x3,%eax
8010207f:	03 05 34 c2 11 80    	add    0x8011c234,%eax
80102085:	50                   	push   %eax
80102086:	56                   	push   %esi
80102087:	e8 44 e0 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010208c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010208f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102091:	89 f8                	mov    %edi,%eax
80102093:	83 e0 07             	and    $0x7,%eax
80102096:	c1 e0 06             	shl    $0x6,%eax
80102099:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010209d:	66 83 39 00          	cmpw   $0x0,(%ecx)
801020a1:	75 bd                	jne    80102060 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801020a3:	83 ec 04             	sub    $0x4,%esp
801020a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801020a9:	6a 40                	push   $0x40
801020ab:	6a 00                	push   $0x0
801020ad:	51                   	push   %ecx
801020ae:	e8 cd 32 00 00       	call   80105380 <memset>
      dip->type = type;
801020b3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801020b7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801020ba:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801020bd:	89 1c 24             	mov    %ebx,(%esp)
801020c0:	e8 9b 18 00 00       	call   80103960 <log_write>
      brelse(bp);
801020c5:	89 1c 24             	mov    %ebx,(%esp)
801020c8:	e8 23 e1 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801020cd:	83 c4 10             	add    $0x10,%esp
}
801020d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801020d3:	89 fa                	mov    %edi,%edx
}
801020d5:	5b                   	pop    %ebx
      return iget(dev, inum);
801020d6:	89 f0                	mov    %esi,%eax
}
801020d8:	5e                   	pop    %esi
801020d9:	5f                   	pop    %edi
801020da:	5d                   	pop    %ebp
      return iget(dev, inum);
801020db:	e9 b0 fc ff ff       	jmp    80101d90 <iget>
  panic("ialloc: no inodes");
801020e0:	83 ec 0c             	sub    $0xc,%esp
801020e3:	68 98 80 10 80       	push   $0x80108098
801020e8:	e8 a3 e2 ff ff       	call   80100390 <panic>
801020ed:	8d 76 00             	lea    0x0(%esi),%esi

801020f0 <iupdate>:
{
801020f0:	f3 0f 1e fb          	endbr32 
801020f4:	55                   	push   %ebp
801020f5:	89 e5                	mov    %esp,%ebp
801020f7:	56                   	push   %esi
801020f8:	53                   	push   %ebx
801020f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801020fc:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801020ff:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102102:	83 ec 08             	sub    $0x8,%esp
80102105:	c1 e8 03             	shr    $0x3,%eax
80102108:	03 05 34 c2 11 80    	add    0x8011c234,%eax
8010210e:	50                   	push   %eax
8010210f:	ff 73 a4             	pushl  -0x5c(%ebx)
80102112:	e8 b9 df ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102117:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010211b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010211e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80102120:	8b 43 a8             	mov    -0x58(%ebx),%eax
80102123:	83 e0 07             	and    $0x7,%eax
80102126:	c1 e0 06             	shl    $0x6,%eax
80102129:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
8010212d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80102130:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102134:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102137:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
8010213b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010213f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80102143:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102147:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
8010214b:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010214e:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102151:	6a 34                	push   $0x34
80102153:	53                   	push   %ebx
80102154:	50                   	push   %eax
80102155:	e8 c6 32 00 00       	call   80105420 <memmove>
  log_write(bp);
8010215a:	89 34 24             	mov    %esi,(%esp)
8010215d:	e8 fe 17 00 00       	call   80103960 <log_write>
  brelse(bp);
80102162:	89 75 08             	mov    %esi,0x8(%ebp)
80102165:	83 c4 10             	add    $0x10,%esp
}
80102168:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010216b:	5b                   	pop    %ebx
8010216c:	5e                   	pop    %esi
8010216d:	5d                   	pop    %ebp
  brelse(bp);
8010216e:	e9 7d e0 ff ff       	jmp    801001f0 <brelse>
80102173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102180 <idup>:
{
80102180:	f3 0f 1e fb          	endbr32 
80102184:	55                   	push   %ebp
80102185:	89 e5                	mov    %esp,%ebp
80102187:	53                   	push   %ebx
80102188:	83 ec 10             	sub    $0x10,%esp
8010218b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010218e:	68 40 c2 11 80       	push   $0x8011c240
80102193:	e8 d8 30 00 00       	call   80105270 <acquire>
  ip->ref++;
80102198:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010219c:	c7 04 24 40 c2 11 80 	movl   $0x8011c240,(%esp)
801021a3:	e8 88 31 00 00       	call   80105330 <release>
}
801021a8:	89 d8                	mov    %ebx,%eax
801021aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021ad:	c9                   	leave  
801021ae:	c3                   	ret    
801021af:	90                   	nop

801021b0 <ilock>:
{
801021b0:	f3 0f 1e fb          	endbr32 
801021b4:	55                   	push   %ebp
801021b5:	89 e5                	mov    %esp,%ebp
801021b7:	56                   	push   %esi
801021b8:	53                   	push   %ebx
801021b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801021bc:	85 db                	test   %ebx,%ebx
801021be:	0f 84 b3 00 00 00    	je     80102277 <ilock+0xc7>
801021c4:	8b 53 08             	mov    0x8(%ebx),%edx
801021c7:	85 d2                	test   %edx,%edx
801021c9:	0f 8e a8 00 00 00    	jle    80102277 <ilock+0xc7>
  acquiresleep(&ip->lock);
801021cf:	83 ec 0c             	sub    $0xc,%esp
801021d2:	8d 43 0c             	lea    0xc(%ebx),%eax
801021d5:	50                   	push   %eax
801021d6:	e8 15 2e 00 00       	call   80104ff0 <acquiresleep>
  if(ip->valid == 0){
801021db:	8b 43 4c             	mov    0x4c(%ebx),%eax
801021de:	83 c4 10             	add    $0x10,%esp
801021e1:	85 c0                	test   %eax,%eax
801021e3:	74 0b                	je     801021f0 <ilock+0x40>
}
801021e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801021e8:	5b                   	pop    %ebx
801021e9:	5e                   	pop    %esi
801021ea:	5d                   	pop    %ebp
801021eb:	c3                   	ret    
801021ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801021f0:	8b 43 04             	mov    0x4(%ebx),%eax
801021f3:	83 ec 08             	sub    $0x8,%esp
801021f6:	c1 e8 03             	shr    $0x3,%eax
801021f9:	03 05 34 c2 11 80    	add    0x8011c234,%eax
801021ff:	50                   	push   %eax
80102200:	ff 33                	pushl  (%ebx)
80102202:	e8 c9 de ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102207:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010220a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010220c:	8b 43 04             	mov    0x4(%ebx),%eax
8010220f:	83 e0 07             	and    $0x7,%eax
80102212:	c1 e0 06             	shl    $0x6,%eax
80102215:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102219:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010221c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010221f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102223:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102227:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010222b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010222f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102233:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102237:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010223b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010223e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102241:	6a 34                	push   $0x34
80102243:	50                   	push   %eax
80102244:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102247:	50                   	push   %eax
80102248:	e8 d3 31 00 00       	call   80105420 <memmove>
    brelse(bp);
8010224d:	89 34 24             	mov    %esi,(%esp)
80102250:	e8 9b df ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102255:	83 c4 10             	add    $0x10,%esp
80102258:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010225d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102264:	0f 85 7b ff ff ff    	jne    801021e5 <ilock+0x35>
      panic("ilock: no type");
8010226a:	83 ec 0c             	sub    $0xc,%esp
8010226d:	68 b0 80 10 80       	push   $0x801080b0
80102272:	e8 19 e1 ff ff       	call   80100390 <panic>
    panic("ilock");
80102277:	83 ec 0c             	sub    $0xc,%esp
8010227a:	68 aa 80 10 80       	push   $0x801080aa
8010227f:	e8 0c e1 ff ff       	call   80100390 <panic>
80102284:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010228b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010228f:	90                   	nop

80102290 <iunlock>:
{
80102290:	f3 0f 1e fb          	endbr32 
80102294:	55                   	push   %ebp
80102295:	89 e5                	mov    %esp,%ebp
80102297:	56                   	push   %esi
80102298:	53                   	push   %ebx
80102299:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010229c:	85 db                	test   %ebx,%ebx
8010229e:	74 28                	je     801022c8 <iunlock+0x38>
801022a0:	83 ec 0c             	sub    $0xc,%esp
801022a3:	8d 73 0c             	lea    0xc(%ebx),%esi
801022a6:	56                   	push   %esi
801022a7:	e8 e4 2d 00 00       	call   80105090 <holdingsleep>
801022ac:	83 c4 10             	add    $0x10,%esp
801022af:	85 c0                	test   %eax,%eax
801022b1:	74 15                	je     801022c8 <iunlock+0x38>
801022b3:	8b 43 08             	mov    0x8(%ebx),%eax
801022b6:	85 c0                	test   %eax,%eax
801022b8:	7e 0e                	jle    801022c8 <iunlock+0x38>
  releasesleep(&ip->lock);
801022ba:	89 75 08             	mov    %esi,0x8(%ebp)
}
801022bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022c0:	5b                   	pop    %ebx
801022c1:	5e                   	pop    %esi
801022c2:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801022c3:	e9 88 2d 00 00       	jmp    80105050 <releasesleep>
    panic("iunlock");
801022c8:	83 ec 0c             	sub    $0xc,%esp
801022cb:	68 bf 80 10 80       	push   $0x801080bf
801022d0:	e8 bb e0 ff ff       	call   80100390 <panic>
801022d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022e0 <iput>:
{
801022e0:	f3 0f 1e fb          	endbr32 
801022e4:	55                   	push   %ebp
801022e5:	89 e5                	mov    %esp,%ebp
801022e7:	57                   	push   %edi
801022e8:	56                   	push   %esi
801022e9:	53                   	push   %ebx
801022ea:	83 ec 28             	sub    $0x28,%esp
801022ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801022f0:	8d 7b 0c             	lea    0xc(%ebx),%edi
801022f3:	57                   	push   %edi
801022f4:	e8 f7 2c 00 00       	call   80104ff0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801022f9:	8b 53 4c             	mov    0x4c(%ebx),%edx
801022fc:	83 c4 10             	add    $0x10,%esp
801022ff:	85 d2                	test   %edx,%edx
80102301:	74 07                	je     8010230a <iput+0x2a>
80102303:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102308:	74 36                	je     80102340 <iput+0x60>
  releasesleep(&ip->lock);
8010230a:	83 ec 0c             	sub    $0xc,%esp
8010230d:	57                   	push   %edi
8010230e:	e8 3d 2d 00 00       	call   80105050 <releasesleep>
  acquire(&icache.lock);
80102313:	c7 04 24 40 c2 11 80 	movl   $0x8011c240,(%esp)
8010231a:	e8 51 2f 00 00       	call   80105270 <acquire>
  ip->ref--;
8010231f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102323:	83 c4 10             	add    $0x10,%esp
80102326:	c7 45 08 40 c2 11 80 	movl   $0x8011c240,0x8(%ebp)
}
8010232d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102330:	5b                   	pop    %ebx
80102331:	5e                   	pop    %esi
80102332:	5f                   	pop    %edi
80102333:	5d                   	pop    %ebp
  release(&icache.lock);
80102334:	e9 f7 2f 00 00       	jmp    80105330 <release>
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	68 40 c2 11 80       	push   $0x8011c240
80102348:	e8 23 2f 00 00       	call   80105270 <acquire>
    int r = ip->ref;
8010234d:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102350:	c7 04 24 40 c2 11 80 	movl   $0x8011c240,(%esp)
80102357:	e8 d4 2f 00 00       	call   80105330 <release>
    if(r == 1){
8010235c:	83 c4 10             	add    $0x10,%esp
8010235f:	83 fe 01             	cmp    $0x1,%esi
80102362:	75 a6                	jne    8010230a <iput+0x2a>
80102364:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
8010236a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010236d:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102370:	89 cf                	mov    %ecx,%edi
80102372:	eb 0b                	jmp    8010237f <iput+0x9f>
80102374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102378:	83 c6 04             	add    $0x4,%esi
8010237b:	39 fe                	cmp    %edi,%esi
8010237d:	74 19                	je     80102398 <iput+0xb8>
    if(ip->addrs[i]){
8010237f:	8b 16                	mov    (%esi),%edx
80102381:	85 d2                	test   %edx,%edx
80102383:	74 f3                	je     80102378 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80102385:	8b 03                	mov    (%ebx),%eax
80102387:	e8 74 f8 ff ff       	call   80101c00 <bfree>
      ip->addrs[i] = 0;
8010238c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80102392:	eb e4                	jmp    80102378 <iput+0x98>
80102394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102398:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010239e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801023a1:	85 c0                	test   %eax,%eax
801023a3:	75 33                	jne    801023d8 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801023a5:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801023a8:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801023af:	53                   	push   %ebx
801023b0:	e8 3b fd ff ff       	call   801020f0 <iupdate>
      ip->type = 0;
801023b5:	31 c0                	xor    %eax,%eax
801023b7:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801023bb:	89 1c 24             	mov    %ebx,(%esp)
801023be:	e8 2d fd ff ff       	call   801020f0 <iupdate>
      ip->valid = 0;
801023c3:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801023ca:	83 c4 10             	add    $0x10,%esp
801023cd:	e9 38 ff ff ff       	jmp    8010230a <iput+0x2a>
801023d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801023d8:	83 ec 08             	sub    $0x8,%esp
801023db:	50                   	push   %eax
801023dc:	ff 33                	pushl  (%ebx)
801023de:	e8 ed dc ff ff       	call   801000d0 <bread>
801023e3:	89 7d e0             	mov    %edi,-0x20(%ebp)
801023e6:	83 c4 10             	add    $0x10,%esp
801023e9:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801023ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801023f2:	8d 70 5c             	lea    0x5c(%eax),%esi
801023f5:	89 cf                	mov    %ecx,%edi
801023f7:	eb 0e                	jmp    80102407 <iput+0x127>
801023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102400:	83 c6 04             	add    $0x4,%esi
80102403:	39 f7                	cmp    %esi,%edi
80102405:	74 19                	je     80102420 <iput+0x140>
      if(a[j])
80102407:	8b 16                	mov    (%esi),%edx
80102409:	85 d2                	test   %edx,%edx
8010240b:	74 f3                	je     80102400 <iput+0x120>
        bfree(ip->dev, a[j]);
8010240d:	8b 03                	mov    (%ebx),%eax
8010240f:	e8 ec f7 ff ff       	call   80101c00 <bfree>
80102414:	eb ea                	jmp    80102400 <iput+0x120>
80102416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010241d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80102420:	83 ec 0c             	sub    $0xc,%esp
80102423:	ff 75 e4             	pushl  -0x1c(%ebp)
80102426:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102429:	e8 c2 dd ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010242e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80102434:	8b 03                	mov    (%ebx),%eax
80102436:	e8 c5 f7 ff ff       	call   80101c00 <bfree>
    ip->addrs[NDIRECT] = 0;
8010243b:	83 c4 10             	add    $0x10,%esp
8010243e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80102445:	00 00 00 
80102448:	e9 58 ff ff ff       	jmp    801023a5 <iput+0xc5>
8010244d:	8d 76 00             	lea    0x0(%esi),%esi

80102450 <iunlockput>:
{
80102450:	f3 0f 1e fb          	endbr32 
80102454:	55                   	push   %ebp
80102455:	89 e5                	mov    %esp,%ebp
80102457:	53                   	push   %ebx
80102458:	83 ec 10             	sub    $0x10,%esp
8010245b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010245e:	53                   	push   %ebx
8010245f:	e8 2c fe ff ff       	call   80102290 <iunlock>
  iput(ip);
80102464:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102467:	83 c4 10             	add    $0x10,%esp
}
8010246a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010246d:	c9                   	leave  
  iput(ip);
8010246e:	e9 6d fe ff ff       	jmp    801022e0 <iput>
80102473:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102480 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102480:	f3 0f 1e fb          	endbr32 
80102484:	55                   	push   %ebp
80102485:	89 e5                	mov    %esp,%ebp
80102487:	8b 55 08             	mov    0x8(%ebp),%edx
8010248a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
8010248d:	8b 0a                	mov    (%edx),%ecx
8010248f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80102492:	8b 4a 04             	mov    0x4(%edx),%ecx
80102495:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102498:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
8010249c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010249f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801024a3:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801024a7:	8b 52 58             	mov    0x58(%edx),%edx
801024aa:	89 50 10             	mov    %edx,0x10(%eax)
}
801024ad:	5d                   	pop    %ebp
801024ae:	c3                   	ret    
801024af:	90                   	nop

801024b0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801024b0:	f3 0f 1e fb          	endbr32 
801024b4:	55                   	push   %ebp
801024b5:	89 e5                	mov    %esp,%ebp
801024b7:	57                   	push   %edi
801024b8:	56                   	push   %esi
801024b9:	53                   	push   %ebx
801024ba:	83 ec 1c             	sub    $0x1c,%esp
801024bd:	8b 7d 0c             	mov    0xc(%ebp),%edi
801024c0:	8b 45 08             	mov    0x8(%ebp),%eax
801024c3:	8b 75 10             	mov    0x10(%ebp),%esi
801024c6:	89 7d e0             	mov    %edi,-0x20(%ebp)
801024c9:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801024cc:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801024d1:	89 45 d8             	mov    %eax,-0x28(%ebp)
801024d4:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
801024d7:	0f 84 a3 00 00 00    	je     80102580 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801024dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
801024e0:	8b 40 58             	mov    0x58(%eax),%eax
801024e3:	39 c6                	cmp    %eax,%esi
801024e5:	0f 87 b6 00 00 00    	ja     801025a1 <readi+0xf1>
801024eb:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801024ee:	31 c9                	xor    %ecx,%ecx
801024f0:	89 da                	mov    %ebx,%edx
801024f2:	01 f2                	add    %esi,%edx
801024f4:	0f 92 c1             	setb   %cl
801024f7:	89 cf                	mov    %ecx,%edi
801024f9:	0f 82 a2 00 00 00    	jb     801025a1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801024ff:	89 c1                	mov    %eax,%ecx
80102501:	29 f1                	sub    %esi,%ecx
80102503:	39 d0                	cmp    %edx,%eax
80102505:	0f 43 cb             	cmovae %ebx,%ecx
80102508:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010250b:	85 c9                	test   %ecx,%ecx
8010250d:	74 63                	je     80102572 <readi+0xc2>
8010250f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102510:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102513:	89 f2                	mov    %esi,%edx
80102515:	c1 ea 09             	shr    $0x9,%edx
80102518:	89 d8                	mov    %ebx,%eax
8010251a:	e8 61 f9 ff ff       	call   80101e80 <bmap>
8010251f:	83 ec 08             	sub    $0x8,%esp
80102522:	50                   	push   %eax
80102523:	ff 33                	pushl  (%ebx)
80102525:	e8 a6 db ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010252a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010252d:	b9 00 02 00 00       	mov    $0x200,%ecx
80102532:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102535:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102537:	89 f0                	mov    %esi,%eax
80102539:	25 ff 01 00 00       	and    $0x1ff,%eax
8010253e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102540:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102543:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80102545:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102549:	39 d9                	cmp    %ebx,%ecx
8010254b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
8010254e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010254f:	01 df                	add    %ebx,%edi
80102551:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80102553:	50                   	push   %eax
80102554:	ff 75 e0             	pushl  -0x20(%ebp)
80102557:	e8 c4 2e 00 00       	call   80105420 <memmove>
    brelse(bp);
8010255c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010255f:	89 14 24             	mov    %edx,(%esp)
80102562:	e8 89 dc ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102567:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010256a:	83 c4 10             	add    $0x10,%esp
8010256d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102570:	77 9e                	ja     80102510 <readi+0x60>
  }
  return n;
80102572:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102575:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102578:	5b                   	pop    %ebx
80102579:	5e                   	pop    %esi
8010257a:	5f                   	pop    %edi
8010257b:	5d                   	pop    %ebp
8010257c:	c3                   	ret    
8010257d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102580:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102584:	66 83 f8 09          	cmp    $0x9,%ax
80102588:	77 17                	ja     801025a1 <readi+0xf1>
8010258a:	8b 04 c5 c0 c1 11 80 	mov    -0x7fee3e40(,%eax,8),%eax
80102591:	85 c0                	test   %eax,%eax
80102593:	74 0c                	je     801025a1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102595:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102598:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010259b:	5b                   	pop    %ebx
8010259c:	5e                   	pop    %esi
8010259d:	5f                   	pop    %edi
8010259e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010259f:	ff e0                	jmp    *%eax
      return -1;
801025a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025a6:	eb cd                	jmp    80102575 <readi+0xc5>
801025a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801025b0:	f3 0f 1e fb          	endbr32 
801025b4:	55                   	push   %ebp
801025b5:	89 e5                	mov    %esp,%ebp
801025b7:	57                   	push   %edi
801025b8:	56                   	push   %esi
801025b9:	53                   	push   %ebx
801025ba:	83 ec 1c             	sub    $0x1c,%esp
801025bd:	8b 45 08             	mov    0x8(%ebp),%eax
801025c0:	8b 75 0c             	mov    0xc(%ebp),%esi
801025c3:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801025c6:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801025cb:	89 75 dc             	mov    %esi,-0x24(%ebp)
801025ce:	89 45 d8             	mov    %eax,-0x28(%ebp)
801025d1:	8b 75 10             	mov    0x10(%ebp),%esi
801025d4:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
801025d7:	0f 84 b3 00 00 00    	je     80102690 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801025dd:	8b 45 d8             	mov    -0x28(%ebp),%eax
801025e0:	39 70 58             	cmp    %esi,0x58(%eax)
801025e3:	0f 82 e3 00 00 00    	jb     801026cc <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801025e9:	8b 7d e0             	mov    -0x20(%ebp),%edi
801025ec:	89 f8                	mov    %edi,%eax
801025ee:	01 f0                	add    %esi,%eax
801025f0:	0f 82 d6 00 00 00    	jb     801026cc <writei+0x11c>
801025f6:	3d 00 18 01 00       	cmp    $0x11800,%eax
801025fb:	0f 87 cb 00 00 00    	ja     801026cc <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102601:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102608:	85 ff                	test   %edi,%edi
8010260a:	74 75                	je     80102681 <writei+0xd1>
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102610:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102613:	89 f2                	mov    %esi,%edx
80102615:	c1 ea 09             	shr    $0x9,%edx
80102618:	89 f8                	mov    %edi,%eax
8010261a:	e8 61 f8 ff ff       	call   80101e80 <bmap>
8010261f:	83 ec 08             	sub    $0x8,%esp
80102622:	50                   	push   %eax
80102623:	ff 37                	pushl  (%edi)
80102625:	e8 a6 da ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010262a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010262f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102632:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102635:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102637:	89 f0                	mov    %esi,%eax
80102639:	83 c4 0c             	add    $0xc,%esp
8010263c:	25 ff 01 00 00       	and    $0x1ff,%eax
80102641:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102643:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102647:	39 d9                	cmp    %ebx,%ecx
80102649:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010264c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010264d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
8010264f:	ff 75 dc             	pushl  -0x24(%ebp)
80102652:	50                   	push   %eax
80102653:	e8 c8 2d 00 00       	call   80105420 <memmove>
    log_write(bp);
80102658:	89 3c 24             	mov    %edi,(%esp)
8010265b:	e8 00 13 00 00       	call   80103960 <log_write>
    brelse(bp);
80102660:	89 3c 24             	mov    %edi,(%esp)
80102663:	e8 88 db ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102668:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010266b:	83 c4 10             	add    $0x10,%esp
8010266e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102671:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102674:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102677:	77 97                	ja     80102610 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102679:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010267c:	3b 70 58             	cmp    0x58(%eax),%esi
8010267f:	77 37                	ja     801026b8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102681:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102684:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102687:	5b                   	pop    %ebx
80102688:	5e                   	pop    %esi
80102689:	5f                   	pop    %edi
8010268a:	5d                   	pop    %ebp
8010268b:	c3                   	ret    
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102690:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102694:	66 83 f8 09          	cmp    $0x9,%ax
80102698:	77 32                	ja     801026cc <writei+0x11c>
8010269a:	8b 04 c5 c4 c1 11 80 	mov    -0x7fee3e3c(,%eax,8),%eax
801026a1:	85 c0                	test   %eax,%eax
801026a3:	74 27                	je     801026cc <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
801026a5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
801026a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026ab:	5b                   	pop    %ebx
801026ac:	5e                   	pop    %esi
801026ad:	5f                   	pop    %edi
801026ae:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
801026af:	ff e0                	jmp    *%eax
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
801026b8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
801026bb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
801026be:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
801026c1:	50                   	push   %eax
801026c2:	e8 29 fa ff ff       	call   801020f0 <iupdate>
801026c7:	83 c4 10             	add    $0x10,%esp
801026ca:	eb b5                	jmp    80102681 <writei+0xd1>
      return -1;
801026cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801026d1:	eb b1                	jmp    80102684 <writei+0xd4>
801026d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801026e0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801026e0:	f3 0f 1e fb          	endbr32 
801026e4:	55                   	push   %ebp
801026e5:	89 e5                	mov    %esp,%ebp
801026e7:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
801026ea:	6a 0e                	push   $0xe
801026ec:	ff 75 0c             	pushl  0xc(%ebp)
801026ef:	ff 75 08             	pushl  0x8(%ebp)
801026f2:	e8 99 2d 00 00       	call   80105490 <strncmp>
}
801026f7:	c9                   	leave  
801026f8:	c3                   	ret    
801026f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102700 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102700:	f3 0f 1e fb          	endbr32 
80102704:	55                   	push   %ebp
80102705:	89 e5                	mov    %esp,%ebp
80102707:	57                   	push   %edi
80102708:	56                   	push   %esi
80102709:	53                   	push   %ebx
8010270a:	83 ec 1c             	sub    $0x1c,%esp
8010270d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102710:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102715:	0f 85 89 00 00 00    	jne    801027a4 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010271b:	8b 53 58             	mov    0x58(%ebx),%edx
8010271e:	31 ff                	xor    %edi,%edi
80102720:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102723:	85 d2                	test   %edx,%edx
80102725:	74 42                	je     80102769 <dirlookup+0x69>
80102727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102730:	6a 10                	push   $0x10
80102732:	57                   	push   %edi
80102733:	56                   	push   %esi
80102734:	53                   	push   %ebx
80102735:	e8 76 fd ff ff       	call   801024b0 <readi>
8010273a:	83 c4 10             	add    $0x10,%esp
8010273d:	83 f8 10             	cmp    $0x10,%eax
80102740:	75 55                	jne    80102797 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
80102742:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102747:	74 18                	je     80102761 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80102749:	83 ec 04             	sub    $0x4,%esp
8010274c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010274f:	6a 0e                	push   $0xe
80102751:	50                   	push   %eax
80102752:	ff 75 0c             	pushl  0xc(%ebp)
80102755:	e8 36 2d 00 00       	call   80105490 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
8010275a:	83 c4 10             	add    $0x10,%esp
8010275d:	85 c0                	test   %eax,%eax
8010275f:	74 17                	je     80102778 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102761:	83 c7 10             	add    $0x10,%edi
80102764:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102767:	72 c7                	jb     80102730 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102769:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010276c:	31 c0                	xor    %eax,%eax
}
8010276e:	5b                   	pop    %ebx
8010276f:	5e                   	pop    %esi
80102770:	5f                   	pop    %edi
80102771:	5d                   	pop    %ebp
80102772:	c3                   	ret    
80102773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102777:	90                   	nop
      if(poff)
80102778:	8b 45 10             	mov    0x10(%ebp),%eax
8010277b:	85 c0                	test   %eax,%eax
8010277d:	74 05                	je     80102784 <dirlookup+0x84>
        *poff = off;
8010277f:	8b 45 10             	mov    0x10(%ebp),%eax
80102782:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102784:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102788:	8b 03                	mov    (%ebx),%eax
8010278a:	e8 01 f6 ff ff       	call   80101d90 <iget>
}
8010278f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102792:	5b                   	pop    %ebx
80102793:	5e                   	pop    %esi
80102794:	5f                   	pop    %edi
80102795:	5d                   	pop    %ebp
80102796:	c3                   	ret    
      panic("dirlookup read");
80102797:	83 ec 0c             	sub    $0xc,%esp
8010279a:	68 d9 80 10 80       	push   $0x801080d9
8010279f:	e8 ec db ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 c7 80 10 80       	push   $0x801080c7
801027ac:	e8 df db ff ff       	call   80100390 <panic>
801027b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027bf:	90                   	nop

801027c0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
801027c0:	55                   	push   %ebp
801027c1:	89 e5                	mov    %esp,%ebp
801027c3:	57                   	push   %edi
801027c4:	56                   	push   %esi
801027c5:	53                   	push   %ebx
801027c6:	89 c3                	mov    %eax,%ebx
801027c8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
801027cb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
801027ce:	89 55 e0             	mov    %edx,-0x20(%ebp)
801027d1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
801027d4:	0f 84 86 01 00 00    	je     80102960 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
801027da:	e8 21 1c 00 00       	call   80104400 <myproc>
  acquire(&icache.lock);
801027df:	83 ec 0c             	sub    $0xc,%esp
801027e2:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
801027e4:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
801027e7:	68 40 c2 11 80       	push   $0x8011c240
801027ec:	e8 7f 2a 00 00       	call   80105270 <acquire>
  ip->ref++;
801027f1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
801027f5:	c7 04 24 40 c2 11 80 	movl   $0x8011c240,(%esp)
801027fc:	e8 2f 2b 00 00       	call   80105330 <release>
80102801:	83 c4 10             	add    $0x10,%esp
80102804:	eb 0d                	jmp    80102813 <namex+0x53>
80102806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010280d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80102810:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80102813:	0f b6 07             	movzbl (%edi),%eax
80102816:	3c 2f                	cmp    $0x2f,%al
80102818:	74 f6                	je     80102810 <namex+0x50>
  if(*path == 0)
8010281a:	84 c0                	test   %al,%al
8010281c:	0f 84 ee 00 00 00    	je     80102910 <namex+0x150>
  while(*path != '/' && *path != 0)
80102822:	0f b6 07             	movzbl (%edi),%eax
80102825:	84 c0                	test   %al,%al
80102827:	0f 84 fb 00 00 00    	je     80102928 <namex+0x168>
8010282d:	89 fb                	mov    %edi,%ebx
8010282f:	3c 2f                	cmp    $0x2f,%al
80102831:	0f 84 f1 00 00 00    	je     80102928 <namex+0x168>
80102837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010283e:	66 90                	xchg   %ax,%ax
80102840:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
80102844:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
80102847:	3c 2f                	cmp    $0x2f,%al
80102849:	74 04                	je     8010284f <namex+0x8f>
8010284b:	84 c0                	test   %al,%al
8010284d:	75 f1                	jne    80102840 <namex+0x80>
  len = path - s;
8010284f:	89 d8                	mov    %ebx,%eax
80102851:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
80102853:	83 f8 0d             	cmp    $0xd,%eax
80102856:	0f 8e 84 00 00 00    	jle    801028e0 <namex+0x120>
    memmove(name, s, DIRSIZ);
8010285c:	83 ec 04             	sub    $0x4,%esp
8010285f:	6a 0e                	push   $0xe
80102861:	57                   	push   %edi
    path++;
80102862:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
80102864:	ff 75 e4             	pushl  -0x1c(%ebp)
80102867:	e8 b4 2b 00 00       	call   80105420 <memmove>
8010286c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010286f:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102872:	75 0c                	jne    80102880 <namex+0xc0>
80102874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102878:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
8010287b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010287e:	74 f8                	je     80102878 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102880:	83 ec 0c             	sub    $0xc,%esp
80102883:	56                   	push   %esi
80102884:	e8 27 f9 ff ff       	call   801021b0 <ilock>
    if(ip->type != T_DIR){
80102889:	83 c4 10             	add    $0x10,%esp
8010288c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102891:	0f 85 a1 00 00 00    	jne    80102938 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102897:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010289a:	85 d2                	test   %edx,%edx
8010289c:	74 09                	je     801028a7 <namex+0xe7>
8010289e:	80 3f 00             	cmpb   $0x0,(%edi)
801028a1:	0f 84 d9 00 00 00    	je     80102980 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801028a7:	83 ec 04             	sub    $0x4,%esp
801028aa:	6a 00                	push   $0x0
801028ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801028af:	56                   	push   %esi
801028b0:	e8 4b fe ff ff       	call   80102700 <dirlookup>
801028b5:	83 c4 10             	add    $0x10,%esp
801028b8:	89 c3                	mov    %eax,%ebx
801028ba:	85 c0                	test   %eax,%eax
801028bc:	74 7a                	je     80102938 <namex+0x178>
  iunlock(ip);
801028be:	83 ec 0c             	sub    $0xc,%esp
801028c1:	56                   	push   %esi
801028c2:	e8 c9 f9 ff ff       	call   80102290 <iunlock>
  iput(ip);
801028c7:	89 34 24             	mov    %esi,(%esp)
801028ca:	89 de                	mov    %ebx,%esi
801028cc:	e8 0f fa ff ff       	call   801022e0 <iput>
801028d1:	83 c4 10             	add    $0x10,%esp
801028d4:	e9 3a ff ff ff       	jmp    80102813 <namex+0x53>
801028d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801028e3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
801028e6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
801028e9:	83 ec 04             	sub    $0x4,%esp
801028ec:	50                   	push   %eax
801028ed:	57                   	push   %edi
    name[len] = 0;
801028ee:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
801028f0:	ff 75 e4             	pushl  -0x1c(%ebp)
801028f3:	e8 28 2b 00 00       	call   80105420 <memmove>
    name[len] = 0;
801028f8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801028fb:	83 c4 10             	add    $0x10,%esp
801028fe:	c6 00 00             	movb   $0x0,(%eax)
80102901:	e9 69 ff ff ff       	jmp    8010286f <namex+0xaf>
80102906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102910:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102913:	85 c0                	test   %eax,%eax
80102915:	0f 85 85 00 00 00    	jne    801029a0 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010291b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010291e:	89 f0                	mov    %esi,%eax
80102920:	5b                   	pop    %ebx
80102921:	5e                   	pop    %esi
80102922:	5f                   	pop    %edi
80102923:	5d                   	pop    %ebp
80102924:	c3                   	ret    
80102925:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102928:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010292b:	89 fb                	mov    %edi,%ebx
8010292d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102930:	31 c0                	xor    %eax,%eax
80102932:	eb b5                	jmp    801028e9 <namex+0x129>
80102934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102938:	83 ec 0c             	sub    $0xc,%esp
8010293b:	56                   	push   %esi
8010293c:	e8 4f f9 ff ff       	call   80102290 <iunlock>
  iput(ip);
80102941:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102944:	31 f6                	xor    %esi,%esi
  iput(ip);
80102946:	e8 95 f9 ff ff       	call   801022e0 <iput>
      return 0;
8010294b:	83 c4 10             	add    $0x10,%esp
}
8010294e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102951:	89 f0                	mov    %esi,%eax
80102953:	5b                   	pop    %ebx
80102954:	5e                   	pop    %esi
80102955:	5f                   	pop    %edi
80102956:	5d                   	pop    %ebp
80102957:	c3                   	ret    
80102958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010295f:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
80102960:	ba 01 00 00 00       	mov    $0x1,%edx
80102965:	b8 01 00 00 00       	mov    $0x1,%eax
8010296a:	89 df                	mov    %ebx,%edi
8010296c:	e8 1f f4 ff ff       	call   80101d90 <iget>
80102971:	89 c6                	mov    %eax,%esi
80102973:	e9 9b fe ff ff       	jmp    80102813 <namex+0x53>
80102978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010297f:	90                   	nop
      iunlock(ip);
80102980:	83 ec 0c             	sub    $0xc,%esp
80102983:	56                   	push   %esi
80102984:	e8 07 f9 ff ff       	call   80102290 <iunlock>
      return ip;
80102989:	83 c4 10             	add    $0x10,%esp
}
8010298c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010298f:	89 f0                	mov    %esi,%eax
80102991:	5b                   	pop    %ebx
80102992:	5e                   	pop    %esi
80102993:	5f                   	pop    %edi
80102994:	5d                   	pop    %ebp
80102995:	c3                   	ret    
80102996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010299d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
801029a0:	83 ec 0c             	sub    $0xc,%esp
801029a3:	56                   	push   %esi
    return 0;
801029a4:	31 f6                	xor    %esi,%esi
    iput(ip);
801029a6:	e8 35 f9 ff ff       	call   801022e0 <iput>
    return 0;
801029ab:	83 c4 10             	add    $0x10,%esp
801029ae:	e9 68 ff ff ff       	jmp    8010291b <namex+0x15b>
801029b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029c0 <dirlink>:
{
801029c0:	f3 0f 1e fb          	endbr32 
801029c4:	55                   	push   %ebp
801029c5:	89 e5                	mov    %esp,%ebp
801029c7:	57                   	push   %edi
801029c8:	56                   	push   %esi
801029c9:	53                   	push   %ebx
801029ca:	83 ec 20             	sub    $0x20,%esp
801029cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801029d0:	6a 00                	push   $0x0
801029d2:	ff 75 0c             	pushl  0xc(%ebp)
801029d5:	53                   	push   %ebx
801029d6:	e8 25 fd ff ff       	call   80102700 <dirlookup>
801029db:	83 c4 10             	add    $0x10,%esp
801029de:	85 c0                	test   %eax,%eax
801029e0:	75 6b                	jne    80102a4d <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
801029e2:	8b 7b 58             	mov    0x58(%ebx),%edi
801029e5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801029e8:	85 ff                	test   %edi,%edi
801029ea:	74 2d                	je     80102a19 <dirlink+0x59>
801029ec:	31 ff                	xor    %edi,%edi
801029ee:	8d 75 d8             	lea    -0x28(%ebp),%esi
801029f1:	eb 0d                	jmp    80102a00 <dirlink+0x40>
801029f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029f7:	90                   	nop
801029f8:	83 c7 10             	add    $0x10,%edi
801029fb:	3b 7b 58             	cmp    0x58(%ebx),%edi
801029fe:	73 19                	jae    80102a19 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a00:	6a 10                	push   $0x10
80102a02:	57                   	push   %edi
80102a03:	56                   	push   %esi
80102a04:	53                   	push   %ebx
80102a05:	e8 a6 fa ff ff       	call   801024b0 <readi>
80102a0a:	83 c4 10             	add    $0x10,%esp
80102a0d:	83 f8 10             	cmp    $0x10,%eax
80102a10:	75 4e                	jne    80102a60 <dirlink+0xa0>
    if(de.inum == 0)
80102a12:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102a17:	75 df                	jne    801029f8 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102a19:	83 ec 04             	sub    $0x4,%esp
80102a1c:	8d 45 da             	lea    -0x26(%ebp),%eax
80102a1f:	6a 0e                	push   $0xe
80102a21:	ff 75 0c             	pushl  0xc(%ebp)
80102a24:	50                   	push   %eax
80102a25:	e8 b6 2a 00 00       	call   801054e0 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a2a:	6a 10                	push   $0x10
  de.inum = inum;
80102a2c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a2f:	57                   	push   %edi
80102a30:	56                   	push   %esi
80102a31:	53                   	push   %ebx
  de.inum = inum;
80102a32:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102a36:	e8 75 fb ff ff       	call   801025b0 <writei>
80102a3b:	83 c4 20             	add    $0x20,%esp
80102a3e:	83 f8 10             	cmp    $0x10,%eax
80102a41:	75 2a                	jne    80102a6d <dirlink+0xad>
  return 0;
80102a43:	31 c0                	xor    %eax,%eax
}
80102a45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a48:	5b                   	pop    %ebx
80102a49:	5e                   	pop    %esi
80102a4a:	5f                   	pop    %edi
80102a4b:	5d                   	pop    %ebp
80102a4c:	c3                   	ret    
    iput(ip);
80102a4d:	83 ec 0c             	sub    $0xc,%esp
80102a50:	50                   	push   %eax
80102a51:	e8 8a f8 ff ff       	call   801022e0 <iput>
    return -1;
80102a56:	83 c4 10             	add    $0x10,%esp
80102a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102a5e:	eb e5                	jmp    80102a45 <dirlink+0x85>
      panic("dirlink read");
80102a60:	83 ec 0c             	sub    $0xc,%esp
80102a63:	68 e8 80 10 80       	push   $0x801080e8
80102a68:	e8 23 d9 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102a6d:	83 ec 0c             	sub    $0xc,%esp
80102a70:	68 de 86 10 80       	push   $0x801086de
80102a75:	e8 16 d9 ff ff       	call   80100390 <panic>
80102a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a80 <namei>:

struct inode*
namei(char *path)
{
80102a80:	f3 0f 1e fb          	endbr32 
80102a84:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102a85:	31 d2                	xor    %edx,%edx
{
80102a87:	89 e5                	mov    %esp,%ebp
80102a89:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102a8c:	8b 45 08             	mov    0x8(%ebp),%eax
80102a8f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102a92:	e8 29 fd ff ff       	call   801027c0 <namex>
}
80102a97:	c9                   	leave  
80102a98:	c3                   	ret    
80102a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102aa0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102aa0:	f3 0f 1e fb          	endbr32 
80102aa4:	55                   	push   %ebp
  return namex(path, 1, name);
80102aa5:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102aaa:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102aac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102aaf:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102ab2:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102ab3:	e9 08 fd ff ff       	jmp    801027c0 <namex>
80102ab8:	66 90                	xchg   %ax,%ax
80102aba:	66 90                	xchg   %ax,%ax
80102abc:	66 90                	xchg   %ax,%ax
80102abe:	66 90                	xchg   %ax,%ax

80102ac0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	57                   	push   %edi
80102ac4:	56                   	push   %esi
80102ac5:	53                   	push   %ebx
80102ac6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102ac9:	85 c0                	test   %eax,%eax
80102acb:	0f 84 b4 00 00 00    	je     80102b85 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ad1:	8b 70 08             	mov    0x8(%eax),%esi
80102ad4:	89 c3                	mov    %eax,%ebx
80102ad6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102adc:	0f 87 96 00 00 00    	ja     80102b78 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102aee:	66 90                	xchg   %ax,%ax
80102af0:	89 ca                	mov    %ecx,%edx
80102af2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102af3:	83 e0 c0             	and    $0xffffffc0,%eax
80102af6:	3c 40                	cmp    $0x40,%al
80102af8:	75 f6                	jne    80102af0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102afa:	31 ff                	xor    %edi,%edi
80102afc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102b01:	89 f8                	mov    %edi,%eax
80102b03:	ee                   	out    %al,(%dx)
80102b04:	b8 01 00 00 00       	mov    $0x1,%eax
80102b09:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102b0e:	ee                   	out    %al,(%dx)
80102b0f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102b14:	89 f0                	mov    %esi,%eax
80102b16:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102b17:	89 f0                	mov    %esi,%eax
80102b19:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102b1e:	c1 f8 08             	sar    $0x8,%eax
80102b21:	ee                   	out    %al,(%dx)
80102b22:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102b27:	89 f8                	mov    %edi,%eax
80102b29:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102b2a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102b2e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102b33:	c1 e0 04             	shl    $0x4,%eax
80102b36:	83 e0 10             	and    $0x10,%eax
80102b39:	83 c8 e0             	or     $0xffffffe0,%eax
80102b3c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102b3d:	f6 03 04             	testb  $0x4,(%ebx)
80102b40:	75 16                	jne    80102b58 <idestart+0x98>
80102b42:	b8 20 00 00 00       	mov    $0x20,%eax
80102b47:	89 ca                	mov    %ecx,%edx
80102b49:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102b4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b4d:	5b                   	pop    %ebx
80102b4e:	5e                   	pop    %esi
80102b4f:	5f                   	pop    %edi
80102b50:	5d                   	pop    %ebp
80102b51:	c3                   	ret    
80102b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b58:	b8 30 00 00 00       	mov    $0x30,%eax
80102b5d:	89 ca                	mov    %ecx,%edx
80102b5f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102b60:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102b65:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102b68:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102b6d:	fc                   	cld    
80102b6e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b73:	5b                   	pop    %ebx
80102b74:	5e                   	pop    %esi
80102b75:	5f                   	pop    %edi
80102b76:	5d                   	pop    %ebp
80102b77:	c3                   	ret    
    panic("incorrect blockno");
80102b78:	83 ec 0c             	sub    $0xc,%esp
80102b7b:	68 54 81 10 80       	push   $0x80108154
80102b80:	e8 0b d8 ff ff       	call   80100390 <panic>
    panic("idestart");
80102b85:	83 ec 0c             	sub    $0xc,%esp
80102b88:	68 4b 81 10 80       	push   $0x8010814b
80102b8d:	e8 fe d7 ff ff       	call   80100390 <panic>
80102b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <ideinit>:
{
80102ba0:	f3 0f 1e fb          	endbr32 
80102ba4:	55                   	push   %ebp
80102ba5:	89 e5                	mov    %esp,%ebp
80102ba7:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102baa:	68 66 81 10 80       	push   $0x80108166
80102baf:	68 80 b5 10 80       	push   $0x8010b580
80102bb4:	e8 37 25 00 00       	call   801050f0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102bb9:	58                   	pop    %eax
80102bba:	a1 60 e5 11 80       	mov    0x8011e560,%eax
80102bbf:	5a                   	pop    %edx
80102bc0:	83 e8 01             	sub    $0x1,%eax
80102bc3:	50                   	push   %eax
80102bc4:	6a 0e                	push   $0xe
80102bc6:	e8 b5 02 00 00       	call   80102e80 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102bcb:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bce:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102bd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102bd7:	90                   	nop
80102bd8:	ec                   	in     (%dx),%al
80102bd9:	83 e0 c0             	and    $0xffffffc0,%eax
80102bdc:	3c 40                	cmp    $0x40,%al
80102bde:	75 f8                	jne    80102bd8 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be0:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102be5:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102bea:	ee                   	out    %al,(%dx)
80102beb:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf0:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102bf5:	eb 0e                	jmp    80102c05 <ideinit+0x65>
80102bf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bfe:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102c00:	83 e9 01             	sub    $0x1,%ecx
80102c03:	74 0f                	je     80102c14 <ideinit+0x74>
80102c05:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102c06:	84 c0                	test   %al,%al
80102c08:	74 f6                	je     80102c00 <ideinit+0x60>
      havedisk1 = 1;
80102c0a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102c11:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c14:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102c19:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102c1e:	ee                   	out    %al,(%dx)
}
80102c1f:	c9                   	leave  
80102c20:	c3                   	ret    
80102c21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c2f:	90                   	nop

80102c30 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102c30:	f3 0f 1e fb          	endbr32 
80102c34:	55                   	push   %ebp
80102c35:	89 e5                	mov    %esp,%ebp
80102c37:	57                   	push   %edi
80102c38:	56                   	push   %esi
80102c39:	53                   	push   %ebx
80102c3a:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102c3d:	68 80 b5 10 80       	push   $0x8010b580
80102c42:	e8 29 26 00 00       	call   80105270 <acquire>

  if((b = idequeue) == 0){
80102c47:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102c4d:	83 c4 10             	add    $0x10,%esp
80102c50:	85 db                	test   %ebx,%ebx
80102c52:	74 5f                	je     80102cb3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102c54:	8b 43 58             	mov    0x58(%ebx),%eax
80102c57:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102c5c:	8b 33                	mov    (%ebx),%esi
80102c5e:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102c64:	75 2b                	jne    80102c91 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c66:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c6f:	90                   	nop
80102c70:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102c71:	89 c1                	mov    %eax,%ecx
80102c73:	83 e1 c0             	and    $0xffffffc0,%ecx
80102c76:	80 f9 40             	cmp    $0x40,%cl
80102c79:	75 f5                	jne    80102c70 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102c7b:	a8 21                	test   $0x21,%al
80102c7d:	75 12                	jne    80102c91 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102c7f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102c82:	b9 80 00 00 00       	mov    $0x80,%ecx
80102c87:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102c8c:	fc                   	cld    
80102c8d:	f3 6d                	rep insl (%dx),%es:(%edi)
80102c8f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102c91:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102c94:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102c97:	83 ce 02             	or     $0x2,%esi
80102c9a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102c9c:	53                   	push   %ebx
80102c9d:	e8 1e 1f 00 00       	call   80104bc0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102ca2:	a1 64 b5 10 80       	mov    0x8010b564,%eax
80102ca7:	83 c4 10             	add    $0x10,%esp
80102caa:	85 c0                	test   %eax,%eax
80102cac:	74 05                	je     80102cb3 <ideintr+0x83>
    idestart(idequeue);
80102cae:	e8 0d fe ff ff       	call   80102ac0 <idestart>
    release(&idelock);
80102cb3:	83 ec 0c             	sub    $0xc,%esp
80102cb6:	68 80 b5 10 80       	push   $0x8010b580
80102cbb:	e8 70 26 00 00       	call   80105330 <release>

  release(&idelock);
}
80102cc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cc3:	5b                   	pop    %ebx
80102cc4:	5e                   	pop    %esi
80102cc5:	5f                   	pop    %edi
80102cc6:	5d                   	pop    %ebp
80102cc7:	c3                   	ret    
80102cc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ccf:	90                   	nop

80102cd0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102cd0:	f3 0f 1e fb          	endbr32 
80102cd4:	55                   	push   %ebp
80102cd5:	89 e5                	mov    %esp,%ebp
80102cd7:	53                   	push   %ebx
80102cd8:	83 ec 10             	sub    $0x10,%esp
80102cdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102cde:	8d 43 0c             	lea    0xc(%ebx),%eax
80102ce1:	50                   	push   %eax
80102ce2:	e8 a9 23 00 00       	call   80105090 <holdingsleep>
80102ce7:	83 c4 10             	add    $0x10,%esp
80102cea:	85 c0                	test   %eax,%eax
80102cec:	0f 84 cf 00 00 00    	je     80102dc1 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102cf2:	8b 03                	mov    (%ebx),%eax
80102cf4:	83 e0 06             	and    $0x6,%eax
80102cf7:	83 f8 02             	cmp    $0x2,%eax
80102cfa:	0f 84 b4 00 00 00    	je     80102db4 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102d00:	8b 53 04             	mov    0x4(%ebx),%edx
80102d03:	85 d2                	test   %edx,%edx
80102d05:	74 0d                	je     80102d14 <iderw+0x44>
80102d07:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102d0c:	85 c0                	test   %eax,%eax
80102d0e:	0f 84 93 00 00 00    	je     80102da7 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102d14:	83 ec 0c             	sub    $0xc,%esp
80102d17:	68 80 b5 10 80       	push   $0x8010b580
80102d1c:	e8 4f 25 00 00       	call   80105270 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102d21:	a1 64 b5 10 80       	mov    0x8010b564,%eax
  b->qnext = 0;
80102d26:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102d2d:	83 c4 10             	add    $0x10,%esp
80102d30:	85 c0                	test   %eax,%eax
80102d32:	74 6c                	je     80102da0 <iderw+0xd0>
80102d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d38:	89 c2                	mov    %eax,%edx
80102d3a:	8b 40 58             	mov    0x58(%eax),%eax
80102d3d:	85 c0                	test   %eax,%eax
80102d3f:	75 f7                	jne    80102d38 <iderw+0x68>
80102d41:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102d44:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102d46:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
80102d4c:	74 42                	je     80102d90 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102d4e:	8b 03                	mov    (%ebx),%eax
80102d50:	83 e0 06             	and    $0x6,%eax
80102d53:	83 f8 02             	cmp    $0x2,%eax
80102d56:	74 23                	je     80102d7b <iderw+0xab>
80102d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d5f:	90                   	nop
    sleep(b, &idelock);
80102d60:	83 ec 08             	sub    $0x8,%esp
80102d63:	68 80 b5 10 80       	push   $0x8010b580
80102d68:	53                   	push   %ebx
80102d69:	e8 92 1c 00 00       	call   80104a00 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102d6e:	8b 03                	mov    (%ebx),%eax
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	83 e0 06             	and    $0x6,%eax
80102d76:	83 f8 02             	cmp    $0x2,%eax
80102d79:	75 e5                	jne    80102d60 <iderw+0x90>
  }


  release(&idelock);
80102d7b:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
80102d82:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d85:	c9                   	leave  
  release(&idelock);
80102d86:	e9 a5 25 00 00       	jmp    80105330 <release>
80102d8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d8f:	90                   	nop
    idestart(b);
80102d90:	89 d8                	mov    %ebx,%eax
80102d92:	e8 29 fd ff ff       	call   80102ac0 <idestart>
80102d97:	eb b5                	jmp    80102d4e <iderw+0x7e>
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102da0:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102da5:	eb 9d                	jmp    80102d44 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102da7:	83 ec 0c             	sub    $0xc,%esp
80102daa:	68 95 81 10 80       	push   $0x80108195
80102daf:	e8 dc d5 ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102db4:	83 ec 0c             	sub    $0xc,%esp
80102db7:	68 80 81 10 80       	push   $0x80108180
80102dbc:	e8 cf d5 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102dc1:	83 ec 0c             	sub    $0xc,%esp
80102dc4:	68 6a 81 10 80       	push   $0x8010816a
80102dc9:	e8 c2 d5 ff ff       	call   80100390 <panic>
80102dce:	66 90                	xchg   %ax,%ax

80102dd0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102dd0:	f3 0f 1e fb          	endbr32 
80102dd4:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102dd5:	c7 05 94 de 11 80 00 	movl   $0xfec00000,0x8011de94
80102ddc:	00 c0 fe 
{
80102ddf:	89 e5                	mov    %esp,%ebp
80102de1:	56                   	push   %esi
80102de2:	53                   	push   %ebx
  ioapic->reg = reg;
80102de3:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102dea:	00 00 00 
  return ioapic->data;
80102ded:	8b 15 94 de 11 80    	mov    0x8011de94,%edx
80102df3:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102df6:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102dfc:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102e02:	0f b6 15 c0 df 11 80 	movzbl 0x8011dfc0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102e09:	c1 ee 10             	shr    $0x10,%esi
80102e0c:	89 f0                	mov    %esi,%eax
80102e0e:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102e11:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102e14:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102e17:	39 c2                	cmp    %eax,%edx
80102e19:	74 16                	je     80102e31 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102e1b:	83 ec 0c             	sub    $0xc,%esp
80102e1e:	68 b4 81 10 80       	push   $0x801081b4
80102e23:	e8 c8 d8 ff ff       	call   801006f0 <cprintf>
80102e28:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
80102e2e:	83 c4 10             	add    $0x10,%esp
80102e31:	83 c6 21             	add    $0x21,%esi
{
80102e34:	ba 10 00 00 00       	mov    $0x10,%edx
80102e39:	b8 20 00 00 00       	mov    $0x20,%eax
80102e3e:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102e40:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102e42:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102e44:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
80102e4a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102e4d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102e53:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102e56:	8d 5a 01             	lea    0x1(%edx),%ebx
80102e59:	83 c2 02             	add    $0x2,%edx
80102e5c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102e5e:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
80102e64:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102e6b:	39 f0                	cmp    %esi,%eax
80102e6d:	75 d1                	jne    80102e40 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102e6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e72:	5b                   	pop    %ebx
80102e73:	5e                   	pop    %esi
80102e74:	5d                   	pop    %ebp
80102e75:	c3                   	ret    
80102e76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e7d:	8d 76 00             	lea    0x0(%esi),%esi

80102e80 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102e80:	f3 0f 1e fb          	endbr32 
80102e84:	55                   	push   %ebp
  ioapic->reg = reg;
80102e85:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
{
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102e90:	8d 50 20             	lea    0x20(%eax),%edx
80102e93:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102e97:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102e99:	8b 0d 94 de 11 80    	mov    0x8011de94,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102e9f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102ea2:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102ea5:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102ea8:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102eaa:	a1 94 de 11 80       	mov    0x8011de94,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102eaf:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102eb2:	89 50 10             	mov    %edx,0x10(%eax)
}
80102eb5:	5d                   	pop    %ebp
80102eb6:	c3                   	ret    
80102eb7:	66 90                	xchg   %ax,%ax
80102eb9:	66 90                	xchg   %ax,%ax
80102ebb:	66 90                	xchg   %ax,%ax
80102ebd:	66 90                	xchg   %ax,%ax
80102ebf:	90                   	nop

80102ec0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102ec0:	f3 0f 1e fb          	endbr32 
80102ec4:	55                   	push   %ebp
80102ec5:	89 e5                	mov    %esp,%ebp
80102ec7:	53                   	push   %ebx
80102ec8:	83 ec 04             	sub    $0x4,%esp
80102ecb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102ece:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102ed4:	75 7a                	jne    80102f50 <kfree+0x90>
80102ed6:	81 fb 08 39 39 80    	cmp    $0x80393908,%ebx
80102edc:	72 72                	jb     80102f50 <kfree+0x90>
80102ede:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102ee4:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102ee9:	77 65                	ja     80102f50 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102eeb:	83 ec 04             	sub    $0x4,%esp
80102eee:	68 00 10 00 00       	push   $0x1000
80102ef3:	6a 01                	push   $0x1
80102ef5:	53                   	push   %ebx
80102ef6:	e8 85 24 00 00       	call   80105380 <memset>

  if(kmem.use_lock)
80102efb:	8b 15 d4 de 11 80    	mov    0x8011ded4,%edx
80102f01:	83 c4 10             	add    $0x10,%esp
80102f04:	85 d2                	test   %edx,%edx
80102f06:	75 20                	jne    80102f28 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102f08:	a1 d8 de 11 80       	mov    0x8011ded8,%eax
80102f0d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102f0f:	a1 d4 de 11 80       	mov    0x8011ded4,%eax
  kmem.freelist = r;
80102f14:	89 1d d8 de 11 80    	mov    %ebx,0x8011ded8
  if(kmem.use_lock)
80102f1a:	85 c0                	test   %eax,%eax
80102f1c:	75 22                	jne    80102f40 <kfree+0x80>
    release(&kmem.lock);
}
80102f1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f21:	c9                   	leave  
80102f22:	c3                   	ret    
80102f23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f27:	90                   	nop
    acquire(&kmem.lock);
80102f28:	83 ec 0c             	sub    $0xc,%esp
80102f2b:	68 a0 de 11 80       	push   $0x8011dea0
80102f30:	e8 3b 23 00 00       	call   80105270 <acquire>
80102f35:	83 c4 10             	add    $0x10,%esp
80102f38:	eb ce                	jmp    80102f08 <kfree+0x48>
80102f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102f40:	c7 45 08 a0 de 11 80 	movl   $0x8011dea0,0x8(%ebp)
}
80102f47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f4a:	c9                   	leave  
    release(&kmem.lock);
80102f4b:	e9 e0 23 00 00       	jmp    80105330 <release>
    panic("kfree");
80102f50:	83 ec 0c             	sub    $0xc,%esp
80102f53:	68 e6 81 10 80       	push   $0x801081e6
80102f58:	e8 33 d4 ff ff       	call   80100390 <panic>
80102f5d:	8d 76 00             	lea    0x0(%esi),%esi

80102f60 <freerange>:
{
80102f60:	f3 0f 1e fb          	endbr32 
80102f64:	55                   	push   %ebp
80102f65:	89 e5                	mov    %esp,%ebp
80102f67:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102f68:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102f6b:	8b 75 0c             	mov    0xc(%ebp),%esi
80102f6e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102f6f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102f75:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f7b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102f81:	39 de                	cmp    %ebx,%esi
80102f83:	72 1f                	jb     80102fa4 <freerange+0x44>
80102f85:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102f97:	50                   	push   %eax
80102f98:	e8 23 ff ff ff       	call   80102ec0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f9d:	83 c4 10             	add    $0x10,%esp
80102fa0:	39 f3                	cmp    %esi,%ebx
80102fa2:	76 e4                	jbe    80102f88 <freerange+0x28>
}
80102fa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102fa7:	5b                   	pop    %ebx
80102fa8:	5e                   	pop    %esi
80102fa9:	5d                   	pop    %ebp
80102faa:	c3                   	ret    
80102fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102faf:	90                   	nop

80102fb0 <kinit1>:
{
80102fb0:	f3 0f 1e fb          	endbr32 
80102fb4:	55                   	push   %ebp
80102fb5:	89 e5                	mov    %esp,%ebp
80102fb7:	56                   	push   %esi
80102fb8:	53                   	push   %ebx
80102fb9:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102fbc:	83 ec 08             	sub    $0x8,%esp
80102fbf:	68 ec 81 10 80       	push   $0x801081ec
80102fc4:	68 a0 de 11 80       	push   $0x8011dea0
80102fc9:	e8 22 21 00 00       	call   801050f0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102fce:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102fd1:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102fd4:	c7 05 d4 de 11 80 00 	movl   $0x0,0x8011ded4
80102fdb:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102fde:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102fe4:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102fea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ff0:	39 de                	cmp    %ebx,%esi
80102ff2:	72 20                	jb     80103014 <kinit1+0x64>
80102ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102ff8:	83 ec 0c             	sub    $0xc,%esp
80102ffb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103001:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103007:	50                   	push   %eax
80103008:	e8 b3 fe ff ff       	call   80102ec0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010300d:	83 c4 10             	add    $0x10,%esp
80103010:	39 de                	cmp    %ebx,%esi
80103012:	73 e4                	jae    80102ff8 <kinit1+0x48>
}
80103014:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103017:	5b                   	pop    %ebx
80103018:	5e                   	pop    %esi
80103019:	5d                   	pop    %ebp
8010301a:	c3                   	ret    
8010301b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010301f:	90                   	nop

80103020 <kinit2>:
{
80103020:	f3 0f 1e fb          	endbr32 
80103024:	55                   	push   %ebp
80103025:	89 e5                	mov    %esp,%ebp
80103027:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103028:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010302b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010302e:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010302f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103035:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010303b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80103041:	39 de                	cmp    %ebx,%esi
80103043:	72 1f                	jb     80103064 <kinit2+0x44>
80103045:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80103048:	83 ec 0c             	sub    $0xc,%esp
8010304b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103051:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103057:	50                   	push   %eax
80103058:	e8 63 fe ff ff       	call   80102ec0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010305d:	83 c4 10             	add    $0x10,%esp
80103060:	39 de                	cmp    %ebx,%esi
80103062:	73 e4                	jae    80103048 <kinit2+0x28>
  kmem.use_lock = 1;
80103064:	c7 05 d4 de 11 80 01 	movl   $0x1,0x8011ded4
8010306b:	00 00 00 
}
8010306e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103071:	5b                   	pop    %ebx
80103072:	5e                   	pop    %esi
80103073:	5d                   	pop    %ebp
80103074:	c3                   	ret    
80103075:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010307c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103080 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103080:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80103084:	a1 d4 de 11 80       	mov    0x8011ded4,%eax
80103089:	85 c0                	test   %eax,%eax
8010308b:	75 1b                	jne    801030a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
8010308d:	a1 d8 de 11 80       	mov    0x8011ded8,%eax
  if(r)
80103092:	85 c0                	test   %eax,%eax
80103094:	74 0a                	je     801030a0 <kalloc+0x20>
    kmem.freelist = r->next;
80103096:	8b 10                	mov    (%eax),%edx
80103098:	89 15 d8 de 11 80    	mov    %edx,0x8011ded8
  if(kmem.use_lock)
8010309e:	c3                   	ret    
8010309f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801030a0:	c3                   	ret    
801030a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801030a8:	55                   	push   %ebp
801030a9:	89 e5                	mov    %esp,%ebp
801030ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801030ae:	68 a0 de 11 80       	push   $0x8011dea0
801030b3:	e8 b8 21 00 00       	call   80105270 <acquire>
  r = kmem.freelist;
801030b8:	a1 d8 de 11 80       	mov    0x8011ded8,%eax
  if(r)
801030bd:	8b 15 d4 de 11 80    	mov    0x8011ded4,%edx
801030c3:	83 c4 10             	add    $0x10,%esp
801030c6:	85 c0                	test   %eax,%eax
801030c8:	74 08                	je     801030d2 <kalloc+0x52>
    kmem.freelist = r->next;
801030ca:	8b 08                	mov    (%eax),%ecx
801030cc:	89 0d d8 de 11 80    	mov    %ecx,0x8011ded8
  if(kmem.use_lock)
801030d2:	85 d2                	test   %edx,%edx
801030d4:	74 16                	je     801030ec <kalloc+0x6c>
    release(&kmem.lock);
801030d6:	83 ec 0c             	sub    $0xc,%esp
801030d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801030dc:	68 a0 de 11 80       	push   $0x8011dea0
801030e1:	e8 4a 22 00 00       	call   80105330 <release>
  return (char*)r;
801030e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801030e9:	83 c4 10             	add    $0x10,%esp
}
801030ec:	c9                   	leave  
801030ed:	c3                   	ret    
801030ee:	66 90                	xchg   %ax,%ax

801030f0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801030f0:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030f4:	ba 64 00 00 00       	mov    $0x64,%edx
801030f9:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801030fa:	a8 01                	test   $0x1,%al
801030fc:	0f 84 be 00 00 00    	je     801031c0 <kbdgetc+0xd0>
{
80103102:	55                   	push   %ebp
80103103:	ba 60 00 00 00       	mov    $0x60,%edx
80103108:	89 e5                	mov    %esp,%ebp
8010310a:	53                   	push   %ebx
8010310b:	ec                   	in     (%dx),%al
  return data;
8010310c:	8b 1d b4 b5 10 80    	mov    0x8010b5b4,%ebx
    return -1;
  data = inb(KBDATAP);
80103112:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80103115:	3c e0                	cmp    $0xe0,%al
80103117:	74 57                	je     80103170 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80103119:	89 d9                	mov    %ebx,%ecx
8010311b:	83 e1 40             	and    $0x40,%ecx
8010311e:	84 c0                	test   %al,%al
80103120:	78 5e                	js     80103180 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80103122:	85 c9                	test   %ecx,%ecx
80103124:	74 09                	je     8010312f <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103126:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103129:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
8010312c:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
8010312f:	0f b6 8a 20 83 10 80 	movzbl -0x7fef7ce0(%edx),%ecx
  shift ^= togglecode[data];
80103136:	0f b6 82 20 82 10 80 	movzbl -0x7fef7de0(%edx),%eax
  shift |= shiftcode[data];
8010313d:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
8010313f:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80103141:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80103143:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80103149:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010314c:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
8010314f:	8b 04 85 00 82 10 80 	mov    -0x7fef7e00(,%eax,4),%eax
80103156:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
8010315a:	74 0b                	je     80103167 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
8010315c:	8d 50 9f             	lea    -0x61(%eax),%edx
8010315f:	83 fa 19             	cmp    $0x19,%edx
80103162:	77 44                	ja     801031a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103164:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103167:	5b                   	pop    %ebx
80103168:	5d                   	pop    %ebp
80103169:	c3                   	ret    
8010316a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80103170:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103173:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103175:	89 1d b4 b5 10 80    	mov    %ebx,0x8010b5b4
}
8010317b:	5b                   	pop    %ebx
8010317c:	5d                   	pop    %ebp
8010317d:	c3                   	ret    
8010317e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80103180:	83 e0 7f             	and    $0x7f,%eax
80103183:	85 c9                	test   %ecx,%ecx
80103185:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80103188:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
8010318a:	0f b6 8a 20 83 10 80 	movzbl -0x7fef7ce0(%edx),%ecx
80103191:	83 c9 40             	or     $0x40,%ecx
80103194:	0f b6 c9             	movzbl %cl,%ecx
80103197:	f7 d1                	not    %ecx
80103199:	21 d9                	and    %ebx,%ecx
}
8010319b:	5b                   	pop    %ebx
8010319c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
8010319d:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801031a3:	c3                   	ret    
801031a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801031a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801031ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801031ae:	5b                   	pop    %ebx
801031af:	5d                   	pop    %ebp
      c += 'a' - 'A';
801031b0:	83 f9 1a             	cmp    $0x1a,%ecx
801031b3:	0f 42 c2             	cmovb  %edx,%eax
}
801031b6:	c3                   	ret    
801031b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031be:	66 90                	xchg   %ax,%ax
    return -1;
801031c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801031c5:	c3                   	ret    
801031c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031cd:	8d 76 00             	lea    0x0(%esi),%esi

801031d0 <kbdintr>:

void
kbdintr(void)
{
801031d0:	f3 0f 1e fb          	endbr32 
801031d4:	55                   	push   %ebp
801031d5:	89 e5                	mov    %esp,%ebp
801031d7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801031da:	68 f0 30 10 80       	push   $0x801030f0
801031df:	e8 0c db ff ff       	call   80100cf0 <consoleintr>
}
801031e4:	83 c4 10             	add    $0x10,%esp
801031e7:	c9                   	leave  
801031e8:	c3                   	ret    
801031e9:	66 90                	xchg   %ax,%ax
801031eb:	66 90                	xchg   %ax,%ax
801031ed:	66 90                	xchg   %ax,%ax
801031ef:	90                   	nop

801031f0 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801031f0:	f3 0f 1e fb          	endbr32 
  if(!lapic)
801031f4:	a1 dc de 11 80       	mov    0x8011dedc,%eax
801031f9:	85 c0                	test   %eax,%eax
801031fb:	0f 84 c7 00 00 00    	je     801032c8 <lapicinit+0xd8>
  lapic[index] = value;
80103201:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103208:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010320b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010320e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103215:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103218:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010321b:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80103222:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103225:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103228:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010322f:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80103232:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103235:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010323c:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010323f:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103242:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103249:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010324c:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010324f:	8b 50 30             	mov    0x30(%eax),%edx
80103252:	c1 ea 10             	shr    $0x10,%edx
80103255:	81 e2 fc 00 00 00    	and    $0xfc,%edx
8010325b:	75 73                	jne    801032d0 <lapicinit+0xe0>
  lapic[index] = value;
8010325d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103264:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103267:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010326a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103271:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103274:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103277:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010327e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103281:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103284:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
8010328b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010328e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103291:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103298:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010329b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010329e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801032a5:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801032a8:	8b 50 20             	mov    0x20(%eax),%edx
801032ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032af:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801032b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801032b6:	80 e6 10             	and    $0x10,%dh
801032b9:	75 f5                	jne    801032b0 <lapicinit+0xc0>
  lapic[index] = value;
801032bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801032c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801032c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801032c8:	c3                   	ret    
801032c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801032d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801032d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801032da:	8b 50 20             	mov    0x20(%eax),%edx
}
801032dd:	e9 7b ff ff ff       	jmp    8010325d <lapicinit+0x6d>
801032e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801032f0 <lapicid>:

int
lapicid(void)
{
801032f0:	f3 0f 1e fb          	endbr32 
  if (!lapic)
801032f4:	a1 dc de 11 80       	mov    0x8011dedc,%eax
801032f9:	85 c0                	test   %eax,%eax
801032fb:	74 0b                	je     80103308 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801032fd:	8b 40 20             	mov    0x20(%eax),%eax
80103300:	c1 e8 18             	shr    $0x18,%eax
80103303:	c3                   	ret    
80103304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80103308:	31 c0                	xor    %eax,%eax
}
8010330a:	c3                   	ret    
8010330b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010330f:	90                   	nop

80103310 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103310:	f3 0f 1e fb          	endbr32 
  if(lapic)
80103314:	a1 dc de 11 80       	mov    0x8011dedc,%eax
80103319:	85 c0                	test   %eax,%eax
8010331b:	74 0d                	je     8010332a <lapiceoi+0x1a>
  lapic[index] = value;
8010331d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103324:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103327:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
8010332a:	c3                   	ret    
8010332b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010332f:	90                   	nop

80103330 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103330:	f3 0f 1e fb          	endbr32 
}
80103334:	c3                   	ret    
80103335:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010333c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103340 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103340:	f3 0f 1e fb          	endbr32 
80103344:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103345:	b8 0f 00 00 00       	mov    $0xf,%eax
8010334a:	ba 70 00 00 00       	mov    $0x70,%edx
8010334f:	89 e5                	mov    %esp,%ebp
80103351:	53                   	push   %ebx
80103352:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103355:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103358:	ee                   	out    %al,(%dx)
80103359:	b8 0a 00 00 00       	mov    $0xa,%eax
8010335e:	ba 71 00 00 00       	mov    $0x71,%edx
80103363:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103364:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103366:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103369:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010336f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80103371:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103374:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103376:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103379:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
8010337c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80103382:	a1 dc de 11 80       	mov    0x8011dedc,%eax
80103387:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010338d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103390:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103397:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010339a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010339d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801033a4:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033a7:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801033aa:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801033b0:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801033b3:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801033b9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801033bc:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801033c2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033c5:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
801033cb:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
801033cc:	8b 40 20             	mov    0x20(%eax),%eax
}
801033cf:	5d                   	pop    %ebp
801033d0:	c3                   	ret    
801033d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033df:	90                   	nop

801033e0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801033e0:	f3 0f 1e fb          	endbr32 
801033e4:	55                   	push   %ebp
801033e5:	b8 0b 00 00 00       	mov    $0xb,%eax
801033ea:	ba 70 00 00 00       	mov    $0x70,%edx
801033ef:	89 e5                	mov    %esp,%ebp
801033f1:	57                   	push   %edi
801033f2:	56                   	push   %esi
801033f3:	53                   	push   %ebx
801033f4:	83 ec 4c             	sub    $0x4c,%esp
801033f7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801033f8:	ba 71 00 00 00       	mov    $0x71,%edx
801033fd:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801033fe:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103401:	bb 70 00 00 00       	mov    $0x70,%ebx
80103406:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103410:	31 c0                	xor    %eax,%eax
80103412:	89 da                	mov    %ebx,%edx
80103414:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103415:	b9 71 00 00 00       	mov    $0x71,%ecx
8010341a:	89 ca                	mov    %ecx,%edx
8010341c:	ec                   	in     (%dx),%al
8010341d:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103420:	89 da                	mov    %ebx,%edx
80103422:	b8 02 00 00 00       	mov    $0x2,%eax
80103427:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103428:	89 ca                	mov    %ecx,%edx
8010342a:	ec                   	in     (%dx),%al
8010342b:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010342e:	89 da                	mov    %ebx,%edx
80103430:	b8 04 00 00 00       	mov    $0x4,%eax
80103435:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103436:	89 ca                	mov    %ecx,%edx
80103438:	ec                   	in     (%dx),%al
80103439:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010343c:	89 da                	mov    %ebx,%edx
8010343e:	b8 07 00 00 00       	mov    $0x7,%eax
80103443:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103444:	89 ca                	mov    %ecx,%edx
80103446:	ec                   	in     (%dx),%al
80103447:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010344a:	89 da                	mov    %ebx,%edx
8010344c:	b8 08 00 00 00       	mov    $0x8,%eax
80103451:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103452:	89 ca                	mov    %ecx,%edx
80103454:	ec                   	in     (%dx),%al
80103455:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103457:	89 da                	mov    %ebx,%edx
80103459:	b8 09 00 00 00       	mov    $0x9,%eax
8010345e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010345f:	89 ca                	mov    %ecx,%edx
80103461:	ec                   	in     (%dx),%al
80103462:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103464:	89 da                	mov    %ebx,%edx
80103466:	b8 0a 00 00 00       	mov    $0xa,%eax
8010346b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010346c:	89 ca                	mov    %ecx,%edx
8010346e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
8010346f:	84 c0                	test   %al,%al
80103471:	78 9d                	js     80103410 <cmostime+0x30>
  return inb(CMOS_RETURN);
80103473:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103477:	89 fa                	mov    %edi,%edx
80103479:	0f b6 fa             	movzbl %dl,%edi
8010347c:	89 f2                	mov    %esi,%edx
8010347e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103481:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103485:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103488:	89 da                	mov    %ebx,%edx
8010348a:	89 7d c8             	mov    %edi,-0x38(%ebp)
8010348d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103490:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80103494:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103497:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010349a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
8010349e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801034a1:	31 c0                	xor    %eax,%eax
801034a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034a4:	89 ca                	mov    %ecx,%edx
801034a6:	ec                   	in     (%dx),%al
801034a7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034aa:	89 da                	mov    %ebx,%edx
801034ac:	89 45 d0             	mov    %eax,-0x30(%ebp)
801034af:	b8 02 00 00 00       	mov    $0x2,%eax
801034b4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034b5:	89 ca                	mov    %ecx,%edx
801034b7:	ec                   	in     (%dx),%al
801034b8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034bb:	89 da                	mov    %ebx,%edx
801034bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801034c0:	b8 04 00 00 00       	mov    $0x4,%eax
801034c5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034c6:	89 ca                	mov    %ecx,%edx
801034c8:	ec                   	in     (%dx),%al
801034c9:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034cc:	89 da                	mov    %ebx,%edx
801034ce:	89 45 d8             	mov    %eax,-0x28(%ebp)
801034d1:	b8 07 00 00 00       	mov    $0x7,%eax
801034d6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034d7:	89 ca                	mov    %ecx,%edx
801034d9:	ec                   	in     (%dx),%al
801034da:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034dd:	89 da                	mov    %ebx,%edx
801034df:	89 45 dc             	mov    %eax,-0x24(%ebp)
801034e2:	b8 08 00 00 00       	mov    $0x8,%eax
801034e7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034e8:	89 ca                	mov    %ecx,%edx
801034ea:	ec                   	in     (%dx),%al
801034eb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034ee:	89 da                	mov    %ebx,%edx
801034f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801034f3:	b8 09 00 00 00       	mov    $0x9,%eax
801034f8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034f9:	89 ca                	mov    %ecx,%edx
801034fb:	ec                   	in     (%dx),%al
801034fc:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801034ff:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80103502:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103505:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103508:	6a 18                	push   $0x18
8010350a:	50                   	push   %eax
8010350b:	8d 45 b8             	lea    -0x48(%ebp),%eax
8010350e:	50                   	push   %eax
8010350f:	e8 bc 1e 00 00       	call   801053d0 <memcmp>
80103514:	83 c4 10             	add    $0x10,%esp
80103517:	85 c0                	test   %eax,%eax
80103519:	0f 85 f1 fe ff ff    	jne    80103410 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
8010351f:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80103523:	75 78                	jne    8010359d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103525:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103528:	89 c2                	mov    %eax,%edx
8010352a:	83 e0 0f             	and    $0xf,%eax
8010352d:	c1 ea 04             	shr    $0x4,%edx
80103530:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103533:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103536:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103539:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010353c:	89 c2                	mov    %eax,%edx
8010353e:	83 e0 0f             	and    $0xf,%eax
80103541:	c1 ea 04             	shr    $0x4,%edx
80103544:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103547:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010354a:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
8010354d:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103550:	89 c2                	mov    %eax,%edx
80103552:	83 e0 0f             	and    $0xf,%eax
80103555:	c1 ea 04             	shr    $0x4,%edx
80103558:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010355b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010355e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103561:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103564:	89 c2                	mov    %eax,%edx
80103566:	83 e0 0f             	and    $0xf,%eax
80103569:	c1 ea 04             	shr    $0x4,%edx
8010356c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010356f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103572:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103575:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103578:	89 c2                	mov    %eax,%edx
8010357a:	83 e0 0f             	and    $0xf,%eax
8010357d:	c1 ea 04             	shr    $0x4,%edx
80103580:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103583:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103586:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103589:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010358c:	89 c2                	mov    %eax,%edx
8010358e:	83 e0 0f             	and    $0xf,%eax
80103591:	c1 ea 04             	shr    $0x4,%edx
80103594:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103597:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010359a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
8010359d:	8b 75 08             	mov    0x8(%ebp),%esi
801035a0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801035a3:	89 06                	mov    %eax,(%esi)
801035a5:	8b 45 bc             	mov    -0x44(%ebp),%eax
801035a8:	89 46 04             	mov    %eax,0x4(%esi)
801035ab:	8b 45 c0             	mov    -0x40(%ebp),%eax
801035ae:	89 46 08             	mov    %eax,0x8(%esi)
801035b1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801035b4:	89 46 0c             	mov    %eax,0xc(%esi)
801035b7:	8b 45 c8             	mov    -0x38(%ebp),%eax
801035ba:	89 46 10             	mov    %eax,0x10(%esi)
801035bd:	8b 45 cc             	mov    -0x34(%ebp),%eax
801035c0:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801035c3:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801035ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035cd:	5b                   	pop    %ebx
801035ce:	5e                   	pop    %esi
801035cf:	5f                   	pop    %edi
801035d0:	5d                   	pop    %ebp
801035d1:	c3                   	ret    
801035d2:	66 90                	xchg   %ax,%ax
801035d4:	66 90                	xchg   %ax,%ax
801035d6:	66 90                	xchg   %ax,%ax
801035d8:	66 90                	xchg   %ax,%ax
801035da:	66 90                	xchg   %ax,%ax
801035dc:	66 90                	xchg   %ax,%ax
801035de:	66 90                	xchg   %ax,%ax

801035e0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801035e0:	8b 0d 28 df 11 80    	mov    0x8011df28,%ecx
801035e6:	85 c9                	test   %ecx,%ecx
801035e8:	0f 8e 8a 00 00 00    	jle    80103678 <install_trans+0x98>
{
801035ee:	55                   	push   %ebp
801035ef:	89 e5                	mov    %esp,%ebp
801035f1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801035f2:	31 ff                	xor    %edi,%edi
{
801035f4:	56                   	push   %esi
801035f5:	53                   	push   %ebx
801035f6:	83 ec 0c             	sub    $0xc,%esp
801035f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103600:	a1 14 df 11 80       	mov    0x8011df14,%eax
80103605:	83 ec 08             	sub    $0x8,%esp
80103608:	01 f8                	add    %edi,%eax
8010360a:	83 c0 01             	add    $0x1,%eax
8010360d:	50                   	push   %eax
8010360e:	ff 35 24 df 11 80    	pushl  0x8011df24
80103614:	e8 b7 ca ff ff       	call   801000d0 <bread>
80103619:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010361b:	58                   	pop    %eax
8010361c:	5a                   	pop    %edx
8010361d:	ff 34 bd 2c df 11 80 	pushl  -0x7fee20d4(,%edi,4)
80103624:	ff 35 24 df 11 80    	pushl  0x8011df24
  for (tail = 0; tail < log.lh.n; tail++) {
8010362a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010362d:	e8 9e ca ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103632:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103635:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103637:	8d 46 5c             	lea    0x5c(%esi),%eax
8010363a:	68 00 02 00 00       	push   $0x200
8010363f:	50                   	push   %eax
80103640:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103643:	50                   	push   %eax
80103644:	e8 d7 1d 00 00       	call   80105420 <memmove>
    bwrite(dbuf);  // write dst to disk
80103649:	89 1c 24             	mov    %ebx,(%esp)
8010364c:	e8 5f cb ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103651:	89 34 24             	mov    %esi,(%esp)
80103654:	e8 97 cb ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103659:	89 1c 24             	mov    %ebx,(%esp)
8010365c:	e8 8f cb ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103661:	83 c4 10             	add    $0x10,%esp
80103664:	39 3d 28 df 11 80    	cmp    %edi,0x8011df28
8010366a:	7f 94                	jg     80103600 <install_trans+0x20>
  }
}
8010366c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010366f:	5b                   	pop    %ebx
80103670:	5e                   	pop    %esi
80103671:	5f                   	pop    %edi
80103672:	5d                   	pop    %ebp
80103673:	c3                   	ret    
80103674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103678:	c3                   	ret    
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103680 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	53                   	push   %ebx
80103684:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103687:	ff 35 14 df 11 80    	pushl  0x8011df14
8010368d:	ff 35 24 df 11 80    	pushl  0x8011df24
80103693:	e8 38 ca ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103698:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010369b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010369d:	a1 28 df 11 80       	mov    0x8011df28,%eax
801036a2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801036a5:	85 c0                	test   %eax,%eax
801036a7:	7e 19                	jle    801036c2 <write_head+0x42>
801036a9:	31 d2                	xor    %edx,%edx
801036ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036af:	90                   	nop
    hb->block[i] = log.lh.block[i];
801036b0:	8b 0c 95 2c df 11 80 	mov    -0x7fee20d4(,%edx,4),%ecx
801036b7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801036bb:	83 c2 01             	add    $0x1,%edx
801036be:	39 d0                	cmp    %edx,%eax
801036c0:	75 ee                	jne    801036b0 <write_head+0x30>
  }
  bwrite(buf);
801036c2:	83 ec 0c             	sub    $0xc,%esp
801036c5:	53                   	push   %ebx
801036c6:	e8 e5 ca ff ff       	call   801001b0 <bwrite>
  brelse(buf);
801036cb:	89 1c 24             	mov    %ebx,(%esp)
801036ce:	e8 1d cb ff ff       	call   801001f0 <brelse>
}
801036d3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801036d6:	83 c4 10             	add    $0x10,%esp
801036d9:	c9                   	leave  
801036da:	c3                   	ret    
801036db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036df:	90                   	nop

801036e0 <initlog>:
{
801036e0:	f3 0f 1e fb          	endbr32 
801036e4:	55                   	push   %ebp
801036e5:	89 e5                	mov    %esp,%ebp
801036e7:	53                   	push   %ebx
801036e8:	83 ec 2c             	sub    $0x2c,%esp
801036eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801036ee:	68 20 84 10 80       	push   $0x80108420
801036f3:	68 e0 de 11 80       	push   $0x8011dee0
801036f8:	e8 f3 19 00 00       	call   801050f0 <initlock>
  readsb(dev, &sb);
801036fd:	58                   	pop    %eax
801036fe:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103701:	5a                   	pop    %edx
80103702:	50                   	push   %eax
80103703:	53                   	push   %ebx
80103704:	e8 47 e8 ff ff       	call   80101f50 <readsb>
  log.start = sb.logstart;
80103709:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010370c:	59                   	pop    %ecx
  log.dev = dev;
8010370d:	89 1d 24 df 11 80    	mov    %ebx,0x8011df24
  log.size = sb.nlog;
80103713:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103716:	a3 14 df 11 80       	mov    %eax,0x8011df14
  log.size = sb.nlog;
8010371b:	89 15 18 df 11 80    	mov    %edx,0x8011df18
  struct buf *buf = bread(log.dev, log.start);
80103721:	5a                   	pop    %edx
80103722:	50                   	push   %eax
80103723:	53                   	push   %ebx
80103724:	e8 a7 c9 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103729:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
8010372c:	8b 48 5c             	mov    0x5c(%eax),%ecx
8010372f:	89 0d 28 df 11 80    	mov    %ecx,0x8011df28
  for (i = 0; i < log.lh.n; i++) {
80103735:	85 c9                	test   %ecx,%ecx
80103737:	7e 19                	jle    80103752 <initlog+0x72>
80103739:	31 d2                	xor    %edx,%edx
8010373b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010373f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103740:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
80103744:	89 1c 95 2c df 11 80 	mov    %ebx,-0x7fee20d4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010374b:	83 c2 01             	add    $0x1,%edx
8010374e:	39 d1                	cmp    %edx,%ecx
80103750:	75 ee                	jne    80103740 <initlog+0x60>
  brelse(buf);
80103752:	83 ec 0c             	sub    $0xc,%esp
80103755:	50                   	push   %eax
80103756:	e8 95 ca ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010375b:	e8 80 fe ff ff       	call   801035e0 <install_trans>
  log.lh.n = 0;
80103760:	c7 05 28 df 11 80 00 	movl   $0x0,0x8011df28
80103767:	00 00 00 
  write_head(); // clear the log
8010376a:	e8 11 ff ff ff       	call   80103680 <write_head>
}
8010376f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103772:	83 c4 10             	add    $0x10,%esp
80103775:	c9                   	leave  
80103776:	c3                   	ret    
80103777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010377e:	66 90                	xchg   %ax,%ax

80103780 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103780:	f3 0f 1e fb          	endbr32 
80103784:	55                   	push   %ebp
80103785:	89 e5                	mov    %esp,%ebp
80103787:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010378a:	68 e0 de 11 80       	push   $0x8011dee0
8010378f:	e8 dc 1a 00 00       	call   80105270 <acquire>
80103794:	83 c4 10             	add    $0x10,%esp
80103797:	eb 1c                	jmp    801037b5 <begin_op+0x35>
80103799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801037a0:	83 ec 08             	sub    $0x8,%esp
801037a3:	68 e0 de 11 80       	push   $0x8011dee0
801037a8:	68 e0 de 11 80       	push   $0x8011dee0
801037ad:	e8 4e 12 00 00       	call   80104a00 <sleep>
801037b2:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801037b5:	a1 20 df 11 80       	mov    0x8011df20,%eax
801037ba:	85 c0                	test   %eax,%eax
801037bc:	75 e2                	jne    801037a0 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801037be:	a1 1c df 11 80       	mov    0x8011df1c,%eax
801037c3:	8b 15 28 df 11 80    	mov    0x8011df28,%edx
801037c9:	83 c0 01             	add    $0x1,%eax
801037cc:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801037cf:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801037d2:	83 fa 1e             	cmp    $0x1e,%edx
801037d5:	7f c9                	jg     801037a0 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801037d7:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801037da:	a3 1c df 11 80       	mov    %eax,0x8011df1c
      release(&log.lock);
801037df:	68 e0 de 11 80       	push   $0x8011dee0
801037e4:	e8 47 1b 00 00       	call   80105330 <release>
      break;
    }
  }
}
801037e9:	83 c4 10             	add    $0x10,%esp
801037ec:	c9                   	leave  
801037ed:	c3                   	ret    
801037ee:	66 90                	xchg   %ax,%ax

801037f0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801037f0:	f3 0f 1e fb          	endbr32 
801037f4:	55                   	push   %ebp
801037f5:	89 e5                	mov    %esp,%ebp
801037f7:	57                   	push   %edi
801037f8:	56                   	push   %esi
801037f9:	53                   	push   %ebx
801037fa:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801037fd:	68 e0 de 11 80       	push   $0x8011dee0
80103802:	e8 69 1a 00 00       	call   80105270 <acquire>
  log.outstanding -= 1;
80103807:	a1 1c df 11 80       	mov    0x8011df1c,%eax
  if(log.committing)
8010380c:	8b 35 20 df 11 80    	mov    0x8011df20,%esi
80103812:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103815:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103818:	89 1d 1c df 11 80    	mov    %ebx,0x8011df1c
  if(log.committing)
8010381e:	85 f6                	test   %esi,%esi
80103820:	0f 85 1e 01 00 00    	jne    80103944 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103826:	85 db                	test   %ebx,%ebx
80103828:	0f 85 f2 00 00 00    	jne    80103920 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010382e:	c7 05 20 df 11 80 01 	movl   $0x1,0x8011df20
80103835:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103838:	83 ec 0c             	sub    $0xc,%esp
8010383b:	68 e0 de 11 80       	push   $0x8011dee0
80103840:	e8 eb 1a 00 00       	call   80105330 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103845:	8b 0d 28 df 11 80    	mov    0x8011df28,%ecx
8010384b:	83 c4 10             	add    $0x10,%esp
8010384e:	85 c9                	test   %ecx,%ecx
80103850:	7f 3e                	jg     80103890 <end_op+0xa0>
    acquire(&log.lock);
80103852:	83 ec 0c             	sub    $0xc,%esp
80103855:	68 e0 de 11 80       	push   $0x8011dee0
8010385a:	e8 11 1a 00 00       	call   80105270 <acquire>
    wakeup(&log);
8010385f:	c7 04 24 e0 de 11 80 	movl   $0x8011dee0,(%esp)
    log.committing = 0;
80103866:	c7 05 20 df 11 80 00 	movl   $0x0,0x8011df20
8010386d:	00 00 00 
    wakeup(&log);
80103870:	e8 4b 13 00 00       	call   80104bc0 <wakeup>
    release(&log.lock);
80103875:	c7 04 24 e0 de 11 80 	movl   $0x8011dee0,(%esp)
8010387c:	e8 af 1a 00 00       	call   80105330 <release>
80103881:	83 c4 10             	add    $0x10,%esp
}
80103884:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103887:	5b                   	pop    %ebx
80103888:	5e                   	pop    %esi
80103889:	5f                   	pop    %edi
8010388a:	5d                   	pop    %ebp
8010388b:	c3                   	ret    
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103890:	a1 14 df 11 80       	mov    0x8011df14,%eax
80103895:	83 ec 08             	sub    $0x8,%esp
80103898:	01 d8                	add    %ebx,%eax
8010389a:	83 c0 01             	add    $0x1,%eax
8010389d:	50                   	push   %eax
8010389e:	ff 35 24 df 11 80    	pushl  0x8011df24
801038a4:	e8 27 c8 ff ff       	call   801000d0 <bread>
801038a9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801038ab:	58                   	pop    %eax
801038ac:	5a                   	pop    %edx
801038ad:	ff 34 9d 2c df 11 80 	pushl  -0x7fee20d4(,%ebx,4)
801038b4:	ff 35 24 df 11 80    	pushl  0x8011df24
  for (tail = 0; tail < log.lh.n; tail++) {
801038ba:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801038bd:	e8 0e c8 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
801038c2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801038c5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801038c7:	8d 40 5c             	lea    0x5c(%eax),%eax
801038ca:	68 00 02 00 00       	push   $0x200
801038cf:	50                   	push   %eax
801038d0:	8d 46 5c             	lea    0x5c(%esi),%eax
801038d3:	50                   	push   %eax
801038d4:	e8 47 1b 00 00       	call   80105420 <memmove>
    bwrite(to);  // write the log
801038d9:	89 34 24             	mov    %esi,(%esp)
801038dc:	e8 cf c8 ff ff       	call   801001b0 <bwrite>
    brelse(from);
801038e1:	89 3c 24             	mov    %edi,(%esp)
801038e4:	e8 07 c9 ff ff       	call   801001f0 <brelse>
    brelse(to);
801038e9:	89 34 24             	mov    %esi,(%esp)
801038ec:	e8 ff c8 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801038f1:	83 c4 10             	add    $0x10,%esp
801038f4:	3b 1d 28 df 11 80    	cmp    0x8011df28,%ebx
801038fa:	7c 94                	jl     80103890 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801038fc:	e8 7f fd ff ff       	call   80103680 <write_head>
    install_trans(); // Now install writes to home locations
80103901:	e8 da fc ff ff       	call   801035e0 <install_trans>
    log.lh.n = 0;
80103906:	c7 05 28 df 11 80 00 	movl   $0x0,0x8011df28
8010390d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103910:	e8 6b fd ff ff       	call   80103680 <write_head>
80103915:	e9 38 ff ff ff       	jmp    80103852 <end_op+0x62>
8010391a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103920:	83 ec 0c             	sub    $0xc,%esp
80103923:	68 e0 de 11 80       	push   $0x8011dee0
80103928:	e8 93 12 00 00       	call   80104bc0 <wakeup>
  release(&log.lock);
8010392d:	c7 04 24 e0 de 11 80 	movl   $0x8011dee0,(%esp)
80103934:	e8 f7 19 00 00       	call   80105330 <release>
80103939:	83 c4 10             	add    $0x10,%esp
}
8010393c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010393f:	5b                   	pop    %ebx
80103940:	5e                   	pop    %esi
80103941:	5f                   	pop    %edi
80103942:	5d                   	pop    %ebp
80103943:	c3                   	ret    
    panic("log.committing");
80103944:	83 ec 0c             	sub    $0xc,%esp
80103947:	68 24 84 10 80       	push   $0x80108424
8010394c:	e8 3f ca ff ff       	call   80100390 <panic>
80103951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010395f:	90                   	nop

80103960 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103960:	f3 0f 1e fb          	endbr32 
80103964:	55                   	push   %ebp
80103965:	89 e5                	mov    %esp,%ebp
80103967:	53                   	push   %ebx
80103968:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010396b:	8b 15 28 df 11 80    	mov    0x8011df28,%edx
{
80103971:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103974:	83 fa 1d             	cmp    $0x1d,%edx
80103977:	0f 8f 91 00 00 00    	jg     80103a0e <log_write+0xae>
8010397d:	a1 18 df 11 80       	mov    0x8011df18,%eax
80103982:	83 e8 01             	sub    $0x1,%eax
80103985:	39 c2                	cmp    %eax,%edx
80103987:	0f 8d 81 00 00 00    	jge    80103a0e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010398d:	a1 1c df 11 80       	mov    0x8011df1c,%eax
80103992:	85 c0                	test   %eax,%eax
80103994:	0f 8e 81 00 00 00    	jle    80103a1b <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010399a:	83 ec 0c             	sub    $0xc,%esp
8010399d:	68 e0 de 11 80       	push   $0x8011dee0
801039a2:	e8 c9 18 00 00       	call   80105270 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801039a7:	8b 15 28 df 11 80    	mov    0x8011df28,%edx
801039ad:	83 c4 10             	add    $0x10,%esp
801039b0:	85 d2                	test   %edx,%edx
801039b2:	7e 4e                	jle    80103a02 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801039b4:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801039b7:	31 c0                	xor    %eax,%eax
801039b9:	eb 0c                	jmp    801039c7 <log_write+0x67>
801039bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039bf:	90                   	nop
801039c0:	83 c0 01             	add    $0x1,%eax
801039c3:	39 c2                	cmp    %eax,%edx
801039c5:	74 29                	je     801039f0 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801039c7:	39 0c 85 2c df 11 80 	cmp    %ecx,-0x7fee20d4(,%eax,4)
801039ce:	75 f0                	jne    801039c0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801039d0:	89 0c 85 2c df 11 80 	mov    %ecx,-0x7fee20d4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801039d7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801039da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801039dd:	c7 45 08 e0 de 11 80 	movl   $0x8011dee0,0x8(%ebp)
}
801039e4:	c9                   	leave  
  release(&log.lock);
801039e5:	e9 46 19 00 00       	jmp    80105330 <release>
801039ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801039f0:	89 0c 95 2c df 11 80 	mov    %ecx,-0x7fee20d4(,%edx,4)
    log.lh.n++;
801039f7:	83 c2 01             	add    $0x1,%edx
801039fa:	89 15 28 df 11 80    	mov    %edx,0x8011df28
80103a00:	eb d5                	jmp    801039d7 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103a02:	8b 43 08             	mov    0x8(%ebx),%eax
80103a05:	a3 2c df 11 80       	mov    %eax,0x8011df2c
  if (i == log.lh.n)
80103a0a:	75 cb                	jne    801039d7 <log_write+0x77>
80103a0c:	eb e9                	jmp    801039f7 <log_write+0x97>
    panic("too big a transaction");
80103a0e:	83 ec 0c             	sub    $0xc,%esp
80103a11:	68 33 84 10 80       	push   $0x80108433
80103a16:	e8 75 c9 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103a1b:	83 ec 0c             	sub    $0xc,%esp
80103a1e:	68 49 84 10 80       	push   $0x80108449
80103a23:	e8 68 c9 ff ff       	call   80100390 <panic>
80103a28:	66 90                	xchg   %ax,%ax
80103a2a:	66 90                	xchg   %ax,%ax
80103a2c:	66 90                	xchg   %ax,%ax
80103a2e:	66 90                	xchg   %ax,%ax

80103a30 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	53                   	push   %ebx
80103a34:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103a37:	e8 a4 09 00 00       	call   801043e0 <cpuid>
80103a3c:	89 c3                	mov    %eax,%ebx
80103a3e:	e8 9d 09 00 00       	call   801043e0 <cpuid>
80103a43:	83 ec 04             	sub    $0x4,%esp
80103a46:	53                   	push   %ebx
80103a47:	50                   	push   %eax
80103a48:	68 64 84 10 80       	push   $0x80108464
80103a4d:	e8 9e cc ff ff       	call   801006f0 <cprintf>
  idtinit();       // load idt register
80103a52:	e8 59 2d 00 00       	call   801067b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103a57:	e8 14 09 00 00       	call   80104370 <mycpu>
80103a5c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103a5e:	b8 01 00 00 00       	mov    $0x1,%eax
80103a63:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103a6a:	e8 61 0c 00 00       	call   801046d0 <scheduler>
80103a6f:	90                   	nop

80103a70 <mpenter>:
{
80103a70:	f3 0f 1e fb          	endbr32 
80103a74:	55                   	push   %ebp
80103a75:	89 e5                	mov    %esp,%ebp
80103a77:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103a7a:	e8 01 3e 00 00       	call   80107880 <switchkvm>
  seginit();
80103a7f:	e8 6c 3d 00 00       	call   801077f0 <seginit>
  lapicinit();
80103a84:	e8 67 f7 ff ff       	call   801031f0 <lapicinit>
  mpmain();
80103a89:	e8 a2 ff ff ff       	call   80103a30 <mpmain>
80103a8e:	66 90                	xchg   %ax,%ax

80103a90 <main>:
{
80103a90:	f3 0f 1e fb          	endbr32 
80103a94:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103a98:	83 e4 f0             	and    $0xfffffff0,%esp
80103a9b:	ff 71 fc             	pushl  -0x4(%ecx)
80103a9e:	55                   	push   %ebp
80103a9f:	89 e5                	mov    %esp,%ebp
80103aa1:	53                   	push   %ebx
80103aa2:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103aa3:	83 ec 08             	sub    $0x8,%esp
80103aa6:	68 00 00 40 80       	push   $0x80400000
80103aab:	68 08 39 39 80       	push   $0x80393908
80103ab0:	e8 fb f4 ff ff       	call   80102fb0 <kinit1>
  kvmalloc();      // kernel page table
80103ab5:	e8 a6 42 00 00       	call   80107d60 <kvmalloc>
  mpinit();        // detect other processors
80103aba:	e8 81 01 00 00       	call   80103c40 <mpinit>
  lapicinit();     // interrupt controller
80103abf:	e8 2c f7 ff ff       	call   801031f0 <lapicinit>
  seginit();       // segment descriptors
80103ac4:	e8 27 3d 00 00       	call   801077f0 <seginit>
  picinit();       // disable pic
80103ac9:	e8 52 03 00 00       	call   80103e20 <picinit>
  ioapicinit();    // another interrupt controller
80103ace:	e8 fd f2 ff ff       	call   80102dd0 <ioapicinit>
  consoleinit();   // console hardware
80103ad3:	e8 98 d9 ff ff       	call   80101470 <consoleinit>
  uartinit();      // serial port
80103ad8:	e8 d3 2f 00 00       	call   80106ab0 <uartinit>
  pinit();         // process table
80103add:	e8 6e 08 00 00       	call   80104350 <pinit>
  tvinit();        // trap vectors
80103ae2:	e8 49 2c 00 00       	call   80106730 <tvinit>
  binit();         // buffer cache
80103ae7:	e8 54 c5 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103aec:	e8 3f dd ff ff       	call   80101830 <fileinit>
  ideinit();       // disk 
80103af1:	e8 aa f0 ff ff       	call   80102ba0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103af6:	83 c4 0c             	add    $0xc,%esp
80103af9:	68 8a 00 00 00       	push   $0x8a
80103afe:	68 8c b4 10 80       	push   $0x8010b48c
80103b03:	68 00 70 00 80       	push   $0x80007000
80103b08:	e8 13 19 00 00       	call   80105420 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103b0d:	83 c4 10             	add    $0x10,%esp
80103b10:	69 05 60 e5 11 80 b0 	imul   $0xb0,0x8011e560,%eax
80103b17:	00 00 00 
80103b1a:	05 e0 df 11 80       	add    $0x8011dfe0,%eax
80103b1f:	3d e0 df 11 80       	cmp    $0x8011dfe0,%eax
80103b24:	76 7a                	jbe    80103ba0 <main+0x110>
80103b26:	bb e0 df 11 80       	mov    $0x8011dfe0,%ebx
80103b2b:	eb 1c                	jmp    80103b49 <main+0xb9>
80103b2d:	8d 76 00             	lea    0x0(%esi),%esi
80103b30:	69 05 60 e5 11 80 b0 	imul   $0xb0,0x8011e560,%eax
80103b37:	00 00 00 
80103b3a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103b40:	05 e0 df 11 80       	add    $0x8011dfe0,%eax
80103b45:	39 c3                	cmp    %eax,%ebx
80103b47:	73 57                	jae    80103ba0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103b49:	e8 22 08 00 00       	call   80104370 <mycpu>
80103b4e:	39 c3                	cmp    %eax,%ebx
80103b50:	74 de                	je     80103b30 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103b52:	e8 29 f5 ff ff       	call   80103080 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103b57:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103b5a:	c7 05 f8 6f 00 80 70 	movl   $0x80103a70,0x80006ff8
80103b61:	3a 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103b64:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103b6b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103b6e:	05 00 10 00 00       	add    $0x1000,%eax
80103b73:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103b78:	0f b6 03             	movzbl (%ebx),%eax
80103b7b:	68 00 70 00 00       	push   $0x7000
80103b80:	50                   	push   %eax
80103b81:	e8 ba f7 ff ff       	call   80103340 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103b86:	83 c4 10             	add    $0x10,%esp
80103b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b90:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103b96:	85 c0                	test   %eax,%eax
80103b98:	74 f6                	je     80103b90 <main+0x100>
80103b9a:	eb 94                	jmp    80103b30 <main+0xa0>
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103ba0:	83 ec 08             	sub    $0x8,%esp
80103ba3:	68 00 00 00 8e       	push   $0x8e000000
80103ba8:	68 00 00 40 80       	push   $0x80400000
80103bad:	e8 6e f4 ff ff       	call   80103020 <kinit2>
  userinit();      // first user process
80103bb2:	e8 79 08 00 00       	call   80104430 <userinit>
  mpmain();        // finish this processor's setup
80103bb7:	e8 74 fe ff ff       	call   80103a30 <mpmain>
80103bbc:	66 90                	xchg   %ax,%ax
80103bbe:	66 90                	xchg   %ax,%ax

80103bc0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	57                   	push   %edi
80103bc4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103bc5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103bcb:	53                   	push   %ebx
  e = addr+len;
80103bcc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103bcf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103bd2:	39 de                	cmp    %ebx,%esi
80103bd4:	72 10                	jb     80103be6 <mpsearch1+0x26>
80103bd6:	eb 50                	jmp    80103c28 <mpsearch1+0x68>
80103bd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bdf:	90                   	nop
80103be0:	89 fe                	mov    %edi,%esi
80103be2:	39 fb                	cmp    %edi,%ebx
80103be4:	76 42                	jbe    80103c28 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103be6:	83 ec 04             	sub    $0x4,%esp
80103be9:	8d 7e 10             	lea    0x10(%esi),%edi
80103bec:	6a 04                	push   $0x4
80103bee:	68 78 84 10 80       	push   $0x80108478
80103bf3:	56                   	push   %esi
80103bf4:	e8 d7 17 00 00       	call   801053d0 <memcmp>
80103bf9:	83 c4 10             	add    $0x10,%esp
80103bfc:	85 c0                	test   %eax,%eax
80103bfe:	75 e0                	jne    80103be0 <mpsearch1+0x20>
80103c00:	89 f2                	mov    %esi,%edx
80103c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103c08:	0f b6 0a             	movzbl (%edx),%ecx
80103c0b:	83 c2 01             	add    $0x1,%edx
80103c0e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103c10:	39 fa                	cmp    %edi,%edx
80103c12:	75 f4                	jne    80103c08 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103c14:	84 c0                	test   %al,%al
80103c16:	75 c8                	jne    80103be0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103c18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c1b:	89 f0                	mov    %esi,%eax
80103c1d:	5b                   	pop    %ebx
80103c1e:	5e                   	pop    %esi
80103c1f:	5f                   	pop    %edi
80103c20:	5d                   	pop    %ebp
80103c21:	c3                   	ret    
80103c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103c2b:	31 f6                	xor    %esi,%esi
}
80103c2d:	5b                   	pop    %ebx
80103c2e:	89 f0                	mov    %esi,%eax
80103c30:	5e                   	pop    %esi
80103c31:	5f                   	pop    %edi
80103c32:	5d                   	pop    %ebp
80103c33:	c3                   	ret    
80103c34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c3f:	90                   	nop

80103c40 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103c40:	f3 0f 1e fb          	endbr32 
80103c44:	55                   	push   %ebp
80103c45:	89 e5                	mov    %esp,%ebp
80103c47:	57                   	push   %edi
80103c48:	56                   	push   %esi
80103c49:	53                   	push   %ebx
80103c4a:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103c4d:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103c54:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103c5b:	c1 e0 08             	shl    $0x8,%eax
80103c5e:	09 d0                	or     %edx,%eax
80103c60:	c1 e0 04             	shl    $0x4,%eax
80103c63:	75 1b                	jne    80103c80 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103c65:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103c6c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103c73:	c1 e0 08             	shl    $0x8,%eax
80103c76:	09 d0                	or     %edx,%eax
80103c78:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103c7b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103c80:	ba 00 04 00 00       	mov    $0x400,%edx
80103c85:	e8 36 ff ff ff       	call   80103bc0 <mpsearch1>
80103c8a:	89 c6                	mov    %eax,%esi
80103c8c:	85 c0                	test   %eax,%eax
80103c8e:	0f 84 4c 01 00 00    	je     80103de0 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103c94:	8b 5e 04             	mov    0x4(%esi),%ebx
80103c97:	85 db                	test   %ebx,%ebx
80103c99:	0f 84 61 01 00 00    	je     80103e00 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
80103c9f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103ca2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103ca8:	6a 04                	push   $0x4
80103caa:	68 7d 84 10 80       	push   $0x8010847d
80103caf:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103cb0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103cb3:	e8 18 17 00 00       	call   801053d0 <memcmp>
80103cb8:	83 c4 10             	add    $0x10,%esp
80103cbb:	85 c0                	test   %eax,%eax
80103cbd:	0f 85 3d 01 00 00    	jne    80103e00 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103cc3:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103cca:	3c 01                	cmp    $0x1,%al
80103ccc:	74 08                	je     80103cd6 <mpinit+0x96>
80103cce:	3c 04                	cmp    $0x4,%al
80103cd0:	0f 85 2a 01 00 00    	jne    80103e00 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103cd6:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
80103cdd:	66 85 d2             	test   %dx,%dx
80103ce0:	74 26                	je     80103d08 <mpinit+0xc8>
80103ce2:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103ce5:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103ce7:	31 d2                	xor    %edx,%edx
80103ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103cf0:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103cf7:	83 c0 01             	add    $0x1,%eax
80103cfa:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103cfc:	39 f8                	cmp    %edi,%eax
80103cfe:	75 f0                	jne    80103cf0 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103d00:	84 d2                	test   %dl,%dl
80103d02:	0f 85 f8 00 00 00    	jne    80103e00 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103d08:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103d0e:	a3 dc de 11 80       	mov    %eax,0x8011dedc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d13:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103d19:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
80103d20:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d25:	03 55 e4             	add    -0x1c(%ebp),%edx
80103d28:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d2f:	90                   	nop
80103d30:	39 c2                	cmp    %eax,%edx
80103d32:	76 15                	jbe    80103d49 <mpinit+0x109>
    switch(*p){
80103d34:	0f b6 08             	movzbl (%eax),%ecx
80103d37:	80 f9 02             	cmp    $0x2,%cl
80103d3a:	74 5c                	je     80103d98 <mpinit+0x158>
80103d3c:	77 42                	ja     80103d80 <mpinit+0x140>
80103d3e:	84 c9                	test   %cl,%cl
80103d40:	74 6e                	je     80103db0 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103d42:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d45:	39 c2                	cmp    %eax,%edx
80103d47:	77 eb                	ja     80103d34 <mpinit+0xf4>
80103d49:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103d4c:	85 db                	test   %ebx,%ebx
80103d4e:	0f 84 b9 00 00 00    	je     80103e0d <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103d54:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103d58:	74 15                	je     80103d6f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d5a:	b8 70 00 00 00       	mov    $0x70,%eax
80103d5f:	ba 22 00 00 00       	mov    $0x22,%edx
80103d64:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103d65:	ba 23 00 00 00       	mov    $0x23,%edx
80103d6a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d6b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103d6e:	ee                   	out    %al,(%dx)
  }
}
80103d6f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d72:	5b                   	pop    %ebx
80103d73:	5e                   	pop    %esi
80103d74:	5f                   	pop    %edi
80103d75:	5d                   	pop    %ebp
80103d76:	c3                   	ret    
80103d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d7e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103d80:	83 e9 03             	sub    $0x3,%ecx
80103d83:	80 f9 01             	cmp    $0x1,%cl
80103d86:	76 ba                	jbe    80103d42 <mpinit+0x102>
80103d88:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80103d8f:	eb 9f                	jmp    80103d30 <mpinit+0xf0>
80103d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103d98:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103d9c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103d9f:	88 0d c0 df 11 80    	mov    %cl,0x8011dfc0
      continue;
80103da5:	eb 89                	jmp    80103d30 <mpinit+0xf0>
80103da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dae:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103db0:	8b 0d 60 e5 11 80    	mov    0x8011e560,%ecx
80103db6:	83 f9 07             	cmp    $0x7,%ecx
80103db9:	7f 19                	jg     80103dd4 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103dbb:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103dc1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103dc5:	83 c1 01             	add    $0x1,%ecx
80103dc8:	89 0d 60 e5 11 80    	mov    %ecx,0x8011e560
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103dce:	88 9f e0 df 11 80    	mov    %bl,-0x7fee2020(%edi)
      p += sizeof(struct mpproc);
80103dd4:	83 c0 14             	add    $0x14,%eax
      continue;
80103dd7:	e9 54 ff ff ff       	jmp    80103d30 <mpinit+0xf0>
80103ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103de0:	ba 00 00 01 00       	mov    $0x10000,%edx
80103de5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103dea:	e8 d1 fd ff ff       	call   80103bc0 <mpsearch1>
80103def:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103df1:	85 c0                	test   %eax,%eax
80103df3:	0f 85 9b fe ff ff    	jne    80103c94 <mpinit+0x54>
80103df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103e00:	83 ec 0c             	sub    $0xc,%esp
80103e03:	68 82 84 10 80       	push   $0x80108482
80103e08:	e8 83 c5 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
80103e0d:	83 ec 0c             	sub    $0xc,%esp
80103e10:	68 9c 84 10 80       	push   $0x8010849c
80103e15:	e8 76 c5 ff ff       	call   80100390 <panic>
80103e1a:	66 90                	xchg   %ax,%ax
80103e1c:	66 90                	xchg   %ax,%ax
80103e1e:	66 90                	xchg   %ax,%ax

80103e20 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103e20:	f3 0f 1e fb          	endbr32 
80103e24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e29:	ba 21 00 00 00       	mov    $0x21,%edx
80103e2e:	ee                   	out    %al,(%dx)
80103e2f:	ba a1 00 00 00       	mov    $0xa1,%edx
80103e34:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103e35:	c3                   	ret    
80103e36:	66 90                	xchg   %ax,%ax
80103e38:	66 90                	xchg   %ax,%ax
80103e3a:	66 90                	xchg   %ax,%ax
80103e3c:	66 90                	xchg   %ax,%ax
80103e3e:	66 90                	xchg   %ax,%ax

80103e40 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	57                   	push   %edi
80103e48:	56                   	push   %esi
80103e49:	53                   	push   %ebx
80103e4a:	83 ec 0c             	sub    $0xc,%esp
80103e4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103e50:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103e53:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103e59:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103e5f:	e8 ec d9 ff ff       	call   80101850 <filealloc>
80103e64:	89 03                	mov    %eax,(%ebx)
80103e66:	85 c0                	test   %eax,%eax
80103e68:	0f 84 ac 00 00 00    	je     80103f1a <pipealloc+0xda>
80103e6e:	e8 dd d9 ff ff       	call   80101850 <filealloc>
80103e73:	89 06                	mov    %eax,(%esi)
80103e75:	85 c0                	test   %eax,%eax
80103e77:	0f 84 8b 00 00 00    	je     80103f08 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103e7d:	e8 fe f1 ff ff       	call   80103080 <kalloc>
80103e82:	89 c7                	mov    %eax,%edi
80103e84:	85 c0                	test   %eax,%eax
80103e86:	0f 84 b4 00 00 00    	je     80103f40 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
80103e8c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103e93:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103e96:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103e99:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103ea0:	00 00 00 
  p->nwrite = 0;
80103ea3:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103eaa:	00 00 00 
  p->nread = 0;
80103ead:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103eb4:	00 00 00 
  initlock(&p->lock, "pipe");
80103eb7:	68 bb 84 10 80       	push   $0x801084bb
80103ebc:	50                   	push   %eax
80103ebd:	e8 2e 12 00 00       	call   801050f0 <initlock>
  (*f0)->type = FD_PIPE;
80103ec2:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103ec4:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103ec7:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103ecd:	8b 03                	mov    (%ebx),%eax
80103ecf:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ed3:	8b 03                	mov    (%ebx),%eax
80103ed5:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103ed9:	8b 03                	mov    (%ebx),%eax
80103edb:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103ede:	8b 06                	mov    (%esi),%eax
80103ee0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103ee6:	8b 06                	mov    (%esi),%eax
80103ee8:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103eec:	8b 06                	mov    (%esi),%eax
80103eee:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103ef2:	8b 06                	mov    (%esi),%eax
80103ef4:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103ef7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103efa:	31 c0                	xor    %eax,%eax
}
80103efc:	5b                   	pop    %ebx
80103efd:	5e                   	pop    %esi
80103efe:	5f                   	pop    %edi
80103eff:	5d                   	pop    %ebp
80103f00:	c3                   	ret    
80103f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103f08:	8b 03                	mov    (%ebx),%eax
80103f0a:	85 c0                	test   %eax,%eax
80103f0c:	74 1e                	je     80103f2c <pipealloc+0xec>
    fileclose(*f0);
80103f0e:	83 ec 0c             	sub    $0xc,%esp
80103f11:	50                   	push   %eax
80103f12:	e8 f9 d9 ff ff       	call   80101910 <fileclose>
80103f17:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103f1a:	8b 06                	mov    (%esi),%eax
80103f1c:	85 c0                	test   %eax,%eax
80103f1e:	74 0c                	je     80103f2c <pipealloc+0xec>
    fileclose(*f1);
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	50                   	push   %eax
80103f24:	e8 e7 d9 ff ff       	call   80101910 <fileclose>
80103f29:	83 c4 10             	add    $0x10,%esp
}
80103f2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103f2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f34:	5b                   	pop    %ebx
80103f35:	5e                   	pop    %esi
80103f36:	5f                   	pop    %edi
80103f37:	5d                   	pop    %ebp
80103f38:	c3                   	ret    
80103f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103f40:	8b 03                	mov    (%ebx),%eax
80103f42:	85 c0                	test   %eax,%eax
80103f44:	75 c8                	jne    80103f0e <pipealloc+0xce>
80103f46:	eb d2                	jmp    80103f1a <pipealloc+0xda>
80103f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f4f:	90                   	nop

80103f50 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103f50:	f3 0f 1e fb          	endbr32 
80103f54:	55                   	push   %ebp
80103f55:	89 e5                	mov    %esp,%ebp
80103f57:	56                   	push   %esi
80103f58:	53                   	push   %ebx
80103f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103f5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103f5f:	83 ec 0c             	sub    $0xc,%esp
80103f62:	53                   	push   %ebx
80103f63:	e8 08 13 00 00       	call   80105270 <acquire>
  if(writable){
80103f68:	83 c4 10             	add    $0x10,%esp
80103f6b:	85 f6                	test   %esi,%esi
80103f6d:	74 41                	je     80103fb0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103f6f:	83 ec 0c             	sub    $0xc,%esp
80103f72:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103f78:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103f7f:	00 00 00 
    wakeup(&p->nread);
80103f82:	50                   	push   %eax
80103f83:	e8 38 0c 00 00       	call   80104bc0 <wakeup>
80103f88:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103f8b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103f91:	85 d2                	test   %edx,%edx
80103f93:	75 0a                	jne    80103f9f <pipeclose+0x4f>
80103f95:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103f9b:	85 c0                	test   %eax,%eax
80103f9d:	74 31                	je     80103fd0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103f9f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103fa2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fa5:	5b                   	pop    %ebx
80103fa6:	5e                   	pop    %esi
80103fa7:	5d                   	pop    %ebp
    release(&p->lock);
80103fa8:	e9 83 13 00 00       	jmp    80105330 <release>
80103fad:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103fb0:	83 ec 0c             	sub    $0xc,%esp
80103fb3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103fb9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103fc0:	00 00 00 
    wakeup(&p->nwrite);
80103fc3:	50                   	push   %eax
80103fc4:	e8 f7 0b 00 00       	call   80104bc0 <wakeup>
80103fc9:	83 c4 10             	add    $0x10,%esp
80103fcc:	eb bd                	jmp    80103f8b <pipeclose+0x3b>
80103fce:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103fd0:	83 ec 0c             	sub    $0xc,%esp
80103fd3:	53                   	push   %ebx
80103fd4:	e8 57 13 00 00       	call   80105330 <release>
    kfree((char*)p);
80103fd9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103fdc:	83 c4 10             	add    $0x10,%esp
}
80103fdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fe2:	5b                   	pop    %ebx
80103fe3:	5e                   	pop    %esi
80103fe4:	5d                   	pop    %ebp
    kfree((char*)p);
80103fe5:	e9 d6 ee ff ff       	jmp    80102ec0 <kfree>
80103fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ff0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103ff0:	f3 0f 1e fb          	endbr32 
80103ff4:	55                   	push   %ebp
80103ff5:	89 e5                	mov    %esp,%ebp
80103ff7:	57                   	push   %edi
80103ff8:	56                   	push   %esi
80103ff9:	53                   	push   %ebx
80103ffa:	83 ec 28             	sub    $0x28,%esp
80103ffd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80104000:	53                   	push   %ebx
80104001:	e8 6a 12 00 00       	call   80105270 <acquire>
  for(i = 0; i < n; i++){
80104006:	8b 45 10             	mov    0x10(%ebp),%eax
80104009:	83 c4 10             	add    $0x10,%esp
8010400c:	85 c0                	test   %eax,%eax
8010400e:	0f 8e bc 00 00 00    	jle    801040d0 <pipewrite+0xe0>
80104014:	8b 45 0c             	mov    0xc(%ebp),%eax
80104017:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010401d:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80104023:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104026:	03 45 10             	add    0x10(%ebp),%eax
80104029:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010402c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104032:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104038:	89 ca                	mov    %ecx,%edx
8010403a:	05 00 02 00 00       	add    $0x200,%eax
8010403f:	39 c1                	cmp    %eax,%ecx
80104041:	74 3b                	je     8010407e <pipewrite+0x8e>
80104043:	eb 63                	jmp    801040a8 <pipewrite+0xb8>
80104045:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80104048:	e8 b3 03 00 00       	call   80104400 <myproc>
8010404d:	8b 48 24             	mov    0x24(%eax),%ecx
80104050:	85 c9                	test   %ecx,%ecx
80104052:	75 34                	jne    80104088 <pipewrite+0x98>
      wakeup(&p->nread);
80104054:	83 ec 0c             	sub    $0xc,%esp
80104057:	57                   	push   %edi
80104058:	e8 63 0b 00 00       	call   80104bc0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010405d:	58                   	pop    %eax
8010405e:	5a                   	pop    %edx
8010405f:	53                   	push   %ebx
80104060:	56                   	push   %esi
80104061:	e8 9a 09 00 00       	call   80104a00 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104066:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010406c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104072:	83 c4 10             	add    $0x10,%esp
80104075:	05 00 02 00 00       	add    $0x200,%eax
8010407a:	39 c2                	cmp    %eax,%edx
8010407c:	75 2a                	jne    801040a8 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010407e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104084:	85 c0                	test   %eax,%eax
80104086:	75 c0                	jne    80104048 <pipewrite+0x58>
        release(&p->lock);
80104088:	83 ec 0c             	sub    $0xc,%esp
8010408b:	53                   	push   %ebx
8010408c:	e8 9f 12 00 00       	call   80105330 <release>
        return -1;
80104091:	83 c4 10             	add    $0x10,%esp
80104094:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104099:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010409c:	5b                   	pop    %ebx
8010409d:	5e                   	pop    %esi
8010409e:	5f                   	pop    %edi
8010409f:	5d                   	pop    %ebp
801040a0:	c3                   	ret    
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801040a8:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801040ab:	8d 4a 01             	lea    0x1(%edx),%ecx
801040ae:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801040b4:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
801040ba:	0f b6 06             	movzbl (%esi),%eax
801040bd:	83 c6 01             	add    $0x1,%esi
801040c0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801040c3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801040c7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801040ca:	0f 85 5c ff ff ff    	jne    8010402c <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801040d0:	83 ec 0c             	sub    $0xc,%esp
801040d3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801040d9:	50                   	push   %eax
801040da:	e8 e1 0a 00 00       	call   80104bc0 <wakeup>
  release(&p->lock);
801040df:	89 1c 24             	mov    %ebx,(%esp)
801040e2:	e8 49 12 00 00       	call   80105330 <release>
  return n;
801040e7:	8b 45 10             	mov    0x10(%ebp),%eax
801040ea:	83 c4 10             	add    $0x10,%esp
801040ed:	eb aa                	jmp    80104099 <pipewrite+0xa9>
801040ef:	90                   	nop

801040f0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801040f0:	f3 0f 1e fb          	endbr32 
801040f4:	55                   	push   %ebp
801040f5:	89 e5                	mov    %esp,%ebp
801040f7:	57                   	push   %edi
801040f8:	56                   	push   %esi
801040f9:	53                   	push   %ebx
801040fa:	83 ec 18             	sub    $0x18,%esp
801040fd:	8b 75 08             	mov    0x8(%ebp),%esi
80104100:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80104103:	56                   	push   %esi
80104104:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010410a:	e8 61 11 00 00       	call   80105270 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010410f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104115:	83 c4 10             	add    $0x10,%esp
80104118:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
8010411e:	74 33                	je     80104153 <piperead+0x63>
80104120:	eb 3b                	jmp    8010415d <piperead+0x6d>
80104122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80104128:	e8 d3 02 00 00       	call   80104400 <myproc>
8010412d:	8b 48 24             	mov    0x24(%eax),%ecx
80104130:	85 c9                	test   %ecx,%ecx
80104132:	0f 85 88 00 00 00    	jne    801041c0 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104138:	83 ec 08             	sub    $0x8,%esp
8010413b:	56                   	push   %esi
8010413c:	53                   	push   %ebx
8010413d:	e8 be 08 00 00       	call   80104a00 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104142:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80104148:	83 c4 10             	add    $0x10,%esp
8010414b:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80104151:	75 0a                	jne    8010415d <piperead+0x6d>
80104153:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80104159:	85 c0                	test   %eax,%eax
8010415b:	75 cb                	jne    80104128 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010415d:	8b 55 10             	mov    0x10(%ebp),%edx
80104160:	31 db                	xor    %ebx,%ebx
80104162:	85 d2                	test   %edx,%edx
80104164:	7f 28                	jg     8010418e <piperead+0x9e>
80104166:	eb 34                	jmp    8010419c <piperead+0xac>
80104168:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010416f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104170:	8d 48 01             	lea    0x1(%eax),%ecx
80104173:	25 ff 01 00 00       	and    $0x1ff,%eax
80104178:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010417e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104183:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104186:	83 c3 01             	add    $0x1,%ebx
80104189:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010418c:	74 0e                	je     8010419c <piperead+0xac>
    if(p->nread == p->nwrite)
8010418e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104194:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010419a:	75 d4                	jne    80104170 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010419c:	83 ec 0c             	sub    $0xc,%esp
8010419f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801041a5:	50                   	push   %eax
801041a6:	e8 15 0a 00 00       	call   80104bc0 <wakeup>
  release(&p->lock);
801041ab:	89 34 24             	mov    %esi,(%esp)
801041ae:	e8 7d 11 00 00       	call   80105330 <release>
  return i;
801041b3:	83 c4 10             	add    $0x10,%esp
}
801041b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041b9:	89 d8                	mov    %ebx,%eax
801041bb:	5b                   	pop    %ebx
801041bc:	5e                   	pop    %esi
801041bd:	5f                   	pop    %edi
801041be:	5d                   	pop    %ebp
801041bf:	c3                   	ret    
      release(&p->lock);
801041c0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801041c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801041c8:	56                   	push   %esi
801041c9:	e8 62 11 00 00       	call   80105330 <release>
      return -1;
801041ce:	83 c4 10             	add    $0x10,%esp
}
801041d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041d4:	89 d8                	mov    %ebx,%eax
801041d6:	5b                   	pop    %ebx
801041d7:	5e                   	pop    %esi
801041d8:	5f                   	pop    %edi
801041d9:	5d                   	pop    %ebp
801041da:	c3                   	ret    
801041db:	66 90                	xchg   %ax,%ax
801041dd:	66 90                	xchg   %ax,%ax
801041df:	90                   	nop

801041e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041e4:	bb b4 e5 11 80       	mov    $0x8011e5b4,%ebx
{
801041e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801041ec:	68 80 e5 11 80       	push   $0x8011e580
801041f1:	e8 7a 10 00 00       	call   80105270 <acquire>
801041f6:	83 c4 10             	add    $0x10,%esp
801041f9:	eb 12                	jmp    8010420d <allocproc+0x2d>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041fb:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
80104201:	81 fb b4 30 39 80    	cmp    $0x803930b4,%ebx
80104207:	0f 84 c1 00 00 00    	je     801042ce <allocproc+0xee>
    if(p->state == UNUSED)
8010420d:	8b 43 0c             	mov    0xc(%ebx),%eax
80104210:	85 c0                	test   %eax,%eax
80104212:	75 e7                	jne    801041fb <allocproc+0x1b>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104214:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80104219:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010421c:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80104223:	89 43 10             	mov    %eax,0x10(%ebx)
80104226:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104229:	68 80 e5 11 80       	push   $0x8011e580
  p->pid = nextpid++;
8010422e:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80104234:	e8 f7 10 00 00       	call   80105330 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104239:	e8 42 ee ff ff       	call   80103080 <kalloc>
8010423e:	83 c4 10             	add    $0x10,%esp
80104241:	89 43 08             	mov    %eax,0x8(%ebx)
80104244:	85 c0                	test   %eax,%eax
80104246:	0f 84 9b 00 00 00    	je     801042e7 <allocproc+0x107>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010424c:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104252:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80104255:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010425a:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010425d:	c7 40 14 1d 67 10 80 	movl   $0x8010671d,0x14(%eax)
  p->context = (struct context*)sp;
80104264:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104267:	6a 14                	push   $0x14
80104269:	6a 00                	push   $0x0
8010426b:	50                   	push   %eax
8010426c:	e8 0f 11 00 00       	call   80105380 <memset>
  p->context->eip = (uint)forkret;
80104271:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104274:	8d 93 ec 00 00 00    	lea    0xec(%ebx),%edx
8010427a:	83 c4 10             	add    $0x10,%esp
8010427d:	c7 40 10 00 43 10 80 	movl   $0x80104300,0x10(%eax)

  for(int i = 0; i < sizeof(p->callcount)/sizeof(int); i++){
80104284:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
    p->callcount[i] = 0;
8010428a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(int i = 0; i < sizeof(p->callcount)/sizeof(int); i++){
80104290:	83 c0 04             	add    $0x4,%eax
80104293:	39 d0                	cmp    %edx,%eax
80104295:	75 f3                	jne    8010428a <allocproc+0xaa>
80104297:	8d 93 7c 02 00 00    	lea    0x27c(%ebx),%edx
8010429d:	8d 8b bc 9e 00 00    	lea    0x9ebc(%ebx),%ecx
  }

  for(int i = 0; i < 100; i++){
    for(int j = 0; j < 100; j++){
801042a3:	8d 82 70 fe ff ff    	lea    -0x190(%edx),%eax
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      p->caller_count[i][j] = 0;
801042b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    for(int j = 0; j < 100; j++){
801042b6:	83 c0 04             	add    $0x4,%eax
801042b9:	39 d0                	cmp    %edx,%eax
801042bb:	75 f3                	jne    801042b0 <allocproc+0xd0>
  for(int i = 0; i < 100; i++){
801042bd:	81 c2 90 01 00 00    	add    $0x190,%edx
801042c3:	39 ca                	cmp    %ecx,%edx
801042c5:	75 dc                	jne    801042a3 <allocproc+0xc3>
    }
  }

  return p;
}
801042c7:	89 d8                	mov    %ebx,%eax
801042c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042cc:	c9                   	leave  
801042cd:	c3                   	ret    
  release(&ptable.lock);
801042ce:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801042d1:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
801042d3:	68 80 e5 11 80       	push   $0x8011e580
801042d8:	e8 53 10 00 00       	call   80105330 <release>
}
801042dd:	89 d8                	mov    %ebx,%eax
  return 0;
801042df:	83 c4 10             	add    $0x10,%esp
}
801042e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042e5:	c9                   	leave  
801042e6:	c3                   	ret    
    p->state = UNUSED;
801042e7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801042ee:	31 db                	xor    %ebx,%ebx
}
801042f0:	89 d8                	mov    %ebx,%eax
801042f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042f5:	c9                   	leave  
801042f6:	c3                   	ret    
801042f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042fe:	66 90                	xchg   %ax,%ax

80104300 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104300:	f3 0f 1e fb          	endbr32 
80104304:	55                   	push   %ebp
80104305:	89 e5                	mov    %esp,%ebp
80104307:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010430a:	68 80 e5 11 80       	push   $0x8011e580
8010430f:	e8 1c 10 00 00       	call   80105330 <release>

  if (first) {
80104314:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104319:	83 c4 10             	add    $0x10,%esp
8010431c:	85 c0                	test   %eax,%eax
8010431e:	75 08                	jne    80104328 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104320:	c9                   	leave  
80104321:	c3                   	ret    
80104322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80104328:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010432f:	00 00 00 
    iinit(ROOTDEV);
80104332:	83 ec 0c             	sub    $0xc,%esp
80104335:	6a 01                	push   $0x1
80104337:	e8 54 dc ff ff       	call   80101f90 <iinit>
    initlog(ROOTDEV);
8010433c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104343:	e8 98 f3 ff ff       	call   801036e0 <initlog>
}
80104348:	83 c4 10             	add    $0x10,%esp
8010434b:	c9                   	leave  
8010434c:	c3                   	ret    
8010434d:	8d 76 00             	lea    0x0(%esi),%esi

80104350 <pinit>:
{
80104350:	f3 0f 1e fb          	endbr32 
80104354:	55                   	push   %ebp
80104355:	89 e5                	mov    %esp,%ebp
80104357:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
8010435a:	68 c0 84 10 80       	push   $0x801084c0
8010435f:	68 80 e5 11 80       	push   $0x8011e580
80104364:	e8 87 0d 00 00       	call   801050f0 <initlock>
}
80104369:	83 c4 10             	add    $0x10,%esp
8010436c:	c9                   	leave  
8010436d:	c3                   	ret    
8010436e:	66 90                	xchg   %ax,%ax

80104370 <mycpu>:
{
80104370:	f3 0f 1e fb          	endbr32 
80104374:	55                   	push   %ebp
80104375:	89 e5                	mov    %esp,%ebp
80104377:	56                   	push   %esi
80104378:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104379:	9c                   	pushf  
8010437a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010437b:	f6 c4 02             	test   $0x2,%ah
8010437e:	75 4a                	jne    801043ca <mycpu+0x5a>
  apicid = lapicid();
80104380:	e8 6b ef ff ff       	call   801032f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104385:	8b 35 60 e5 11 80    	mov    0x8011e560,%esi
  apicid = lapicid();
8010438b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
8010438d:	85 f6                	test   %esi,%esi
8010438f:	7e 2c                	jle    801043bd <mycpu+0x4d>
80104391:	31 d2                	xor    %edx,%edx
80104393:	eb 0a                	jmp    8010439f <mycpu+0x2f>
80104395:	8d 76 00             	lea    0x0(%esi),%esi
80104398:	83 c2 01             	add    $0x1,%edx
8010439b:	39 f2                	cmp    %esi,%edx
8010439d:	74 1e                	je     801043bd <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
8010439f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801043a5:	0f b6 81 e0 df 11 80 	movzbl -0x7fee2020(%ecx),%eax
801043ac:	39 d8                	cmp    %ebx,%eax
801043ae:	75 e8                	jne    80104398 <mycpu+0x28>
}
801043b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801043b3:	8d 81 e0 df 11 80    	lea    -0x7fee2020(%ecx),%eax
}
801043b9:	5b                   	pop    %ebx
801043ba:	5e                   	pop    %esi
801043bb:	5d                   	pop    %ebp
801043bc:	c3                   	ret    
  panic("unknown apicid\n");
801043bd:	83 ec 0c             	sub    $0xc,%esp
801043c0:	68 c7 84 10 80       	push   $0x801084c7
801043c5:	e8 c6 bf ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801043ca:	83 ec 0c             	sub    $0xc,%esp
801043cd:	68 a4 85 10 80       	push   $0x801085a4
801043d2:	e8 b9 bf ff ff       	call   80100390 <panic>
801043d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043de:	66 90                	xchg   %ax,%ax

801043e0 <cpuid>:
cpuid() {
801043e0:	f3 0f 1e fb          	endbr32 
801043e4:	55                   	push   %ebp
801043e5:	89 e5                	mov    %esp,%ebp
801043e7:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801043ea:	e8 81 ff ff ff       	call   80104370 <mycpu>
}
801043ef:	c9                   	leave  
  return mycpu()-cpus;
801043f0:	2d e0 df 11 80       	sub    $0x8011dfe0,%eax
801043f5:	c1 f8 04             	sar    $0x4,%eax
801043f8:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801043fe:	c3                   	ret    
801043ff:	90                   	nop

80104400 <myproc>:
myproc(void) {
80104400:	f3 0f 1e fb          	endbr32 
80104404:	55                   	push   %ebp
80104405:	89 e5                	mov    %esp,%ebp
80104407:	53                   	push   %ebx
80104408:	83 ec 04             	sub    $0x4,%esp
  pushcli();
8010440b:	e8 60 0d 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104410:	e8 5b ff ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104415:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010441b:	e8 a0 0d 00 00       	call   801051c0 <popcli>
}
80104420:	83 c4 04             	add    $0x4,%esp
80104423:	89 d8                	mov    %ebx,%eax
80104425:	5b                   	pop    %ebx
80104426:	5d                   	pop    %ebp
80104427:	c3                   	ret    
80104428:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010442f:	90                   	nop

80104430 <userinit>:
{
80104430:	f3 0f 1e fb          	endbr32 
80104434:	55                   	push   %ebp
80104435:	89 e5                	mov    %esp,%ebp
80104437:	53                   	push   %ebx
80104438:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
8010443b:	e8 a0 fd ff ff       	call   801041e0 <allocproc>
80104440:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104442:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80104447:	e8 94 38 00 00       	call   80107ce0 <setupkvm>
8010444c:	89 43 04             	mov    %eax,0x4(%ebx)
8010444f:	85 c0                	test   %eax,%eax
80104451:	0f 84 bd 00 00 00    	je     80104514 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104457:	83 ec 04             	sub    $0x4,%esp
8010445a:	68 2c 00 00 00       	push   $0x2c
8010445f:	68 60 b4 10 80       	push   $0x8010b460
80104464:	50                   	push   %eax
80104465:	e8 46 35 00 00       	call   801079b0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
8010446a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010446d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104473:	6a 4c                	push   $0x4c
80104475:	6a 00                	push   $0x0
80104477:	ff 73 18             	pushl  0x18(%ebx)
8010447a:	e8 01 0f 00 00       	call   80105380 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010447f:	8b 43 18             	mov    0x18(%ebx),%eax
80104482:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104487:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010448a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010448f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104493:	8b 43 18             	mov    0x18(%ebx),%eax
80104496:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010449a:	8b 43 18             	mov    0x18(%ebx),%eax
8010449d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801044a1:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801044a5:	8b 43 18             	mov    0x18(%ebx),%eax
801044a8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801044ac:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801044b0:	8b 43 18             	mov    0x18(%ebx),%eax
801044b3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801044ba:	8b 43 18             	mov    0x18(%ebx),%eax
801044bd:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801044c4:	8b 43 18             	mov    0x18(%ebx),%eax
801044c7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801044ce:	8d 43 6c             	lea    0x6c(%ebx),%eax
801044d1:	6a 10                	push   $0x10
801044d3:	68 f0 84 10 80       	push   $0x801084f0
801044d8:	50                   	push   %eax
801044d9:	e8 62 10 00 00       	call   80105540 <safestrcpy>
  p->cwd = namei("/");
801044de:	c7 04 24 f9 84 10 80 	movl   $0x801084f9,(%esp)
801044e5:	e8 96 e5 ff ff       	call   80102a80 <namei>
801044ea:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801044ed:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
801044f4:	e8 77 0d 00 00       	call   80105270 <acquire>
  p->state = RUNNABLE;
801044f9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104500:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
80104507:	e8 24 0e 00 00       	call   80105330 <release>
}
8010450c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010450f:	83 c4 10             	add    $0x10,%esp
80104512:	c9                   	leave  
80104513:	c3                   	ret    
    panic("userinit: out of memory?");
80104514:	83 ec 0c             	sub    $0xc,%esp
80104517:	68 d7 84 10 80       	push   $0x801084d7
8010451c:	e8 6f be ff ff       	call   80100390 <panic>
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010452f:	90                   	nop

80104530 <growproc>:
{
80104530:	f3 0f 1e fb          	endbr32 
80104534:	55                   	push   %ebp
80104535:	89 e5                	mov    %esp,%ebp
80104537:	56                   	push   %esi
80104538:	53                   	push   %ebx
80104539:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010453c:	e8 2f 0c 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104541:	e8 2a fe ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104546:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010454c:	e8 6f 0c 00 00       	call   801051c0 <popcli>
  sz = curproc->sz;
80104551:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104553:	85 f6                	test   %esi,%esi
80104555:	7f 19                	jg     80104570 <growproc+0x40>
  } else if(n < 0){
80104557:	75 37                	jne    80104590 <growproc+0x60>
  switchuvm(curproc);
80104559:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
8010455c:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010455e:	53                   	push   %ebx
8010455f:	e8 3c 33 00 00       	call   801078a0 <switchuvm>
  return 0;
80104564:	83 c4 10             	add    $0x10,%esp
80104567:	31 c0                	xor    %eax,%eax
}
80104569:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010456c:	5b                   	pop    %ebx
8010456d:	5e                   	pop    %esi
8010456e:	5d                   	pop    %ebp
8010456f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104570:	83 ec 04             	sub    $0x4,%esp
80104573:	01 c6                	add    %eax,%esi
80104575:	56                   	push   %esi
80104576:	50                   	push   %eax
80104577:	ff 73 04             	pushl  0x4(%ebx)
8010457a:	e8 81 35 00 00       	call   80107b00 <allocuvm>
8010457f:	83 c4 10             	add    $0x10,%esp
80104582:	85 c0                	test   %eax,%eax
80104584:	75 d3                	jne    80104559 <growproc+0x29>
      return -1;
80104586:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010458b:	eb dc                	jmp    80104569 <growproc+0x39>
8010458d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104590:	83 ec 04             	sub    $0x4,%esp
80104593:	01 c6                	add    %eax,%esi
80104595:	56                   	push   %esi
80104596:	50                   	push   %eax
80104597:	ff 73 04             	pushl  0x4(%ebx)
8010459a:	e8 91 36 00 00       	call   80107c30 <deallocuvm>
8010459f:	83 c4 10             	add    $0x10,%esp
801045a2:	85 c0                	test   %eax,%eax
801045a4:	75 b3                	jne    80104559 <growproc+0x29>
801045a6:	eb de                	jmp    80104586 <growproc+0x56>
801045a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045af:	90                   	nop

801045b0 <fork>:
{
801045b0:	f3 0f 1e fb          	endbr32 
801045b4:	55                   	push   %ebp
801045b5:	89 e5                	mov    %esp,%ebp
801045b7:	57                   	push   %edi
801045b8:	56                   	push   %esi
801045b9:	53                   	push   %ebx
801045ba:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801045bd:	e8 ae 0b 00 00       	call   80105170 <pushcli>
  c = mycpu();
801045c2:	e8 a9 fd ff ff       	call   80104370 <mycpu>
  p = c->proc;
801045c7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045cd:	e8 ee 0b 00 00       	call   801051c0 <popcli>
  if((np = allocproc()) == 0){
801045d2:	e8 09 fc ff ff       	call   801041e0 <allocproc>
801045d7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801045da:	85 c0                	test   %eax,%eax
801045dc:	0f 84 bb 00 00 00    	je     8010469d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801045e2:	83 ec 08             	sub    $0x8,%esp
801045e5:	ff 33                	pushl  (%ebx)
801045e7:	89 c7                	mov    %eax,%edi
801045e9:	ff 73 04             	pushl  0x4(%ebx)
801045ec:	e8 bf 37 00 00       	call   80107db0 <copyuvm>
801045f1:	83 c4 10             	add    $0x10,%esp
801045f4:	89 47 04             	mov    %eax,0x4(%edi)
801045f7:	85 c0                	test   %eax,%eax
801045f9:	0f 84 a5 00 00 00    	je     801046a4 <fork+0xf4>
  np->sz = curproc->sz;
801045ff:	8b 03                	mov    (%ebx),%eax
80104601:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104604:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104606:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104609:	89 c8                	mov    %ecx,%eax
8010460b:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010460e:	b9 13 00 00 00       	mov    $0x13,%ecx
80104613:	8b 73 18             	mov    0x18(%ebx),%esi
80104616:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104618:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
8010461a:	8b 40 18             	mov    0x18(%eax),%eax
8010461d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80104628:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010462c:	85 c0                	test   %eax,%eax
8010462e:	74 13                	je     80104643 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104630:	83 ec 0c             	sub    $0xc,%esp
80104633:	50                   	push   %eax
80104634:	e8 87 d2 ff ff       	call   801018c0 <filedup>
80104639:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010463c:	83 c4 10             	add    $0x10,%esp
8010463f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104643:	83 c6 01             	add    $0x1,%esi
80104646:	83 fe 10             	cmp    $0x10,%esi
80104649:	75 dd                	jne    80104628 <fork+0x78>
  np->cwd = idup(curproc->cwd);
8010464b:	83 ec 0c             	sub    $0xc,%esp
8010464e:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104651:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104654:	e8 27 db ff ff       	call   80102180 <idup>
80104659:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010465c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010465f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104662:	8d 47 6c             	lea    0x6c(%edi),%eax
80104665:	6a 10                	push   $0x10
80104667:	53                   	push   %ebx
80104668:	50                   	push   %eax
80104669:	e8 d2 0e 00 00       	call   80105540 <safestrcpy>
  pid = np->pid;
8010466e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104671:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
80104678:	e8 f3 0b 00 00       	call   80105270 <acquire>
  np->state = RUNNABLE;
8010467d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104684:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
8010468b:	e8 a0 0c 00 00       	call   80105330 <release>
  return pid;
80104690:	83 c4 10             	add    $0x10,%esp
}
80104693:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104696:	89 d8                	mov    %ebx,%eax
80104698:	5b                   	pop    %ebx
80104699:	5e                   	pop    %esi
8010469a:	5f                   	pop    %edi
8010469b:	5d                   	pop    %ebp
8010469c:	c3                   	ret    
    return -1;
8010469d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801046a2:	eb ef                	jmp    80104693 <fork+0xe3>
    kfree(np->kstack);
801046a4:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801046a7:	83 ec 0c             	sub    $0xc,%esp
801046aa:	ff 73 08             	pushl  0x8(%ebx)
801046ad:	e8 0e e8 ff ff       	call   80102ec0 <kfree>
    np->kstack = 0;
801046b2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801046b9:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801046bc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801046c3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801046c8:	eb c9                	jmp    80104693 <fork+0xe3>
801046ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046d0 <scheduler>:
{
801046d0:	f3 0f 1e fb          	endbr32 
801046d4:	55                   	push   %ebp
801046d5:	89 e5                	mov    %esp,%ebp
801046d7:	57                   	push   %edi
801046d8:	56                   	push   %esi
801046d9:	53                   	push   %ebx
801046da:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801046dd:	e8 8e fc ff ff       	call   80104370 <mycpu>
  c->proc = 0;
801046e2:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801046e9:	00 00 00 
  struct cpu *c = mycpu();
801046ec:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801046ee:	8d 78 04             	lea    0x4(%eax),%edi
801046f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
801046f8:	fb                   	sti    
    acquire(&ptable.lock);
801046f9:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046fc:	bb b4 e5 11 80       	mov    $0x8011e5b4,%ebx
    acquire(&ptable.lock);
80104701:	68 80 e5 11 80       	push   $0x8011e580
80104706:	e8 65 0b 00 00       	call   80105270 <acquire>
8010470b:	83 c4 10             	add    $0x10,%esp
8010470e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104710:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104714:	75 33                	jne    80104749 <scheduler+0x79>
      switchuvm(p);
80104716:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104719:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010471f:	53                   	push   %ebx
80104720:	e8 7b 31 00 00       	call   801078a0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104725:	58                   	pop    %eax
80104726:	5a                   	pop    %edx
80104727:	ff 73 1c             	pushl  0x1c(%ebx)
8010472a:	57                   	push   %edi
      p->state = RUNNING;
8010472b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104732:	e8 6c 0e 00 00       	call   801055a3 <swtch>
      switchkvm();
80104737:	e8 44 31 00 00       	call   80107880 <switchkvm>
      c->proc = 0;
8010473c:	83 c4 10             	add    $0x10,%esp
8010473f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104746:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104749:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
8010474f:	81 fb b4 30 39 80    	cmp    $0x803930b4,%ebx
80104755:	75 b9                	jne    80104710 <scheduler+0x40>
    release(&ptable.lock);
80104757:	83 ec 0c             	sub    $0xc,%esp
8010475a:	68 80 e5 11 80       	push   $0x8011e580
8010475f:	e8 cc 0b 00 00       	call   80105330 <release>
    sti();
80104764:	83 c4 10             	add    $0x10,%esp
80104767:	eb 8f                	jmp    801046f8 <scheduler+0x28>
80104769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104770 <sched>:
{
80104770:	f3 0f 1e fb          	endbr32 
80104774:	55                   	push   %ebp
80104775:	89 e5                	mov    %esp,%ebp
80104777:	56                   	push   %esi
80104778:	53                   	push   %ebx
  pushcli();
80104779:	e8 f2 09 00 00       	call   80105170 <pushcli>
  c = mycpu();
8010477e:	e8 ed fb ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104783:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104789:	e8 32 0a 00 00       	call   801051c0 <popcli>
  if(!holding(&ptable.lock))
8010478e:	83 ec 0c             	sub    $0xc,%esp
80104791:	68 80 e5 11 80       	push   $0x8011e580
80104796:	e8 85 0a 00 00       	call   80105220 <holding>
8010479b:	83 c4 10             	add    $0x10,%esp
8010479e:	85 c0                	test   %eax,%eax
801047a0:	74 4f                	je     801047f1 <sched+0x81>
  if(mycpu()->ncli != 1)
801047a2:	e8 c9 fb ff ff       	call   80104370 <mycpu>
801047a7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801047ae:	75 68                	jne    80104818 <sched+0xa8>
  if(p->state == RUNNING)
801047b0:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801047b4:	74 55                	je     8010480b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801047b6:	9c                   	pushf  
801047b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801047b8:	f6 c4 02             	test   $0x2,%ah
801047bb:	75 41                	jne    801047fe <sched+0x8e>
  intena = mycpu()->intena;
801047bd:	e8 ae fb ff ff       	call   80104370 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801047c2:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801047c5:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801047cb:	e8 a0 fb ff ff       	call   80104370 <mycpu>
801047d0:	83 ec 08             	sub    $0x8,%esp
801047d3:	ff 70 04             	pushl  0x4(%eax)
801047d6:	53                   	push   %ebx
801047d7:	e8 c7 0d 00 00       	call   801055a3 <swtch>
  mycpu()->intena = intena;
801047dc:	e8 8f fb ff ff       	call   80104370 <mycpu>
}
801047e1:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801047e4:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801047ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047ed:	5b                   	pop    %ebx
801047ee:	5e                   	pop    %esi
801047ef:	5d                   	pop    %ebp
801047f0:	c3                   	ret    
    panic("sched ptable.lock");
801047f1:	83 ec 0c             	sub    $0xc,%esp
801047f4:	68 fb 84 10 80       	push   $0x801084fb
801047f9:	e8 92 bb ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801047fe:	83 ec 0c             	sub    $0xc,%esp
80104801:	68 27 85 10 80       	push   $0x80108527
80104806:	e8 85 bb ff ff       	call   80100390 <panic>
    panic("sched running");
8010480b:	83 ec 0c             	sub    $0xc,%esp
8010480e:	68 19 85 10 80       	push   $0x80108519
80104813:	e8 78 bb ff ff       	call   80100390 <panic>
    panic("sched locks");
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	68 0d 85 10 80       	push   $0x8010850d
80104820:	e8 6b bb ff ff       	call   80100390 <panic>
80104825:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104830 <exit>:
{
80104830:	f3 0f 1e fb          	endbr32 
80104834:	55                   	push   %ebp
80104835:	89 e5                	mov    %esp,%ebp
80104837:	57                   	push   %edi
80104838:	56                   	push   %esi
80104839:	53                   	push   %ebx
8010483a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010483d:	e8 2e 09 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104842:	e8 29 fb ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104847:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010484d:	e8 6e 09 00 00       	call   801051c0 <popcli>
  if(curproc == initproc)
80104852:	8d 73 28             	lea    0x28(%ebx),%esi
80104855:	8d 7b 68             	lea    0x68(%ebx),%edi
80104858:	39 1d b8 b5 10 80    	cmp    %ebx,0x8010b5b8
8010485e:	0f 84 3d 01 00 00    	je     801049a1 <exit+0x171>
80104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104868:	8b 06                	mov    (%esi),%eax
8010486a:	85 c0                	test   %eax,%eax
8010486c:	74 12                	je     80104880 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010486e:	83 ec 0c             	sub    $0xc,%esp
80104871:	50                   	push   %eax
80104872:	e8 99 d0 ff ff       	call   80101910 <fileclose>
      curproc->ofile[fd] = 0;
80104877:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010487d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104880:	83 c6 04             	add    $0x4,%esi
80104883:	39 fe                	cmp    %edi,%esi
80104885:	75 e1                	jne    80104868 <exit+0x38>
  begin_op();
80104887:	e8 f4 ee ff ff       	call   80103780 <begin_op>
  iput(curproc->cwd);
8010488c:	83 ec 0c             	sub    $0xc,%esp
8010488f:	ff 73 68             	pushl  0x68(%ebx)
80104892:	e8 49 da ff ff       	call   801022e0 <iput>
  end_op();
80104897:	e8 54 ef ff ff       	call   801037f0 <end_op>
  curproc->cwd = 0;
8010489c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801048a3:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
801048aa:	e8 c1 09 00 00       	call   80105270 <acquire>
  wakeup1(curproc->parent);
801048af:	8b 53 14             	mov    0x14(%ebx),%edx
801048b2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048b5:	b8 b4 e5 11 80       	mov    $0x8011e5b4,%eax
801048ba:	eb 10                	jmp    801048cc <exit+0x9c>
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048c0:	05 2c 9d 00 00       	add    $0x9d2c,%eax
801048c5:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
801048ca:	74 1e                	je     801048ea <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
801048cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801048d0:	75 ee                	jne    801048c0 <exit+0x90>
801048d2:	3b 50 20             	cmp    0x20(%eax),%edx
801048d5:	75 e9                	jne    801048c0 <exit+0x90>
      p->state = RUNNABLE;
801048d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048de:	05 2c 9d 00 00       	add    $0x9d2c,%eax
801048e3:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
801048e8:	75 e2                	jne    801048cc <exit+0x9c>
  wakeup1(curproc->waiting_processor);
801048ea:	8b 53 7c             	mov    0x7c(%ebx),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801048ed:	b8 b4 e5 11 80       	mov    $0x8011e5b4,%eax
801048f2:	eb 10                	jmp    80104904 <exit+0xd4>
801048f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048f8:	05 2c 9d 00 00       	add    $0x9d2c,%eax
801048fd:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104902:	74 1e                	je     80104922 <exit+0xf2>
    if(p->state == SLEEPING && p->chan == chan)
80104904:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104908:	75 ee                	jne    801048f8 <exit+0xc8>
8010490a:	3b 50 20             	cmp    0x20(%eax),%edx
8010490d:	75 e9                	jne    801048f8 <exit+0xc8>
      p->state = RUNNABLE;
8010490f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104916:	05 2c 9d 00 00       	add    $0x9d2c,%eax
8010491b:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104920:	75 e2                	jne    80104904 <exit+0xd4>
  curproc->waiting_processor = '\0';
80104922:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
      p->parent = initproc;
80104929:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010492f:	ba b4 e5 11 80       	mov    $0x8011e5b4,%edx
80104934:	eb 18                	jmp    8010494e <exit+0x11e>
80104936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493d:	8d 76 00             	lea    0x0(%esi),%esi
80104940:	81 c2 2c 9d 00 00    	add    $0x9d2c,%edx
80104946:	81 fa b4 30 39 80    	cmp    $0x803930b4,%edx
8010494c:	74 3a                	je     80104988 <exit+0x158>
    if(p->parent == curproc){
8010494e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104951:	75 ed                	jne    80104940 <exit+0x110>
      if(p->state == ZOMBIE)
80104953:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104957:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010495a:	75 e4                	jne    80104940 <exit+0x110>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010495c:	b8 b4 e5 11 80       	mov    $0x8011e5b4,%eax
80104961:	eb 11                	jmp    80104974 <exit+0x144>
80104963:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104967:	90                   	nop
80104968:	05 2c 9d 00 00       	add    $0x9d2c,%eax
8010496d:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104972:	74 cc                	je     80104940 <exit+0x110>
    if(p->state == SLEEPING && p->chan == chan)
80104974:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104978:	75 ee                	jne    80104968 <exit+0x138>
8010497a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010497d:	75 e9                	jne    80104968 <exit+0x138>
      p->state = RUNNABLE;
8010497f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104986:	eb e0                	jmp    80104968 <exit+0x138>
  curproc->state = ZOMBIE;
80104988:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010498f:	e8 dc fd ff ff       	call   80104770 <sched>
  panic("zombie exit");
80104994:	83 ec 0c             	sub    $0xc,%esp
80104997:	68 48 85 10 80       	push   $0x80108548
8010499c:	e8 ef b9 ff ff       	call   80100390 <panic>
    panic("init exiting");
801049a1:	83 ec 0c             	sub    $0xc,%esp
801049a4:	68 3b 85 10 80       	push   $0x8010853b
801049a9:	e8 e2 b9 ff ff       	call   80100390 <panic>
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <yield>:
{
801049b0:	f3 0f 1e fb          	endbr32 
801049b4:	55                   	push   %ebp
801049b5:	89 e5                	mov    %esp,%ebp
801049b7:	53                   	push   %ebx
801049b8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801049bb:	68 80 e5 11 80       	push   $0x8011e580
801049c0:	e8 ab 08 00 00       	call   80105270 <acquire>
  pushcli();
801049c5:	e8 a6 07 00 00       	call   80105170 <pushcli>
  c = mycpu();
801049ca:	e8 a1 f9 ff ff       	call   80104370 <mycpu>
  p = c->proc;
801049cf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801049d5:	e8 e6 07 00 00       	call   801051c0 <popcli>
  myproc()->state = RUNNABLE;
801049da:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801049e1:	e8 8a fd ff ff       	call   80104770 <sched>
  release(&ptable.lock);
801049e6:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
801049ed:	e8 3e 09 00 00       	call   80105330 <release>
}
801049f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f5:	83 c4 10             	add    $0x10,%esp
801049f8:	c9                   	leave  
801049f9:	c3                   	ret    
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <sleep>:
{
80104a00:	f3 0f 1e fb          	endbr32 
80104a04:	55                   	push   %ebp
80104a05:	89 e5                	mov    %esp,%ebp
80104a07:	57                   	push   %edi
80104a08:	56                   	push   %esi
80104a09:	53                   	push   %ebx
80104a0a:	83 ec 0c             	sub    $0xc,%esp
80104a0d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104a10:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104a13:	e8 58 07 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104a18:	e8 53 f9 ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104a1d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a23:	e8 98 07 00 00       	call   801051c0 <popcli>
  if(p == 0)
80104a28:	85 db                	test   %ebx,%ebx
80104a2a:	0f 84 83 00 00 00    	je     80104ab3 <sleep+0xb3>
  if(lk == 0)
80104a30:	85 f6                	test   %esi,%esi
80104a32:	74 72                	je     80104aa6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104a34:	81 fe 80 e5 11 80    	cmp    $0x8011e580,%esi
80104a3a:	74 4c                	je     80104a88 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104a3c:	83 ec 0c             	sub    $0xc,%esp
80104a3f:	68 80 e5 11 80       	push   $0x8011e580
80104a44:	e8 27 08 00 00       	call   80105270 <acquire>
    release(lk);
80104a49:	89 34 24             	mov    %esi,(%esp)
80104a4c:	e8 df 08 00 00       	call   80105330 <release>
  p->chan = chan;
80104a51:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104a54:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104a5b:	e8 10 fd ff ff       	call   80104770 <sched>
  p->chan = 0;
80104a60:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104a67:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
80104a6e:	e8 bd 08 00 00       	call   80105330 <release>
    acquire(lk);
80104a73:	89 75 08             	mov    %esi,0x8(%ebp)
80104a76:	83 c4 10             	add    $0x10,%esp
}
80104a79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a7c:	5b                   	pop    %ebx
80104a7d:	5e                   	pop    %esi
80104a7e:	5f                   	pop    %edi
80104a7f:	5d                   	pop    %ebp
    acquire(lk);
80104a80:	e9 eb 07 00 00       	jmp    80105270 <acquire>
80104a85:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104a88:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104a8b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104a92:	e8 d9 fc ff ff       	call   80104770 <sched>
  p->chan = 0;
80104a97:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104a9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104aa1:	5b                   	pop    %ebx
80104aa2:	5e                   	pop    %esi
80104aa3:	5f                   	pop    %edi
80104aa4:	5d                   	pop    %ebp
80104aa5:	c3                   	ret    
    panic("sleep without lk");
80104aa6:	83 ec 0c             	sub    $0xc,%esp
80104aa9:	68 5a 85 10 80       	push   $0x8010855a
80104aae:	e8 dd b8 ff ff       	call   80100390 <panic>
    panic("sleep");
80104ab3:	83 ec 0c             	sub    $0xc,%esp
80104ab6:	68 54 85 10 80       	push   $0x80108554
80104abb:	e8 d0 b8 ff ff       	call   80100390 <panic>

80104ac0 <wait>:
{
80104ac0:	f3 0f 1e fb          	endbr32 
80104ac4:	55                   	push   %ebp
80104ac5:	89 e5                	mov    %esp,%ebp
80104ac7:	56                   	push   %esi
80104ac8:	53                   	push   %ebx
  pushcli();
80104ac9:	e8 a2 06 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104ace:	e8 9d f8 ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104ad3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104ad9:	e8 e2 06 00 00       	call   801051c0 <popcli>
  acquire(&ptable.lock);
80104ade:	83 ec 0c             	sub    $0xc,%esp
80104ae1:	68 80 e5 11 80       	push   $0x8011e580
80104ae6:	e8 85 07 00 00       	call   80105270 <acquire>
80104aeb:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104aee:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104af0:	bb b4 e5 11 80       	mov    $0x8011e5b4,%ebx
80104af5:	eb 17                	jmp    80104b0e <wait+0x4e>
80104af7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104afe:	66 90                	xchg   %ax,%ax
80104b00:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
80104b06:	81 fb b4 30 39 80    	cmp    $0x803930b4,%ebx
80104b0c:	74 1e                	je     80104b2c <wait+0x6c>
      if(p->parent != curproc)
80104b0e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104b11:	75 ed                	jne    80104b00 <wait+0x40>
      if(p->state == ZOMBIE){
80104b13:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104b17:	74 37                	je     80104b50 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b19:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
      havekids = 1;
80104b1f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b24:	81 fb b4 30 39 80    	cmp    $0x803930b4,%ebx
80104b2a:	75 e2                	jne    80104b0e <wait+0x4e>
    if(!havekids || curproc->killed){
80104b2c:	85 c0                	test   %eax,%eax
80104b2e:	74 76                	je     80104ba6 <wait+0xe6>
80104b30:	8b 46 24             	mov    0x24(%esi),%eax
80104b33:	85 c0                	test   %eax,%eax
80104b35:	75 6f                	jne    80104ba6 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104b37:	83 ec 08             	sub    $0x8,%esp
80104b3a:	68 80 e5 11 80       	push   $0x8011e580
80104b3f:	56                   	push   %esi
80104b40:	e8 bb fe ff ff       	call   80104a00 <sleep>
    havekids = 0;
80104b45:	83 c4 10             	add    $0x10,%esp
80104b48:	eb a4                	jmp    80104aee <wait+0x2e>
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104b50:	83 ec 0c             	sub    $0xc,%esp
80104b53:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104b56:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104b59:	e8 62 e3 ff ff       	call   80102ec0 <kfree>
        freevm(p->pgdir);
80104b5e:	5a                   	pop    %edx
80104b5f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104b62:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104b69:	e8 f2 30 00 00       	call   80107c60 <freevm>
        release(&ptable.lock);
80104b6e:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
        p->pid = 0;
80104b75:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104b7c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104b83:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104b87:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104b8e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104b95:	e8 96 07 00 00       	call   80105330 <release>
        return pid;
80104b9a:	83 c4 10             	add    $0x10,%esp
}
80104b9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ba0:	89 f0                	mov    %esi,%eax
80104ba2:	5b                   	pop    %ebx
80104ba3:	5e                   	pop    %esi
80104ba4:	5d                   	pop    %ebp
80104ba5:	c3                   	ret    
      release(&ptable.lock);
80104ba6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104ba9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104bae:	68 80 e5 11 80       	push   $0x8011e580
80104bb3:	e8 78 07 00 00       	call   80105330 <release>
      return -1;
80104bb8:	83 c4 10             	add    $0x10,%esp
80104bbb:	eb e0                	jmp    80104b9d <wait+0xdd>
80104bbd:	8d 76 00             	lea    0x0(%esi),%esi

80104bc0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104bc0:	f3 0f 1e fb          	endbr32 
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	53                   	push   %ebx
80104bc8:	83 ec 10             	sub    $0x10,%esp
80104bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104bce:	68 80 e5 11 80       	push   $0x8011e580
80104bd3:	e8 98 06 00 00       	call   80105270 <acquire>
80104bd8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104bdb:	b8 b4 e5 11 80       	mov    $0x8011e5b4,%eax
80104be0:	eb 12                	jmp    80104bf4 <wakeup+0x34>
80104be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104be8:	05 2c 9d 00 00       	add    $0x9d2c,%eax
80104bed:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104bf2:	74 1e                	je     80104c12 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104bf4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104bf8:	75 ee                	jne    80104be8 <wakeup+0x28>
80104bfa:	3b 58 20             	cmp    0x20(%eax),%ebx
80104bfd:	75 e9                	jne    80104be8 <wakeup+0x28>
      p->state = RUNNABLE;
80104bff:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c06:	05 2c 9d 00 00       	add    $0x9d2c,%eax
80104c0b:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104c10:	75 e2                	jne    80104bf4 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104c12:	c7 45 08 80 e5 11 80 	movl   $0x8011e580,0x8(%ebp)
}
80104c19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c1c:	c9                   	leave  
  release(&ptable.lock);
80104c1d:	e9 0e 07 00 00       	jmp    80105330 <release>
80104c22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c30 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104c30:	f3 0f 1e fb          	endbr32 
80104c34:	55                   	push   %ebp
80104c35:	89 e5                	mov    %esp,%ebp
80104c37:	53                   	push   %ebx
80104c38:	83 ec 10             	sub    $0x10,%esp
80104c3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104c3e:	68 80 e5 11 80       	push   $0x8011e580
80104c43:	e8 28 06 00 00       	call   80105270 <acquire>
80104c48:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c4b:	b8 b4 e5 11 80       	mov    $0x8011e5b4,%eax
80104c50:	eb 12                	jmp    80104c64 <kill+0x34>
80104c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c58:	05 2c 9d 00 00       	add    $0x9d2c,%eax
80104c5d:	3d b4 30 39 80       	cmp    $0x803930b4,%eax
80104c62:	74 34                	je     80104c98 <kill+0x68>
    if(p->pid == pid){
80104c64:	39 58 10             	cmp    %ebx,0x10(%eax)
80104c67:	75 ef                	jne    80104c58 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104c69:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104c6d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104c74:	75 07                	jne    80104c7d <kill+0x4d>
        p->state = RUNNABLE;
80104c76:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104c7d:	83 ec 0c             	sub    $0xc,%esp
80104c80:	68 80 e5 11 80       	push   $0x8011e580
80104c85:	e8 a6 06 00 00       	call   80105330 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104c8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104c8d:	83 c4 10             	add    $0x10,%esp
80104c90:	31 c0                	xor    %eax,%eax
}
80104c92:	c9                   	leave  
80104c93:	c3                   	ret    
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104c98:	83 ec 0c             	sub    $0xc,%esp
80104c9b:	68 80 e5 11 80       	push   $0x8011e580
80104ca0:	e8 8b 06 00 00       	call   80105330 <release>
}
80104ca5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ca8:	83 c4 10             	add    $0x10,%esp
80104cab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cb0:	c9                   	leave  
80104cb1:	c3                   	ret    
80104cb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104cc0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104cc0:	f3 0f 1e fb          	endbr32 
80104cc4:	55                   	push   %ebp
80104cc5:	89 e5                	mov    %esp,%ebp
80104cc7:	57                   	push   %edi
80104cc8:	56                   	push   %esi
80104cc9:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104ccc:	53                   	push   %ebx
80104ccd:	bb 20 e6 11 80       	mov    $0x8011e620,%ebx
80104cd2:	83 ec 3c             	sub    $0x3c,%esp
80104cd5:	eb 2b                	jmp    80104d02 <procdump+0x42>
80104cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cde:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ce0:	83 ec 0c             	sub    $0xc,%esp
80104ce3:	68 37 89 10 80       	push   $0x80108937
80104ce8:	e8 03 ba ff ff       	call   801006f0 <cprintf>
80104ced:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cf0:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
80104cf6:	81 fb 20 31 39 80    	cmp    $0x80393120,%ebx
80104cfc:	0f 84 8e 00 00 00    	je     80104d90 <procdump+0xd0>
    if(p->state == UNUSED)
80104d02:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104d05:	85 c0                	test   %eax,%eax
80104d07:	74 e7                	je     80104cf0 <procdump+0x30>
      state = "???";
80104d09:	ba 6b 85 10 80       	mov    $0x8010856b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d0e:	83 f8 05             	cmp    $0x5,%eax
80104d11:	77 11                	ja     80104d24 <procdump+0x64>
80104d13:	8b 14 85 cc 85 10 80 	mov    -0x7fef7a34(,%eax,4),%edx
      state = "???";
80104d1a:	b8 6b 85 10 80       	mov    $0x8010856b,%eax
80104d1f:	85 d2                	test   %edx,%edx
80104d21:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104d24:	53                   	push   %ebx
80104d25:	52                   	push   %edx
80104d26:	ff 73 a4             	pushl  -0x5c(%ebx)
80104d29:	68 6f 85 10 80       	push   $0x8010856f
80104d2e:	e8 bd b9 ff ff       	call   801006f0 <cprintf>
    if(p->state == SLEEPING){
80104d33:	83 c4 10             	add    $0x10,%esp
80104d36:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104d3a:	75 a4                	jne    80104ce0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104d3c:	83 ec 08             	sub    $0x8,%esp
80104d3f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104d42:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104d45:	50                   	push   %eax
80104d46:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104d49:	8b 40 0c             	mov    0xc(%eax),%eax
80104d4c:	83 c0 08             	add    $0x8,%eax
80104d4f:	50                   	push   %eax
80104d50:	e8 bb 03 00 00       	call   80105110 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d55:	83 c4 10             	add    $0x10,%esp
80104d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5f:	90                   	nop
80104d60:	8b 17                	mov    (%edi),%edx
80104d62:	85 d2                	test   %edx,%edx
80104d64:	0f 84 76 ff ff ff    	je     80104ce0 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104d6a:	83 ec 08             	sub    $0x8,%esp
80104d6d:	83 c7 04             	add    $0x4,%edi
80104d70:	52                   	push   %edx
80104d71:	68 c1 7f 10 80       	push   $0x80107fc1
80104d76:	e8 75 b9 ff ff       	call   801006f0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d7b:	83 c4 10             	add    $0x10,%esp
80104d7e:	39 fe                	cmp    %edi,%esi
80104d80:	75 de                	jne    80104d60 <procdump+0xa0>
80104d82:	e9 59 ff ff ff       	jmp    80104ce0 <procdump+0x20>
80104d87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8e:	66 90                	xchg   %ax,%ax
  }
}
80104d90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d93:	5b                   	pop    %ebx
80104d94:	5e                   	pop    %esi
80104d95:	5f                   	pop    %edi
80104d96:	5d                   	pop    %ebp
80104d97:	c3                   	ret    
80104d98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d9f:	90                   	nop

80104da0 <wait_for_process>:

int wait_for_process(int pid) {
80104da0:	f3 0f 1e fb          	endbr32 
80104da4:	55                   	push   %ebp
80104da5:	89 e5                	mov    %esp,%ebp
80104da7:	57                   	push   %edi
80104da8:	56                   	push   %esi
80104da9:	53                   	push   %ebx
80104daa:	83 ec 1c             	sub    $0x1c,%esp
80104dad:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104db0:	e8 bb 03 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104db5:	e8 b6 f5 ff ff       	call   80104370 <mycpu>
  p = c->proc;
80104dba:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104dc0:	e8 fb 03 00 00       	call   801051c0 <popcli>
  struct proc *p;
  struct proc *curproc = myproc();
  int pidFound = 0;

  acquire(&ptable.lock);
80104dc5:	83 ec 0c             	sub    $0xc,%esp
80104dc8:	68 80 e5 11 80       	push   $0x8011e580
80104dcd:	e8 9e 04 00 00       	call   80105270 <acquire>
80104dd2:	83 c4 10             	add    $0x10,%esp
  int pidFound = 0;
80104dd5:	31 c0                	xor    %eax,%eax

  for(;;) {
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104dd7:	bb b4 e5 11 80       	mov    $0x8011e5b4,%ebx
80104ddc:	eb 15                	jmp    80104df3 <wait_for_process+0x53>
80104dde:	66 90                	xchg   %ax,%ax
      if (p->pid != pid){
        continue;
      }
      p->waiting_processor = curproc;
      pidFound = 1;
80104de0:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104de5:	81 c3 2c 9d 00 00    	add    $0x9d2c,%ebx
80104deb:	81 fb b4 30 39 80    	cmp    $0x803930b4,%ebx
80104df1:	74 65                	je     80104e58 <wait_for_process+0xb8>
      if (p->pid != pid){
80104df3:	39 73 10             	cmp    %esi,0x10(%ebx)
80104df6:	75 ed                	jne    80104de5 <wait_for_process+0x45>
      if (p->state == ZOMBIE) {
80104df8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
      p->waiting_processor = curproc;
80104dfc:	89 7b 7c             	mov    %edi,0x7c(%ebx)
      if (p->state == ZOMBIE) {
80104dff:	75 df                	jne    80104de0 <wait_for_process+0x40>

        kfree(p->kstack);
80104e01:	83 ec 0c             	sub    $0xc,%esp
80104e04:	ff 73 08             	pushl  0x8(%ebx)
80104e07:	e8 b4 e0 ff ff       	call   80102ec0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104e0c:	59                   	pop    %ecx
80104e0d:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104e10:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104e17:	e8 44 2e 00 00       	call   80107c60 <freevm>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80104e1c:	c7 04 24 80 e5 11 80 	movl   $0x8011e580,(%esp)
        p->pid = 0;
80104e23:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104e2a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104e31:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104e35:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104e3c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104e43:	e8 e8 04 00 00       	call   80105330 <release>
        return pid;
80104e48:	83 c4 10             	add    $0x10,%esp
80104e4b:	89 f0                	mov    %esi,%eax
      return -1;
    }

    sleep(curproc, &ptable.lock); // DOC: wait-sleep
  }
}
80104e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e50:	5b                   	pop    %ebx
80104e51:	5e                   	pop    %esi
80104e52:	5f                   	pop    %edi
80104e53:	5d                   	pop    %ebp
80104e54:	c3                   	ret    
80104e55:	8d 76 00             	lea    0x0(%esi),%esi
    if (!pidFound || curproc->killed) {
80104e58:	85 c0                	test   %eax,%eax
80104e5a:	74 23                	je     80104e7f <wait_for_process+0xdf>
80104e5c:	8b 57 24             	mov    0x24(%edi),%edx
80104e5f:	85 d2                	test   %edx,%edx
80104e61:	75 1c                	jne    80104e7f <wait_for_process+0xdf>
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
80104e63:	83 ec 08             	sub    $0x8,%esp
80104e66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104e69:	68 80 e5 11 80       	push   $0x8011e580
80104e6e:	57                   	push   %edi
80104e6f:	e8 8c fb ff ff       	call   80104a00 <sleep>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104e74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104e77:	83 c4 10             	add    $0x10,%esp
80104e7a:	e9 58 ff ff ff       	jmp    80104dd7 <wait_for_process+0x37>
      release(&ptable.lock);
80104e7f:	83 ec 0c             	sub    $0xc,%esp
80104e82:	68 80 e5 11 80       	push   $0x8011e580
80104e87:	e8 a4 04 00 00       	call   80105330 <release>
      return -1;
80104e8c:	83 c4 10             	add    $0x10,%esp
80104e8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e94:	eb b7                	jmp    80104e4d <wait_for_process+0xad>
80104e96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi

80104ea0 <isPrime>:

//util function
int isPrime(int n)
{
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
    // Corner cases
    if (n <= 1)  return 0;
80104ea5:	31 d2                	xor    %edx,%edx
{
80104ea7:	89 e5                	mov    %esp,%ebp
80104ea9:	56                   	push   %esi
80104eaa:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104ead:	53                   	push   %ebx
    if (n <= 1)  return 0;
80104eae:	83 f9 01             	cmp    $0x1,%ecx
80104eb1:	0f 8e a1 00 00 00    	jle    80104f58 <isPrime+0xb8>
    if (n <= 3)  return 1;
80104eb7:	ba 01 00 00 00       	mov    $0x1,%edx
80104ebc:	83 f9 03             	cmp    $0x3,%ecx
80104ebf:	0f 8e 93 00 00 00    	jle    80104f58 <isPrime+0xb8>
    if (n <= 1)  return 0;
80104ec5:	31 d2                	xor    %edx,%edx

    // This is checked so that we can skip
    // middle five numbers in below loop
    if (n%2 == 0 || n%3 == 0) return 0;
80104ec7:	f6 c1 01             	test   $0x1,%cl
80104eca:	0f 84 88 00 00 00    	je     80104f58 <isPrime+0xb8>
80104ed0:	89 c8                	mov    %ecx,%eax
80104ed2:	ba 56 55 55 55       	mov    $0x55555556,%edx
80104ed7:	89 cb                	mov    %ecx,%ebx
80104ed9:	f7 ea                	imul   %edx
80104edb:	c1 fb 1f             	sar    $0x1f,%ebx
80104ede:	29 da                	sub    %ebx,%edx
80104ee0:	8d 04 52             	lea    (%edx,%edx,2),%eax
80104ee3:	89 ca                	mov    %ecx,%edx
80104ee5:	29 c2                	sub    %eax,%edx
80104ee7:	74 6f                	je     80104f58 <isPrime+0xb8>

    for (int i=5; i*i<=n; i=i+6)
80104ee9:	83 f9 18             	cmp    $0x18,%ecx
80104eec:	7e 65                	jle    80104f53 <isPrime+0xb3>
        if (n%i == 0 || n%(i+2) == 0)
80104eee:	89 c8                	mov    %ecx,%eax
80104ef0:	ba 67 66 66 66       	mov    $0x66666667,%edx
80104ef5:	f7 ea                	imul   %edx
80104ef7:	d1 fa                	sar    %edx
80104ef9:	29 da                	sub    %ebx,%edx
80104efb:	8d 04 92             	lea    (%edx,%edx,4),%eax
80104efe:	89 ca                	mov    %ecx,%edx
80104f00:	29 c2                	sub    %eax,%edx
80104f02:	74 54                	je     80104f58 <isPrime+0xb8>
80104f04:	89 c8                	mov    %ecx,%eax
80104f06:	ba 93 24 49 92       	mov    $0x92492493,%edx
80104f0b:	f7 ea                	imul   %edx
80104f0d:	01 ca                	add    %ecx,%edx
80104f0f:	c1 fa 02             	sar    $0x2,%edx
80104f12:	29 da                	sub    %ebx,%edx
80104f14:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
80104f1b:	29 d0                	sub    %edx,%eax
80104f1d:	89 ca                	mov    %ecx,%edx
80104f1f:	29 c2                	sub    %eax,%edx
80104f21:	74 35                	je     80104f58 <isPrime+0xb8>
    for (int i=5; i*i<=n; i=i+6)
80104f23:	bb 05 00 00 00       	mov    $0x5,%ebx
80104f28:	eb 1b                	jmp    80104f45 <isPrime+0xa5>
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (n%i == 0 || n%(i+2) == 0)
80104f30:	89 c8                	mov    %ecx,%eax
80104f32:	99                   	cltd   
80104f33:	f7 fb                	idiv   %ebx
80104f35:	85 d2                	test   %edx,%edx
80104f37:	74 1f                	je     80104f58 <isPrime+0xb8>
80104f39:	89 c8                	mov    %ecx,%eax
80104f3b:	83 c6 08             	add    $0x8,%esi
80104f3e:	99                   	cltd   
80104f3f:	f7 fe                	idiv   %esi
80104f41:	85 d2                	test   %edx,%edx
80104f43:	74 13                	je     80104f58 <isPrime+0xb8>
    for (int i=5; i*i<=n; i=i+6)
80104f45:	89 de                	mov    %ebx,%esi
80104f47:	83 c3 06             	add    $0x6,%ebx
80104f4a:	89 d8                	mov    %ebx,%eax
80104f4c:	0f af c3             	imul   %ebx,%eax
80104f4f:	39 c1                	cmp    %eax,%ecx
80104f51:	7d dd                	jge    80104f30 <isPrime+0x90>
    if (n <= 3)  return 1;
80104f53:	ba 01 00 00 00       	mov    $0x1,%edx
           return 0;

    return 1;
}
80104f58:	5b                   	pop    %ebx
80104f59:	89 d0                	mov    %edx,%eax
80104f5b:	5e                   	pop    %esi
80104f5c:	5d                   	pop    %ebp
80104f5d:	c3                   	ret    
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <find_next_prime_number>:

int find_next_prime_number(int n)
{
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
80104f65:	89 e5                	mov    %esp,%ebp
80104f67:	53                   	push   %ebx
80104f68:	83 ec 04             	sub    $0x4,%esp
80104f6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    // Base case
    if (n <= 1)
80104f6e:	83 fb 01             	cmp    $0x1,%ebx
80104f71:	7e 25                	jle    80104f98 <find_next_prime_number+0x38>
80104f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f77:	90                   	nop
    // Loop continuously until isPrime returns
    // 1 for a number greater than n
    while (!found) {
        prime++;

        if (isPrime(prime))
80104f78:	83 ec 0c             	sub    $0xc,%esp
        prime++;
80104f7b:	83 c3 01             	add    $0x1,%ebx
        if (isPrime(prime))
80104f7e:	53                   	push   %ebx
80104f7f:	e8 1c ff ff ff       	call   80104ea0 <isPrime>
80104f84:	83 c4 10             	add    $0x10,%esp
80104f87:	85 c0                	test   %eax,%eax
80104f89:	74 ed                	je     80104f78 <find_next_prime_number+0x18>
            found = 1;
    }

    return prime;
80104f8b:	89 d8                	mov    %ebx,%eax
80104f8d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f90:	c9                   	leave  
80104f91:	c3                   	ret    
80104f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return 2;
80104f98:	bb 02 00 00 00       	mov    $0x2,%ebx
80104f9d:	89 d8                	mov    %ebx,%eax
80104f9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fa2:	c9                   	leave  
80104fa3:	c3                   	ret    
80104fa4:	66 90                	xchg   %ax,%ax
80104fa6:	66 90                	xchg   %ax,%ax
80104fa8:	66 90                	xchg   %ax,%ax
80104faa:	66 90                	xchg   %ax,%ax
80104fac:	66 90                	xchg   %ax,%ax
80104fae:	66 90                	xchg   %ax,%ax

80104fb0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104fb0:	f3 0f 1e fb          	endbr32 
80104fb4:	55                   	push   %ebp
80104fb5:	89 e5                	mov    %esp,%ebp
80104fb7:	53                   	push   %ebx
80104fb8:	83 ec 0c             	sub    $0xc,%esp
80104fbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104fbe:	68 e4 85 10 80       	push   $0x801085e4
80104fc3:	8d 43 04             	lea    0x4(%ebx),%eax
80104fc6:	50                   	push   %eax
80104fc7:	e8 24 01 00 00       	call   801050f0 <initlock>
  lk->name = name;
80104fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104fcf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104fd5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104fd8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104fdf:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104fe2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fe5:	c9                   	leave  
80104fe6:	c3                   	ret    
80104fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fee:	66 90                	xchg   %ax,%ax

80104ff0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104ff0:	f3 0f 1e fb          	endbr32 
80104ff4:	55                   	push   %ebp
80104ff5:	89 e5                	mov    %esp,%ebp
80104ff7:	56                   	push   %esi
80104ff8:	53                   	push   %ebx
80104ff9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ffc:	8d 73 04             	lea    0x4(%ebx),%esi
80104fff:	83 ec 0c             	sub    $0xc,%esp
80105002:	56                   	push   %esi
80105003:	e8 68 02 00 00       	call   80105270 <acquire>
  while (lk->locked) {
80105008:	8b 13                	mov    (%ebx),%edx
8010500a:	83 c4 10             	add    $0x10,%esp
8010500d:	85 d2                	test   %edx,%edx
8010500f:	74 1a                	je     8010502b <acquiresleep+0x3b>
80105011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105018:	83 ec 08             	sub    $0x8,%esp
8010501b:	56                   	push   %esi
8010501c:	53                   	push   %ebx
8010501d:	e8 de f9 ff ff       	call   80104a00 <sleep>
  while (lk->locked) {
80105022:	8b 03                	mov    (%ebx),%eax
80105024:	83 c4 10             	add    $0x10,%esp
80105027:	85 c0                	test   %eax,%eax
80105029:	75 ed                	jne    80105018 <acquiresleep+0x28>
  }
  lk->locked = 1;
8010502b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105031:	e8 ca f3 ff ff       	call   80104400 <myproc>
80105036:	8b 40 10             	mov    0x10(%eax),%eax
80105039:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
8010503c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010503f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105042:	5b                   	pop    %ebx
80105043:	5e                   	pop    %esi
80105044:	5d                   	pop    %ebp
  release(&lk->lk);
80105045:	e9 e6 02 00 00       	jmp    80105330 <release>
8010504a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105050 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105050:	f3 0f 1e fb          	endbr32 
80105054:	55                   	push   %ebp
80105055:	89 e5                	mov    %esp,%ebp
80105057:	56                   	push   %esi
80105058:	53                   	push   %ebx
80105059:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010505c:	8d 73 04             	lea    0x4(%ebx),%esi
8010505f:	83 ec 0c             	sub    $0xc,%esp
80105062:	56                   	push   %esi
80105063:	e8 08 02 00 00       	call   80105270 <acquire>
  lk->locked = 0;
80105068:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010506e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105075:	89 1c 24             	mov    %ebx,(%esp)
80105078:	e8 43 fb ff ff       	call   80104bc0 <wakeup>
  release(&lk->lk);
8010507d:	89 75 08             	mov    %esi,0x8(%ebp)
80105080:	83 c4 10             	add    $0x10,%esp
}
80105083:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105086:	5b                   	pop    %ebx
80105087:	5e                   	pop    %esi
80105088:	5d                   	pop    %ebp
  release(&lk->lk);
80105089:	e9 a2 02 00 00       	jmp    80105330 <release>
8010508e:	66 90                	xchg   %ax,%ax

80105090 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105090:	f3 0f 1e fb          	endbr32 
80105094:	55                   	push   %ebp
80105095:	89 e5                	mov    %esp,%ebp
80105097:	57                   	push   %edi
80105098:	31 ff                	xor    %edi,%edi
8010509a:	56                   	push   %esi
8010509b:	53                   	push   %ebx
8010509c:	83 ec 18             	sub    $0x18,%esp
8010509f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801050a2:	8d 73 04             	lea    0x4(%ebx),%esi
801050a5:	56                   	push   %esi
801050a6:	e8 c5 01 00 00       	call   80105270 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801050ab:	8b 03                	mov    (%ebx),%eax
801050ad:	83 c4 10             	add    $0x10,%esp
801050b0:	85 c0                	test   %eax,%eax
801050b2:	75 1c                	jne    801050d0 <holdingsleep+0x40>
  release(&lk->lk);
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	56                   	push   %esi
801050b8:	e8 73 02 00 00       	call   80105330 <release>
  return r;
}
801050bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050c0:	89 f8                	mov    %edi,%eax
801050c2:	5b                   	pop    %ebx
801050c3:	5e                   	pop    %esi
801050c4:	5f                   	pop    %edi
801050c5:	5d                   	pop    %ebp
801050c6:	c3                   	ret    
801050c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ce:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
801050d0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801050d3:	e8 28 f3 ff ff       	call   80104400 <myproc>
801050d8:	39 58 10             	cmp    %ebx,0x10(%eax)
801050db:	0f 94 c0             	sete   %al
801050de:	0f b6 c0             	movzbl %al,%eax
801050e1:	89 c7                	mov    %eax,%edi
801050e3:	eb cf                	jmp    801050b4 <holdingsleep+0x24>
801050e5:	66 90                	xchg   %ax,%ax
801050e7:	66 90                	xchg   %ax,%ax
801050e9:	66 90                	xchg   %ax,%ax
801050eb:	66 90                	xchg   %ax,%ax
801050ed:	66 90                	xchg   %ax,%ax
801050ef:	90                   	nop

801050f0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050f0:	f3 0f 1e fb          	endbr32 
801050f4:	55                   	push   %ebp
801050f5:	89 e5                	mov    %esp,%ebp
801050f7:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801050fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801050fd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80105103:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105106:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010510d:	5d                   	pop    %ebp
8010510e:	c3                   	ret    
8010510f:	90                   	nop

80105110 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105110:	f3 0f 1e fb          	endbr32 
80105114:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105115:	31 d2                	xor    %edx,%edx
{
80105117:	89 e5                	mov    %esp,%ebp
80105119:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010511a:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010511d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80105120:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80105123:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105127:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105128:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010512e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105134:	77 1a                	ja     80105150 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105136:	8b 58 04             	mov    0x4(%eax),%ebx
80105139:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010513c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
8010513f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105141:	83 fa 0a             	cmp    $0xa,%edx
80105144:	75 e2                	jne    80105128 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80105146:	5b                   	pop    %ebx
80105147:	5d                   	pop    %ebp
80105148:	c3                   	ret    
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105150:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105153:	8d 51 28             	lea    0x28(%ecx),%edx
80105156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105160:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105166:	83 c0 04             	add    $0x4,%eax
80105169:	39 d0                	cmp    %edx,%eax
8010516b:	75 f3                	jne    80105160 <getcallerpcs+0x50>
}
8010516d:	5b                   	pop    %ebx
8010516e:	5d                   	pop    %ebp
8010516f:	c3                   	ret    

80105170 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105170:	f3 0f 1e fb          	endbr32 
80105174:	55                   	push   %ebp
80105175:	89 e5                	mov    %esp,%ebp
80105177:	53                   	push   %ebx
80105178:	83 ec 04             	sub    $0x4,%esp
8010517b:	9c                   	pushf  
8010517c:	5b                   	pop    %ebx
  asm volatile("cli");
8010517d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010517e:	e8 ed f1 ff ff       	call   80104370 <mycpu>
80105183:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105189:	85 c0                	test   %eax,%eax
8010518b:	74 13                	je     801051a0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
8010518d:	e8 de f1 ff ff       	call   80104370 <mycpu>
80105192:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105199:	83 c4 04             	add    $0x4,%esp
8010519c:	5b                   	pop    %ebx
8010519d:	5d                   	pop    %ebp
8010519e:	c3                   	ret    
8010519f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
801051a0:	e8 cb f1 ff ff       	call   80104370 <mycpu>
801051a5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801051ab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801051b1:	eb da                	jmp    8010518d <pushcli+0x1d>
801051b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051c0 <popcli>:

void
popcli(void)
{
801051c0:	f3 0f 1e fb          	endbr32 
801051c4:	55                   	push   %ebp
801051c5:	89 e5                	mov    %esp,%ebp
801051c7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801051ca:	9c                   	pushf  
801051cb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801051cc:	f6 c4 02             	test   $0x2,%ah
801051cf:	75 31                	jne    80105202 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801051d1:	e8 9a f1 ff ff       	call   80104370 <mycpu>
801051d6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801051dd:	78 30                	js     8010520f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801051df:	e8 8c f1 ff ff       	call   80104370 <mycpu>
801051e4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801051ea:	85 d2                	test   %edx,%edx
801051ec:	74 02                	je     801051f0 <popcli+0x30>
    sti();
}
801051ee:	c9                   	leave  
801051ef:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
801051f0:	e8 7b f1 ff ff       	call   80104370 <mycpu>
801051f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801051fb:	85 c0                	test   %eax,%eax
801051fd:	74 ef                	je     801051ee <popcli+0x2e>
  asm volatile("sti");
801051ff:	fb                   	sti    
}
80105200:	c9                   	leave  
80105201:	c3                   	ret    
    panic("popcli - interruptible");
80105202:	83 ec 0c             	sub    $0xc,%esp
80105205:	68 ef 85 10 80       	push   $0x801085ef
8010520a:	e8 81 b1 ff ff       	call   80100390 <panic>
    panic("popcli");
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	68 06 86 10 80       	push   $0x80108606
80105217:	e8 74 b1 ff ff       	call   80100390 <panic>
8010521c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105220 <holding>:
{
80105220:	f3 0f 1e fb          	endbr32 
80105224:	55                   	push   %ebp
80105225:	89 e5                	mov    %esp,%ebp
80105227:	56                   	push   %esi
80105228:	53                   	push   %ebx
80105229:	8b 75 08             	mov    0x8(%ebp),%esi
8010522c:	31 db                	xor    %ebx,%ebx
  pushcli();
8010522e:	e8 3d ff ff ff       	call   80105170 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105233:	8b 06                	mov    (%esi),%eax
80105235:	85 c0                	test   %eax,%eax
80105237:	75 0f                	jne    80105248 <holding+0x28>
  popcli();
80105239:	e8 82 ff ff ff       	call   801051c0 <popcli>
}
8010523e:	89 d8                	mov    %ebx,%eax
80105240:	5b                   	pop    %ebx
80105241:	5e                   	pop    %esi
80105242:	5d                   	pop    %ebp
80105243:	c3                   	ret    
80105244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80105248:	8b 5e 08             	mov    0x8(%esi),%ebx
8010524b:	e8 20 f1 ff ff       	call   80104370 <mycpu>
80105250:	39 c3                	cmp    %eax,%ebx
80105252:	0f 94 c3             	sete   %bl
  popcli();
80105255:	e8 66 ff ff ff       	call   801051c0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010525a:	0f b6 db             	movzbl %bl,%ebx
}
8010525d:	89 d8                	mov    %ebx,%eax
8010525f:	5b                   	pop    %ebx
80105260:	5e                   	pop    %esi
80105261:	5d                   	pop    %ebp
80105262:	c3                   	ret    
80105263:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105270 <acquire>:
{
80105270:	f3 0f 1e fb          	endbr32 
80105274:	55                   	push   %ebp
80105275:	89 e5                	mov    %esp,%ebp
80105277:	56                   	push   %esi
80105278:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105279:	e8 f2 fe ff ff       	call   80105170 <pushcli>
  if(holding(lk))
8010527e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105281:	83 ec 0c             	sub    $0xc,%esp
80105284:	53                   	push   %ebx
80105285:	e8 96 ff ff ff       	call   80105220 <holding>
8010528a:	83 c4 10             	add    $0x10,%esp
8010528d:	85 c0                	test   %eax,%eax
8010528f:	0f 85 7f 00 00 00    	jne    80105314 <acquire+0xa4>
80105295:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105297:	ba 01 00 00 00       	mov    $0x1,%edx
8010529c:	eb 05                	jmp    801052a3 <acquire+0x33>
8010529e:	66 90                	xchg   %ax,%ax
801052a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052a3:	89 d0                	mov    %edx,%eax
801052a5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801052a8:	85 c0                	test   %eax,%eax
801052aa:	75 f4                	jne    801052a0 <acquire+0x30>
  __sync_synchronize();
801052ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801052b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052b4:	e8 b7 f0 ff ff       	call   80104370 <mycpu>
801052b9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801052bc:	89 e8                	mov    %ebp,%eax
801052be:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801052c0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801052c6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
801052cc:	77 22                	ja     801052f0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801052ce:	8b 50 04             	mov    0x4(%eax),%edx
801052d1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
801052d5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801052d8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801052da:	83 fe 0a             	cmp    $0xa,%esi
801052dd:	75 e1                	jne    801052c0 <acquire+0x50>
}
801052df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052e2:	5b                   	pop    %ebx
801052e3:	5e                   	pop    %esi
801052e4:	5d                   	pop    %ebp
801052e5:	c3                   	ret    
801052e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ed:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
801052f0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
801052f4:	83 c3 34             	add    $0x34,%ebx
801052f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052fe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105300:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105306:	83 c0 04             	add    $0x4,%eax
80105309:	39 d8                	cmp    %ebx,%eax
8010530b:	75 f3                	jne    80105300 <acquire+0x90>
}
8010530d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105310:	5b                   	pop    %ebx
80105311:	5e                   	pop    %esi
80105312:	5d                   	pop    %ebp
80105313:	c3                   	ret    
    panic("acquire");
80105314:	83 ec 0c             	sub    $0xc,%esp
80105317:	68 0d 86 10 80       	push   $0x8010860d
8010531c:	e8 6f b0 ff ff       	call   80100390 <panic>
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105328:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010532f:	90                   	nop

80105330 <release>:
{
80105330:	f3 0f 1e fb          	endbr32 
80105334:	55                   	push   %ebp
80105335:	89 e5                	mov    %esp,%ebp
80105337:	53                   	push   %ebx
80105338:	83 ec 10             	sub    $0x10,%esp
8010533b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010533e:	53                   	push   %ebx
8010533f:	e8 dc fe ff ff       	call   80105220 <holding>
80105344:	83 c4 10             	add    $0x10,%esp
80105347:	85 c0                	test   %eax,%eax
80105349:	74 22                	je     8010536d <release+0x3d>
  lk->pcs[0] = 0;
8010534b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105352:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105359:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010535e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105364:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105367:	c9                   	leave  
  popcli();
80105368:	e9 53 fe ff ff       	jmp    801051c0 <popcli>
    panic("release");
8010536d:	83 ec 0c             	sub    $0xc,%esp
80105370:	68 15 86 10 80       	push   $0x80108615
80105375:	e8 16 b0 ff ff       	call   80100390 <panic>
8010537a:	66 90                	xchg   %ax,%ax
8010537c:	66 90                	xchg   %ax,%ax
8010537e:	66 90                	xchg   %ax,%ax

80105380 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105380:	f3 0f 1e fb          	endbr32 
80105384:	55                   	push   %ebp
80105385:	89 e5                	mov    %esp,%ebp
80105387:	57                   	push   %edi
80105388:	8b 55 08             	mov    0x8(%ebp),%edx
8010538b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010538e:	53                   	push   %ebx
8010538f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80105392:	89 d7                	mov    %edx,%edi
80105394:	09 cf                	or     %ecx,%edi
80105396:	83 e7 03             	and    $0x3,%edi
80105399:	75 25                	jne    801053c0 <memset+0x40>
    c &= 0xFF;
8010539b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010539e:	c1 e0 18             	shl    $0x18,%eax
801053a1:	89 fb                	mov    %edi,%ebx
801053a3:	c1 e9 02             	shr    $0x2,%ecx
801053a6:	c1 e3 10             	shl    $0x10,%ebx
801053a9:	09 d8                	or     %ebx,%eax
801053ab:	09 f8                	or     %edi,%eax
801053ad:	c1 e7 08             	shl    $0x8,%edi
801053b0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801053b2:	89 d7                	mov    %edx,%edi
801053b4:	fc                   	cld    
801053b5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801053b7:	5b                   	pop    %ebx
801053b8:	89 d0                	mov    %edx,%eax
801053ba:	5f                   	pop    %edi
801053bb:	5d                   	pop    %ebp
801053bc:	c3                   	ret    
801053bd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
801053c0:	89 d7                	mov    %edx,%edi
801053c2:	fc                   	cld    
801053c3:	f3 aa                	rep stos %al,%es:(%edi)
801053c5:	5b                   	pop    %ebx
801053c6:	89 d0                	mov    %edx,%eax
801053c8:	5f                   	pop    %edi
801053c9:	5d                   	pop    %ebp
801053ca:	c3                   	ret    
801053cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053cf:	90                   	nop

801053d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801053d0:	f3 0f 1e fb          	endbr32 
801053d4:	55                   	push   %ebp
801053d5:	89 e5                	mov    %esp,%ebp
801053d7:	56                   	push   %esi
801053d8:	8b 75 10             	mov    0x10(%ebp),%esi
801053db:	8b 55 08             	mov    0x8(%ebp),%edx
801053de:	53                   	push   %ebx
801053df:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801053e2:	85 f6                	test   %esi,%esi
801053e4:	74 2a                	je     80105410 <memcmp+0x40>
801053e6:	01 c6                	add    %eax,%esi
801053e8:	eb 10                	jmp    801053fa <memcmp+0x2a>
801053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801053f0:	83 c0 01             	add    $0x1,%eax
801053f3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801053f6:	39 f0                	cmp    %esi,%eax
801053f8:	74 16                	je     80105410 <memcmp+0x40>
    if(*s1 != *s2)
801053fa:	0f b6 0a             	movzbl (%edx),%ecx
801053fd:	0f b6 18             	movzbl (%eax),%ebx
80105400:	38 d9                	cmp    %bl,%cl
80105402:	74 ec                	je     801053f0 <memcmp+0x20>
      return *s1 - *s2;
80105404:	0f b6 c1             	movzbl %cl,%eax
80105407:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105409:	5b                   	pop    %ebx
8010540a:	5e                   	pop    %esi
8010540b:	5d                   	pop    %ebp
8010540c:	c3                   	ret    
8010540d:	8d 76 00             	lea    0x0(%esi),%esi
80105410:	5b                   	pop    %ebx
  return 0;
80105411:	31 c0                	xor    %eax,%eax
}
80105413:	5e                   	pop    %esi
80105414:	5d                   	pop    %ebp
80105415:	c3                   	ret    
80105416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010541d:	8d 76 00             	lea    0x0(%esi),%esi

80105420 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105420:	f3 0f 1e fb          	endbr32 
80105424:	55                   	push   %ebp
80105425:	89 e5                	mov    %esp,%ebp
80105427:	57                   	push   %edi
80105428:	8b 55 08             	mov    0x8(%ebp),%edx
8010542b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010542e:	56                   	push   %esi
8010542f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105432:	39 d6                	cmp    %edx,%esi
80105434:	73 2a                	jae    80105460 <memmove+0x40>
80105436:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105439:	39 fa                	cmp    %edi,%edx
8010543b:	73 23                	jae    80105460 <memmove+0x40>
8010543d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105440:	85 c9                	test   %ecx,%ecx
80105442:	74 13                	je     80105457 <memmove+0x37>
80105444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80105448:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010544c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
8010544f:	83 e8 01             	sub    $0x1,%eax
80105452:	83 f8 ff             	cmp    $0xffffffff,%eax
80105455:	75 f1                	jne    80105448 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105457:	5e                   	pop    %esi
80105458:	89 d0                	mov    %edx,%eax
8010545a:	5f                   	pop    %edi
8010545b:	5d                   	pop    %ebp
8010545c:	c3                   	ret    
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80105460:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105463:	89 d7                	mov    %edx,%edi
80105465:	85 c9                	test   %ecx,%ecx
80105467:	74 ee                	je     80105457 <memmove+0x37>
80105469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105470:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105471:	39 f0                	cmp    %esi,%eax
80105473:	75 fb                	jne    80105470 <memmove+0x50>
}
80105475:	5e                   	pop    %esi
80105476:	89 d0                	mov    %edx,%eax
80105478:	5f                   	pop    %edi
80105479:	5d                   	pop    %ebp
8010547a:	c3                   	ret    
8010547b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010547f:	90                   	nop

80105480 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105480:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80105484:	eb 9a                	jmp    80105420 <memmove>
80105486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010548d:	8d 76 00             	lea    0x0(%esi),%esi

80105490 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105490:	f3 0f 1e fb          	endbr32 
80105494:	55                   	push   %ebp
80105495:	89 e5                	mov    %esp,%ebp
80105497:	56                   	push   %esi
80105498:	8b 75 10             	mov    0x10(%ebp),%esi
8010549b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010549e:	53                   	push   %ebx
8010549f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801054a2:	85 f6                	test   %esi,%esi
801054a4:	74 32                	je     801054d8 <strncmp+0x48>
801054a6:	01 c6                	add    %eax,%esi
801054a8:	eb 14                	jmp    801054be <strncmp+0x2e>
801054aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054b0:	38 da                	cmp    %bl,%dl
801054b2:	75 14                	jne    801054c8 <strncmp+0x38>
    n--, p++, q++;
801054b4:	83 c0 01             	add    $0x1,%eax
801054b7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801054ba:	39 f0                	cmp    %esi,%eax
801054bc:	74 1a                	je     801054d8 <strncmp+0x48>
801054be:	0f b6 11             	movzbl (%ecx),%edx
801054c1:	0f b6 18             	movzbl (%eax),%ebx
801054c4:	84 d2                	test   %dl,%dl
801054c6:	75 e8                	jne    801054b0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801054c8:	0f b6 c2             	movzbl %dl,%eax
801054cb:	29 d8                	sub    %ebx,%eax
}
801054cd:	5b                   	pop    %ebx
801054ce:	5e                   	pop    %esi
801054cf:	5d                   	pop    %ebp
801054d0:	c3                   	ret    
801054d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054d8:	5b                   	pop    %ebx
    return 0;
801054d9:	31 c0                	xor    %eax,%eax
}
801054db:	5e                   	pop    %esi
801054dc:	5d                   	pop    %ebp
801054dd:	c3                   	ret    
801054de:	66 90                	xchg   %ax,%ax

801054e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801054e0:	f3 0f 1e fb          	endbr32 
801054e4:	55                   	push   %ebp
801054e5:	89 e5                	mov    %esp,%ebp
801054e7:	57                   	push   %edi
801054e8:	56                   	push   %esi
801054e9:	8b 75 08             	mov    0x8(%ebp),%esi
801054ec:	53                   	push   %ebx
801054ed:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801054f0:	89 f2                	mov    %esi,%edx
801054f2:	eb 1b                	jmp    8010550f <strncpy+0x2f>
801054f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054f8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801054fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801054ff:	83 c2 01             	add    $0x1,%edx
80105502:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105506:	89 f9                	mov    %edi,%ecx
80105508:	88 4a ff             	mov    %cl,-0x1(%edx)
8010550b:	84 c9                	test   %cl,%cl
8010550d:	74 09                	je     80105518 <strncpy+0x38>
8010550f:	89 c3                	mov    %eax,%ebx
80105511:	83 e8 01             	sub    $0x1,%eax
80105514:	85 db                	test   %ebx,%ebx
80105516:	7f e0                	jg     801054f8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105518:	89 d1                	mov    %edx,%ecx
8010551a:	85 c0                	test   %eax,%eax
8010551c:	7e 15                	jle    80105533 <strncpy+0x53>
8010551e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80105520:	83 c1 01             	add    $0x1,%ecx
80105523:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80105527:	89 c8                	mov    %ecx,%eax
80105529:	f7 d0                	not    %eax
8010552b:	01 d0                	add    %edx,%eax
8010552d:	01 d8                	add    %ebx,%eax
8010552f:	85 c0                	test   %eax,%eax
80105531:	7f ed                	jg     80105520 <strncpy+0x40>
  return os;
}
80105533:	5b                   	pop    %ebx
80105534:	89 f0                	mov    %esi,%eax
80105536:	5e                   	pop    %esi
80105537:	5f                   	pop    %edi
80105538:	5d                   	pop    %ebp
80105539:	c3                   	ret    
8010553a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105540 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105540:	f3 0f 1e fb          	endbr32 
80105544:	55                   	push   %ebp
80105545:	89 e5                	mov    %esp,%ebp
80105547:	56                   	push   %esi
80105548:	8b 55 10             	mov    0x10(%ebp),%edx
8010554b:	8b 75 08             	mov    0x8(%ebp),%esi
8010554e:	53                   	push   %ebx
8010554f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105552:	85 d2                	test   %edx,%edx
80105554:	7e 21                	jle    80105577 <safestrcpy+0x37>
80105556:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010555a:	89 f2                	mov    %esi,%edx
8010555c:	eb 12                	jmp    80105570 <safestrcpy+0x30>
8010555e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105560:	0f b6 08             	movzbl (%eax),%ecx
80105563:	83 c0 01             	add    $0x1,%eax
80105566:	83 c2 01             	add    $0x1,%edx
80105569:	88 4a ff             	mov    %cl,-0x1(%edx)
8010556c:	84 c9                	test   %cl,%cl
8010556e:	74 04                	je     80105574 <safestrcpy+0x34>
80105570:	39 d8                	cmp    %ebx,%eax
80105572:	75 ec                	jne    80105560 <safestrcpy+0x20>
    ;
  *s = 0;
80105574:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105577:	89 f0                	mov    %esi,%eax
80105579:	5b                   	pop    %ebx
8010557a:	5e                   	pop    %esi
8010557b:	5d                   	pop    %ebp
8010557c:	c3                   	ret    
8010557d:	8d 76 00             	lea    0x0(%esi),%esi

80105580 <strlen>:

int
strlen(const char *s)
{
80105580:	f3 0f 1e fb          	endbr32 
80105584:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105585:	31 c0                	xor    %eax,%eax
{
80105587:	89 e5                	mov    %esp,%ebp
80105589:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
8010558c:	80 3a 00             	cmpb   $0x0,(%edx)
8010558f:	74 10                	je     801055a1 <strlen+0x21>
80105591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105598:	83 c0 01             	add    $0x1,%eax
8010559b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
8010559f:	75 f7                	jne    80105598 <strlen+0x18>
    ;
  return n;
}
801055a1:	5d                   	pop    %ebp
801055a2:	c3                   	ret    

801055a3 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801055a3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801055a7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801055ab:	55                   	push   %ebp
  pushl %ebx
801055ac:	53                   	push   %ebx
  pushl %esi
801055ad:	56                   	push   %esi
  pushl %edi
801055ae:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801055af:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801055b1:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801055b3:	5f                   	pop    %edi
  popl %esi
801055b4:	5e                   	pop    %esi
  popl %ebx
801055b5:	5b                   	pop    %ebx
  popl %ebp
801055b6:	5d                   	pop    %ebp
  ret
801055b7:	c3                   	ret    
801055b8:	66 90                	xchg   %ax,%ax
801055ba:	66 90                	xchg   %ax,%ax
801055bc:	66 90                	xchg   %ax,%ax
801055be:	66 90                	xchg   %ax,%ax

801055c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801055c0:	f3 0f 1e fb          	endbr32 
801055c4:	55                   	push   %ebp
801055c5:	89 e5                	mov    %esp,%ebp
801055c7:	53                   	push   %ebx
801055c8:	83 ec 04             	sub    $0x4,%esp
801055cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801055ce:	e8 2d ee ff ff       	call   80104400 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055d3:	8b 00                	mov    (%eax),%eax
801055d5:	39 d8                	cmp    %ebx,%eax
801055d7:	76 17                	jbe    801055f0 <fetchint+0x30>
801055d9:	8d 53 04             	lea    0x4(%ebx),%edx
801055dc:	39 d0                	cmp    %edx,%eax
801055de:	72 10                	jb     801055f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801055e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801055e3:	8b 13                	mov    (%ebx),%edx
801055e5:	89 10                	mov    %edx,(%eax)
  return 0;
801055e7:	31 c0                	xor    %eax,%eax
}
801055e9:	83 c4 04             	add    $0x4,%esp
801055ec:	5b                   	pop    %ebx
801055ed:	5d                   	pop    %ebp
801055ee:	c3                   	ret    
801055ef:	90                   	nop
    return -1;
801055f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055f5:	eb f2                	jmp    801055e9 <fetchint+0x29>
801055f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055fe:	66 90                	xchg   %ax,%ax

80105600 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105600:	f3 0f 1e fb          	endbr32 
80105604:	55                   	push   %ebp
80105605:	89 e5                	mov    %esp,%ebp
80105607:	53                   	push   %ebx
80105608:	83 ec 04             	sub    $0x4,%esp
8010560b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010560e:	e8 ed ed ff ff       	call   80104400 <myproc>

  if(addr >= curproc->sz)
80105613:	39 18                	cmp    %ebx,(%eax)
80105615:	76 31                	jbe    80105648 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105617:	8b 55 0c             	mov    0xc(%ebp),%edx
8010561a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010561c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010561e:	39 d3                	cmp    %edx,%ebx
80105620:	73 26                	jae    80105648 <fetchstr+0x48>
80105622:	89 d8                	mov    %ebx,%eax
80105624:	eb 11                	jmp    80105637 <fetchstr+0x37>
80105626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
80105630:	83 c0 01             	add    $0x1,%eax
80105633:	39 c2                	cmp    %eax,%edx
80105635:	76 11                	jbe    80105648 <fetchstr+0x48>
    if(*s == 0)
80105637:	80 38 00             	cmpb   $0x0,(%eax)
8010563a:	75 f4                	jne    80105630 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010563c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010563f:	29 d8                	sub    %ebx,%eax
}
80105641:	5b                   	pop    %ebx
80105642:	5d                   	pop    %ebp
80105643:	c3                   	ret    
80105644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105648:	83 c4 04             	add    $0x4,%esp
    return -1;
8010564b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105650:	5b                   	pop    %ebx
80105651:	5d                   	pop    %ebp
80105652:	c3                   	ret    
80105653:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010565a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105660 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105660:	f3 0f 1e fb          	endbr32 
80105664:	55                   	push   %ebp
80105665:	89 e5                	mov    %esp,%ebp
80105667:	56                   	push   %esi
80105668:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105669:	e8 92 ed ff ff       	call   80104400 <myproc>
8010566e:	8b 55 08             	mov    0x8(%ebp),%edx
80105671:	8b 40 18             	mov    0x18(%eax),%eax
80105674:	8b 40 44             	mov    0x44(%eax),%eax
80105677:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010567a:	e8 81 ed ff ff       	call   80104400 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010567f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105682:	8b 00                	mov    (%eax),%eax
80105684:	39 c6                	cmp    %eax,%esi
80105686:	73 18                	jae    801056a0 <argint+0x40>
80105688:	8d 53 08             	lea    0x8(%ebx),%edx
8010568b:	39 d0                	cmp    %edx,%eax
8010568d:	72 11                	jb     801056a0 <argint+0x40>
  *ip = *(int*)(addr);
8010568f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105692:	8b 53 04             	mov    0x4(%ebx),%edx
80105695:	89 10                	mov    %edx,(%eax)
  return 0;
80105697:	31 c0                	xor    %eax,%eax
}
80105699:	5b                   	pop    %ebx
8010569a:	5e                   	pop    %esi
8010569b:	5d                   	pop    %ebp
8010569c:	c3                   	ret    
8010569d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801056a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056a5:	eb f2                	jmp    80105699 <argint+0x39>
801056a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ae:	66 90                	xchg   %ax,%ax

801056b0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801056b0:	f3 0f 1e fb          	endbr32 
801056b4:	55                   	push   %ebp
801056b5:	89 e5                	mov    %esp,%ebp
801056b7:	56                   	push   %esi
801056b8:	53                   	push   %ebx
801056b9:	83 ec 10             	sub    $0x10,%esp
801056bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801056bf:	e8 3c ed ff ff       	call   80104400 <myproc>
 
  if(argint(n, &i) < 0)
801056c4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801056c7:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801056c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056cc:	50                   	push   %eax
801056cd:	ff 75 08             	pushl  0x8(%ebp)
801056d0:	e8 8b ff ff ff       	call   80105660 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801056d5:	83 c4 10             	add    $0x10,%esp
801056d8:	85 c0                	test   %eax,%eax
801056da:	78 24                	js     80105700 <argptr+0x50>
801056dc:	85 db                	test   %ebx,%ebx
801056de:	78 20                	js     80105700 <argptr+0x50>
801056e0:	8b 16                	mov    (%esi),%edx
801056e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056e5:	39 c2                	cmp    %eax,%edx
801056e7:	76 17                	jbe    80105700 <argptr+0x50>
801056e9:	01 c3                	add    %eax,%ebx
801056eb:	39 da                	cmp    %ebx,%edx
801056ed:	72 11                	jb     80105700 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801056ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801056f2:	89 02                	mov    %eax,(%edx)
  return 0;
801056f4:	31 c0                	xor    %eax,%eax
}
801056f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056f9:	5b                   	pop    %ebx
801056fa:	5e                   	pop    %esi
801056fb:	5d                   	pop    %ebp
801056fc:	c3                   	ret    
801056fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105700:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105705:	eb ef                	jmp    801056f6 <argptr+0x46>
80105707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010570e:	66 90                	xchg   %ax,%ax

80105710 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105710:	f3 0f 1e fb          	endbr32 
80105714:	55                   	push   %ebp
80105715:	89 e5                	mov    %esp,%ebp
80105717:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010571a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010571d:	50                   	push   %eax
8010571e:	ff 75 08             	pushl  0x8(%ebp)
80105721:	e8 3a ff ff ff       	call   80105660 <argint>
80105726:	83 c4 10             	add    $0x10,%esp
80105729:	85 c0                	test   %eax,%eax
8010572b:	78 13                	js     80105740 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010572d:	83 ec 08             	sub    $0x8,%esp
80105730:	ff 75 0c             	pushl  0xc(%ebp)
80105733:	ff 75 f4             	pushl  -0xc(%ebp)
80105736:	e8 c5 fe ff ff       	call   80105600 <fetchstr>
8010573b:	83 c4 10             	add    $0x10,%esp
}
8010573e:	c9                   	leave  
8010573f:	c3                   	ret    
80105740:	c9                   	leave  
    return -1;
80105741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105746:	c3                   	ret    
80105747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574e:	66 90                	xchg   %ax,%ax

80105750 <syscall>:
};

int caller_count[100][100] = {0};
void
syscall(void)
{
80105750:	f3 0f 1e fb          	endbr32 
80105754:	55                   	push   %ebp
80105755:	89 e5                	mov    %esp,%ebp
80105757:	57                   	push   %edi
80105758:	56                   	push   %esi
80105759:	53                   	push   %ebx
8010575a:	83 ec 0c             	sub    $0xc,%esp
  int num;
  struct proc *curproc = myproc();
8010575d:	e8 9e ec ff ff       	call   80104400 <myproc>

  num = curproc->tf->eax;
  curproc->callcount[num - 1] = curproc->callcount[num - 1] + 1;
  
  caller_count[num - 1][curproc->pid] = caller_count[num - 1][curproc->pid] + 1;
80105762:	b9 90 01 00 00       	mov    $0x190,%ecx
  struct proc *curproc = myproc();
80105767:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80105769:	8b 40 18             	mov    0x18(%eax),%eax
8010576c:	8b 70 1c             	mov    0x1c(%eax),%esi
  curproc->callcount[num - 1] = curproc->callcount[num - 1] + 1;
8010576f:	8d 7e ff             	lea    -0x1(%esi),%edi
80105772:	83 44 b3 7c 01       	addl   $0x1,0x7c(%ebx,%esi,4)
  caller_count[num - 1][curproc->pid] = caller_count[num - 1][curproc->pid] + 1;
80105777:	6b c7 64             	imul   $0x64,%edi,%eax
8010577a:	03 43 10             	add    0x10(%ebx),%eax
8010577d:	83 04 85 c0 b5 10 80 	addl   $0x1,-0x7fef4a40(,%eax,4)
80105784:	01 

  for(int i = 0;i < 100; i++){
    for (int j = 0; j < 100; j++){
80105785:	8d 81 70 fe ff ff    	lea    -0x190(%ecx),%eax
8010578b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010578f:	90                   	nop
        curproc->caller_count[i][j] = caller_count[i][j];
80105790:	8b 90 c0 b5 10 80    	mov    -0x7fef4a40(%eax),%edx
80105796:	89 94 03 ec 00 00 00 	mov    %edx,0xec(%ebx,%eax,1)
    for (int j = 0; j < 100; j++){
8010579d:	83 c0 04             	add    $0x4,%eax
801057a0:	39 c8                	cmp    %ecx,%eax
801057a2:	75 ec                	jne    80105790 <syscall+0x40>
  for(int i = 0;i < 100; i++){
801057a4:	8d 88 90 01 00 00    	lea    0x190(%eax),%ecx
801057aa:	3d 40 9c 00 00       	cmp    $0x9c40,%eax
801057af:	75 d4                	jne    80105785 <syscall+0x35>
    }
  }

  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801057b1:	83 ff 1c             	cmp    $0x1c,%edi
801057b4:	77 1d                	ja     801057d3 <syscall+0x83>
801057b6:	8b 04 b5 40 86 10 80 	mov    -0x7fef79c0(,%esi,4),%eax
801057bd:	85 c0                	test   %eax,%eax
801057bf:	74 12                	je     801057d3 <syscall+0x83>
    curproc->tf->eax = syscalls[num]();
801057c1:	ff d0                	call   *%eax
801057c3:	89 c2                	mov    %eax,%edx
801057c5:	8b 43 18             	mov    0x18(%ebx),%eax
801057c8:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801057cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057ce:	5b                   	pop    %ebx
801057cf:	5e                   	pop    %esi
801057d0:	5f                   	pop    %edi
801057d1:	5d                   	pop    %ebp
801057d2:	c3                   	ret    
            curproc->pid, curproc->name, num);
801057d3:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801057d6:	56                   	push   %esi
801057d7:	50                   	push   %eax
801057d8:	ff 73 10             	pushl  0x10(%ebx)
801057db:	68 1d 86 10 80       	push   $0x8010861d
801057e0:	e8 0b af ff ff       	call   801006f0 <cprintf>
    curproc->tf->eax = -1;
801057e5:	8b 43 18             	mov    0x18(%ebx),%eax
801057e8:	83 c4 10             	add    $0x10,%esp
801057eb:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801057f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057f5:	5b                   	pop    %ebx
801057f6:	5e                   	pop    %esi
801057f7:	5f                   	pop    %edi
801057f8:	5d                   	pop    %ebp
801057f9:	c3                   	ret    
801057fa:	66 90                	xchg   %ax,%ax
801057fc:	66 90                	xchg   %ax,%ax
801057fe:	66 90                	xchg   %ax,%ax

80105800 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105805:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105808:	53                   	push   %ebx
80105809:	83 ec 34             	sub    $0x34,%esp
8010580c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010580f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105812:	57                   	push   %edi
80105813:	50                   	push   %eax
{
80105814:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105817:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010581a:	e8 81 d2 ff ff       	call   80102aa0 <nameiparent>
8010581f:	83 c4 10             	add    $0x10,%esp
80105822:	85 c0                	test   %eax,%eax
80105824:	0f 84 46 01 00 00    	je     80105970 <create+0x170>
    return 0;
  ilock(dp);
8010582a:	83 ec 0c             	sub    $0xc,%esp
8010582d:	89 c3                	mov    %eax,%ebx
8010582f:	50                   	push   %eax
80105830:	e8 7b c9 ff ff       	call   801021b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105835:	83 c4 0c             	add    $0xc,%esp
80105838:	6a 00                	push   $0x0
8010583a:	57                   	push   %edi
8010583b:	53                   	push   %ebx
8010583c:	e8 bf ce ff ff       	call   80102700 <dirlookup>
80105841:	83 c4 10             	add    $0x10,%esp
80105844:	89 c6                	mov    %eax,%esi
80105846:	85 c0                	test   %eax,%eax
80105848:	74 56                	je     801058a0 <create+0xa0>
    iunlockput(dp);
8010584a:	83 ec 0c             	sub    $0xc,%esp
8010584d:	53                   	push   %ebx
8010584e:	e8 fd cb ff ff       	call   80102450 <iunlockput>
    ilock(ip);
80105853:	89 34 24             	mov    %esi,(%esp)
80105856:	e8 55 c9 ff ff       	call   801021b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010585b:	83 c4 10             	add    $0x10,%esp
8010585e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105863:	75 1b                	jne    80105880 <create+0x80>
80105865:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010586a:	75 14                	jne    80105880 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010586c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010586f:	89 f0                	mov    %esi,%eax
80105871:	5b                   	pop    %ebx
80105872:	5e                   	pop    %esi
80105873:	5f                   	pop    %edi
80105874:	5d                   	pop    %ebp
80105875:	c3                   	ret    
80105876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010587d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105880:	83 ec 0c             	sub    $0xc,%esp
80105883:	56                   	push   %esi
    return 0;
80105884:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105886:	e8 c5 cb ff ff       	call   80102450 <iunlockput>
    return 0;
8010588b:	83 c4 10             	add    $0x10,%esp
}
8010588e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105891:	89 f0                	mov    %esi,%eax
80105893:	5b                   	pop    %ebx
80105894:	5e                   	pop    %esi
80105895:	5f                   	pop    %edi
80105896:	5d                   	pop    %ebp
80105897:	c3                   	ret    
80105898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801058a0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801058a4:	83 ec 08             	sub    $0x8,%esp
801058a7:	50                   	push   %eax
801058a8:	ff 33                	pushl  (%ebx)
801058aa:	e8 81 c7 ff ff       	call   80102030 <ialloc>
801058af:	83 c4 10             	add    $0x10,%esp
801058b2:	89 c6                	mov    %eax,%esi
801058b4:	85 c0                	test   %eax,%eax
801058b6:	0f 84 cd 00 00 00    	je     80105989 <create+0x189>
  ilock(ip);
801058bc:	83 ec 0c             	sub    $0xc,%esp
801058bf:	50                   	push   %eax
801058c0:	e8 eb c8 ff ff       	call   801021b0 <ilock>
  ip->major = major;
801058c5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801058c9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801058cd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801058d1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801058d5:	b8 01 00 00 00       	mov    $0x1,%eax
801058da:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801058de:	89 34 24             	mov    %esi,(%esp)
801058e1:	e8 0a c8 ff ff       	call   801020f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801058ee:	74 30                	je     80105920 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801058f0:	83 ec 04             	sub    $0x4,%esp
801058f3:	ff 76 04             	pushl  0x4(%esi)
801058f6:	57                   	push   %edi
801058f7:	53                   	push   %ebx
801058f8:	e8 c3 d0 ff ff       	call   801029c0 <dirlink>
801058fd:	83 c4 10             	add    $0x10,%esp
80105900:	85 c0                	test   %eax,%eax
80105902:	78 78                	js     8010597c <create+0x17c>
  iunlockput(dp);
80105904:	83 ec 0c             	sub    $0xc,%esp
80105907:	53                   	push   %ebx
80105908:	e8 43 cb ff ff       	call   80102450 <iunlockput>
  return ip;
8010590d:	83 c4 10             	add    $0x10,%esp
}
80105910:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105913:	89 f0                	mov    %esi,%eax
80105915:	5b                   	pop    %ebx
80105916:	5e                   	pop    %esi
80105917:	5f                   	pop    %edi
80105918:	5d                   	pop    %ebp
80105919:	c3                   	ret    
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105920:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105923:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105928:	53                   	push   %ebx
80105929:	e8 c2 c7 ff ff       	call   801020f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010592e:	83 c4 0c             	add    $0xc,%esp
80105931:	ff 76 04             	pushl  0x4(%esi)
80105934:	68 d4 86 10 80       	push   $0x801086d4
80105939:	56                   	push   %esi
8010593a:	e8 81 d0 ff ff       	call   801029c0 <dirlink>
8010593f:	83 c4 10             	add    $0x10,%esp
80105942:	85 c0                	test   %eax,%eax
80105944:	78 18                	js     8010595e <create+0x15e>
80105946:	83 ec 04             	sub    $0x4,%esp
80105949:	ff 73 04             	pushl  0x4(%ebx)
8010594c:	68 d3 86 10 80       	push   $0x801086d3
80105951:	56                   	push   %esi
80105952:	e8 69 d0 ff ff       	call   801029c0 <dirlink>
80105957:	83 c4 10             	add    $0x10,%esp
8010595a:	85 c0                	test   %eax,%eax
8010595c:	79 92                	jns    801058f0 <create+0xf0>
      panic("create dots");
8010595e:	83 ec 0c             	sub    $0xc,%esp
80105961:	68 c7 86 10 80       	push   $0x801086c7
80105966:	e8 25 aa ff ff       	call   80100390 <panic>
8010596b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010596f:	90                   	nop
}
80105970:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105973:	31 f6                	xor    %esi,%esi
}
80105975:	5b                   	pop    %ebx
80105976:	89 f0                	mov    %esi,%eax
80105978:	5e                   	pop    %esi
80105979:	5f                   	pop    %edi
8010597a:	5d                   	pop    %ebp
8010597b:	c3                   	ret    
    panic("create: dirlink");
8010597c:	83 ec 0c             	sub    $0xc,%esp
8010597f:	68 d6 86 10 80       	push   $0x801086d6
80105984:	e8 07 aa ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105989:	83 ec 0c             	sub    $0xc,%esp
8010598c:	68 b8 86 10 80       	push   $0x801086b8
80105991:	e8 fa a9 ff ff       	call   80100390 <panic>
80105996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010599d:	8d 76 00             	lea    0x0(%esi),%esi

801059a0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	56                   	push   %esi
801059a4:	89 d6                	mov    %edx,%esi
801059a6:	53                   	push   %ebx
801059a7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801059a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801059ac:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801059af:	50                   	push   %eax
801059b0:	6a 00                	push   $0x0
801059b2:	e8 a9 fc ff ff       	call   80105660 <argint>
801059b7:	83 c4 10             	add    $0x10,%esp
801059ba:	85 c0                	test   %eax,%eax
801059bc:	78 2a                	js     801059e8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801059be:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059c2:	77 24                	ja     801059e8 <argfd.constprop.0+0x48>
801059c4:	e8 37 ea ff ff       	call   80104400 <myproc>
801059c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059cc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801059d0:	85 c0                	test   %eax,%eax
801059d2:	74 14                	je     801059e8 <argfd.constprop.0+0x48>
  if(pfd)
801059d4:	85 db                	test   %ebx,%ebx
801059d6:	74 02                	je     801059da <argfd.constprop.0+0x3a>
    *pfd = fd;
801059d8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801059da:	89 06                	mov    %eax,(%esi)
  return 0;
801059dc:	31 c0                	xor    %eax,%eax
}
801059de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059e1:	5b                   	pop    %ebx
801059e2:	5e                   	pop    %esi
801059e3:	5d                   	pop    %ebp
801059e4:	c3                   	ret    
801059e5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801059e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059ed:	eb ef                	jmp    801059de <argfd.constprop.0+0x3e>
801059ef:	90                   	nop

801059f0 <sys_dup>:
{
801059f0:	f3 0f 1e fb          	endbr32 
801059f4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801059f5:	31 c0                	xor    %eax,%eax
{
801059f7:	89 e5                	mov    %esp,%ebp
801059f9:	56                   	push   %esi
801059fa:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801059fb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801059fe:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105a01:	e8 9a ff ff ff       	call   801059a0 <argfd.constprop.0>
80105a06:	85 c0                	test   %eax,%eax
80105a08:	78 1e                	js     80105a28 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80105a0a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105a0d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105a0f:	e8 ec e9 ff ff       	call   80104400 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105a18:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105a1c:	85 d2                	test   %edx,%edx
80105a1e:	74 20                	je     80105a40 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105a20:	83 c3 01             	add    $0x1,%ebx
80105a23:	83 fb 10             	cmp    $0x10,%ebx
80105a26:	75 f0                	jne    80105a18 <sys_dup+0x28>
}
80105a28:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105a2b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105a30:	89 d8                	mov    %ebx,%eax
80105a32:	5b                   	pop    %ebx
80105a33:	5e                   	pop    %esi
80105a34:	5d                   	pop    %ebp
80105a35:	c3                   	ret    
80105a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105a40:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105a44:	83 ec 0c             	sub    $0xc,%esp
80105a47:	ff 75 f4             	pushl  -0xc(%ebp)
80105a4a:	e8 71 be ff ff       	call   801018c0 <filedup>
  return fd;
80105a4f:	83 c4 10             	add    $0x10,%esp
}
80105a52:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a55:	89 d8                	mov    %ebx,%eax
80105a57:	5b                   	pop    %ebx
80105a58:	5e                   	pop    %esi
80105a59:	5d                   	pop    %ebp
80105a5a:	c3                   	ret    
80105a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a5f:	90                   	nop

80105a60 <sys_read>:
{
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a65:	31 c0                	xor    %eax,%eax
{
80105a67:	89 e5                	mov    %esp,%ebp
80105a69:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a6c:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105a6f:	e8 2c ff ff ff       	call   801059a0 <argfd.constprop.0>
80105a74:	85 c0                	test   %eax,%eax
80105a76:	78 48                	js     80105ac0 <sys_read+0x60>
80105a78:	83 ec 08             	sub    $0x8,%esp
80105a7b:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a7e:	50                   	push   %eax
80105a7f:	6a 02                	push   $0x2
80105a81:	e8 da fb ff ff       	call   80105660 <argint>
80105a86:	83 c4 10             	add    $0x10,%esp
80105a89:	85 c0                	test   %eax,%eax
80105a8b:	78 33                	js     80105ac0 <sys_read+0x60>
80105a8d:	83 ec 04             	sub    $0x4,%esp
80105a90:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a93:	ff 75 f0             	pushl  -0x10(%ebp)
80105a96:	50                   	push   %eax
80105a97:	6a 01                	push   $0x1
80105a99:	e8 12 fc ff ff       	call   801056b0 <argptr>
80105a9e:	83 c4 10             	add    $0x10,%esp
80105aa1:	85 c0                	test   %eax,%eax
80105aa3:	78 1b                	js     80105ac0 <sys_read+0x60>
  return fileread(f, p, n);
80105aa5:	83 ec 04             	sub    $0x4,%esp
80105aa8:	ff 75 f0             	pushl  -0x10(%ebp)
80105aab:	ff 75 f4             	pushl  -0xc(%ebp)
80105aae:	ff 75 ec             	pushl  -0x14(%ebp)
80105ab1:	e8 8a bf ff ff       	call   80101a40 <fileread>
80105ab6:	83 c4 10             	add    $0x10,%esp
}
80105ab9:	c9                   	leave  
80105aba:	c3                   	ret    
80105abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105abf:	90                   	nop
80105ac0:	c9                   	leave  
    return -1;
80105ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ac6:	c3                   	ret    
80105ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ace:	66 90                	xchg   %ax,%ax

80105ad0 <sys_write>:
{
80105ad0:	f3 0f 1e fb          	endbr32 
80105ad4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105ad5:	31 c0                	xor    %eax,%eax
{
80105ad7:	89 e5                	mov    %esp,%ebp
80105ad9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105adc:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105adf:	e8 bc fe ff ff       	call   801059a0 <argfd.constprop.0>
80105ae4:	85 c0                	test   %eax,%eax
80105ae6:	78 48                	js     80105b30 <sys_write+0x60>
80105ae8:	83 ec 08             	sub    $0x8,%esp
80105aeb:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105aee:	50                   	push   %eax
80105aef:	6a 02                	push   $0x2
80105af1:	e8 6a fb ff ff       	call   80105660 <argint>
80105af6:	83 c4 10             	add    $0x10,%esp
80105af9:	85 c0                	test   %eax,%eax
80105afb:	78 33                	js     80105b30 <sys_write+0x60>
80105afd:	83 ec 04             	sub    $0x4,%esp
80105b00:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b03:	ff 75 f0             	pushl  -0x10(%ebp)
80105b06:	50                   	push   %eax
80105b07:	6a 01                	push   $0x1
80105b09:	e8 a2 fb ff ff       	call   801056b0 <argptr>
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	85 c0                	test   %eax,%eax
80105b13:	78 1b                	js     80105b30 <sys_write+0x60>
  return filewrite(f, p, n);
80105b15:	83 ec 04             	sub    $0x4,%esp
80105b18:	ff 75 f0             	pushl  -0x10(%ebp)
80105b1b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1e:	ff 75 ec             	pushl  -0x14(%ebp)
80105b21:	e8 ba bf ff ff       	call   80101ae0 <filewrite>
80105b26:	83 c4 10             	add    $0x10,%esp
}
80105b29:	c9                   	leave  
80105b2a:	c3                   	ret    
80105b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b2f:	90                   	nop
80105b30:	c9                   	leave  
    return -1;
80105b31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b36:	c3                   	ret    
80105b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b3e:	66 90                	xchg   %ax,%ax

80105b40 <sys_close>:
{
80105b40:	f3 0f 1e fb          	endbr32 
80105b44:	55                   	push   %ebp
80105b45:	89 e5                	mov    %esp,%ebp
80105b47:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
80105b4a:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105b4d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b50:	e8 4b fe ff ff       	call   801059a0 <argfd.constprop.0>
80105b55:	85 c0                	test   %eax,%eax
80105b57:	78 27                	js     80105b80 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105b59:	e8 a2 e8 ff ff       	call   80104400 <myproc>
80105b5e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105b61:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105b64:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105b6b:	00 
  fileclose(f);
80105b6c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b6f:	e8 9c bd ff ff       	call   80101910 <fileclose>
  return 0;
80105b74:	83 c4 10             	add    $0x10,%esp
80105b77:	31 c0                	xor    %eax,%eax
}
80105b79:	c9                   	leave  
80105b7a:	c3                   	ret    
80105b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b7f:	90                   	nop
80105b80:	c9                   	leave  
    return -1;
80105b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b86:	c3                   	ret    
80105b87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b8e:	66 90                	xchg   %ax,%ax

80105b90 <sys_fstat>:
{
80105b90:	f3 0f 1e fb          	endbr32 
80105b94:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105b95:	31 c0                	xor    %eax,%eax
{
80105b97:	89 e5                	mov    %esp,%ebp
80105b99:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105b9c:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105b9f:	e8 fc fd ff ff       	call   801059a0 <argfd.constprop.0>
80105ba4:	85 c0                	test   %eax,%eax
80105ba6:	78 30                	js     80105bd8 <sys_fstat+0x48>
80105ba8:	83 ec 04             	sub    $0x4,%esp
80105bab:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bae:	6a 14                	push   $0x14
80105bb0:	50                   	push   %eax
80105bb1:	6a 01                	push   $0x1
80105bb3:	e8 f8 fa ff ff       	call   801056b0 <argptr>
80105bb8:	83 c4 10             	add    $0x10,%esp
80105bbb:	85 c0                	test   %eax,%eax
80105bbd:	78 19                	js     80105bd8 <sys_fstat+0x48>
  return filestat(f, st);
80105bbf:	83 ec 08             	sub    $0x8,%esp
80105bc2:	ff 75 f4             	pushl  -0xc(%ebp)
80105bc5:	ff 75 f0             	pushl  -0x10(%ebp)
80105bc8:	e8 23 be ff ff       	call   801019f0 <filestat>
80105bcd:	83 c4 10             	add    $0x10,%esp
}
80105bd0:	c9                   	leave  
80105bd1:	c3                   	ret    
80105bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105bd8:	c9                   	leave  
    return -1;
80105bd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bde:	c3                   	ret    
80105bdf:	90                   	nop

80105be0 <sys_link>:
{
80105be0:	f3 0f 1e fb          	endbr32 
80105be4:	55                   	push   %ebp
80105be5:	89 e5                	mov    %esp,%ebp
80105be7:	57                   	push   %edi
80105be8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105be9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105bec:	53                   	push   %ebx
80105bed:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105bf0:	50                   	push   %eax
80105bf1:	6a 00                	push   $0x0
80105bf3:	e8 18 fb ff ff       	call   80105710 <argstr>
80105bf8:	83 c4 10             	add    $0x10,%esp
80105bfb:	85 c0                	test   %eax,%eax
80105bfd:	0f 88 ff 00 00 00    	js     80105d02 <sys_link+0x122>
80105c03:	83 ec 08             	sub    $0x8,%esp
80105c06:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105c09:	50                   	push   %eax
80105c0a:	6a 01                	push   $0x1
80105c0c:	e8 ff fa ff ff       	call   80105710 <argstr>
80105c11:	83 c4 10             	add    $0x10,%esp
80105c14:	85 c0                	test   %eax,%eax
80105c16:	0f 88 e6 00 00 00    	js     80105d02 <sys_link+0x122>
  begin_op();
80105c1c:	e8 5f db ff ff       	call   80103780 <begin_op>
  if((ip = namei(old)) == 0){
80105c21:	83 ec 0c             	sub    $0xc,%esp
80105c24:	ff 75 d4             	pushl  -0x2c(%ebp)
80105c27:	e8 54 ce ff ff       	call   80102a80 <namei>
80105c2c:	83 c4 10             	add    $0x10,%esp
80105c2f:	89 c3                	mov    %eax,%ebx
80105c31:	85 c0                	test   %eax,%eax
80105c33:	0f 84 e8 00 00 00    	je     80105d21 <sys_link+0x141>
  ilock(ip);
80105c39:	83 ec 0c             	sub    $0xc,%esp
80105c3c:	50                   	push   %eax
80105c3d:	e8 6e c5 ff ff       	call   801021b0 <ilock>
  if(ip->type == T_DIR){
80105c42:	83 c4 10             	add    $0x10,%esp
80105c45:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c4a:	0f 84 b9 00 00 00    	je     80105d09 <sys_link+0x129>
  iupdate(ip);
80105c50:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105c53:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105c58:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105c5b:	53                   	push   %ebx
80105c5c:	e8 8f c4 ff ff       	call   801020f0 <iupdate>
  iunlock(ip);
80105c61:	89 1c 24             	mov    %ebx,(%esp)
80105c64:	e8 27 c6 ff ff       	call   80102290 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105c69:	58                   	pop    %eax
80105c6a:	5a                   	pop    %edx
80105c6b:	57                   	push   %edi
80105c6c:	ff 75 d0             	pushl  -0x30(%ebp)
80105c6f:	e8 2c ce ff ff       	call   80102aa0 <nameiparent>
80105c74:	83 c4 10             	add    $0x10,%esp
80105c77:	89 c6                	mov    %eax,%esi
80105c79:	85 c0                	test   %eax,%eax
80105c7b:	74 5f                	je     80105cdc <sys_link+0xfc>
  ilock(dp);
80105c7d:	83 ec 0c             	sub    $0xc,%esp
80105c80:	50                   	push   %eax
80105c81:	e8 2a c5 ff ff       	call   801021b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105c86:	8b 03                	mov    (%ebx),%eax
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	39 06                	cmp    %eax,(%esi)
80105c8d:	75 41                	jne    80105cd0 <sys_link+0xf0>
80105c8f:	83 ec 04             	sub    $0x4,%esp
80105c92:	ff 73 04             	pushl  0x4(%ebx)
80105c95:	57                   	push   %edi
80105c96:	56                   	push   %esi
80105c97:	e8 24 cd ff ff       	call   801029c0 <dirlink>
80105c9c:	83 c4 10             	add    $0x10,%esp
80105c9f:	85 c0                	test   %eax,%eax
80105ca1:	78 2d                	js     80105cd0 <sys_link+0xf0>
  iunlockput(dp);
80105ca3:	83 ec 0c             	sub    $0xc,%esp
80105ca6:	56                   	push   %esi
80105ca7:	e8 a4 c7 ff ff       	call   80102450 <iunlockput>
  iput(ip);
80105cac:	89 1c 24             	mov    %ebx,(%esp)
80105caf:	e8 2c c6 ff ff       	call   801022e0 <iput>
  end_op();
80105cb4:	e8 37 db ff ff       	call   801037f0 <end_op>
  return 0;
80105cb9:	83 c4 10             	add    $0x10,%esp
80105cbc:	31 c0                	xor    %eax,%eax
}
80105cbe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cc1:	5b                   	pop    %ebx
80105cc2:	5e                   	pop    %esi
80105cc3:	5f                   	pop    %edi
80105cc4:	5d                   	pop    %ebp
80105cc5:	c3                   	ret    
80105cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ccd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105cd0:	83 ec 0c             	sub    $0xc,%esp
80105cd3:	56                   	push   %esi
80105cd4:	e8 77 c7 ff ff       	call   80102450 <iunlockput>
    goto bad;
80105cd9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105cdc:	83 ec 0c             	sub    $0xc,%esp
80105cdf:	53                   	push   %ebx
80105ce0:	e8 cb c4 ff ff       	call   801021b0 <ilock>
  ip->nlink--;
80105ce5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cea:	89 1c 24             	mov    %ebx,(%esp)
80105ced:	e8 fe c3 ff ff       	call   801020f0 <iupdate>
  iunlockput(ip);
80105cf2:	89 1c 24             	mov    %ebx,(%esp)
80105cf5:	e8 56 c7 ff ff       	call   80102450 <iunlockput>
  end_op();
80105cfa:	e8 f1 da ff ff       	call   801037f0 <end_op>
  return -1;
80105cff:	83 c4 10             	add    $0x10,%esp
80105d02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d07:	eb b5                	jmp    80105cbe <sys_link+0xde>
    iunlockput(ip);
80105d09:	83 ec 0c             	sub    $0xc,%esp
80105d0c:	53                   	push   %ebx
80105d0d:	e8 3e c7 ff ff       	call   80102450 <iunlockput>
    end_op();
80105d12:	e8 d9 da ff ff       	call   801037f0 <end_op>
    return -1;
80105d17:	83 c4 10             	add    $0x10,%esp
80105d1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d1f:	eb 9d                	jmp    80105cbe <sys_link+0xde>
    end_op();
80105d21:	e8 ca da ff ff       	call   801037f0 <end_op>
    return -1;
80105d26:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d2b:	eb 91                	jmp    80105cbe <sys_link+0xde>
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi

80105d30 <sys_unlink>:
{
80105d30:	f3 0f 1e fb          	endbr32 
80105d34:	55                   	push   %ebp
80105d35:	89 e5                	mov    %esp,%ebp
80105d37:	57                   	push   %edi
80105d38:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105d39:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105d3c:	53                   	push   %ebx
80105d3d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105d40:	50                   	push   %eax
80105d41:	6a 00                	push   $0x0
80105d43:	e8 c8 f9 ff ff       	call   80105710 <argstr>
80105d48:	83 c4 10             	add    $0x10,%esp
80105d4b:	85 c0                	test   %eax,%eax
80105d4d:	0f 88 7d 01 00 00    	js     80105ed0 <sys_unlink+0x1a0>
  begin_op();
80105d53:	e8 28 da ff ff       	call   80103780 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105d58:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105d5b:	83 ec 08             	sub    $0x8,%esp
80105d5e:	53                   	push   %ebx
80105d5f:	ff 75 c0             	pushl  -0x40(%ebp)
80105d62:	e8 39 cd ff ff       	call   80102aa0 <nameiparent>
80105d67:	83 c4 10             	add    $0x10,%esp
80105d6a:	89 c6                	mov    %eax,%esi
80105d6c:	85 c0                	test   %eax,%eax
80105d6e:	0f 84 66 01 00 00    	je     80105eda <sys_unlink+0x1aa>
  ilock(dp);
80105d74:	83 ec 0c             	sub    $0xc,%esp
80105d77:	50                   	push   %eax
80105d78:	e8 33 c4 ff ff       	call   801021b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105d7d:	58                   	pop    %eax
80105d7e:	5a                   	pop    %edx
80105d7f:	68 d4 86 10 80       	push   $0x801086d4
80105d84:	53                   	push   %ebx
80105d85:	e8 56 c9 ff ff       	call   801026e0 <namecmp>
80105d8a:	83 c4 10             	add    $0x10,%esp
80105d8d:	85 c0                	test   %eax,%eax
80105d8f:	0f 84 03 01 00 00    	je     80105e98 <sys_unlink+0x168>
80105d95:	83 ec 08             	sub    $0x8,%esp
80105d98:	68 d3 86 10 80       	push   $0x801086d3
80105d9d:	53                   	push   %ebx
80105d9e:	e8 3d c9 ff ff       	call   801026e0 <namecmp>
80105da3:	83 c4 10             	add    $0x10,%esp
80105da6:	85 c0                	test   %eax,%eax
80105da8:	0f 84 ea 00 00 00    	je     80105e98 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105dae:	83 ec 04             	sub    $0x4,%esp
80105db1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105db4:	50                   	push   %eax
80105db5:	53                   	push   %ebx
80105db6:	56                   	push   %esi
80105db7:	e8 44 c9 ff ff       	call   80102700 <dirlookup>
80105dbc:	83 c4 10             	add    $0x10,%esp
80105dbf:	89 c3                	mov    %eax,%ebx
80105dc1:	85 c0                	test   %eax,%eax
80105dc3:	0f 84 cf 00 00 00    	je     80105e98 <sys_unlink+0x168>
  ilock(ip);
80105dc9:	83 ec 0c             	sub    $0xc,%esp
80105dcc:	50                   	push   %eax
80105dcd:	e8 de c3 ff ff       	call   801021b0 <ilock>
  if(ip->nlink < 1)
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105dda:	0f 8e 23 01 00 00    	jle    80105f03 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105de0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105de5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105de8:	74 66                	je     80105e50 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105dea:	83 ec 04             	sub    $0x4,%esp
80105ded:	6a 10                	push   $0x10
80105def:	6a 00                	push   $0x0
80105df1:	57                   	push   %edi
80105df2:	e8 89 f5 ff ff       	call   80105380 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105df7:	6a 10                	push   $0x10
80105df9:	ff 75 c4             	pushl  -0x3c(%ebp)
80105dfc:	57                   	push   %edi
80105dfd:	56                   	push   %esi
80105dfe:	e8 ad c7 ff ff       	call   801025b0 <writei>
80105e03:	83 c4 20             	add    $0x20,%esp
80105e06:	83 f8 10             	cmp    $0x10,%eax
80105e09:	0f 85 e7 00 00 00    	jne    80105ef6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
80105e0f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105e14:	0f 84 96 00 00 00    	je     80105eb0 <sys_unlink+0x180>
  iunlockput(dp);
80105e1a:	83 ec 0c             	sub    $0xc,%esp
80105e1d:	56                   	push   %esi
80105e1e:	e8 2d c6 ff ff       	call   80102450 <iunlockput>
  ip->nlink--;
80105e23:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105e28:	89 1c 24             	mov    %ebx,(%esp)
80105e2b:	e8 c0 c2 ff ff       	call   801020f0 <iupdate>
  iunlockput(ip);
80105e30:	89 1c 24             	mov    %ebx,(%esp)
80105e33:	e8 18 c6 ff ff       	call   80102450 <iunlockput>
  end_op();
80105e38:	e8 b3 d9 ff ff       	call   801037f0 <end_op>
  return 0;
80105e3d:	83 c4 10             	add    $0x10,%esp
80105e40:	31 c0                	xor    %eax,%eax
}
80105e42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e45:	5b                   	pop    %ebx
80105e46:	5e                   	pop    %esi
80105e47:	5f                   	pop    %edi
80105e48:	5d                   	pop    %ebp
80105e49:	c3                   	ret    
80105e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105e50:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105e54:	76 94                	jbe    80105dea <sys_unlink+0xba>
80105e56:	ba 20 00 00 00       	mov    $0x20,%edx
80105e5b:	eb 0b                	jmp    80105e68 <sys_unlink+0x138>
80105e5d:	8d 76 00             	lea    0x0(%esi),%esi
80105e60:	83 c2 10             	add    $0x10,%edx
80105e63:	39 53 58             	cmp    %edx,0x58(%ebx)
80105e66:	76 82                	jbe    80105dea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105e68:	6a 10                	push   $0x10
80105e6a:	52                   	push   %edx
80105e6b:	57                   	push   %edi
80105e6c:	53                   	push   %ebx
80105e6d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105e70:	e8 3b c6 ff ff       	call   801024b0 <readi>
80105e75:	83 c4 10             	add    $0x10,%esp
80105e78:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105e7b:	83 f8 10             	cmp    $0x10,%eax
80105e7e:	75 69                	jne    80105ee9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105e80:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105e85:	74 d9                	je     80105e60 <sys_unlink+0x130>
    iunlockput(ip);
80105e87:	83 ec 0c             	sub    $0xc,%esp
80105e8a:	53                   	push   %ebx
80105e8b:	e8 c0 c5 ff ff       	call   80102450 <iunlockput>
    goto bad;
80105e90:	83 c4 10             	add    $0x10,%esp
80105e93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e97:	90                   	nop
  iunlockput(dp);
80105e98:	83 ec 0c             	sub    $0xc,%esp
80105e9b:	56                   	push   %esi
80105e9c:	e8 af c5 ff ff       	call   80102450 <iunlockput>
  end_op();
80105ea1:	e8 4a d9 ff ff       	call   801037f0 <end_op>
  return -1;
80105ea6:	83 c4 10             	add    $0x10,%esp
80105ea9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eae:	eb 92                	jmp    80105e42 <sys_unlink+0x112>
    iupdate(dp);
80105eb0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105eb3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105eb8:	56                   	push   %esi
80105eb9:	e8 32 c2 ff ff       	call   801020f0 <iupdate>
80105ebe:	83 c4 10             	add    $0x10,%esp
80105ec1:	e9 54 ff ff ff       	jmp    80105e1a <sys_unlink+0xea>
80105ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ecd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed5:	e9 68 ff ff ff       	jmp    80105e42 <sys_unlink+0x112>
    end_op();
80105eda:	e8 11 d9 ff ff       	call   801037f0 <end_op>
    return -1;
80105edf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ee4:	e9 59 ff ff ff       	jmp    80105e42 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105ee9:	83 ec 0c             	sub    $0xc,%esp
80105eec:	68 f8 86 10 80       	push   $0x801086f8
80105ef1:	e8 9a a4 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105ef6:	83 ec 0c             	sub    $0xc,%esp
80105ef9:	68 0a 87 10 80       	push   $0x8010870a
80105efe:	e8 8d a4 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105f03:	83 ec 0c             	sub    $0xc,%esp
80105f06:	68 e6 86 10 80       	push   $0x801086e6
80105f0b:	e8 80 a4 ff ff       	call   80100390 <panic>

80105f10 <sys_open>:

int
sys_open(void)
{
80105f10:	f3 0f 1e fb          	endbr32 
80105f14:	55                   	push   %ebp
80105f15:	89 e5                	mov    %esp,%ebp
80105f17:	57                   	push   %edi
80105f18:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f19:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105f1c:	53                   	push   %ebx
80105f1d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f20:	50                   	push   %eax
80105f21:	6a 00                	push   $0x0
80105f23:	e8 e8 f7 ff ff       	call   80105710 <argstr>
80105f28:	83 c4 10             	add    $0x10,%esp
80105f2b:	85 c0                	test   %eax,%eax
80105f2d:	0f 88 8a 00 00 00    	js     80105fbd <sys_open+0xad>
80105f33:	83 ec 08             	sub    $0x8,%esp
80105f36:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f39:	50                   	push   %eax
80105f3a:	6a 01                	push   $0x1
80105f3c:	e8 1f f7 ff ff       	call   80105660 <argint>
80105f41:	83 c4 10             	add    $0x10,%esp
80105f44:	85 c0                	test   %eax,%eax
80105f46:	78 75                	js     80105fbd <sys_open+0xad>
    return -1;

  begin_op();
80105f48:	e8 33 d8 ff ff       	call   80103780 <begin_op>

  if(omode & O_CREATE){
80105f4d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105f51:	75 75                	jne    80105fc8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105f53:	83 ec 0c             	sub    $0xc,%esp
80105f56:	ff 75 e0             	pushl  -0x20(%ebp)
80105f59:	e8 22 cb ff ff       	call   80102a80 <namei>
80105f5e:	83 c4 10             	add    $0x10,%esp
80105f61:	89 c6                	mov    %eax,%esi
80105f63:	85 c0                	test   %eax,%eax
80105f65:	74 7e                	je     80105fe5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105f67:	83 ec 0c             	sub    $0xc,%esp
80105f6a:	50                   	push   %eax
80105f6b:	e8 40 c2 ff ff       	call   801021b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105f70:	83 c4 10             	add    $0x10,%esp
80105f73:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105f78:	0f 84 c2 00 00 00    	je     80106040 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105f7e:	e8 cd b8 ff ff       	call   80101850 <filealloc>
80105f83:	89 c7                	mov    %eax,%edi
80105f85:	85 c0                	test   %eax,%eax
80105f87:	74 23                	je     80105fac <sys_open+0x9c>
  struct proc *curproc = myproc();
80105f89:	e8 72 e4 ff ff       	call   80104400 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f8e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105f90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f94:	85 d2                	test   %edx,%edx
80105f96:	74 60                	je     80105ff8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105f98:	83 c3 01             	add    $0x1,%ebx
80105f9b:	83 fb 10             	cmp    $0x10,%ebx
80105f9e:	75 f0                	jne    80105f90 <sys_open+0x80>
    if(f)
      fileclose(f);
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	57                   	push   %edi
80105fa4:	e8 67 b9 ff ff       	call   80101910 <fileclose>
80105fa9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105fac:	83 ec 0c             	sub    $0xc,%esp
80105faf:	56                   	push   %esi
80105fb0:	e8 9b c4 ff ff       	call   80102450 <iunlockput>
    end_op();
80105fb5:	e8 36 d8 ff ff       	call   801037f0 <end_op>
    return -1;
80105fba:	83 c4 10             	add    $0x10,%esp
80105fbd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fc2:	eb 6d                	jmp    80106031 <sys_open+0x121>
80105fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105fc8:	83 ec 0c             	sub    $0xc,%esp
80105fcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105fce:	31 c9                	xor    %ecx,%ecx
80105fd0:	ba 02 00 00 00       	mov    $0x2,%edx
80105fd5:	6a 00                	push   $0x0
80105fd7:	e8 24 f8 ff ff       	call   80105800 <create>
    if(ip == 0){
80105fdc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105fdf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105fe1:	85 c0                	test   %eax,%eax
80105fe3:	75 99                	jne    80105f7e <sys_open+0x6e>
      end_op();
80105fe5:	e8 06 d8 ff ff       	call   801037f0 <end_op>
      return -1;
80105fea:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fef:	eb 40                	jmp    80106031 <sys_open+0x121>
80105ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105ff8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105ffb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105fff:	56                   	push   %esi
80106000:	e8 8b c2 ff ff       	call   80102290 <iunlock>
  end_op();
80106005:	e8 e6 d7 ff ff       	call   801037f0 <end_op>

  f->type = FD_INODE;
8010600a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106010:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106013:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106016:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106019:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010601b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80106022:	f7 d0                	not    %eax
80106024:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106027:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010602a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010602d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106034:	89 d8                	mov    %ebx,%eax
80106036:	5b                   	pop    %ebx
80106037:	5e                   	pop    %esi
80106038:	5f                   	pop    %edi
80106039:	5d                   	pop    %ebp
8010603a:	c3                   	ret    
8010603b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010603f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80106040:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106043:	85 c9                	test   %ecx,%ecx
80106045:	0f 84 33 ff ff ff    	je     80105f7e <sys_open+0x6e>
8010604b:	e9 5c ff ff ff       	jmp    80105fac <sys_open+0x9c>

80106050 <sys_mkdir>:

int
sys_mkdir(void)
{
80106050:	f3 0f 1e fb          	endbr32 
80106054:	55                   	push   %ebp
80106055:	89 e5                	mov    %esp,%ebp
80106057:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
8010605a:	e8 21 d7 ff ff       	call   80103780 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010605f:	83 ec 08             	sub    $0x8,%esp
80106062:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106065:	50                   	push   %eax
80106066:	6a 00                	push   $0x0
80106068:	e8 a3 f6 ff ff       	call   80105710 <argstr>
8010606d:	83 c4 10             	add    $0x10,%esp
80106070:	85 c0                	test   %eax,%eax
80106072:	78 34                	js     801060a8 <sys_mkdir+0x58>
80106074:	83 ec 0c             	sub    $0xc,%esp
80106077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010607a:	31 c9                	xor    %ecx,%ecx
8010607c:	ba 01 00 00 00       	mov    $0x1,%edx
80106081:	6a 00                	push   $0x0
80106083:	e8 78 f7 ff ff       	call   80105800 <create>
80106088:	83 c4 10             	add    $0x10,%esp
8010608b:	85 c0                	test   %eax,%eax
8010608d:	74 19                	je     801060a8 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010608f:	83 ec 0c             	sub    $0xc,%esp
80106092:	50                   	push   %eax
80106093:	e8 b8 c3 ff ff       	call   80102450 <iunlockput>
  end_op();
80106098:	e8 53 d7 ff ff       	call   801037f0 <end_op>
  return 0;
8010609d:	83 c4 10             	add    $0x10,%esp
801060a0:	31 c0                	xor    %eax,%eax
}
801060a2:	c9                   	leave  
801060a3:	c3                   	ret    
801060a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801060a8:	e8 43 d7 ff ff       	call   801037f0 <end_op>
    return -1;
801060ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060b2:	c9                   	leave  
801060b3:	c3                   	ret    
801060b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060bf:	90                   	nop

801060c0 <sys_mknod>:

int
sys_mknod(void)
{
801060c0:	f3 0f 1e fb          	endbr32 
801060c4:	55                   	push   %ebp
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801060ca:	e8 b1 d6 ff ff       	call   80103780 <begin_op>
  if((argstr(0, &path)) < 0 ||
801060cf:	83 ec 08             	sub    $0x8,%esp
801060d2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801060d5:	50                   	push   %eax
801060d6:	6a 00                	push   $0x0
801060d8:	e8 33 f6 ff ff       	call   80105710 <argstr>
801060dd:	83 c4 10             	add    $0x10,%esp
801060e0:	85 c0                	test   %eax,%eax
801060e2:	78 64                	js     80106148 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
801060e4:	83 ec 08             	sub    $0x8,%esp
801060e7:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060ea:	50                   	push   %eax
801060eb:	6a 01                	push   $0x1
801060ed:	e8 6e f5 ff ff       	call   80105660 <argint>
  if((argstr(0, &path)) < 0 ||
801060f2:	83 c4 10             	add    $0x10,%esp
801060f5:	85 c0                	test   %eax,%eax
801060f7:	78 4f                	js     80106148 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
801060f9:	83 ec 08             	sub    $0x8,%esp
801060fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060ff:	50                   	push   %eax
80106100:	6a 02                	push   $0x2
80106102:	e8 59 f5 ff ff       	call   80105660 <argint>
     argint(1, &major) < 0 ||
80106107:	83 c4 10             	add    $0x10,%esp
8010610a:	85 c0                	test   %eax,%eax
8010610c:	78 3a                	js     80106148 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010610e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80106112:	83 ec 0c             	sub    $0xc,%esp
80106115:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106119:	ba 03 00 00 00       	mov    $0x3,%edx
8010611e:	50                   	push   %eax
8010611f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106122:	e8 d9 f6 ff ff       	call   80105800 <create>
     argint(2, &minor) < 0 ||
80106127:	83 c4 10             	add    $0x10,%esp
8010612a:	85 c0                	test   %eax,%eax
8010612c:	74 1a                	je     80106148 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010612e:	83 ec 0c             	sub    $0xc,%esp
80106131:	50                   	push   %eax
80106132:	e8 19 c3 ff ff       	call   80102450 <iunlockput>
  end_op();
80106137:	e8 b4 d6 ff ff       	call   801037f0 <end_op>
  return 0;
8010613c:	83 c4 10             	add    $0x10,%esp
8010613f:	31 c0                	xor    %eax,%eax
}
80106141:	c9                   	leave  
80106142:	c3                   	ret    
80106143:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106147:	90                   	nop
    end_op();
80106148:	e8 a3 d6 ff ff       	call   801037f0 <end_op>
    return -1;
8010614d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106152:	c9                   	leave  
80106153:	c3                   	ret    
80106154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010615b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010615f:	90                   	nop

80106160 <sys_chdir>:

int
sys_chdir(void)
{
80106160:	f3 0f 1e fb          	endbr32 
80106164:	55                   	push   %ebp
80106165:	89 e5                	mov    %esp,%ebp
80106167:	56                   	push   %esi
80106168:	53                   	push   %ebx
80106169:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
8010616c:	e8 8f e2 ff ff       	call   80104400 <myproc>
80106171:	89 c6                	mov    %eax,%esi
  
  begin_op();
80106173:	e8 08 d6 ff ff       	call   80103780 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106178:	83 ec 08             	sub    $0x8,%esp
8010617b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010617e:	50                   	push   %eax
8010617f:	6a 00                	push   $0x0
80106181:	e8 8a f5 ff ff       	call   80105710 <argstr>
80106186:	83 c4 10             	add    $0x10,%esp
80106189:	85 c0                	test   %eax,%eax
8010618b:	78 73                	js     80106200 <sys_chdir+0xa0>
8010618d:	83 ec 0c             	sub    $0xc,%esp
80106190:	ff 75 f4             	pushl  -0xc(%ebp)
80106193:	e8 e8 c8 ff ff       	call   80102a80 <namei>
80106198:	83 c4 10             	add    $0x10,%esp
8010619b:	89 c3                	mov    %eax,%ebx
8010619d:	85 c0                	test   %eax,%eax
8010619f:	74 5f                	je     80106200 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801061a1:	83 ec 0c             	sub    $0xc,%esp
801061a4:	50                   	push   %eax
801061a5:	e8 06 c0 ff ff       	call   801021b0 <ilock>
  if(ip->type != T_DIR){
801061aa:	83 c4 10             	add    $0x10,%esp
801061ad:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801061b2:	75 2c                	jne    801061e0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801061b4:	83 ec 0c             	sub    $0xc,%esp
801061b7:	53                   	push   %ebx
801061b8:	e8 d3 c0 ff ff       	call   80102290 <iunlock>
  iput(curproc->cwd);
801061bd:	58                   	pop    %eax
801061be:	ff 76 68             	pushl  0x68(%esi)
801061c1:	e8 1a c1 ff ff       	call   801022e0 <iput>
  end_op();
801061c6:	e8 25 d6 ff ff       	call   801037f0 <end_op>
  curproc->cwd = ip;
801061cb:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801061ce:	83 c4 10             	add    $0x10,%esp
801061d1:	31 c0                	xor    %eax,%eax
}
801061d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801061d6:	5b                   	pop    %ebx
801061d7:	5e                   	pop    %esi
801061d8:	5d                   	pop    %ebp
801061d9:	c3                   	ret    
801061da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
801061e0:	83 ec 0c             	sub    $0xc,%esp
801061e3:	53                   	push   %ebx
801061e4:	e8 67 c2 ff ff       	call   80102450 <iunlockput>
    end_op();
801061e9:	e8 02 d6 ff ff       	call   801037f0 <end_op>
    return -1;
801061ee:	83 c4 10             	add    $0x10,%esp
801061f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061f6:	eb db                	jmp    801061d3 <sys_chdir+0x73>
801061f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ff:	90                   	nop
    end_op();
80106200:	e8 eb d5 ff ff       	call   801037f0 <end_op>
    return -1;
80106205:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010620a:	eb c7                	jmp    801061d3 <sys_chdir+0x73>
8010620c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106210 <sys_exec>:

int
sys_exec(void)
{
80106210:	f3 0f 1e fb          	endbr32 
80106214:	55                   	push   %ebp
80106215:	89 e5                	mov    %esp,%ebp
80106217:	57                   	push   %edi
80106218:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106219:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010621f:	53                   	push   %ebx
80106220:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106226:	50                   	push   %eax
80106227:	6a 00                	push   $0x0
80106229:	e8 e2 f4 ff ff       	call   80105710 <argstr>
8010622e:	83 c4 10             	add    $0x10,%esp
80106231:	85 c0                	test   %eax,%eax
80106233:	0f 88 8b 00 00 00    	js     801062c4 <sys_exec+0xb4>
80106239:	83 ec 08             	sub    $0x8,%esp
8010623c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106242:	50                   	push   %eax
80106243:	6a 01                	push   $0x1
80106245:	e8 16 f4 ff ff       	call   80105660 <argint>
8010624a:	83 c4 10             	add    $0x10,%esp
8010624d:	85 c0                	test   %eax,%eax
8010624f:	78 73                	js     801062c4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106251:	83 ec 04             	sub    $0x4,%esp
80106254:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010625a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010625c:	68 80 00 00 00       	push   $0x80
80106261:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106267:	6a 00                	push   $0x0
80106269:	50                   	push   %eax
8010626a:	e8 11 f1 ff ff       	call   80105380 <memset>
8010626f:	83 c4 10             	add    $0x10,%esp
80106272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106278:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010627e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106285:	83 ec 08             	sub    $0x8,%esp
80106288:	57                   	push   %edi
80106289:	01 f0                	add    %esi,%eax
8010628b:	50                   	push   %eax
8010628c:	e8 2f f3 ff ff       	call   801055c0 <fetchint>
80106291:	83 c4 10             	add    $0x10,%esp
80106294:	85 c0                	test   %eax,%eax
80106296:	78 2c                	js     801062c4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80106298:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010629e:	85 c0                	test   %eax,%eax
801062a0:	74 36                	je     801062d8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801062a2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801062a8:	83 ec 08             	sub    $0x8,%esp
801062ab:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801062ae:	52                   	push   %edx
801062af:	50                   	push   %eax
801062b0:	e8 4b f3 ff ff       	call   80105600 <fetchstr>
801062b5:	83 c4 10             	add    $0x10,%esp
801062b8:	85 c0                	test   %eax,%eax
801062ba:	78 08                	js     801062c4 <sys_exec+0xb4>
  for(i=0;; i++){
801062bc:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801062bf:	83 fb 20             	cmp    $0x20,%ebx
801062c2:	75 b4                	jne    80106278 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
801062c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801062c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062cc:	5b                   	pop    %ebx
801062cd:	5e                   	pop    %esi
801062ce:	5f                   	pop    %edi
801062cf:	5d                   	pop    %ebp
801062d0:	c3                   	ret    
801062d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801062d8:	83 ec 08             	sub    $0x8,%esp
801062db:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801062e1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801062e8:	00 00 00 00 
  return exec(path, argv);
801062ec:	50                   	push   %eax
801062ed:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801062f3:	e8 d8 b1 ff ff       	call   801014d0 <exec>
801062f8:	83 c4 10             	add    $0x10,%esp
}
801062fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062fe:	5b                   	pop    %ebx
801062ff:	5e                   	pop    %esi
80106300:	5f                   	pop    %edi
80106301:	5d                   	pop    %ebp
80106302:	c3                   	ret    
80106303:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010630a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106310 <sys_pipe>:

int
sys_pipe(void)
{
80106310:	f3 0f 1e fb          	endbr32 
80106314:	55                   	push   %ebp
80106315:	89 e5                	mov    %esp,%ebp
80106317:	57                   	push   %edi
80106318:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106319:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010631c:	53                   	push   %ebx
8010631d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106320:	6a 08                	push   $0x8
80106322:	50                   	push   %eax
80106323:	6a 00                	push   $0x0
80106325:	e8 86 f3 ff ff       	call   801056b0 <argptr>
8010632a:	83 c4 10             	add    $0x10,%esp
8010632d:	85 c0                	test   %eax,%eax
8010632f:	78 4e                	js     8010637f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106331:	83 ec 08             	sub    $0x8,%esp
80106334:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106337:	50                   	push   %eax
80106338:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010633b:	50                   	push   %eax
8010633c:	e8 ff da ff ff       	call   80103e40 <pipealloc>
80106341:	83 c4 10             	add    $0x10,%esp
80106344:	85 c0                	test   %eax,%eax
80106346:	78 37                	js     8010637f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106348:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010634b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010634d:	e8 ae e0 ff ff       	call   80104400 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106358:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010635c:	85 f6                	test   %esi,%esi
8010635e:	74 30                	je     80106390 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80106360:	83 c3 01             	add    $0x1,%ebx
80106363:	83 fb 10             	cmp    $0x10,%ebx
80106366:	75 f0                	jne    80106358 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106368:	83 ec 0c             	sub    $0xc,%esp
8010636b:	ff 75 e0             	pushl  -0x20(%ebp)
8010636e:	e8 9d b5 ff ff       	call   80101910 <fileclose>
    fileclose(wf);
80106373:	58                   	pop    %eax
80106374:	ff 75 e4             	pushl  -0x1c(%ebp)
80106377:	e8 94 b5 ff ff       	call   80101910 <fileclose>
    return -1;
8010637c:	83 c4 10             	add    $0x10,%esp
8010637f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106384:	eb 5b                	jmp    801063e1 <sys_pipe+0xd1>
80106386:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010638d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106390:	8d 73 08             	lea    0x8(%ebx),%esi
80106393:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106397:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010639a:	e8 61 e0 ff ff       	call   80104400 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010639f:	31 d2                	xor    %edx,%edx
801063a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801063a8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801063ac:	85 c9                	test   %ecx,%ecx
801063ae:	74 20                	je     801063d0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
801063b0:	83 c2 01             	add    $0x1,%edx
801063b3:	83 fa 10             	cmp    $0x10,%edx
801063b6:	75 f0                	jne    801063a8 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
801063b8:	e8 43 e0 ff ff       	call   80104400 <myproc>
801063bd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801063c4:	00 
801063c5:	eb a1                	jmp    80106368 <sys_pipe+0x58>
801063c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ce:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801063d0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801063d4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801063d7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801063d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801063dc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801063df:	31 c0                	xor    %eax,%eax
}
801063e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063e4:	5b                   	pop    %ebx
801063e5:	5e                   	pop    %esi
801063e6:	5f                   	pop    %edi
801063e7:	5d                   	pop    %ebp
801063e8:	c3                   	ret    
801063e9:	66 90                	xchg   %ax,%ax
801063eb:	66 90                	xchg   %ax,%ax
801063ed:	66 90                	xchg   %ax,%ax
801063ef:	90                   	nop

801063f0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801063f0:	f3 0f 1e fb          	endbr32 
  return fork();
801063f4:	e9 b7 e1 ff ff       	jmp    801045b0 <fork>
801063f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106400 <sys_exit>:
}

int
sys_exit(void)
{
80106400:	f3 0f 1e fb          	endbr32 
80106404:	55                   	push   %ebp
80106405:	89 e5                	mov    %esp,%ebp
80106407:	83 ec 08             	sub    $0x8,%esp
  exit();
8010640a:	e8 21 e4 ff ff       	call   80104830 <exit>
  return 0;  // not reached
}
8010640f:	31 c0                	xor    %eax,%eax
80106411:	c9                   	leave  
80106412:	c3                   	ret    
80106413:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010641a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106420 <sys_wait>:

int
sys_wait(void)
{
80106420:	f3 0f 1e fb          	endbr32 
  return wait();
80106424:	e9 97 e6 ff ff       	jmp    80104ac0 <wait>
80106429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106430 <sys_kill>:
}

int
sys_kill(void)
{
80106430:	f3 0f 1e fb          	endbr32 
80106434:	55                   	push   %ebp
80106435:	89 e5                	mov    %esp,%ebp
80106437:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010643a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010643d:	50                   	push   %eax
8010643e:	6a 00                	push   $0x0
80106440:	e8 1b f2 ff ff       	call   80105660 <argint>
80106445:	83 c4 10             	add    $0x10,%esp
80106448:	85 c0                	test   %eax,%eax
8010644a:	78 14                	js     80106460 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010644c:	83 ec 0c             	sub    $0xc,%esp
8010644f:	ff 75 f4             	pushl  -0xc(%ebp)
80106452:	e8 d9 e7 ff ff       	call   80104c30 <kill>
80106457:	83 c4 10             	add    $0x10,%esp
}
8010645a:	c9                   	leave  
8010645b:	c3                   	ret    
8010645c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106460:	c9                   	leave  
    return -1;
80106461:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106466:	c3                   	ret    
80106467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010646e:	66 90                	xchg   %ax,%ax

80106470 <sys_getpid>:

int
sys_getpid(void)
{
80106470:	f3 0f 1e fb          	endbr32 
80106474:	55                   	push   %ebp
80106475:	89 e5                	mov    %esp,%ebp
80106477:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010647a:	e8 81 df ff ff       	call   80104400 <myproc>
8010647f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106482:	c9                   	leave  
80106483:	c3                   	ret    
80106484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010648b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010648f:	90                   	nop

80106490 <sys_sbrk>:

int
sys_sbrk(void)
{
80106490:	f3 0f 1e fb          	endbr32 
80106494:	55                   	push   %ebp
80106495:	89 e5                	mov    %esp,%ebp
80106497:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106498:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010649b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010649e:	50                   	push   %eax
8010649f:	6a 00                	push   $0x0
801064a1:	e8 ba f1 ff ff       	call   80105660 <argint>
801064a6:	83 c4 10             	add    $0x10,%esp
801064a9:	85 c0                	test   %eax,%eax
801064ab:	78 23                	js     801064d0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801064ad:	e8 4e df ff ff       	call   80104400 <myproc>
  if(growproc(n) < 0)
801064b2:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801064b5:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801064b7:	ff 75 f4             	pushl  -0xc(%ebp)
801064ba:	e8 71 e0 ff ff       	call   80104530 <growproc>
801064bf:	83 c4 10             	add    $0x10,%esp
801064c2:	85 c0                	test   %eax,%eax
801064c4:	78 0a                	js     801064d0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801064c6:	89 d8                	mov    %ebx,%eax
801064c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064cb:	c9                   	leave  
801064cc:	c3                   	ret    
801064cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801064d0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801064d5:	eb ef                	jmp    801064c6 <sys_sbrk+0x36>
801064d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064de:	66 90                	xchg   %ax,%ax

801064e0 <sys_sleep>:

int
sys_sleep(void)
{
801064e0:	f3 0f 1e fb          	endbr32 
801064e4:	55                   	push   %ebp
801064e5:	89 e5                	mov    %esp,%ebp
801064e7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801064e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801064eb:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801064ee:	50                   	push   %eax
801064ef:	6a 00                	push   $0x0
801064f1:	e8 6a f1 ff ff       	call   80105660 <argint>
801064f6:	83 c4 10             	add    $0x10,%esp
801064f9:	85 c0                	test   %eax,%eax
801064fb:	0f 88 86 00 00 00    	js     80106587 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80106501:	83 ec 0c             	sub    $0xc,%esp
80106504:	68 c0 30 39 80       	push   $0x803930c0
80106509:	e8 62 ed ff ff       	call   80105270 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010650e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106511:	8b 1d 00 39 39 80    	mov    0x80393900,%ebx
  while(ticks - ticks0 < n){
80106517:	83 c4 10             	add    $0x10,%esp
8010651a:	85 d2                	test   %edx,%edx
8010651c:	75 23                	jne    80106541 <sys_sleep+0x61>
8010651e:	eb 50                	jmp    80106570 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106520:	83 ec 08             	sub    $0x8,%esp
80106523:	68 c0 30 39 80       	push   $0x803930c0
80106528:	68 00 39 39 80       	push   $0x80393900
8010652d:	e8 ce e4 ff ff       	call   80104a00 <sleep>
  while(ticks - ticks0 < n){
80106532:	a1 00 39 39 80       	mov    0x80393900,%eax
80106537:	83 c4 10             	add    $0x10,%esp
8010653a:	29 d8                	sub    %ebx,%eax
8010653c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010653f:	73 2f                	jae    80106570 <sys_sleep+0x90>
    if(myproc()->killed){
80106541:	e8 ba de ff ff       	call   80104400 <myproc>
80106546:	8b 40 24             	mov    0x24(%eax),%eax
80106549:	85 c0                	test   %eax,%eax
8010654b:	74 d3                	je     80106520 <sys_sleep+0x40>
      release(&tickslock);
8010654d:	83 ec 0c             	sub    $0xc,%esp
80106550:	68 c0 30 39 80       	push   $0x803930c0
80106555:	e8 d6 ed ff ff       	call   80105330 <release>
  }
  release(&tickslock);
  return 0;
}
8010655a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010655d:	83 c4 10             	add    $0x10,%esp
80106560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106565:	c9                   	leave  
80106566:	c3                   	ret    
80106567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010656e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106570:	83 ec 0c             	sub    $0xc,%esp
80106573:	68 c0 30 39 80       	push   $0x803930c0
80106578:	e8 b3 ed ff ff       	call   80105330 <release>
  return 0;
8010657d:	83 c4 10             	add    $0x10,%esp
80106580:	31 c0                	xor    %eax,%eax
}
80106582:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106585:	c9                   	leave  
80106586:	c3                   	ret    
    return -1;
80106587:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010658c:	eb f4                	jmp    80106582 <sys_sleep+0xa2>
8010658e:	66 90                	xchg   %ax,%ax

80106590 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106590:	f3 0f 1e fb          	endbr32 
80106594:	55                   	push   %ebp
80106595:	89 e5                	mov    %esp,%ebp
80106597:	53                   	push   %ebx
80106598:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010659b:	68 c0 30 39 80       	push   $0x803930c0
801065a0:	e8 cb ec ff ff       	call   80105270 <acquire>
  xticks = ticks;
801065a5:	8b 1d 00 39 39 80    	mov    0x80393900,%ebx
  release(&tickslock);
801065ab:	c7 04 24 c0 30 39 80 	movl   $0x803930c0,(%esp)
801065b2:	e8 79 ed ff ff       	call   80105330 <release>
  return xticks;
}
801065b7:	89 d8                	mov    %ebx,%eax
801065b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065bc:	c9                   	leave  
801065bd:	c3                   	ret    
801065be:	66 90                	xchg   %ax,%ax

801065c0 <sys_wait_for_process>:

int
sys_wait_for_process(void)
{
801065c0:	f3 0f 1e fb          	endbr32 
801065c4:	55                   	push   %ebp
801065c5:	89 e5                	mov    %esp,%ebp
801065c7:	83 ec 20             	sub    $0x20,%esp
  int pid;
  if(argint(0, &pid)<0){
801065ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065cd:	50                   	push   %eax
801065ce:	6a 00                	push   $0x0
801065d0:	e8 8b f0 ff ff       	call   80105660 <argint>
801065d5:	83 c4 10             	add    $0x10,%esp
801065d8:	85 c0                	test   %eax,%eax
801065da:	78 14                	js     801065f0 <sys_wait_for_process+0x30>
    return -1;
  }
  else{
    return wait_for_process(pid);
801065dc:	83 ec 0c             	sub    $0xc,%esp
801065df:	ff 75 f4             	pushl  -0xc(%ebp)
801065e2:	e8 b9 e7 ff ff       	call   80104da0 <wait_for_process>
801065e7:	83 c4 10             	add    $0x10,%esp
  }

}
801065ea:	c9                   	leave  
801065eb:	c3                   	ret    
801065ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065f0:	c9                   	leave  
    return -1;
801065f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065f6:	c3                   	ret    
801065f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065fe:	66 90                	xchg   %ax,%ax

80106600 <sys_find_next_prime_number>:

int
sys_find_next_prime_number(void)
{
80106600:	f3 0f 1e fb          	endbr32 
80106604:	55                   	push   %ebp
80106605:	89 e5                	mov    %esp,%ebp
80106607:	53                   	push   %ebx
80106608:	83 ec 04             	sub    $0x4,%esp
  int number = myproc()->tf->ebx; //register after eax
8010660b:	e8 f0 dd ff ff       	call   80104400 <myproc>
  cprintf("Kernel: sys_find_next_prime_number() called for number %d\n", number);
80106610:	83 ec 08             	sub    $0x8,%esp
  int number = myproc()->tf->ebx; //register after eax
80106613:	8b 40 18             	mov    0x18(%eax),%eax
80106616:	8b 58 10             	mov    0x10(%eax),%ebx
  cprintf("Kernel: sys_find_next_prime_number() called for number %d\n", number);
80106619:	53                   	push   %ebx
8010661a:	68 1c 87 10 80       	push   $0x8010871c
8010661f:	e8 cc a0 ff ff       	call   801006f0 <cprintf>
  return find_next_prime_number(number);
80106624:	89 1c 24             	mov    %ebx,(%esp)
80106627:	e8 34 e9 ff ff       	call   80104f60 <find_next_prime_number>
}
8010662c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010662f:	c9                   	leave  
80106630:	c3                   	ret    
80106631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010663f:	90                   	nop

80106640 <sys_get_call_count>:

int sys_get_call_count(void){
80106640:	f3 0f 1e fb          	endbr32 
80106644:	55                   	push   %ebp
80106645:	89 e5                	mov    %esp,%ebp
80106647:	83 ec 20             	sub    $0x20,%esp
  int n;
  if(argint(0, &n) < 0)
8010664a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010664d:	50                   	push   %eax
8010664e:	6a 00                	push   $0x0
80106650:	e8 0b f0 ff ff       	call   80105660 <argint>
80106655:	83 c4 10             	add    $0x10,%esp
80106658:	85 c0                	test   %eax,%eax
8010665a:	78 14                	js     80106670 <sys_get_call_count+0x30>
    return -1;
  return(myproc()->callcount[n-1]);
8010665c:	e8 9f dd ff ff       	call   80104400 <myproc>
80106661:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106664:	8b 44 90 7c          	mov    0x7c(%eax,%edx,4),%eax
}
80106668:	c9                   	leave  
80106669:	c3                   	ret    
8010666a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106670:	c9                   	leave  
    return -1;
80106671:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106676:	c3                   	ret    
80106677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010667e:	66 90                	xchg   %ax,%ax

80106680 <sys_get_most_caller>:

int sys_get_most_caller()
{
80106680:	f3 0f 1e fb          	endbr32 
80106684:	55                   	push   %ebp
80106685:	89 e5                	mov    %esp,%ebp
80106687:	57                   	push   %edi
80106688:	56                   	push   %esi
  int n;
  if(argint(0, &n) < 0)
80106689:	8d 45 e4             	lea    -0x1c(%ebp),%eax
{
8010668c:	53                   	push   %ebx
8010668d:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, &n) < 0)
80106690:	50                   	push   %eax
80106691:	6a 00                	push   $0x0
80106693:	e8 c8 ef ff ff       	call   80105660 <argint>
80106698:	83 c4 10             	add    $0x10,%esp
8010669b:	85 c0                	test   %eax,%eax
8010669d:	78 5f                	js     801066fe <sys_get_most_caller+0x7e>
    return -1;
  
  int index = -1;
  int max = -1;

  for(int i = 0; i < 100; i++){
8010669f:	31 ff                	xor    %edi,%edi
  int max = -1;
801066a1:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  int index = -1;
801066a6:	be ff ff ff ff       	mov    $0xffffffff,%esi
801066ab:	eb 0b                	jmp    801066b8 <sys_get_most_caller+0x38>
801066ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(int i = 0; i < 100; i++){
801066b0:	83 c7 01             	add    $0x1,%edi
801066b3:	83 ff 64             	cmp    $0x64,%edi
801066b6:	74 3c                	je     801066f4 <sys_get_most_caller+0x74>
    if(max < myproc()->caller_count[n-1][i]){
801066b8:	e8 43 dd ff ff       	call   80104400 <myproc>
801066bd:	89 c2                	mov    %eax,%edx
801066bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066c2:	83 e8 01             	sub    $0x1,%eax
801066c5:	6b c0 64             	imul   $0x64,%eax,%eax
801066c8:	8d 44 07 38          	lea    0x38(%edi,%eax,1),%eax
801066cc:	39 5c 82 0c          	cmp    %ebx,0xc(%edx,%eax,4)
801066d0:	7e de                	jle    801066b0 <sys_get_most_caller+0x30>
      max = myproc()->caller_count[n-1][i];
801066d2:	e8 29 dd ff ff       	call   80104400 <myproc>
801066d7:	89 fe                	mov    %edi,%esi
801066d9:	89 c2                	mov    %eax,%edx
801066db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066de:	83 e8 01             	sub    $0x1,%eax
801066e1:	6b c0 64             	imul   $0x64,%eax,%eax
801066e4:	8d 44 07 38          	lea    0x38(%edi,%eax,1),%eax
  for(int i = 0; i < 100; i++){
801066e8:	83 c7 01             	add    $0x1,%edi
      max = myproc()->caller_count[n-1][i];
801066eb:	8b 5c 82 0c          	mov    0xc(%edx,%eax,4),%ebx
  for(int i = 0; i < 100; i++){
801066ef:	83 ff 64             	cmp    $0x64,%edi
801066f2:	75 c4                	jne    801066b8 <sys_get_most_caller+0x38>
      index = i;
    }
  }
  return index;
801066f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066f7:	89 f0                	mov    %esi,%eax
801066f9:	5b                   	pop    %ebx
801066fa:	5e                   	pop    %esi
801066fb:	5f                   	pop    %edi
801066fc:	5d                   	pop    %ebp
801066fd:	c3                   	ret    
    return -1;
801066fe:	be ff ff ff ff       	mov    $0xffffffff,%esi
80106703:	eb ef                	jmp    801066f4 <sys_get_most_caller+0x74>

80106705 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106705:	1e                   	push   %ds
  pushl %es
80106706:	06                   	push   %es
  pushl %fs
80106707:	0f a0                	push   %fs
  pushl %gs
80106709:	0f a8                	push   %gs
  pushal
8010670b:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010670c:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106710:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106712:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106714:	54                   	push   %esp
  call trap
80106715:	e8 c6 00 00 00       	call   801067e0 <trap>
  addl $4, %esp
8010671a:	83 c4 04             	add    $0x4,%esp

8010671d <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010671d:	61                   	popa   
  popl %gs
8010671e:	0f a9                	pop    %gs
  popl %fs
80106720:	0f a1                	pop    %fs
  popl %es
80106722:	07                   	pop    %es
  popl %ds
80106723:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106724:	83 c4 08             	add    $0x8,%esp
  iret
80106727:	cf                   	iret   
80106728:	66 90                	xchg   %ax,%ax
8010672a:	66 90                	xchg   %ax,%ax
8010672c:	66 90                	xchg   %ax,%ax
8010672e:	66 90                	xchg   %ax,%ax

80106730 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106730:	f3 0f 1e fb          	endbr32 
80106734:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106735:	31 c0                	xor    %eax,%eax
{
80106737:	89 e5                	mov    %esp,%ebp
80106739:	83 ec 08             	sub    $0x8,%esp
8010673c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106740:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106747:	c7 04 c5 02 31 39 80 	movl   $0x8e000008,-0x7fc6cefe(,%eax,8)
8010674e:	08 00 00 8e 
80106752:	66 89 14 c5 00 31 39 	mov    %dx,-0x7fc6cf00(,%eax,8)
80106759:	80 
8010675a:	c1 ea 10             	shr    $0x10,%edx
8010675d:	66 89 14 c5 06 31 39 	mov    %dx,-0x7fc6cefa(,%eax,8)
80106764:	80 
  for(i = 0; i < 256; i++)
80106765:	83 c0 01             	add    $0x1,%eax
80106768:	3d 00 01 00 00       	cmp    $0x100,%eax
8010676d:	75 d1                	jne    80106740 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010676f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106772:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106777:	c7 05 02 33 39 80 08 	movl   $0xef000008,0x80393302
8010677e:	00 00 ef 
  initlock(&tickslock, "time");
80106781:	68 57 87 10 80       	push   $0x80108757
80106786:	68 c0 30 39 80       	push   $0x803930c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010678b:	66 a3 00 33 39 80    	mov    %ax,0x80393300
80106791:	c1 e8 10             	shr    $0x10,%eax
80106794:	66 a3 06 33 39 80    	mov    %ax,0x80393306
  initlock(&tickslock, "time");
8010679a:	e8 51 e9 ff ff       	call   801050f0 <initlock>
}
8010679f:	83 c4 10             	add    $0x10,%esp
801067a2:	c9                   	leave  
801067a3:	c3                   	ret    
801067a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067af:	90                   	nop

801067b0 <idtinit>:

void
idtinit(void)
{
801067b0:	f3 0f 1e fb          	endbr32 
801067b4:	55                   	push   %ebp
  pd[0] = size-1;
801067b5:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801067ba:	89 e5                	mov    %esp,%ebp
801067bc:	83 ec 10             	sub    $0x10,%esp
801067bf:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801067c3:	b8 00 31 39 80       	mov    $0x80393100,%eax
801067c8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801067cc:	c1 e8 10             	shr    $0x10,%eax
801067cf:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801067d3:	8d 45 fa             	lea    -0x6(%ebp),%eax
801067d6:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801067d9:	c9                   	leave  
801067da:	c3                   	ret    
801067db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067df:	90                   	nop

801067e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801067e0:	f3 0f 1e fb          	endbr32 
801067e4:	55                   	push   %ebp
801067e5:	89 e5                	mov    %esp,%ebp
801067e7:	57                   	push   %edi
801067e8:	56                   	push   %esi
801067e9:	53                   	push   %ebx
801067ea:	83 ec 1c             	sub    $0x1c,%esp
801067ed:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801067f0:	8b 43 30             	mov    0x30(%ebx),%eax
801067f3:	83 f8 40             	cmp    $0x40,%eax
801067f6:	0f 84 bc 01 00 00    	je     801069b8 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801067fc:	83 e8 20             	sub    $0x20,%eax
801067ff:	83 f8 1f             	cmp    $0x1f,%eax
80106802:	77 08                	ja     8010680c <trap+0x2c>
80106804:	3e ff 24 85 00 88 10 	notrack jmp *-0x7fef7800(,%eax,4)
8010680b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010680c:	e8 ef db ff ff       	call   80104400 <myproc>
80106811:	8b 7b 38             	mov    0x38(%ebx),%edi
80106814:	85 c0                	test   %eax,%eax
80106816:	0f 84 eb 01 00 00    	je     80106a07 <trap+0x227>
8010681c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106820:	0f 84 e1 01 00 00    	je     80106a07 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106826:	0f 20 d1             	mov    %cr2,%ecx
80106829:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010682c:	e8 af db ff ff       	call   801043e0 <cpuid>
80106831:	8b 73 30             	mov    0x30(%ebx),%esi
80106834:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106837:	8b 43 34             	mov    0x34(%ebx),%eax
8010683a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010683d:	e8 be db ff ff       	call   80104400 <myproc>
80106842:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106845:	e8 b6 db ff ff       	call   80104400 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010684a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010684d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106850:	51                   	push   %ecx
80106851:	57                   	push   %edi
80106852:	52                   	push   %edx
80106853:	ff 75 e4             	pushl  -0x1c(%ebp)
80106856:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106857:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010685a:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010685d:	56                   	push   %esi
8010685e:	ff 70 10             	pushl  0x10(%eax)
80106861:	68 bc 87 10 80       	push   $0x801087bc
80106866:	e8 85 9e ff ff       	call   801006f0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010686b:	83 c4 20             	add    $0x20,%esp
8010686e:	e8 8d db ff ff       	call   80104400 <myproc>
80106873:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010687a:	e8 81 db ff ff       	call   80104400 <myproc>
8010687f:	85 c0                	test   %eax,%eax
80106881:	74 1d                	je     801068a0 <trap+0xc0>
80106883:	e8 78 db ff ff       	call   80104400 <myproc>
80106888:	8b 50 24             	mov    0x24(%eax),%edx
8010688b:	85 d2                	test   %edx,%edx
8010688d:	74 11                	je     801068a0 <trap+0xc0>
8010688f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106893:	83 e0 03             	and    $0x3,%eax
80106896:	66 83 f8 03          	cmp    $0x3,%ax
8010689a:	0f 84 50 01 00 00    	je     801069f0 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801068a0:	e8 5b db ff ff       	call   80104400 <myproc>
801068a5:	85 c0                	test   %eax,%eax
801068a7:	74 0f                	je     801068b8 <trap+0xd8>
801068a9:	e8 52 db ff ff       	call   80104400 <myproc>
801068ae:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801068b2:	0f 84 e8 00 00 00    	je     801069a0 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068b8:	e8 43 db ff ff       	call   80104400 <myproc>
801068bd:	85 c0                	test   %eax,%eax
801068bf:	74 1d                	je     801068de <trap+0xfe>
801068c1:	e8 3a db ff ff       	call   80104400 <myproc>
801068c6:	8b 40 24             	mov    0x24(%eax),%eax
801068c9:	85 c0                	test   %eax,%eax
801068cb:	74 11                	je     801068de <trap+0xfe>
801068cd:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801068d1:	83 e0 03             	and    $0x3,%eax
801068d4:	66 83 f8 03          	cmp    $0x3,%ax
801068d8:	0f 84 03 01 00 00    	je     801069e1 <trap+0x201>
    exit();
}
801068de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068e1:	5b                   	pop    %ebx
801068e2:	5e                   	pop    %esi
801068e3:	5f                   	pop    %edi
801068e4:	5d                   	pop    %ebp
801068e5:	c3                   	ret    
    ideintr();
801068e6:	e8 45 c3 ff ff       	call   80102c30 <ideintr>
    lapiceoi();
801068eb:	e8 20 ca ff ff       	call   80103310 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068f0:	e8 0b db ff ff       	call   80104400 <myproc>
801068f5:	85 c0                	test   %eax,%eax
801068f7:	75 8a                	jne    80106883 <trap+0xa3>
801068f9:	eb a5                	jmp    801068a0 <trap+0xc0>
    if(cpuid() == 0){
801068fb:	e8 e0 da ff ff       	call   801043e0 <cpuid>
80106900:	85 c0                	test   %eax,%eax
80106902:	75 e7                	jne    801068eb <trap+0x10b>
      acquire(&tickslock);
80106904:	83 ec 0c             	sub    $0xc,%esp
80106907:	68 c0 30 39 80       	push   $0x803930c0
8010690c:	e8 5f e9 ff ff       	call   80105270 <acquire>
      wakeup(&ticks);
80106911:	c7 04 24 00 39 39 80 	movl   $0x80393900,(%esp)
      ticks++;
80106918:	83 05 00 39 39 80 01 	addl   $0x1,0x80393900
      wakeup(&ticks);
8010691f:	e8 9c e2 ff ff       	call   80104bc0 <wakeup>
      release(&tickslock);
80106924:	c7 04 24 c0 30 39 80 	movl   $0x803930c0,(%esp)
8010692b:	e8 00 ea ff ff       	call   80105330 <release>
80106930:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106933:	eb b6                	jmp    801068eb <trap+0x10b>
    kbdintr();
80106935:	e8 96 c8 ff ff       	call   801031d0 <kbdintr>
    lapiceoi();
8010693a:	e8 d1 c9 ff ff       	call   80103310 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010693f:	e8 bc da ff ff       	call   80104400 <myproc>
80106944:	85 c0                	test   %eax,%eax
80106946:	0f 85 37 ff ff ff    	jne    80106883 <trap+0xa3>
8010694c:	e9 4f ff ff ff       	jmp    801068a0 <trap+0xc0>
    uartintr();
80106951:	e8 4a 02 00 00       	call   80106ba0 <uartintr>
    lapiceoi();
80106956:	e8 b5 c9 ff ff       	call   80103310 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010695b:	e8 a0 da ff ff       	call   80104400 <myproc>
80106960:	85 c0                	test   %eax,%eax
80106962:	0f 85 1b ff ff ff    	jne    80106883 <trap+0xa3>
80106968:	e9 33 ff ff ff       	jmp    801068a0 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010696d:	8b 7b 38             	mov    0x38(%ebx),%edi
80106970:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106974:	e8 67 da ff ff       	call   801043e0 <cpuid>
80106979:	57                   	push   %edi
8010697a:	56                   	push   %esi
8010697b:	50                   	push   %eax
8010697c:	68 64 87 10 80       	push   $0x80108764
80106981:	e8 6a 9d ff ff       	call   801006f0 <cprintf>
    lapiceoi();
80106986:	e8 85 c9 ff ff       	call   80103310 <lapiceoi>
    break;
8010698b:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010698e:	e8 6d da ff ff       	call   80104400 <myproc>
80106993:	85 c0                	test   %eax,%eax
80106995:	0f 85 e8 fe ff ff    	jne    80106883 <trap+0xa3>
8010699b:	e9 00 ff ff ff       	jmp    801068a0 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
801069a0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801069a4:	0f 85 0e ff ff ff    	jne    801068b8 <trap+0xd8>
    yield();
801069aa:	e8 01 e0 ff ff       	call   801049b0 <yield>
801069af:	e9 04 ff ff ff       	jmp    801068b8 <trap+0xd8>
801069b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801069b8:	e8 43 da ff ff       	call   80104400 <myproc>
801069bd:	8b 70 24             	mov    0x24(%eax),%esi
801069c0:	85 f6                	test   %esi,%esi
801069c2:	75 3c                	jne    80106a00 <trap+0x220>
    myproc()->tf = tf;
801069c4:	e8 37 da ff ff       	call   80104400 <myproc>
801069c9:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801069cc:	e8 7f ed ff ff       	call   80105750 <syscall>
    if(myproc()->killed)
801069d1:	e8 2a da ff ff       	call   80104400 <myproc>
801069d6:	8b 48 24             	mov    0x24(%eax),%ecx
801069d9:	85 c9                	test   %ecx,%ecx
801069db:	0f 84 fd fe ff ff    	je     801068de <trap+0xfe>
}
801069e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069e4:	5b                   	pop    %ebx
801069e5:	5e                   	pop    %esi
801069e6:	5f                   	pop    %edi
801069e7:	5d                   	pop    %ebp
      exit();
801069e8:	e9 43 de ff ff       	jmp    80104830 <exit>
801069ed:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
801069f0:	e8 3b de ff ff       	call   80104830 <exit>
801069f5:	e9 a6 fe ff ff       	jmp    801068a0 <trap+0xc0>
801069fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106a00:	e8 2b de ff ff       	call   80104830 <exit>
80106a05:	eb bd                	jmp    801069c4 <trap+0x1e4>
80106a07:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106a0a:	e8 d1 d9 ff ff       	call   801043e0 <cpuid>
80106a0f:	83 ec 0c             	sub    $0xc,%esp
80106a12:	56                   	push   %esi
80106a13:	57                   	push   %edi
80106a14:	50                   	push   %eax
80106a15:	ff 73 30             	pushl  0x30(%ebx)
80106a18:	68 88 87 10 80       	push   $0x80108788
80106a1d:	e8 ce 9c ff ff       	call   801006f0 <cprintf>
      panic("trap");
80106a22:	83 c4 14             	add    $0x14,%esp
80106a25:	68 5c 87 10 80       	push   $0x8010875c
80106a2a:	e8 61 99 ff ff       	call   80100390 <panic>
80106a2f:	90                   	nop

80106a30 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106a30:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106a34:	a1 00 52 11 80       	mov    0x80115200,%eax
80106a39:	85 c0                	test   %eax,%eax
80106a3b:	74 1b                	je     80106a58 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a3d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106a42:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106a43:	a8 01                	test   $0x1,%al
80106a45:	74 11                	je     80106a58 <uartgetc+0x28>
80106a47:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a4c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106a4d:	0f b6 c0             	movzbl %al,%eax
80106a50:	c3                   	ret    
80106a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a5d:	c3                   	ret    
80106a5e:	66 90                	xchg   %ax,%ax

80106a60 <uartputc.part.0>:
uartputc(int c)
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	57                   	push   %edi
80106a64:	89 c7                	mov    %eax,%edi
80106a66:	56                   	push   %esi
80106a67:	be fd 03 00 00       	mov    $0x3fd,%esi
80106a6c:	53                   	push   %ebx
80106a6d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106a72:	83 ec 0c             	sub    $0xc,%esp
80106a75:	eb 1b                	jmp    80106a92 <uartputc.part.0+0x32>
80106a77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a7e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106a80:	83 ec 0c             	sub    $0xc,%esp
80106a83:	6a 0a                	push   $0xa
80106a85:	e8 a6 c8 ff ff       	call   80103330 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a8a:	83 c4 10             	add    $0x10,%esp
80106a8d:	83 eb 01             	sub    $0x1,%ebx
80106a90:	74 07                	je     80106a99 <uartputc.part.0+0x39>
80106a92:	89 f2                	mov    %esi,%edx
80106a94:	ec                   	in     (%dx),%al
80106a95:	a8 20                	test   $0x20,%al
80106a97:	74 e7                	je     80106a80 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a99:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a9e:	89 f8                	mov    %edi,%eax
80106aa0:	ee                   	out    %al,(%dx)
}
80106aa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106aa4:	5b                   	pop    %ebx
80106aa5:	5e                   	pop    %esi
80106aa6:	5f                   	pop    %edi
80106aa7:	5d                   	pop    %ebp
80106aa8:	c3                   	ret    
80106aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ab0 <uartinit>:
{
80106ab0:	f3 0f 1e fb          	endbr32 
80106ab4:	55                   	push   %ebp
80106ab5:	31 c9                	xor    %ecx,%ecx
80106ab7:	89 c8                	mov    %ecx,%eax
80106ab9:	89 e5                	mov    %esp,%ebp
80106abb:	57                   	push   %edi
80106abc:	56                   	push   %esi
80106abd:	53                   	push   %ebx
80106abe:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106ac3:	89 da                	mov    %ebx,%edx
80106ac5:	83 ec 0c             	sub    $0xc,%esp
80106ac8:	ee                   	out    %al,(%dx)
80106ac9:	bf fb 03 00 00       	mov    $0x3fb,%edi
80106ace:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106ad3:	89 fa                	mov    %edi,%edx
80106ad5:	ee                   	out    %al,(%dx)
80106ad6:	b8 0c 00 00 00       	mov    $0xc,%eax
80106adb:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106ae0:	ee                   	out    %al,(%dx)
80106ae1:	be f9 03 00 00       	mov    $0x3f9,%esi
80106ae6:	89 c8                	mov    %ecx,%eax
80106ae8:	89 f2                	mov    %esi,%edx
80106aea:	ee                   	out    %al,(%dx)
80106aeb:	b8 03 00 00 00       	mov    $0x3,%eax
80106af0:	89 fa                	mov    %edi,%edx
80106af2:	ee                   	out    %al,(%dx)
80106af3:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106af8:	89 c8                	mov    %ecx,%eax
80106afa:	ee                   	out    %al,(%dx)
80106afb:	b8 01 00 00 00       	mov    $0x1,%eax
80106b00:	89 f2                	mov    %esi,%edx
80106b02:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b03:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106b08:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106b09:	3c ff                	cmp    $0xff,%al
80106b0b:	74 52                	je     80106b5f <uartinit+0xaf>
  uart = 1;
80106b0d:	c7 05 00 52 11 80 01 	movl   $0x1,0x80115200
80106b14:	00 00 00 
80106b17:	89 da                	mov    %ebx,%edx
80106b19:	ec                   	in     (%dx),%al
80106b1a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b1f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106b20:	83 ec 08             	sub    $0x8,%esp
80106b23:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106b28:	bb 80 88 10 80       	mov    $0x80108880,%ebx
  ioapicenable(IRQ_COM1, 0);
80106b2d:	6a 00                	push   $0x0
80106b2f:	6a 04                	push   $0x4
80106b31:	e8 4a c3 ff ff       	call   80102e80 <ioapicenable>
80106b36:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106b39:	b8 78 00 00 00       	mov    $0x78,%eax
80106b3e:	eb 04                	jmp    80106b44 <uartinit+0x94>
80106b40:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106b44:	8b 15 00 52 11 80    	mov    0x80115200,%edx
80106b4a:	85 d2                	test   %edx,%edx
80106b4c:	74 08                	je     80106b56 <uartinit+0xa6>
    uartputc(*p);
80106b4e:	0f be c0             	movsbl %al,%eax
80106b51:	e8 0a ff ff ff       	call   80106a60 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106b56:	89 f0                	mov    %esi,%eax
80106b58:	83 c3 01             	add    $0x1,%ebx
80106b5b:	84 c0                	test   %al,%al
80106b5d:	75 e1                	jne    80106b40 <uartinit+0x90>
}
80106b5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b62:	5b                   	pop    %ebx
80106b63:	5e                   	pop    %esi
80106b64:	5f                   	pop    %edi
80106b65:	5d                   	pop    %ebp
80106b66:	c3                   	ret    
80106b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b6e:	66 90                	xchg   %ax,%ax

80106b70 <uartputc>:
{
80106b70:	f3 0f 1e fb          	endbr32 
80106b74:	55                   	push   %ebp
  if(!uart)
80106b75:	8b 15 00 52 11 80    	mov    0x80115200,%edx
{
80106b7b:	89 e5                	mov    %esp,%ebp
80106b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106b80:	85 d2                	test   %edx,%edx
80106b82:	74 0c                	je     80106b90 <uartputc+0x20>
}
80106b84:	5d                   	pop    %ebp
80106b85:	e9 d6 fe ff ff       	jmp    80106a60 <uartputc.part.0>
80106b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b90:	5d                   	pop    %ebp
80106b91:	c3                   	ret    
80106b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ba0 <uartintr>:

void
uartintr(void)
{
80106ba0:	f3 0f 1e fb          	endbr32 
80106ba4:	55                   	push   %ebp
80106ba5:	89 e5                	mov    %esp,%ebp
80106ba7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106baa:	68 30 6a 10 80       	push   $0x80106a30
80106baf:	e8 3c a1 ff ff       	call   80100cf0 <consoleintr>
}
80106bb4:	83 c4 10             	add    $0x10,%esp
80106bb7:	c9                   	leave  
80106bb8:	c3                   	ret    

80106bb9 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106bb9:	6a 00                	push   $0x0
  pushl $0
80106bbb:	6a 00                	push   $0x0
  jmp alltraps
80106bbd:	e9 43 fb ff ff       	jmp    80106705 <alltraps>

80106bc2 <vector1>:
.globl vector1
vector1:
  pushl $0
80106bc2:	6a 00                	push   $0x0
  pushl $1
80106bc4:	6a 01                	push   $0x1
  jmp alltraps
80106bc6:	e9 3a fb ff ff       	jmp    80106705 <alltraps>

80106bcb <vector2>:
.globl vector2
vector2:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $2
80106bcd:	6a 02                	push   $0x2
  jmp alltraps
80106bcf:	e9 31 fb ff ff       	jmp    80106705 <alltraps>

80106bd4 <vector3>:
.globl vector3
vector3:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $3
80106bd6:	6a 03                	push   $0x3
  jmp alltraps
80106bd8:	e9 28 fb ff ff       	jmp    80106705 <alltraps>

80106bdd <vector4>:
.globl vector4
vector4:
  pushl $0
80106bdd:	6a 00                	push   $0x0
  pushl $4
80106bdf:	6a 04                	push   $0x4
  jmp alltraps
80106be1:	e9 1f fb ff ff       	jmp    80106705 <alltraps>

80106be6 <vector5>:
.globl vector5
vector5:
  pushl $0
80106be6:	6a 00                	push   $0x0
  pushl $5
80106be8:	6a 05                	push   $0x5
  jmp alltraps
80106bea:	e9 16 fb ff ff       	jmp    80106705 <alltraps>

80106bef <vector6>:
.globl vector6
vector6:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $6
80106bf1:	6a 06                	push   $0x6
  jmp alltraps
80106bf3:	e9 0d fb ff ff       	jmp    80106705 <alltraps>

80106bf8 <vector7>:
.globl vector7
vector7:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $7
80106bfa:	6a 07                	push   $0x7
  jmp alltraps
80106bfc:	e9 04 fb ff ff       	jmp    80106705 <alltraps>

80106c01 <vector8>:
.globl vector8
vector8:
  pushl $8
80106c01:	6a 08                	push   $0x8
  jmp alltraps
80106c03:	e9 fd fa ff ff       	jmp    80106705 <alltraps>

80106c08 <vector9>:
.globl vector9
vector9:
  pushl $0
80106c08:	6a 00                	push   $0x0
  pushl $9
80106c0a:	6a 09                	push   $0x9
  jmp alltraps
80106c0c:	e9 f4 fa ff ff       	jmp    80106705 <alltraps>

80106c11 <vector10>:
.globl vector10
vector10:
  pushl $10
80106c11:	6a 0a                	push   $0xa
  jmp alltraps
80106c13:	e9 ed fa ff ff       	jmp    80106705 <alltraps>

80106c18 <vector11>:
.globl vector11
vector11:
  pushl $11
80106c18:	6a 0b                	push   $0xb
  jmp alltraps
80106c1a:	e9 e6 fa ff ff       	jmp    80106705 <alltraps>

80106c1f <vector12>:
.globl vector12
vector12:
  pushl $12
80106c1f:	6a 0c                	push   $0xc
  jmp alltraps
80106c21:	e9 df fa ff ff       	jmp    80106705 <alltraps>

80106c26 <vector13>:
.globl vector13
vector13:
  pushl $13
80106c26:	6a 0d                	push   $0xd
  jmp alltraps
80106c28:	e9 d8 fa ff ff       	jmp    80106705 <alltraps>

80106c2d <vector14>:
.globl vector14
vector14:
  pushl $14
80106c2d:	6a 0e                	push   $0xe
  jmp alltraps
80106c2f:	e9 d1 fa ff ff       	jmp    80106705 <alltraps>

80106c34 <vector15>:
.globl vector15
vector15:
  pushl $0
80106c34:	6a 00                	push   $0x0
  pushl $15
80106c36:	6a 0f                	push   $0xf
  jmp alltraps
80106c38:	e9 c8 fa ff ff       	jmp    80106705 <alltraps>

80106c3d <vector16>:
.globl vector16
vector16:
  pushl $0
80106c3d:	6a 00                	push   $0x0
  pushl $16
80106c3f:	6a 10                	push   $0x10
  jmp alltraps
80106c41:	e9 bf fa ff ff       	jmp    80106705 <alltraps>

80106c46 <vector17>:
.globl vector17
vector17:
  pushl $17
80106c46:	6a 11                	push   $0x11
  jmp alltraps
80106c48:	e9 b8 fa ff ff       	jmp    80106705 <alltraps>

80106c4d <vector18>:
.globl vector18
vector18:
  pushl $0
80106c4d:	6a 00                	push   $0x0
  pushl $18
80106c4f:	6a 12                	push   $0x12
  jmp alltraps
80106c51:	e9 af fa ff ff       	jmp    80106705 <alltraps>

80106c56 <vector19>:
.globl vector19
vector19:
  pushl $0
80106c56:	6a 00                	push   $0x0
  pushl $19
80106c58:	6a 13                	push   $0x13
  jmp alltraps
80106c5a:	e9 a6 fa ff ff       	jmp    80106705 <alltraps>

80106c5f <vector20>:
.globl vector20
vector20:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $20
80106c61:	6a 14                	push   $0x14
  jmp alltraps
80106c63:	e9 9d fa ff ff       	jmp    80106705 <alltraps>

80106c68 <vector21>:
.globl vector21
vector21:
  pushl $0
80106c68:	6a 00                	push   $0x0
  pushl $21
80106c6a:	6a 15                	push   $0x15
  jmp alltraps
80106c6c:	e9 94 fa ff ff       	jmp    80106705 <alltraps>

80106c71 <vector22>:
.globl vector22
vector22:
  pushl $0
80106c71:	6a 00                	push   $0x0
  pushl $22
80106c73:	6a 16                	push   $0x16
  jmp alltraps
80106c75:	e9 8b fa ff ff       	jmp    80106705 <alltraps>

80106c7a <vector23>:
.globl vector23
vector23:
  pushl $0
80106c7a:	6a 00                	push   $0x0
  pushl $23
80106c7c:	6a 17                	push   $0x17
  jmp alltraps
80106c7e:	e9 82 fa ff ff       	jmp    80106705 <alltraps>

80106c83 <vector24>:
.globl vector24
vector24:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $24
80106c85:	6a 18                	push   $0x18
  jmp alltraps
80106c87:	e9 79 fa ff ff       	jmp    80106705 <alltraps>

80106c8c <vector25>:
.globl vector25
vector25:
  pushl $0
80106c8c:	6a 00                	push   $0x0
  pushl $25
80106c8e:	6a 19                	push   $0x19
  jmp alltraps
80106c90:	e9 70 fa ff ff       	jmp    80106705 <alltraps>

80106c95 <vector26>:
.globl vector26
vector26:
  pushl $0
80106c95:	6a 00                	push   $0x0
  pushl $26
80106c97:	6a 1a                	push   $0x1a
  jmp alltraps
80106c99:	e9 67 fa ff ff       	jmp    80106705 <alltraps>

80106c9e <vector27>:
.globl vector27
vector27:
  pushl $0
80106c9e:	6a 00                	push   $0x0
  pushl $27
80106ca0:	6a 1b                	push   $0x1b
  jmp alltraps
80106ca2:	e9 5e fa ff ff       	jmp    80106705 <alltraps>

80106ca7 <vector28>:
.globl vector28
vector28:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $28
80106ca9:	6a 1c                	push   $0x1c
  jmp alltraps
80106cab:	e9 55 fa ff ff       	jmp    80106705 <alltraps>

80106cb0 <vector29>:
.globl vector29
vector29:
  pushl $0
80106cb0:	6a 00                	push   $0x0
  pushl $29
80106cb2:	6a 1d                	push   $0x1d
  jmp alltraps
80106cb4:	e9 4c fa ff ff       	jmp    80106705 <alltraps>

80106cb9 <vector30>:
.globl vector30
vector30:
  pushl $0
80106cb9:	6a 00                	push   $0x0
  pushl $30
80106cbb:	6a 1e                	push   $0x1e
  jmp alltraps
80106cbd:	e9 43 fa ff ff       	jmp    80106705 <alltraps>

80106cc2 <vector31>:
.globl vector31
vector31:
  pushl $0
80106cc2:	6a 00                	push   $0x0
  pushl $31
80106cc4:	6a 1f                	push   $0x1f
  jmp alltraps
80106cc6:	e9 3a fa ff ff       	jmp    80106705 <alltraps>

80106ccb <vector32>:
.globl vector32
vector32:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $32
80106ccd:	6a 20                	push   $0x20
  jmp alltraps
80106ccf:	e9 31 fa ff ff       	jmp    80106705 <alltraps>

80106cd4 <vector33>:
.globl vector33
vector33:
  pushl $0
80106cd4:	6a 00                	push   $0x0
  pushl $33
80106cd6:	6a 21                	push   $0x21
  jmp alltraps
80106cd8:	e9 28 fa ff ff       	jmp    80106705 <alltraps>

80106cdd <vector34>:
.globl vector34
vector34:
  pushl $0
80106cdd:	6a 00                	push   $0x0
  pushl $34
80106cdf:	6a 22                	push   $0x22
  jmp alltraps
80106ce1:	e9 1f fa ff ff       	jmp    80106705 <alltraps>

80106ce6 <vector35>:
.globl vector35
vector35:
  pushl $0
80106ce6:	6a 00                	push   $0x0
  pushl $35
80106ce8:	6a 23                	push   $0x23
  jmp alltraps
80106cea:	e9 16 fa ff ff       	jmp    80106705 <alltraps>

80106cef <vector36>:
.globl vector36
vector36:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $36
80106cf1:	6a 24                	push   $0x24
  jmp alltraps
80106cf3:	e9 0d fa ff ff       	jmp    80106705 <alltraps>

80106cf8 <vector37>:
.globl vector37
vector37:
  pushl $0
80106cf8:	6a 00                	push   $0x0
  pushl $37
80106cfa:	6a 25                	push   $0x25
  jmp alltraps
80106cfc:	e9 04 fa ff ff       	jmp    80106705 <alltraps>

80106d01 <vector38>:
.globl vector38
vector38:
  pushl $0
80106d01:	6a 00                	push   $0x0
  pushl $38
80106d03:	6a 26                	push   $0x26
  jmp alltraps
80106d05:	e9 fb f9 ff ff       	jmp    80106705 <alltraps>

80106d0a <vector39>:
.globl vector39
vector39:
  pushl $0
80106d0a:	6a 00                	push   $0x0
  pushl $39
80106d0c:	6a 27                	push   $0x27
  jmp alltraps
80106d0e:	e9 f2 f9 ff ff       	jmp    80106705 <alltraps>

80106d13 <vector40>:
.globl vector40
vector40:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $40
80106d15:	6a 28                	push   $0x28
  jmp alltraps
80106d17:	e9 e9 f9 ff ff       	jmp    80106705 <alltraps>

80106d1c <vector41>:
.globl vector41
vector41:
  pushl $0
80106d1c:	6a 00                	push   $0x0
  pushl $41
80106d1e:	6a 29                	push   $0x29
  jmp alltraps
80106d20:	e9 e0 f9 ff ff       	jmp    80106705 <alltraps>

80106d25 <vector42>:
.globl vector42
vector42:
  pushl $0
80106d25:	6a 00                	push   $0x0
  pushl $42
80106d27:	6a 2a                	push   $0x2a
  jmp alltraps
80106d29:	e9 d7 f9 ff ff       	jmp    80106705 <alltraps>

80106d2e <vector43>:
.globl vector43
vector43:
  pushl $0
80106d2e:	6a 00                	push   $0x0
  pushl $43
80106d30:	6a 2b                	push   $0x2b
  jmp alltraps
80106d32:	e9 ce f9 ff ff       	jmp    80106705 <alltraps>

80106d37 <vector44>:
.globl vector44
vector44:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $44
80106d39:	6a 2c                	push   $0x2c
  jmp alltraps
80106d3b:	e9 c5 f9 ff ff       	jmp    80106705 <alltraps>

80106d40 <vector45>:
.globl vector45
vector45:
  pushl $0
80106d40:	6a 00                	push   $0x0
  pushl $45
80106d42:	6a 2d                	push   $0x2d
  jmp alltraps
80106d44:	e9 bc f9 ff ff       	jmp    80106705 <alltraps>

80106d49 <vector46>:
.globl vector46
vector46:
  pushl $0
80106d49:	6a 00                	push   $0x0
  pushl $46
80106d4b:	6a 2e                	push   $0x2e
  jmp alltraps
80106d4d:	e9 b3 f9 ff ff       	jmp    80106705 <alltraps>

80106d52 <vector47>:
.globl vector47
vector47:
  pushl $0
80106d52:	6a 00                	push   $0x0
  pushl $47
80106d54:	6a 2f                	push   $0x2f
  jmp alltraps
80106d56:	e9 aa f9 ff ff       	jmp    80106705 <alltraps>

80106d5b <vector48>:
.globl vector48
vector48:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $48
80106d5d:	6a 30                	push   $0x30
  jmp alltraps
80106d5f:	e9 a1 f9 ff ff       	jmp    80106705 <alltraps>

80106d64 <vector49>:
.globl vector49
vector49:
  pushl $0
80106d64:	6a 00                	push   $0x0
  pushl $49
80106d66:	6a 31                	push   $0x31
  jmp alltraps
80106d68:	e9 98 f9 ff ff       	jmp    80106705 <alltraps>

80106d6d <vector50>:
.globl vector50
vector50:
  pushl $0
80106d6d:	6a 00                	push   $0x0
  pushl $50
80106d6f:	6a 32                	push   $0x32
  jmp alltraps
80106d71:	e9 8f f9 ff ff       	jmp    80106705 <alltraps>

80106d76 <vector51>:
.globl vector51
vector51:
  pushl $0
80106d76:	6a 00                	push   $0x0
  pushl $51
80106d78:	6a 33                	push   $0x33
  jmp alltraps
80106d7a:	e9 86 f9 ff ff       	jmp    80106705 <alltraps>

80106d7f <vector52>:
.globl vector52
vector52:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $52
80106d81:	6a 34                	push   $0x34
  jmp alltraps
80106d83:	e9 7d f9 ff ff       	jmp    80106705 <alltraps>

80106d88 <vector53>:
.globl vector53
vector53:
  pushl $0
80106d88:	6a 00                	push   $0x0
  pushl $53
80106d8a:	6a 35                	push   $0x35
  jmp alltraps
80106d8c:	e9 74 f9 ff ff       	jmp    80106705 <alltraps>

80106d91 <vector54>:
.globl vector54
vector54:
  pushl $0
80106d91:	6a 00                	push   $0x0
  pushl $54
80106d93:	6a 36                	push   $0x36
  jmp alltraps
80106d95:	e9 6b f9 ff ff       	jmp    80106705 <alltraps>

80106d9a <vector55>:
.globl vector55
vector55:
  pushl $0
80106d9a:	6a 00                	push   $0x0
  pushl $55
80106d9c:	6a 37                	push   $0x37
  jmp alltraps
80106d9e:	e9 62 f9 ff ff       	jmp    80106705 <alltraps>

80106da3 <vector56>:
.globl vector56
vector56:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $56
80106da5:	6a 38                	push   $0x38
  jmp alltraps
80106da7:	e9 59 f9 ff ff       	jmp    80106705 <alltraps>

80106dac <vector57>:
.globl vector57
vector57:
  pushl $0
80106dac:	6a 00                	push   $0x0
  pushl $57
80106dae:	6a 39                	push   $0x39
  jmp alltraps
80106db0:	e9 50 f9 ff ff       	jmp    80106705 <alltraps>

80106db5 <vector58>:
.globl vector58
vector58:
  pushl $0
80106db5:	6a 00                	push   $0x0
  pushl $58
80106db7:	6a 3a                	push   $0x3a
  jmp alltraps
80106db9:	e9 47 f9 ff ff       	jmp    80106705 <alltraps>

80106dbe <vector59>:
.globl vector59
vector59:
  pushl $0
80106dbe:	6a 00                	push   $0x0
  pushl $59
80106dc0:	6a 3b                	push   $0x3b
  jmp alltraps
80106dc2:	e9 3e f9 ff ff       	jmp    80106705 <alltraps>

80106dc7 <vector60>:
.globl vector60
vector60:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $60
80106dc9:	6a 3c                	push   $0x3c
  jmp alltraps
80106dcb:	e9 35 f9 ff ff       	jmp    80106705 <alltraps>

80106dd0 <vector61>:
.globl vector61
vector61:
  pushl $0
80106dd0:	6a 00                	push   $0x0
  pushl $61
80106dd2:	6a 3d                	push   $0x3d
  jmp alltraps
80106dd4:	e9 2c f9 ff ff       	jmp    80106705 <alltraps>

80106dd9 <vector62>:
.globl vector62
vector62:
  pushl $0
80106dd9:	6a 00                	push   $0x0
  pushl $62
80106ddb:	6a 3e                	push   $0x3e
  jmp alltraps
80106ddd:	e9 23 f9 ff ff       	jmp    80106705 <alltraps>

80106de2 <vector63>:
.globl vector63
vector63:
  pushl $0
80106de2:	6a 00                	push   $0x0
  pushl $63
80106de4:	6a 3f                	push   $0x3f
  jmp alltraps
80106de6:	e9 1a f9 ff ff       	jmp    80106705 <alltraps>

80106deb <vector64>:
.globl vector64
vector64:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $64
80106ded:	6a 40                	push   $0x40
  jmp alltraps
80106def:	e9 11 f9 ff ff       	jmp    80106705 <alltraps>

80106df4 <vector65>:
.globl vector65
vector65:
  pushl $0
80106df4:	6a 00                	push   $0x0
  pushl $65
80106df6:	6a 41                	push   $0x41
  jmp alltraps
80106df8:	e9 08 f9 ff ff       	jmp    80106705 <alltraps>

80106dfd <vector66>:
.globl vector66
vector66:
  pushl $0
80106dfd:	6a 00                	push   $0x0
  pushl $66
80106dff:	6a 42                	push   $0x42
  jmp alltraps
80106e01:	e9 ff f8 ff ff       	jmp    80106705 <alltraps>

80106e06 <vector67>:
.globl vector67
vector67:
  pushl $0
80106e06:	6a 00                	push   $0x0
  pushl $67
80106e08:	6a 43                	push   $0x43
  jmp alltraps
80106e0a:	e9 f6 f8 ff ff       	jmp    80106705 <alltraps>

80106e0f <vector68>:
.globl vector68
vector68:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $68
80106e11:	6a 44                	push   $0x44
  jmp alltraps
80106e13:	e9 ed f8 ff ff       	jmp    80106705 <alltraps>

80106e18 <vector69>:
.globl vector69
vector69:
  pushl $0
80106e18:	6a 00                	push   $0x0
  pushl $69
80106e1a:	6a 45                	push   $0x45
  jmp alltraps
80106e1c:	e9 e4 f8 ff ff       	jmp    80106705 <alltraps>

80106e21 <vector70>:
.globl vector70
vector70:
  pushl $0
80106e21:	6a 00                	push   $0x0
  pushl $70
80106e23:	6a 46                	push   $0x46
  jmp alltraps
80106e25:	e9 db f8 ff ff       	jmp    80106705 <alltraps>

80106e2a <vector71>:
.globl vector71
vector71:
  pushl $0
80106e2a:	6a 00                	push   $0x0
  pushl $71
80106e2c:	6a 47                	push   $0x47
  jmp alltraps
80106e2e:	e9 d2 f8 ff ff       	jmp    80106705 <alltraps>

80106e33 <vector72>:
.globl vector72
vector72:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $72
80106e35:	6a 48                	push   $0x48
  jmp alltraps
80106e37:	e9 c9 f8 ff ff       	jmp    80106705 <alltraps>

80106e3c <vector73>:
.globl vector73
vector73:
  pushl $0
80106e3c:	6a 00                	push   $0x0
  pushl $73
80106e3e:	6a 49                	push   $0x49
  jmp alltraps
80106e40:	e9 c0 f8 ff ff       	jmp    80106705 <alltraps>

80106e45 <vector74>:
.globl vector74
vector74:
  pushl $0
80106e45:	6a 00                	push   $0x0
  pushl $74
80106e47:	6a 4a                	push   $0x4a
  jmp alltraps
80106e49:	e9 b7 f8 ff ff       	jmp    80106705 <alltraps>

80106e4e <vector75>:
.globl vector75
vector75:
  pushl $0
80106e4e:	6a 00                	push   $0x0
  pushl $75
80106e50:	6a 4b                	push   $0x4b
  jmp alltraps
80106e52:	e9 ae f8 ff ff       	jmp    80106705 <alltraps>

80106e57 <vector76>:
.globl vector76
vector76:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $76
80106e59:	6a 4c                	push   $0x4c
  jmp alltraps
80106e5b:	e9 a5 f8 ff ff       	jmp    80106705 <alltraps>

80106e60 <vector77>:
.globl vector77
vector77:
  pushl $0
80106e60:	6a 00                	push   $0x0
  pushl $77
80106e62:	6a 4d                	push   $0x4d
  jmp alltraps
80106e64:	e9 9c f8 ff ff       	jmp    80106705 <alltraps>

80106e69 <vector78>:
.globl vector78
vector78:
  pushl $0
80106e69:	6a 00                	push   $0x0
  pushl $78
80106e6b:	6a 4e                	push   $0x4e
  jmp alltraps
80106e6d:	e9 93 f8 ff ff       	jmp    80106705 <alltraps>

80106e72 <vector79>:
.globl vector79
vector79:
  pushl $0
80106e72:	6a 00                	push   $0x0
  pushl $79
80106e74:	6a 4f                	push   $0x4f
  jmp alltraps
80106e76:	e9 8a f8 ff ff       	jmp    80106705 <alltraps>

80106e7b <vector80>:
.globl vector80
vector80:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $80
80106e7d:	6a 50                	push   $0x50
  jmp alltraps
80106e7f:	e9 81 f8 ff ff       	jmp    80106705 <alltraps>

80106e84 <vector81>:
.globl vector81
vector81:
  pushl $0
80106e84:	6a 00                	push   $0x0
  pushl $81
80106e86:	6a 51                	push   $0x51
  jmp alltraps
80106e88:	e9 78 f8 ff ff       	jmp    80106705 <alltraps>

80106e8d <vector82>:
.globl vector82
vector82:
  pushl $0
80106e8d:	6a 00                	push   $0x0
  pushl $82
80106e8f:	6a 52                	push   $0x52
  jmp alltraps
80106e91:	e9 6f f8 ff ff       	jmp    80106705 <alltraps>

80106e96 <vector83>:
.globl vector83
vector83:
  pushl $0
80106e96:	6a 00                	push   $0x0
  pushl $83
80106e98:	6a 53                	push   $0x53
  jmp alltraps
80106e9a:	e9 66 f8 ff ff       	jmp    80106705 <alltraps>

80106e9f <vector84>:
.globl vector84
vector84:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $84
80106ea1:	6a 54                	push   $0x54
  jmp alltraps
80106ea3:	e9 5d f8 ff ff       	jmp    80106705 <alltraps>

80106ea8 <vector85>:
.globl vector85
vector85:
  pushl $0
80106ea8:	6a 00                	push   $0x0
  pushl $85
80106eaa:	6a 55                	push   $0x55
  jmp alltraps
80106eac:	e9 54 f8 ff ff       	jmp    80106705 <alltraps>

80106eb1 <vector86>:
.globl vector86
vector86:
  pushl $0
80106eb1:	6a 00                	push   $0x0
  pushl $86
80106eb3:	6a 56                	push   $0x56
  jmp alltraps
80106eb5:	e9 4b f8 ff ff       	jmp    80106705 <alltraps>

80106eba <vector87>:
.globl vector87
vector87:
  pushl $0
80106eba:	6a 00                	push   $0x0
  pushl $87
80106ebc:	6a 57                	push   $0x57
  jmp alltraps
80106ebe:	e9 42 f8 ff ff       	jmp    80106705 <alltraps>

80106ec3 <vector88>:
.globl vector88
vector88:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $88
80106ec5:	6a 58                	push   $0x58
  jmp alltraps
80106ec7:	e9 39 f8 ff ff       	jmp    80106705 <alltraps>

80106ecc <vector89>:
.globl vector89
vector89:
  pushl $0
80106ecc:	6a 00                	push   $0x0
  pushl $89
80106ece:	6a 59                	push   $0x59
  jmp alltraps
80106ed0:	e9 30 f8 ff ff       	jmp    80106705 <alltraps>

80106ed5 <vector90>:
.globl vector90
vector90:
  pushl $0
80106ed5:	6a 00                	push   $0x0
  pushl $90
80106ed7:	6a 5a                	push   $0x5a
  jmp alltraps
80106ed9:	e9 27 f8 ff ff       	jmp    80106705 <alltraps>

80106ede <vector91>:
.globl vector91
vector91:
  pushl $0
80106ede:	6a 00                	push   $0x0
  pushl $91
80106ee0:	6a 5b                	push   $0x5b
  jmp alltraps
80106ee2:	e9 1e f8 ff ff       	jmp    80106705 <alltraps>

80106ee7 <vector92>:
.globl vector92
vector92:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $92
80106ee9:	6a 5c                	push   $0x5c
  jmp alltraps
80106eeb:	e9 15 f8 ff ff       	jmp    80106705 <alltraps>

80106ef0 <vector93>:
.globl vector93
vector93:
  pushl $0
80106ef0:	6a 00                	push   $0x0
  pushl $93
80106ef2:	6a 5d                	push   $0x5d
  jmp alltraps
80106ef4:	e9 0c f8 ff ff       	jmp    80106705 <alltraps>

80106ef9 <vector94>:
.globl vector94
vector94:
  pushl $0
80106ef9:	6a 00                	push   $0x0
  pushl $94
80106efb:	6a 5e                	push   $0x5e
  jmp alltraps
80106efd:	e9 03 f8 ff ff       	jmp    80106705 <alltraps>

80106f02 <vector95>:
.globl vector95
vector95:
  pushl $0
80106f02:	6a 00                	push   $0x0
  pushl $95
80106f04:	6a 5f                	push   $0x5f
  jmp alltraps
80106f06:	e9 fa f7 ff ff       	jmp    80106705 <alltraps>

80106f0b <vector96>:
.globl vector96
vector96:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $96
80106f0d:	6a 60                	push   $0x60
  jmp alltraps
80106f0f:	e9 f1 f7 ff ff       	jmp    80106705 <alltraps>

80106f14 <vector97>:
.globl vector97
vector97:
  pushl $0
80106f14:	6a 00                	push   $0x0
  pushl $97
80106f16:	6a 61                	push   $0x61
  jmp alltraps
80106f18:	e9 e8 f7 ff ff       	jmp    80106705 <alltraps>

80106f1d <vector98>:
.globl vector98
vector98:
  pushl $0
80106f1d:	6a 00                	push   $0x0
  pushl $98
80106f1f:	6a 62                	push   $0x62
  jmp alltraps
80106f21:	e9 df f7 ff ff       	jmp    80106705 <alltraps>

80106f26 <vector99>:
.globl vector99
vector99:
  pushl $0
80106f26:	6a 00                	push   $0x0
  pushl $99
80106f28:	6a 63                	push   $0x63
  jmp alltraps
80106f2a:	e9 d6 f7 ff ff       	jmp    80106705 <alltraps>

80106f2f <vector100>:
.globl vector100
vector100:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $100
80106f31:	6a 64                	push   $0x64
  jmp alltraps
80106f33:	e9 cd f7 ff ff       	jmp    80106705 <alltraps>

80106f38 <vector101>:
.globl vector101
vector101:
  pushl $0
80106f38:	6a 00                	push   $0x0
  pushl $101
80106f3a:	6a 65                	push   $0x65
  jmp alltraps
80106f3c:	e9 c4 f7 ff ff       	jmp    80106705 <alltraps>

80106f41 <vector102>:
.globl vector102
vector102:
  pushl $0
80106f41:	6a 00                	push   $0x0
  pushl $102
80106f43:	6a 66                	push   $0x66
  jmp alltraps
80106f45:	e9 bb f7 ff ff       	jmp    80106705 <alltraps>

80106f4a <vector103>:
.globl vector103
vector103:
  pushl $0
80106f4a:	6a 00                	push   $0x0
  pushl $103
80106f4c:	6a 67                	push   $0x67
  jmp alltraps
80106f4e:	e9 b2 f7 ff ff       	jmp    80106705 <alltraps>

80106f53 <vector104>:
.globl vector104
vector104:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $104
80106f55:	6a 68                	push   $0x68
  jmp alltraps
80106f57:	e9 a9 f7 ff ff       	jmp    80106705 <alltraps>

80106f5c <vector105>:
.globl vector105
vector105:
  pushl $0
80106f5c:	6a 00                	push   $0x0
  pushl $105
80106f5e:	6a 69                	push   $0x69
  jmp alltraps
80106f60:	e9 a0 f7 ff ff       	jmp    80106705 <alltraps>

80106f65 <vector106>:
.globl vector106
vector106:
  pushl $0
80106f65:	6a 00                	push   $0x0
  pushl $106
80106f67:	6a 6a                	push   $0x6a
  jmp alltraps
80106f69:	e9 97 f7 ff ff       	jmp    80106705 <alltraps>

80106f6e <vector107>:
.globl vector107
vector107:
  pushl $0
80106f6e:	6a 00                	push   $0x0
  pushl $107
80106f70:	6a 6b                	push   $0x6b
  jmp alltraps
80106f72:	e9 8e f7 ff ff       	jmp    80106705 <alltraps>

80106f77 <vector108>:
.globl vector108
vector108:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $108
80106f79:	6a 6c                	push   $0x6c
  jmp alltraps
80106f7b:	e9 85 f7 ff ff       	jmp    80106705 <alltraps>

80106f80 <vector109>:
.globl vector109
vector109:
  pushl $0
80106f80:	6a 00                	push   $0x0
  pushl $109
80106f82:	6a 6d                	push   $0x6d
  jmp alltraps
80106f84:	e9 7c f7 ff ff       	jmp    80106705 <alltraps>

80106f89 <vector110>:
.globl vector110
vector110:
  pushl $0
80106f89:	6a 00                	push   $0x0
  pushl $110
80106f8b:	6a 6e                	push   $0x6e
  jmp alltraps
80106f8d:	e9 73 f7 ff ff       	jmp    80106705 <alltraps>

80106f92 <vector111>:
.globl vector111
vector111:
  pushl $0
80106f92:	6a 00                	push   $0x0
  pushl $111
80106f94:	6a 6f                	push   $0x6f
  jmp alltraps
80106f96:	e9 6a f7 ff ff       	jmp    80106705 <alltraps>

80106f9b <vector112>:
.globl vector112
vector112:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $112
80106f9d:	6a 70                	push   $0x70
  jmp alltraps
80106f9f:	e9 61 f7 ff ff       	jmp    80106705 <alltraps>

80106fa4 <vector113>:
.globl vector113
vector113:
  pushl $0
80106fa4:	6a 00                	push   $0x0
  pushl $113
80106fa6:	6a 71                	push   $0x71
  jmp alltraps
80106fa8:	e9 58 f7 ff ff       	jmp    80106705 <alltraps>

80106fad <vector114>:
.globl vector114
vector114:
  pushl $0
80106fad:	6a 00                	push   $0x0
  pushl $114
80106faf:	6a 72                	push   $0x72
  jmp alltraps
80106fb1:	e9 4f f7 ff ff       	jmp    80106705 <alltraps>

80106fb6 <vector115>:
.globl vector115
vector115:
  pushl $0
80106fb6:	6a 00                	push   $0x0
  pushl $115
80106fb8:	6a 73                	push   $0x73
  jmp alltraps
80106fba:	e9 46 f7 ff ff       	jmp    80106705 <alltraps>

80106fbf <vector116>:
.globl vector116
vector116:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $116
80106fc1:	6a 74                	push   $0x74
  jmp alltraps
80106fc3:	e9 3d f7 ff ff       	jmp    80106705 <alltraps>

80106fc8 <vector117>:
.globl vector117
vector117:
  pushl $0
80106fc8:	6a 00                	push   $0x0
  pushl $117
80106fca:	6a 75                	push   $0x75
  jmp alltraps
80106fcc:	e9 34 f7 ff ff       	jmp    80106705 <alltraps>

80106fd1 <vector118>:
.globl vector118
vector118:
  pushl $0
80106fd1:	6a 00                	push   $0x0
  pushl $118
80106fd3:	6a 76                	push   $0x76
  jmp alltraps
80106fd5:	e9 2b f7 ff ff       	jmp    80106705 <alltraps>

80106fda <vector119>:
.globl vector119
vector119:
  pushl $0
80106fda:	6a 00                	push   $0x0
  pushl $119
80106fdc:	6a 77                	push   $0x77
  jmp alltraps
80106fde:	e9 22 f7 ff ff       	jmp    80106705 <alltraps>

80106fe3 <vector120>:
.globl vector120
vector120:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $120
80106fe5:	6a 78                	push   $0x78
  jmp alltraps
80106fe7:	e9 19 f7 ff ff       	jmp    80106705 <alltraps>

80106fec <vector121>:
.globl vector121
vector121:
  pushl $0
80106fec:	6a 00                	push   $0x0
  pushl $121
80106fee:	6a 79                	push   $0x79
  jmp alltraps
80106ff0:	e9 10 f7 ff ff       	jmp    80106705 <alltraps>

80106ff5 <vector122>:
.globl vector122
vector122:
  pushl $0
80106ff5:	6a 00                	push   $0x0
  pushl $122
80106ff7:	6a 7a                	push   $0x7a
  jmp alltraps
80106ff9:	e9 07 f7 ff ff       	jmp    80106705 <alltraps>

80106ffe <vector123>:
.globl vector123
vector123:
  pushl $0
80106ffe:	6a 00                	push   $0x0
  pushl $123
80107000:	6a 7b                	push   $0x7b
  jmp alltraps
80107002:	e9 fe f6 ff ff       	jmp    80106705 <alltraps>

80107007 <vector124>:
.globl vector124
vector124:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $124
80107009:	6a 7c                	push   $0x7c
  jmp alltraps
8010700b:	e9 f5 f6 ff ff       	jmp    80106705 <alltraps>

80107010 <vector125>:
.globl vector125
vector125:
  pushl $0
80107010:	6a 00                	push   $0x0
  pushl $125
80107012:	6a 7d                	push   $0x7d
  jmp alltraps
80107014:	e9 ec f6 ff ff       	jmp    80106705 <alltraps>

80107019 <vector126>:
.globl vector126
vector126:
  pushl $0
80107019:	6a 00                	push   $0x0
  pushl $126
8010701b:	6a 7e                	push   $0x7e
  jmp alltraps
8010701d:	e9 e3 f6 ff ff       	jmp    80106705 <alltraps>

80107022 <vector127>:
.globl vector127
vector127:
  pushl $0
80107022:	6a 00                	push   $0x0
  pushl $127
80107024:	6a 7f                	push   $0x7f
  jmp alltraps
80107026:	e9 da f6 ff ff       	jmp    80106705 <alltraps>

8010702b <vector128>:
.globl vector128
vector128:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $128
8010702d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80107032:	e9 ce f6 ff ff       	jmp    80106705 <alltraps>

80107037 <vector129>:
.globl vector129
vector129:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $129
80107039:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010703e:	e9 c2 f6 ff ff       	jmp    80106705 <alltraps>

80107043 <vector130>:
.globl vector130
vector130:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $130
80107045:	68 82 00 00 00       	push   $0x82
  jmp alltraps
8010704a:	e9 b6 f6 ff ff       	jmp    80106705 <alltraps>

8010704f <vector131>:
.globl vector131
vector131:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $131
80107051:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107056:	e9 aa f6 ff ff       	jmp    80106705 <alltraps>

8010705b <vector132>:
.globl vector132
vector132:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $132
8010705d:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80107062:	e9 9e f6 ff ff       	jmp    80106705 <alltraps>

80107067 <vector133>:
.globl vector133
vector133:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $133
80107069:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010706e:	e9 92 f6 ff ff       	jmp    80106705 <alltraps>

80107073 <vector134>:
.globl vector134
vector134:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $134
80107075:	68 86 00 00 00       	push   $0x86
  jmp alltraps
8010707a:	e9 86 f6 ff ff       	jmp    80106705 <alltraps>

8010707f <vector135>:
.globl vector135
vector135:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $135
80107081:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107086:	e9 7a f6 ff ff       	jmp    80106705 <alltraps>

8010708b <vector136>:
.globl vector136
vector136:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $136
8010708d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80107092:	e9 6e f6 ff ff       	jmp    80106705 <alltraps>

80107097 <vector137>:
.globl vector137
vector137:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $137
80107099:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010709e:	e9 62 f6 ff ff       	jmp    80106705 <alltraps>

801070a3 <vector138>:
.globl vector138
vector138:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $138
801070a5:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801070aa:	e9 56 f6 ff ff       	jmp    80106705 <alltraps>

801070af <vector139>:
.globl vector139
vector139:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $139
801070b1:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801070b6:	e9 4a f6 ff ff       	jmp    80106705 <alltraps>

801070bb <vector140>:
.globl vector140
vector140:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $140
801070bd:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801070c2:	e9 3e f6 ff ff       	jmp    80106705 <alltraps>

801070c7 <vector141>:
.globl vector141
vector141:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $141
801070c9:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801070ce:	e9 32 f6 ff ff       	jmp    80106705 <alltraps>

801070d3 <vector142>:
.globl vector142
vector142:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $142
801070d5:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801070da:	e9 26 f6 ff ff       	jmp    80106705 <alltraps>

801070df <vector143>:
.globl vector143
vector143:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $143
801070e1:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801070e6:	e9 1a f6 ff ff       	jmp    80106705 <alltraps>

801070eb <vector144>:
.globl vector144
vector144:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $144
801070ed:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801070f2:	e9 0e f6 ff ff       	jmp    80106705 <alltraps>

801070f7 <vector145>:
.globl vector145
vector145:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $145
801070f9:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801070fe:	e9 02 f6 ff ff       	jmp    80106705 <alltraps>

80107103 <vector146>:
.globl vector146
vector146:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $146
80107105:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010710a:	e9 f6 f5 ff ff       	jmp    80106705 <alltraps>

8010710f <vector147>:
.globl vector147
vector147:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $147
80107111:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107116:	e9 ea f5 ff ff       	jmp    80106705 <alltraps>

8010711b <vector148>:
.globl vector148
vector148:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $148
8010711d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107122:	e9 de f5 ff ff       	jmp    80106705 <alltraps>

80107127 <vector149>:
.globl vector149
vector149:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $149
80107129:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010712e:	e9 d2 f5 ff ff       	jmp    80106705 <alltraps>

80107133 <vector150>:
.globl vector150
vector150:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $150
80107135:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010713a:	e9 c6 f5 ff ff       	jmp    80106705 <alltraps>

8010713f <vector151>:
.globl vector151
vector151:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $151
80107141:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107146:	e9 ba f5 ff ff       	jmp    80106705 <alltraps>

8010714b <vector152>:
.globl vector152
vector152:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $152
8010714d:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107152:	e9 ae f5 ff ff       	jmp    80106705 <alltraps>

80107157 <vector153>:
.globl vector153
vector153:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $153
80107159:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010715e:	e9 a2 f5 ff ff       	jmp    80106705 <alltraps>

80107163 <vector154>:
.globl vector154
vector154:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $154
80107165:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010716a:	e9 96 f5 ff ff       	jmp    80106705 <alltraps>

8010716f <vector155>:
.globl vector155
vector155:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $155
80107171:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107176:	e9 8a f5 ff ff       	jmp    80106705 <alltraps>

8010717b <vector156>:
.globl vector156
vector156:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $156
8010717d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80107182:	e9 7e f5 ff ff       	jmp    80106705 <alltraps>

80107187 <vector157>:
.globl vector157
vector157:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $157
80107189:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010718e:	e9 72 f5 ff ff       	jmp    80106705 <alltraps>

80107193 <vector158>:
.globl vector158
vector158:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $158
80107195:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
8010719a:	e9 66 f5 ff ff       	jmp    80106705 <alltraps>

8010719f <vector159>:
.globl vector159
vector159:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $159
801071a1:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801071a6:	e9 5a f5 ff ff       	jmp    80106705 <alltraps>

801071ab <vector160>:
.globl vector160
vector160:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $160
801071ad:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801071b2:	e9 4e f5 ff ff       	jmp    80106705 <alltraps>

801071b7 <vector161>:
.globl vector161
vector161:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $161
801071b9:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801071be:	e9 42 f5 ff ff       	jmp    80106705 <alltraps>

801071c3 <vector162>:
.globl vector162
vector162:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $162
801071c5:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801071ca:	e9 36 f5 ff ff       	jmp    80106705 <alltraps>

801071cf <vector163>:
.globl vector163
vector163:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $163
801071d1:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801071d6:	e9 2a f5 ff ff       	jmp    80106705 <alltraps>

801071db <vector164>:
.globl vector164
vector164:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $164
801071dd:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801071e2:	e9 1e f5 ff ff       	jmp    80106705 <alltraps>

801071e7 <vector165>:
.globl vector165
vector165:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $165
801071e9:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801071ee:	e9 12 f5 ff ff       	jmp    80106705 <alltraps>

801071f3 <vector166>:
.globl vector166
vector166:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $166
801071f5:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801071fa:	e9 06 f5 ff ff       	jmp    80106705 <alltraps>

801071ff <vector167>:
.globl vector167
vector167:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $167
80107201:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107206:	e9 fa f4 ff ff       	jmp    80106705 <alltraps>

8010720b <vector168>:
.globl vector168
vector168:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $168
8010720d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107212:	e9 ee f4 ff ff       	jmp    80106705 <alltraps>

80107217 <vector169>:
.globl vector169
vector169:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $169
80107219:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010721e:	e9 e2 f4 ff ff       	jmp    80106705 <alltraps>

80107223 <vector170>:
.globl vector170
vector170:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $170
80107225:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010722a:	e9 d6 f4 ff ff       	jmp    80106705 <alltraps>

8010722f <vector171>:
.globl vector171
vector171:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $171
80107231:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107236:	e9 ca f4 ff ff       	jmp    80106705 <alltraps>

8010723b <vector172>:
.globl vector172
vector172:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $172
8010723d:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107242:	e9 be f4 ff ff       	jmp    80106705 <alltraps>

80107247 <vector173>:
.globl vector173
vector173:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $173
80107249:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010724e:	e9 b2 f4 ff ff       	jmp    80106705 <alltraps>

80107253 <vector174>:
.globl vector174
vector174:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $174
80107255:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010725a:	e9 a6 f4 ff ff       	jmp    80106705 <alltraps>

8010725f <vector175>:
.globl vector175
vector175:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $175
80107261:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107266:	e9 9a f4 ff ff       	jmp    80106705 <alltraps>

8010726b <vector176>:
.globl vector176
vector176:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $176
8010726d:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107272:	e9 8e f4 ff ff       	jmp    80106705 <alltraps>

80107277 <vector177>:
.globl vector177
vector177:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $177
80107279:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010727e:	e9 82 f4 ff ff       	jmp    80106705 <alltraps>

80107283 <vector178>:
.globl vector178
vector178:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $178
80107285:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
8010728a:	e9 76 f4 ff ff       	jmp    80106705 <alltraps>

8010728f <vector179>:
.globl vector179
vector179:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $179
80107291:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107296:	e9 6a f4 ff ff       	jmp    80106705 <alltraps>

8010729b <vector180>:
.globl vector180
vector180:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $180
8010729d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801072a2:	e9 5e f4 ff ff       	jmp    80106705 <alltraps>

801072a7 <vector181>:
.globl vector181
vector181:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $181
801072a9:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801072ae:	e9 52 f4 ff ff       	jmp    80106705 <alltraps>

801072b3 <vector182>:
.globl vector182
vector182:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $182
801072b5:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801072ba:	e9 46 f4 ff ff       	jmp    80106705 <alltraps>

801072bf <vector183>:
.globl vector183
vector183:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $183
801072c1:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801072c6:	e9 3a f4 ff ff       	jmp    80106705 <alltraps>

801072cb <vector184>:
.globl vector184
vector184:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $184
801072cd:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801072d2:	e9 2e f4 ff ff       	jmp    80106705 <alltraps>

801072d7 <vector185>:
.globl vector185
vector185:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $185
801072d9:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801072de:	e9 22 f4 ff ff       	jmp    80106705 <alltraps>

801072e3 <vector186>:
.globl vector186
vector186:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $186
801072e5:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801072ea:	e9 16 f4 ff ff       	jmp    80106705 <alltraps>

801072ef <vector187>:
.globl vector187
vector187:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $187
801072f1:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801072f6:	e9 0a f4 ff ff       	jmp    80106705 <alltraps>

801072fb <vector188>:
.globl vector188
vector188:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $188
801072fd:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107302:	e9 fe f3 ff ff       	jmp    80106705 <alltraps>

80107307 <vector189>:
.globl vector189
vector189:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $189
80107309:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010730e:	e9 f2 f3 ff ff       	jmp    80106705 <alltraps>

80107313 <vector190>:
.globl vector190
vector190:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $190
80107315:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010731a:	e9 e6 f3 ff ff       	jmp    80106705 <alltraps>

8010731f <vector191>:
.globl vector191
vector191:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $191
80107321:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107326:	e9 da f3 ff ff       	jmp    80106705 <alltraps>

8010732b <vector192>:
.globl vector192
vector192:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $192
8010732d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107332:	e9 ce f3 ff ff       	jmp    80106705 <alltraps>

80107337 <vector193>:
.globl vector193
vector193:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $193
80107339:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010733e:	e9 c2 f3 ff ff       	jmp    80106705 <alltraps>

80107343 <vector194>:
.globl vector194
vector194:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $194
80107345:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010734a:	e9 b6 f3 ff ff       	jmp    80106705 <alltraps>

8010734f <vector195>:
.globl vector195
vector195:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $195
80107351:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107356:	e9 aa f3 ff ff       	jmp    80106705 <alltraps>

8010735b <vector196>:
.globl vector196
vector196:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $196
8010735d:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107362:	e9 9e f3 ff ff       	jmp    80106705 <alltraps>

80107367 <vector197>:
.globl vector197
vector197:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $197
80107369:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010736e:	e9 92 f3 ff ff       	jmp    80106705 <alltraps>

80107373 <vector198>:
.globl vector198
vector198:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $198
80107375:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010737a:	e9 86 f3 ff ff       	jmp    80106705 <alltraps>

8010737f <vector199>:
.globl vector199
vector199:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $199
80107381:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107386:	e9 7a f3 ff ff       	jmp    80106705 <alltraps>

8010738b <vector200>:
.globl vector200
vector200:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $200
8010738d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107392:	e9 6e f3 ff ff       	jmp    80106705 <alltraps>

80107397 <vector201>:
.globl vector201
vector201:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $201
80107399:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010739e:	e9 62 f3 ff ff       	jmp    80106705 <alltraps>

801073a3 <vector202>:
.globl vector202
vector202:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $202
801073a5:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801073aa:	e9 56 f3 ff ff       	jmp    80106705 <alltraps>

801073af <vector203>:
.globl vector203
vector203:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $203
801073b1:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801073b6:	e9 4a f3 ff ff       	jmp    80106705 <alltraps>

801073bb <vector204>:
.globl vector204
vector204:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $204
801073bd:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801073c2:	e9 3e f3 ff ff       	jmp    80106705 <alltraps>

801073c7 <vector205>:
.globl vector205
vector205:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $205
801073c9:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801073ce:	e9 32 f3 ff ff       	jmp    80106705 <alltraps>

801073d3 <vector206>:
.globl vector206
vector206:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $206
801073d5:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801073da:	e9 26 f3 ff ff       	jmp    80106705 <alltraps>

801073df <vector207>:
.globl vector207
vector207:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $207
801073e1:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801073e6:	e9 1a f3 ff ff       	jmp    80106705 <alltraps>

801073eb <vector208>:
.globl vector208
vector208:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $208
801073ed:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801073f2:	e9 0e f3 ff ff       	jmp    80106705 <alltraps>

801073f7 <vector209>:
.globl vector209
vector209:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $209
801073f9:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801073fe:	e9 02 f3 ff ff       	jmp    80106705 <alltraps>

80107403 <vector210>:
.globl vector210
vector210:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $210
80107405:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010740a:	e9 f6 f2 ff ff       	jmp    80106705 <alltraps>

8010740f <vector211>:
.globl vector211
vector211:
  pushl $0
8010740f:	6a 00                	push   $0x0
  pushl $211
80107411:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107416:	e9 ea f2 ff ff       	jmp    80106705 <alltraps>

8010741b <vector212>:
.globl vector212
vector212:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $212
8010741d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107422:	e9 de f2 ff ff       	jmp    80106705 <alltraps>

80107427 <vector213>:
.globl vector213
vector213:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $213
80107429:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010742e:	e9 d2 f2 ff ff       	jmp    80106705 <alltraps>

80107433 <vector214>:
.globl vector214
vector214:
  pushl $0
80107433:	6a 00                	push   $0x0
  pushl $214
80107435:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010743a:	e9 c6 f2 ff ff       	jmp    80106705 <alltraps>

8010743f <vector215>:
.globl vector215
vector215:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $215
80107441:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107446:	e9 ba f2 ff ff       	jmp    80106705 <alltraps>

8010744b <vector216>:
.globl vector216
vector216:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $216
8010744d:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107452:	e9 ae f2 ff ff       	jmp    80106705 <alltraps>

80107457 <vector217>:
.globl vector217
vector217:
  pushl $0
80107457:	6a 00                	push   $0x0
  pushl $217
80107459:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010745e:	e9 a2 f2 ff ff       	jmp    80106705 <alltraps>

80107463 <vector218>:
.globl vector218
vector218:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $218
80107465:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010746a:	e9 96 f2 ff ff       	jmp    80106705 <alltraps>

8010746f <vector219>:
.globl vector219
vector219:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $219
80107471:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107476:	e9 8a f2 ff ff       	jmp    80106705 <alltraps>

8010747b <vector220>:
.globl vector220
vector220:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $220
8010747d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107482:	e9 7e f2 ff ff       	jmp    80106705 <alltraps>

80107487 <vector221>:
.globl vector221
vector221:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $221
80107489:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010748e:	e9 72 f2 ff ff       	jmp    80106705 <alltraps>

80107493 <vector222>:
.globl vector222
vector222:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $222
80107495:	68 de 00 00 00       	push   $0xde
  jmp alltraps
8010749a:	e9 66 f2 ff ff       	jmp    80106705 <alltraps>

8010749f <vector223>:
.globl vector223
vector223:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $223
801074a1:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801074a6:	e9 5a f2 ff ff       	jmp    80106705 <alltraps>

801074ab <vector224>:
.globl vector224
vector224:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $224
801074ad:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801074b2:	e9 4e f2 ff ff       	jmp    80106705 <alltraps>

801074b7 <vector225>:
.globl vector225
vector225:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $225
801074b9:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801074be:	e9 42 f2 ff ff       	jmp    80106705 <alltraps>

801074c3 <vector226>:
.globl vector226
vector226:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $226
801074c5:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801074ca:	e9 36 f2 ff ff       	jmp    80106705 <alltraps>

801074cf <vector227>:
.globl vector227
vector227:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $227
801074d1:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801074d6:	e9 2a f2 ff ff       	jmp    80106705 <alltraps>

801074db <vector228>:
.globl vector228
vector228:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $228
801074dd:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801074e2:	e9 1e f2 ff ff       	jmp    80106705 <alltraps>

801074e7 <vector229>:
.globl vector229
vector229:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $229
801074e9:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801074ee:	e9 12 f2 ff ff       	jmp    80106705 <alltraps>

801074f3 <vector230>:
.globl vector230
vector230:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $230
801074f5:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801074fa:	e9 06 f2 ff ff       	jmp    80106705 <alltraps>

801074ff <vector231>:
.globl vector231
vector231:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $231
80107501:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107506:	e9 fa f1 ff ff       	jmp    80106705 <alltraps>

8010750b <vector232>:
.globl vector232
vector232:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $232
8010750d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107512:	e9 ee f1 ff ff       	jmp    80106705 <alltraps>

80107517 <vector233>:
.globl vector233
vector233:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $233
80107519:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010751e:	e9 e2 f1 ff ff       	jmp    80106705 <alltraps>

80107523 <vector234>:
.globl vector234
vector234:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $234
80107525:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
8010752a:	e9 d6 f1 ff ff       	jmp    80106705 <alltraps>

8010752f <vector235>:
.globl vector235
vector235:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $235
80107531:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107536:	e9 ca f1 ff ff       	jmp    80106705 <alltraps>

8010753b <vector236>:
.globl vector236
vector236:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $236
8010753d:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107542:	e9 be f1 ff ff       	jmp    80106705 <alltraps>

80107547 <vector237>:
.globl vector237
vector237:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $237
80107549:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010754e:	e9 b2 f1 ff ff       	jmp    80106705 <alltraps>

80107553 <vector238>:
.globl vector238
vector238:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $238
80107555:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
8010755a:	e9 a6 f1 ff ff       	jmp    80106705 <alltraps>

8010755f <vector239>:
.globl vector239
vector239:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $239
80107561:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107566:	e9 9a f1 ff ff       	jmp    80106705 <alltraps>

8010756b <vector240>:
.globl vector240
vector240:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $240
8010756d:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107572:	e9 8e f1 ff ff       	jmp    80106705 <alltraps>

80107577 <vector241>:
.globl vector241
vector241:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $241
80107579:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010757e:	e9 82 f1 ff ff       	jmp    80106705 <alltraps>

80107583 <vector242>:
.globl vector242
vector242:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $242
80107585:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
8010758a:	e9 76 f1 ff ff       	jmp    80106705 <alltraps>

8010758f <vector243>:
.globl vector243
vector243:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $243
80107591:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107596:	e9 6a f1 ff ff       	jmp    80106705 <alltraps>

8010759b <vector244>:
.globl vector244
vector244:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $244
8010759d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801075a2:	e9 5e f1 ff ff       	jmp    80106705 <alltraps>

801075a7 <vector245>:
.globl vector245
vector245:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $245
801075a9:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801075ae:	e9 52 f1 ff ff       	jmp    80106705 <alltraps>

801075b3 <vector246>:
.globl vector246
vector246:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $246
801075b5:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801075ba:	e9 46 f1 ff ff       	jmp    80106705 <alltraps>

801075bf <vector247>:
.globl vector247
vector247:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $247
801075c1:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801075c6:	e9 3a f1 ff ff       	jmp    80106705 <alltraps>

801075cb <vector248>:
.globl vector248
vector248:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $248
801075cd:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801075d2:	e9 2e f1 ff ff       	jmp    80106705 <alltraps>

801075d7 <vector249>:
.globl vector249
vector249:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $249
801075d9:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801075de:	e9 22 f1 ff ff       	jmp    80106705 <alltraps>

801075e3 <vector250>:
.globl vector250
vector250:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $250
801075e5:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801075ea:	e9 16 f1 ff ff       	jmp    80106705 <alltraps>

801075ef <vector251>:
.globl vector251
vector251:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $251
801075f1:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801075f6:	e9 0a f1 ff ff       	jmp    80106705 <alltraps>

801075fb <vector252>:
.globl vector252
vector252:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $252
801075fd:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107602:	e9 fe f0 ff ff       	jmp    80106705 <alltraps>

80107607 <vector253>:
.globl vector253
vector253:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $253
80107609:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010760e:	e9 f2 f0 ff ff       	jmp    80106705 <alltraps>

80107613 <vector254>:
.globl vector254
vector254:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $254
80107615:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
8010761a:	e9 e6 f0 ff ff       	jmp    80106705 <alltraps>

8010761f <vector255>:
.globl vector255
vector255:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $255
80107621:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107626:	e9 da f0 ff ff       	jmp    80106705 <alltraps>
8010762b:	66 90                	xchg   %ax,%ax
8010762d:	66 90                	xchg   %ax,%ax
8010762f:	90                   	nop

80107630 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107637:	c1 ea 16             	shr    $0x16,%edx
{
8010763a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010763b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010763e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107641:	8b 1f                	mov    (%edi),%ebx
80107643:	f6 c3 01             	test   $0x1,%bl
80107646:	74 28                	je     80107670 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107648:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010764e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107654:	89 f0                	mov    %esi,%eax
}
80107656:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107659:	c1 e8 0a             	shr    $0xa,%eax
8010765c:	25 fc 0f 00 00       	and    $0xffc,%eax
80107661:	01 d8                	add    %ebx,%eax
}
80107663:	5b                   	pop    %ebx
80107664:	5e                   	pop    %esi
80107665:	5f                   	pop    %edi
80107666:	5d                   	pop    %ebp
80107667:	c3                   	ret    
80107668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010766f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107670:	85 c9                	test   %ecx,%ecx
80107672:	74 2c                	je     801076a0 <walkpgdir+0x70>
80107674:	e8 07 ba ff ff       	call   80103080 <kalloc>
80107679:	89 c3                	mov    %eax,%ebx
8010767b:	85 c0                	test   %eax,%eax
8010767d:	74 21                	je     801076a0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010767f:	83 ec 04             	sub    $0x4,%esp
80107682:	68 00 10 00 00       	push   $0x1000
80107687:	6a 00                	push   $0x0
80107689:	50                   	push   %eax
8010768a:	e8 f1 dc ff ff       	call   80105380 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010768f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107695:	83 c4 10             	add    $0x10,%esp
80107698:	83 c8 07             	or     $0x7,%eax
8010769b:	89 07                	mov    %eax,(%edi)
8010769d:	eb b5                	jmp    80107654 <walkpgdir+0x24>
8010769f:	90                   	nop
}
801076a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801076a3:	31 c0                	xor    %eax,%eax
}
801076a5:	5b                   	pop    %ebx
801076a6:	5e                   	pop    %esi
801076a7:	5f                   	pop    %edi
801076a8:	5d                   	pop    %ebp
801076a9:	c3                   	ret    
801076aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801076b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	57                   	push   %edi
801076b4:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801076b6:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
801076ba:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801076bb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
801076c0:	89 d6                	mov    %edx,%esi
{
801076c2:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801076c3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
801076c9:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801076cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
801076cf:	8b 45 08             	mov    0x8(%ebp),%eax
801076d2:	29 f0                	sub    %esi,%eax
801076d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076d7:	eb 1f                	jmp    801076f8 <mappages+0x48>
801076d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801076e0:	f6 00 01             	testb  $0x1,(%eax)
801076e3:	75 45                	jne    8010772a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801076e5:	0b 5d 0c             	or     0xc(%ebp),%ebx
801076e8:	83 cb 01             	or     $0x1,%ebx
801076eb:	89 18                	mov    %ebx,(%eax)
    if(a == last)
801076ed:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801076f0:	74 2e                	je     80107720 <mappages+0x70>
      break;
    a += PGSIZE;
801076f2:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
801076f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801076fb:	b9 01 00 00 00       	mov    $0x1,%ecx
80107700:	89 f2                	mov    %esi,%edx
80107702:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107705:	89 f8                	mov    %edi,%eax
80107707:	e8 24 ff ff ff       	call   80107630 <walkpgdir>
8010770c:	85 c0                	test   %eax,%eax
8010770e:	75 d0                	jne    801076e0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107710:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107713:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107718:	5b                   	pop    %ebx
80107719:	5e                   	pop    %esi
8010771a:	5f                   	pop    %edi
8010771b:	5d                   	pop    %ebp
8010771c:	c3                   	ret    
8010771d:	8d 76 00             	lea    0x0(%esi),%esi
80107720:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107723:	31 c0                	xor    %eax,%eax
}
80107725:	5b                   	pop    %ebx
80107726:	5e                   	pop    %esi
80107727:	5f                   	pop    %edi
80107728:	5d                   	pop    %ebp
80107729:	c3                   	ret    
      panic("remap");
8010772a:	83 ec 0c             	sub    $0xc,%esp
8010772d:	68 88 88 10 80       	push   $0x80108888
80107732:	e8 59 8c ff ff       	call   80100390 <panic>
80107737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010773e:	66 90                	xchg   %ax,%ax

80107740 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	57                   	push   %edi
80107744:	56                   	push   %esi
80107745:	89 c6                	mov    %eax,%esi
80107747:	53                   	push   %ebx
80107748:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010774a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80107750:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107756:	83 ec 1c             	sub    $0x1c,%esp
80107759:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010775c:	39 da                	cmp    %ebx,%edx
8010775e:	73 5b                	jae    801077bb <deallocuvm.part.0+0x7b>
80107760:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80107763:	89 d7                	mov    %edx,%edi
80107765:	eb 14                	jmp    8010777b <deallocuvm.part.0+0x3b>
80107767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010776e:	66 90                	xchg   %ax,%ax
80107770:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107776:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107779:	76 40                	jbe    801077bb <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010777b:	31 c9                	xor    %ecx,%ecx
8010777d:	89 fa                	mov    %edi,%edx
8010777f:	89 f0                	mov    %esi,%eax
80107781:	e8 aa fe ff ff       	call   80107630 <walkpgdir>
80107786:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107788:	85 c0                	test   %eax,%eax
8010778a:	74 44                	je     801077d0 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010778c:	8b 00                	mov    (%eax),%eax
8010778e:	a8 01                	test   $0x1,%al
80107790:	74 de                	je     80107770 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107792:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107797:	74 47                	je     801077e0 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107799:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010779c:	05 00 00 00 80       	add    $0x80000000,%eax
801077a1:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
801077a7:	50                   	push   %eax
801077a8:	e8 13 b7 ff ff       	call   80102ec0 <kfree>
      *pte = 0;
801077ad:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801077b3:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
801077b6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801077b9:	77 c0                	ja     8010777b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
801077bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077c1:	5b                   	pop    %ebx
801077c2:	5e                   	pop    %esi
801077c3:	5f                   	pop    %edi
801077c4:	5d                   	pop    %ebp
801077c5:	c3                   	ret    
801077c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077cd:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801077d0:	89 fa                	mov    %edi,%edx
801077d2:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
801077d8:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
801077de:	eb 96                	jmp    80107776 <deallocuvm.part.0+0x36>
        panic("kfree");
801077e0:	83 ec 0c             	sub    $0xc,%esp
801077e3:	68 e6 81 10 80       	push   $0x801081e6
801077e8:	e8 a3 8b ff ff       	call   80100390 <panic>
801077ed:	8d 76 00             	lea    0x0(%esi),%esi

801077f0 <seginit>:
{
801077f0:	f3 0f 1e fb          	endbr32 
801077f4:	55                   	push   %ebp
801077f5:	89 e5                	mov    %esp,%ebp
801077f7:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801077fa:	e8 e1 cb ff ff       	call   801043e0 <cpuid>
  pd[0] = size-1;
801077ff:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107804:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010780a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010780e:	c7 80 58 e0 11 80 ff 	movl   $0xffff,-0x7fee1fa8(%eax)
80107815:	ff 00 00 
80107818:	c7 80 5c e0 11 80 00 	movl   $0xcf9a00,-0x7fee1fa4(%eax)
8010781f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107822:	c7 80 60 e0 11 80 ff 	movl   $0xffff,-0x7fee1fa0(%eax)
80107829:	ff 00 00 
8010782c:	c7 80 64 e0 11 80 00 	movl   $0xcf9200,-0x7fee1f9c(%eax)
80107833:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107836:	c7 80 68 e0 11 80 ff 	movl   $0xffff,-0x7fee1f98(%eax)
8010783d:	ff 00 00 
80107840:	c7 80 6c e0 11 80 00 	movl   $0xcffa00,-0x7fee1f94(%eax)
80107847:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010784a:	c7 80 70 e0 11 80 ff 	movl   $0xffff,-0x7fee1f90(%eax)
80107851:	ff 00 00 
80107854:	c7 80 74 e0 11 80 00 	movl   $0xcff200,-0x7fee1f8c(%eax)
8010785b:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010785e:	05 50 e0 11 80       	add    $0x8011e050,%eax
  pd[1] = (uint)p;
80107863:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107867:	c1 e8 10             	shr    $0x10,%eax
8010786a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010786e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107871:	0f 01 10             	lgdtl  (%eax)
}
80107874:	c9                   	leave  
80107875:	c3                   	ret    
80107876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010787d:	8d 76 00             	lea    0x0(%esi),%esi

80107880 <switchkvm>:
{
80107880:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107884:	a1 04 39 39 80       	mov    0x80393904,%eax
80107889:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010788e:	0f 22 d8             	mov    %eax,%cr3
}
80107891:	c3                   	ret    
80107892:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078a0 <switchuvm>:
{
801078a0:	f3 0f 1e fb          	endbr32 
801078a4:	55                   	push   %ebp
801078a5:	89 e5                	mov    %esp,%ebp
801078a7:	57                   	push   %edi
801078a8:	56                   	push   %esi
801078a9:	53                   	push   %ebx
801078aa:	83 ec 1c             	sub    $0x1c,%esp
801078ad:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801078b0:	85 f6                	test   %esi,%esi
801078b2:	0f 84 cb 00 00 00    	je     80107983 <switchuvm+0xe3>
  if(p->kstack == 0)
801078b8:	8b 46 08             	mov    0x8(%esi),%eax
801078bb:	85 c0                	test   %eax,%eax
801078bd:	0f 84 da 00 00 00    	je     8010799d <switchuvm+0xfd>
  if(p->pgdir == 0)
801078c3:	8b 46 04             	mov    0x4(%esi),%eax
801078c6:	85 c0                	test   %eax,%eax
801078c8:	0f 84 c2 00 00 00    	je     80107990 <switchuvm+0xf0>
  pushcli();
801078ce:	e8 9d d8 ff ff       	call   80105170 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801078d3:	e8 98 ca ff ff       	call   80104370 <mycpu>
801078d8:	89 c3                	mov    %eax,%ebx
801078da:	e8 91 ca ff ff       	call   80104370 <mycpu>
801078df:	89 c7                	mov    %eax,%edi
801078e1:	e8 8a ca ff ff       	call   80104370 <mycpu>
801078e6:	83 c7 08             	add    $0x8,%edi
801078e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801078ec:	e8 7f ca ff ff       	call   80104370 <mycpu>
801078f1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801078f4:	ba 67 00 00 00       	mov    $0x67,%edx
801078f9:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107900:	83 c0 08             	add    $0x8,%eax
80107903:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010790a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010790f:	83 c1 08             	add    $0x8,%ecx
80107912:	c1 e8 18             	shr    $0x18,%eax
80107915:	c1 e9 10             	shr    $0x10,%ecx
80107918:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010791e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107924:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107929:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107930:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107935:	e8 36 ca ff ff       	call   80104370 <mycpu>
8010793a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107941:	e8 2a ca ff ff       	call   80104370 <mycpu>
80107946:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010794a:	8b 5e 08             	mov    0x8(%esi),%ebx
8010794d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107953:	e8 18 ca ff ff       	call   80104370 <mycpu>
80107958:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010795b:	e8 10 ca ff ff       	call   80104370 <mycpu>
80107960:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107964:	b8 28 00 00 00       	mov    $0x28,%eax
80107969:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010796c:	8b 46 04             	mov    0x4(%esi),%eax
8010796f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107974:	0f 22 d8             	mov    %eax,%cr3
}
80107977:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010797a:	5b                   	pop    %ebx
8010797b:	5e                   	pop    %esi
8010797c:	5f                   	pop    %edi
8010797d:	5d                   	pop    %ebp
  popcli();
8010797e:	e9 3d d8 ff ff       	jmp    801051c0 <popcli>
    panic("switchuvm: no process");
80107983:	83 ec 0c             	sub    $0xc,%esp
80107986:	68 8e 88 10 80       	push   $0x8010888e
8010798b:	e8 00 8a ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107990:	83 ec 0c             	sub    $0xc,%esp
80107993:	68 b9 88 10 80       	push   $0x801088b9
80107998:	e8 f3 89 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
8010799d:	83 ec 0c             	sub    $0xc,%esp
801079a0:	68 a4 88 10 80       	push   $0x801088a4
801079a5:	e8 e6 89 ff ff       	call   80100390 <panic>
801079aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801079b0 <inituvm>:
{
801079b0:	f3 0f 1e fb          	endbr32 
801079b4:	55                   	push   %ebp
801079b5:	89 e5                	mov    %esp,%ebp
801079b7:	57                   	push   %edi
801079b8:	56                   	push   %esi
801079b9:	53                   	push   %ebx
801079ba:	83 ec 1c             	sub    $0x1c,%esp
801079bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801079c0:	8b 75 10             	mov    0x10(%ebp),%esi
801079c3:	8b 7d 08             	mov    0x8(%ebp),%edi
801079c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801079c9:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801079cf:	77 4b                	ja     80107a1c <inituvm+0x6c>
  mem = kalloc();
801079d1:	e8 aa b6 ff ff       	call   80103080 <kalloc>
  memset(mem, 0, PGSIZE);
801079d6:	83 ec 04             	sub    $0x4,%esp
801079d9:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801079de:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801079e0:	6a 00                	push   $0x0
801079e2:	50                   	push   %eax
801079e3:	e8 98 d9 ff ff       	call   80105380 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801079e8:	58                   	pop    %eax
801079e9:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079ef:	5a                   	pop    %edx
801079f0:	6a 06                	push   $0x6
801079f2:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079f7:	31 d2                	xor    %edx,%edx
801079f9:	50                   	push   %eax
801079fa:	89 f8                	mov    %edi,%eax
801079fc:	e8 af fc ff ff       	call   801076b0 <mappages>
  memmove(mem, init, sz);
80107a01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a04:	89 75 10             	mov    %esi,0x10(%ebp)
80107a07:	83 c4 10             	add    $0x10,%esp
80107a0a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107a0d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a13:	5b                   	pop    %ebx
80107a14:	5e                   	pop    %esi
80107a15:	5f                   	pop    %edi
80107a16:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107a17:	e9 04 da ff ff       	jmp    80105420 <memmove>
    panic("inituvm: more than a page");
80107a1c:	83 ec 0c             	sub    $0xc,%esp
80107a1f:	68 cd 88 10 80       	push   $0x801088cd
80107a24:	e8 67 89 ff ff       	call   80100390 <panic>
80107a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107a30 <loaduvm>:
{
80107a30:	f3 0f 1e fb          	endbr32 
80107a34:	55                   	push   %ebp
80107a35:	89 e5                	mov    %esp,%ebp
80107a37:	57                   	push   %edi
80107a38:	56                   	push   %esi
80107a39:	53                   	push   %ebx
80107a3a:	83 ec 1c             	sub    $0x1c,%esp
80107a3d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a40:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107a43:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107a48:	0f 85 99 00 00 00    	jne    80107ae7 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
80107a4e:	01 f0                	add    %esi,%eax
80107a50:	89 f3                	mov    %esi,%ebx
80107a52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a55:	8b 45 14             	mov    0x14(%ebp),%eax
80107a58:	01 f0                	add    %esi,%eax
80107a5a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107a5d:	85 f6                	test   %esi,%esi
80107a5f:	75 15                	jne    80107a76 <loaduvm+0x46>
80107a61:	eb 6d                	jmp    80107ad0 <loaduvm+0xa0>
80107a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a67:	90                   	nop
80107a68:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107a6e:	89 f0                	mov    %esi,%eax
80107a70:	29 d8                	sub    %ebx,%eax
80107a72:	39 c6                	cmp    %eax,%esi
80107a74:	76 5a                	jbe    80107ad0 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107a76:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107a79:	8b 45 08             	mov    0x8(%ebp),%eax
80107a7c:	31 c9                	xor    %ecx,%ecx
80107a7e:	29 da                	sub    %ebx,%edx
80107a80:	e8 ab fb ff ff       	call   80107630 <walkpgdir>
80107a85:	85 c0                	test   %eax,%eax
80107a87:	74 51                	je     80107ada <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107a89:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a8b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107a8e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107a93:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107a98:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107a9e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107aa1:	29 d9                	sub    %ebx,%ecx
80107aa3:	05 00 00 00 80       	add    $0x80000000,%eax
80107aa8:	57                   	push   %edi
80107aa9:	51                   	push   %ecx
80107aaa:	50                   	push   %eax
80107aab:	ff 75 10             	pushl  0x10(%ebp)
80107aae:	e8 fd a9 ff ff       	call   801024b0 <readi>
80107ab3:	83 c4 10             	add    $0x10,%esp
80107ab6:	39 f8                	cmp    %edi,%eax
80107ab8:	74 ae                	je     80107a68 <loaduvm+0x38>
}
80107aba:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107abd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ac2:	5b                   	pop    %ebx
80107ac3:	5e                   	pop    %esi
80107ac4:	5f                   	pop    %edi
80107ac5:	5d                   	pop    %ebp
80107ac6:	c3                   	ret    
80107ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ace:	66 90                	xchg   %ax,%ax
80107ad0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107ad3:	31 c0                	xor    %eax,%eax
}
80107ad5:	5b                   	pop    %ebx
80107ad6:	5e                   	pop    %esi
80107ad7:	5f                   	pop    %edi
80107ad8:	5d                   	pop    %ebp
80107ad9:	c3                   	ret    
      panic("loaduvm: address should exist");
80107ada:	83 ec 0c             	sub    $0xc,%esp
80107add:	68 e7 88 10 80       	push   $0x801088e7
80107ae2:	e8 a9 88 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107ae7:	83 ec 0c             	sub    $0xc,%esp
80107aea:	68 88 89 10 80       	push   $0x80108988
80107aef:	e8 9c 88 ff ff       	call   80100390 <panic>
80107af4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107aff:	90                   	nop

80107b00 <allocuvm>:
{
80107b00:	f3 0f 1e fb          	endbr32 
80107b04:	55                   	push   %ebp
80107b05:	89 e5                	mov    %esp,%ebp
80107b07:	57                   	push   %edi
80107b08:	56                   	push   %esi
80107b09:	53                   	push   %ebx
80107b0a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107b0d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107b10:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107b13:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107b16:	85 c0                	test   %eax,%eax
80107b18:	0f 88 b2 00 00 00    	js     80107bd0 <allocuvm+0xd0>
  if(newsz < oldsz)
80107b1e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107b24:	0f 82 96 00 00 00    	jb     80107bc0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107b2a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107b30:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107b36:	39 75 10             	cmp    %esi,0x10(%ebp)
80107b39:	77 40                	ja     80107b7b <allocuvm+0x7b>
80107b3b:	e9 83 00 00 00       	jmp    80107bc3 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80107b40:	83 ec 04             	sub    $0x4,%esp
80107b43:	68 00 10 00 00       	push   $0x1000
80107b48:	6a 00                	push   $0x0
80107b4a:	50                   	push   %eax
80107b4b:	e8 30 d8 ff ff       	call   80105380 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107b50:	58                   	pop    %eax
80107b51:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b57:	5a                   	pop    %edx
80107b58:	6a 06                	push   $0x6
80107b5a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b5f:	89 f2                	mov    %esi,%edx
80107b61:	50                   	push   %eax
80107b62:	89 f8                	mov    %edi,%eax
80107b64:	e8 47 fb ff ff       	call   801076b0 <mappages>
80107b69:	83 c4 10             	add    $0x10,%esp
80107b6c:	85 c0                	test   %eax,%eax
80107b6e:	78 78                	js     80107be8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107b70:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107b76:	39 75 10             	cmp    %esi,0x10(%ebp)
80107b79:	76 48                	jbe    80107bc3 <allocuvm+0xc3>
    mem = kalloc();
80107b7b:	e8 00 b5 ff ff       	call   80103080 <kalloc>
80107b80:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107b82:	85 c0                	test   %eax,%eax
80107b84:	75 ba                	jne    80107b40 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107b86:	83 ec 0c             	sub    $0xc,%esp
80107b89:	68 05 89 10 80       	push   $0x80108905
80107b8e:	e8 5d 8b ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
80107b93:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b96:	83 c4 10             	add    $0x10,%esp
80107b99:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b9c:	74 32                	je     80107bd0 <allocuvm+0xd0>
80107b9e:	8b 55 10             	mov    0x10(%ebp),%edx
80107ba1:	89 c1                	mov    %eax,%ecx
80107ba3:	89 f8                	mov    %edi,%eax
80107ba5:	e8 96 fb ff ff       	call   80107740 <deallocuvm.part.0>
      return 0;
80107baa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107bb1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bb7:	5b                   	pop    %ebx
80107bb8:	5e                   	pop    %esi
80107bb9:	5f                   	pop    %edi
80107bba:	5d                   	pop    %ebp
80107bbb:	c3                   	ret    
80107bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107bc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107bc3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bc9:	5b                   	pop    %ebx
80107bca:	5e                   	pop    %esi
80107bcb:	5f                   	pop    %edi
80107bcc:	5d                   	pop    %ebp
80107bcd:	c3                   	ret    
80107bce:	66 90                	xchg   %ax,%ax
    return 0;
80107bd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107bd7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107bda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bdd:	5b                   	pop    %ebx
80107bde:	5e                   	pop    %esi
80107bdf:	5f                   	pop    %edi
80107be0:	5d                   	pop    %ebp
80107be1:	c3                   	ret    
80107be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107be8:	83 ec 0c             	sub    $0xc,%esp
80107beb:	68 1d 89 10 80       	push   $0x8010891d
80107bf0:	e8 fb 8a ff ff       	call   801006f0 <cprintf>
  if(newsz >= oldsz)
80107bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bf8:	83 c4 10             	add    $0x10,%esp
80107bfb:	39 45 10             	cmp    %eax,0x10(%ebp)
80107bfe:	74 0c                	je     80107c0c <allocuvm+0x10c>
80107c00:	8b 55 10             	mov    0x10(%ebp),%edx
80107c03:	89 c1                	mov    %eax,%ecx
80107c05:	89 f8                	mov    %edi,%eax
80107c07:	e8 34 fb ff ff       	call   80107740 <deallocuvm.part.0>
      kfree(mem);
80107c0c:	83 ec 0c             	sub    $0xc,%esp
80107c0f:	53                   	push   %ebx
80107c10:	e8 ab b2 ff ff       	call   80102ec0 <kfree>
      return 0;
80107c15:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107c1c:	83 c4 10             	add    $0x10,%esp
}
80107c1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c25:	5b                   	pop    %ebx
80107c26:	5e                   	pop    %esi
80107c27:	5f                   	pop    %edi
80107c28:	5d                   	pop    %ebp
80107c29:	c3                   	ret    
80107c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c30 <deallocuvm>:
{
80107c30:	f3 0f 1e fb          	endbr32 
80107c34:	55                   	push   %ebp
80107c35:	89 e5                	mov    %esp,%ebp
80107c37:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c3a:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107c40:	39 d1                	cmp    %edx,%ecx
80107c42:	73 0c                	jae    80107c50 <deallocuvm+0x20>
}
80107c44:	5d                   	pop    %ebp
80107c45:	e9 f6 fa ff ff       	jmp    80107740 <deallocuvm.part.0>
80107c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c50:	89 d0                	mov    %edx,%eax
80107c52:	5d                   	pop    %ebp
80107c53:	c3                   	ret    
80107c54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c5f:	90                   	nop

80107c60 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107c60:	f3 0f 1e fb          	endbr32 
80107c64:	55                   	push   %ebp
80107c65:	89 e5                	mov    %esp,%ebp
80107c67:	57                   	push   %edi
80107c68:	56                   	push   %esi
80107c69:	53                   	push   %ebx
80107c6a:	83 ec 0c             	sub    $0xc,%esp
80107c6d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107c70:	85 f6                	test   %esi,%esi
80107c72:	74 55                	je     80107cc9 <freevm+0x69>
  if(newsz >= oldsz)
80107c74:	31 c9                	xor    %ecx,%ecx
80107c76:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107c7b:	89 f0                	mov    %esi,%eax
80107c7d:	89 f3                	mov    %esi,%ebx
80107c7f:	e8 bc fa ff ff       	call   80107740 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107c84:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107c8a:	eb 0b                	jmp    80107c97 <freevm+0x37>
80107c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c90:	83 c3 04             	add    $0x4,%ebx
80107c93:	39 df                	cmp    %ebx,%edi
80107c95:	74 23                	je     80107cba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107c97:	8b 03                	mov    (%ebx),%eax
80107c99:	a8 01                	test   $0x1,%al
80107c9b:	74 f3                	je     80107c90 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107c9d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107ca2:	83 ec 0c             	sub    $0xc,%esp
80107ca5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107ca8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107cad:	50                   	push   %eax
80107cae:	e8 0d b2 ff ff       	call   80102ec0 <kfree>
80107cb3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107cb6:	39 df                	cmp    %ebx,%edi
80107cb8:	75 dd                	jne    80107c97 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107cba:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cc0:	5b                   	pop    %ebx
80107cc1:	5e                   	pop    %esi
80107cc2:	5f                   	pop    %edi
80107cc3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107cc4:	e9 f7 b1 ff ff       	jmp    80102ec0 <kfree>
    panic("freevm: no pgdir");
80107cc9:	83 ec 0c             	sub    $0xc,%esp
80107ccc:	68 39 89 10 80       	push   $0x80108939
80107cd1:	e8 ba 86 ff ff       	call   80100390 <panic>
80107cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cdd:	8d 76 00             	lea    0x0(%esi),%esi

80107ce0 <setupkvm>:
{
80107ce0:	f3 0f 1e fb          	endbr32 
80107ce4:	55                   	push   %ebp
80107ce5:	89 e5                	mov    %esp,%ebp
80107ce7:	56                   	push   %esi
80107ce8:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107ce9:	e8 92 b3 ff ff       	call   80103080 <kalloc>
80107cee:	89 c6                	mov    %eax,%esi
80107cf0:	85 c0                	test   %eax,%eax
80107cf2:	74 42                	je     80107d36 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107cf4:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107cf7:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107cfc:	68 00 10 00 00       	push   $0x1000
80107d01:	6a 00                	push   $0x0
80107d03:	50                   	push   %eax
80107d04:	e8 77 d6 ff ff       	call   80105380 <memset>
80107d09:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107d0c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107d0f:	83 ec 08             	sub    $0x8,%esp
80107d12:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107d15:	ff 73 0c             	pushl  0xc(%ebx)
80107d18:	8b 13                	mov    (%ebx),%edx
80107d1a:	50                   	push   %eax
80107d1b:	29 c1                	sub    %eax,%ecx
80107d1d:	89 f0                	mov    %esi,%eax
80107d1f:	e8 8c f9 ff ff       	call   801076b0 <mappages>
80107d24:	83 c4 10             	add    $0x10,%esp
80107d27:	85 c0                	test   %eax,%eax
80107d29:	78 15                	js     80107d40 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107d2b:	83 c3 10             	add    $0x10,%ebx
80107d2e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107d34:	75 d6                	jne    80107d0c <setupkvm+0x2c>
}
80107d36:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d39:	89 f0                	mov    %esi,%eax
80107d3b:	5b                   	pop    %ebx
80107d3c:	5e                   	pop    %esi
80107d3d:	5d                   	pop    %ebp
80107d3e:	c3                   	ret    
80107d3f:	90                   	nop
      freevm(pgdir);
80107d40:	83 ec 0c             	sub    $0xc,%esp
80107d43:	56                   	push   %esi
      return 0;
80107d44:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107d46:	e8 15 ff ff ff       	call   80107c60 <freevm>
      return 0;
80107d4b:	83 c4 10             	add    $0x10,%esp
}
80107d4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d51:	89 f0                	mov    %esi,%eax
80107d53:	5b                   	pop    %ebx
80107d54:	5e                   	pop    %esi
80107d55:	5d                   	pop    %ebp
80107d56:	c3                   	ret    
80107d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d5e:	66 90                	xchg   %ax,%ax

80107d60 <kvmalloc>:
{
80107d60:	f3 0f 1e fb          	endbr32 
80107d64:	55                   	push   %ebp
80107d65:	89 e5                	mov    %esp,%ebp
80107d67:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107d6a:	e8 71 ff ff ff       	call   80107ce0 <setupkvm>
80107d6f:	a3 04 39 39 80       	mov    %eax,0x80393904
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d74:	05 00 00 00 80       	add    $0x80000000,%eax
80107d79:	0f 22 d8             	mov    %eax,%cr3
}
80107d7c:	c9                   	leave  
80107d7d:	c3                   	ret    
80107d7e:	66 90                	xchg   %ax,%ax

80107d80 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107d80:	f3 0f 1e fb          	endbr32 
80107d84:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107d85:	31 c9                	xor    %ecx,%ecx
{
80107d87:	89 e5                	mov    %esp,%ebp
80107d89:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107d8c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d8f:	8b 45 08             	mov    0x8(%ebp),%eax
80107d92:	e8 99 f8 ff ff       	call   80107630 <walkpgdir>
  if(pte == 0)
80107d97:	85 c0                	test   %eax,%eax
80107d99:	74 05                	je     80107da0 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107d9b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107d9e:	c9                   	leave  
80107d9f:	c3                   	ret    
    panic("clearpteu");
80107da0:	83 ec 0c             	sub    $0xc,%esp
80107da3:	68 4a 89 10 80       	push   $0x8010894a
80107da8:	e8 e3 85 ff ff       	call   80100390 <panic>
80107dad:	8d 76 00             	lea    0x0(%esi),%esi

80107db0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107db0:	f3 0f 1e fb          	endbr32 
80107db4:	55                   	push   %ebp
80107db5:	89 e5                	mov    %esp,%ebp
80107db7:	57                   	push   %edi
80107db8:	56                   	push   %esi
80107db9:	53                   	push   %ebx
80107dba:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107dbd:	e8 1e ff ff ff       	call   80107ce0 <setupkvm>
80107dc2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107dc5:	85 c0                	test   %eax,%eax
80107dc7:	0f 84 9b 00 00 00    	je     80107e68 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107dcd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107dd0:	85 c9                	test   %ecx,%ecx
80107dd2:	0f 84 90 00 00 00    	je     80107e68 <copyuvm+0xb8>
80107dd8:	31 f6                	xor    %esi,%esi
80107dda:	eb 46                	jmp    80107e22 <copyuvm+0x72>
80107ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107de0:	83 ec 04             	sub    $0x4,%esp
80107de3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107de9:	68 00 10 00 00       	push   $0x1000
80107dee:	57                   	push   %edi
80107def:	50                   	push   %eax
80107df0:	e8 2b d6 ff ff       	call   80105420 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107df5:	58                   	pop    %eax
80107df6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107dfc:	5a                   	pop    %edx
80107dfd:	ff 75 e4             	pushl  -0x1c(%ebp)
80107e00:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107e05:	89 f2                	mov    %esi,%edx
80107e07:	50                   	push   %eax
80107e08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e0b:	e8 a0 f8 ff ff       	call   801076b0 <mappages>
80107e10:	83 c4 10             	add    $0x10,%esp
80107e13:	85 c0                	test   %eax,%eax
80107e15:	78 61                	js     80107e78 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107e17:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107e1d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107e20:	76 46                	jbe    80107e68 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107e22:	8b 45 08             	mov    0x8(%ebp),%eax
80107e25:	31 c9                	xor    %ecx,%ecx
80107e27:	89 f2                	mov    %esi,%edx
80107e29:	e8 02 f8 ff ff       	call   80107630 <walkpgdir>
80107e2e:	85 c0                	test   %eax,%eax
80107e30:	74 61                	je     80107e93 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107e32:	8b 00                	mov    (%eax),%eax
80107e34:	a8 01                	test   $0x1,%al
80107e36:	74 4e                	je     80107e86 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107e38:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107e3a:	25 ff 0f 00 00       	and    $0xfff,%eax
80107e3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107e42:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107e48:	e8 33 b2 ff ff       	call   80103080 <kalloc>
80107e4d:	89 c3                	mov    %eax,%ebx
80107e4f:	85 c0                	test   %eax,%eax
80107e51:	75 8d                	jne    80107de0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107e53:	83 ec 0c             	sub    $0xc,%esp
80107e56:	ff 75 e0             	pushl  -0x20(%ebp)
80107e59:	e8 02 fe ff ff       	call   80107c60 <freevm>
  return 0;
80107e5e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107e65:	83 c4 10             	add    $0x10,%esp
}
80107e68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e6e:	5b                   	pop    %ebx
80107e6f:	5e                   	pop    %esi
80107e70:	5f                   	pop    %edi
80107e71:	5d                   	pop    %ebp
80107e72:	c3                   	ret    
80107e73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e77:	90                   	nop
      kfree(mem);
80107e78:	83 ec 0c             	sub    $0xc,%esp
80107e7b:	53                   	push   %ebx
80107e7c:	e8 3f b0 ff ff       	call   80102ec0 <kfree>
      goto bad;
80107e81:	83 c4 10             	add    $0x10,%esp
80107e84:	eb cd                	jmp    80107e53 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107e86:	83 ec 0c             	sub    $0xc,%esp
80107e89:	68 6e 89 10 80       	push   $0x8010896e
80107e8e:	e8 fd 84 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107e93:	83 ec 0c             	sub    $0xc,%esp
80107e96:	68 54 89 10 80       	push   $0x80108954
80107e9b:	e8 f0 84 ff ff       	call   80100390 <panic>

80107ea0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107ea0:	f3 0f 1e fb          	endbr32 
80107ea4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107ea5:	31 c9                	xor    %ecx,%ecx
{
80107ea7:	89 e5                	mov    %esp,%ebp
80107ea9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107eac:	8b 55 0c             	mov    0xc(%ebp),%edx
80107eaf:	8b 45 08             	mov    0x8(%ebp),%eax
80107eb2:	e8 79 f7 ff ff       	call   80107630 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107eb7:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107eb9:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107eba:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ebc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107ec1:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ec4:	05 00 00 00 80       	add    $0x80000000,%eax
80107ec9:	83 fa 05             	cmp    $0x5,%edx
80107ecc:	ba 00 00 00 00       	mov    $0x0,%edx
80107ed1:	0f 45 c2             	cmovne %edx,%eax
}
80107ed4:	c3                   	ret    
80107ed5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107ee0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107ee0:	f3 0f 1e fb          	endbr32 
80107ee4:	55                   	push   %ebp
80107ee5:	89 e5                	mov    %esp,%ebp
80107ee7:	57                   	push   %edi
80107ee8:	56                   	push   %esi
80107ee9:	53                   	push   %ebx
80107eea:	83 ec 0c             	sub    $0xc,%esp
80107eed:	8b 75 14             	mov    0x14(%ebp),%esi
80107ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107ef3:	85 f6                	test   %esi,%esi
80107ef5:	75 3c                	jne    80107f33 <copyout+0x53>
80107ef7:	eb 67                	jmp    80107f60 <copyout+0x80>
80107ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107f00:	8b 55 0c             	mov    0xc(%ebp),%edx
80107f03:	89 fb                	mov    %edi,%ebx
80107f05:	29 d3                	sub    %edx,%ebx
80107f07:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107f0d:	39 f3                	cmp    %esi,%ebx
80107f0f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107f12:	29 fa                	sub    %edi,%edx
80107f14:	83 ec 04             	sub    $0x4,%esp
80107f17:	01 c2                	add    %eax,%edx
80107f19:	53                   	push   %ebx
80107f1a:	ff 75 10             	pushl  0x10(%ebp)
80107f1d:	52                   	push   %edx
80107f1e:	e8 fd d4 ff ff       	call   80105420 <memmove>
    len -= n;
    buf += n;
80107f23:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107f26:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107f2c:	83 c4 10             	add    $0x10,%esp
80107f2f:	29 de                	sub    %ebx,%esi
80107f31:	74 2d                	je     80107f60 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107f33:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107f35:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107f38:	89 55 0c             	mov    %edx,0xc(%ebp)
80107f3b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107f41:	57                   	push   %edi
80107f42:	ff 75 08             	pushl  0x8(%ebp)
80107f45:	e8 56 ff ff ff       	call   80107ea0 <uva2ka>
    if(pa0 == 0)
80107f4a:	83 c4 10             	add    $0x10,%esp
80107f4d:	85 c0                	test   %eax,%eax
80107f4f:	75 af                	jne    80107f00 <copyout+0x20>
  }
  return 0;
}
80107f51:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f54:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f59:	5b                   	pop    %ebx
80107f5a:	5e                   	pop    %esi
80107f5b:	5f                   	pop    %edi
80107f5c:	5d                   	pop    %ebp
80107f5d:	c3                   	ret    
80107f5e:	66 90                	xchg   %ax,%ax
80107f60:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107f63:	31 c0                	xor    %eax,%eax
}
80107f65:	5b                   	pop    %ebx
80107f66:	5e                   	pop    %esi
80107f67:	5f                   	pop    %edi
80107f68:	5d                   	pop    %ebp
80107f69:	c3                   	ret    
