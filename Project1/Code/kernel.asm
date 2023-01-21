
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
80100028:	bc d0 70 11 80       	mov    $0x801170d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 3c 10 80       	mov    $0x80103c10,%eax
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
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 7d 10 80       	push   $0x80107d40
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 4f 00 00       	call   80104f80 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 7d 10 80       	push   $0x80107d47
80100097:	50                   	push   %eax
80100098:	e8 b3 4d 00 00       	call   80104e50 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
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
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 67 50 00 00       	call   80105150 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 89 4f 00 00       	call   801050f0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 4d 00 00       	call   80104e90 <acquiresleep>
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
8010018c:	e8 ff 2c 00 00       	call   80102e90 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 4e 7d 10 80       	push   $0x80107d4e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 6d 4d 00 00       	call   80104f30 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 b7 2c 00 00       	jmp    80102e90 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 7d 10 80       	push   $0x80107d5f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 4d 00 00       	call   80104f30 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 4c 00 00       	call   80104ef0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 30 4f 00 00       	call   80105150 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 7f 4e 00 00       	jmp    801050f0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 66 7d 10 80       	push   $0x80107d66
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 77 21 00 00       	call   80102410 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 0b 11 80 	movl   $0x80110b20,(%esp)
801002a0:	e8 ab 4e 00 00       	call   80105150 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 0b 11 80       	mov    0x80110b00,%eax
801002b5:	3b 05 04 0b 11 80    	cmp    0x80110b04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 0b 11 80       	push   $0x80110b20
801002c8:	68 00 0b 11 80       	push   $0x80110b00
801002cd:	e8 1e 49 00 00       	call   80104bf0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 0b 11 80       	mov    0x80110b00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 0b 11 80    	cmp    0x80110b04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 39 42 00 00       	call   80104520 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 0b 11 80       	push   $0x80110b20
801002f6:	e8 f5 4d 00 00       	call   801050f0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 2c 20 00 00       	call   80102330 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 0b 11 80    	mov    %edx,0x80110b00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 0a 11 80 	movsbl -0x7feef580(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 0b 11 80       	push   $0x80110b20
8010034c:	e8 9f 4d 00 00       	call   801050f0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 d6 1f 00 00       	call   80102330 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 0b 11 80       	mov    %eax,0x80110b00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 0b 11 80 00 	movl   $0x0,0x80110b54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 02 31 00 00       	call   801034a0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 6d 7d 10 80       	push   $0x80107d6d
801003a7:	e8 34 03 00 00       	call   801006e0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 2b 03 00 00       	call   801006e0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 97 86 10 80 	movl   $0x80108697,(%esp)
801003bc:	e8 1f 03 00 00       	call   801006e0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 d3 4b 00 00       	call   80104fa0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 81 7d 10 80       	push   $0x80107d81
801003dd:	e8 fe 02 00 00       	call   801006e0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 0b 11 80 01 	movl   $0x1,0x80110b58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	89 c6                	mov    %eax,%esi
80100407:	53                   	push   %ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  switch (c) {
8010040b:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100410:	0f 84 62 01 00 00    	je     80100578 <consputc.part.0+0x178>
80100416:	3d 00 01 00 00       	cmp    $0x100,%eax
8010041b:	0f 85 6f 01 00 00    	jne    80100590 <consputc.part.0+0x190>
      uartputc('\b'); uartputc(' '); uartputc('\b');  // uart is writing to the linux shell
80100421:	83 ec 0c             	sub    $0xc,%esp
80100424:	6a 08                	push   $0x8
80100426:	e8 35 64 00 00       	call   80106860 <uartputc>
8010042b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100432:	e8 29 64 00 00       	call   80106860 <uartputc>
80100437:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010043e:	e8 1d 64 00 00       	call   80106860 <uartputc>
      break;
80100443:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100446:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010044b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100450:	89 fa                	mov    %edi,%edx
80100452:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100453:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100458:	89 da                	mov    %ebx,%edx
8010045a:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
8010045b:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045e:	89 fa                	mov    %edi,%edx
80100460:	b8 0f 00 00 00       	mov    $0xf,%eax
80100465:	c1 e1 08             	shl    $0x8,%ecx
80100468:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100469:	89 da                	mov    %ebx,%edx
8010046b:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010046c:	0f b6 d8             	movzbl %al,%ebx
8010046f:	09 cb                	or     %ecx,%ebx
  switch(c) {
80100471:	81 fe e4 00 00 00    	cmp    $0xe4,%esi
80100477:	0f 84 93 00 00 00    	je     80100510 <consputc.part.0+0x110>
8010047d:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100483:	0f 84 87 00 00 00    	je     80100510 <consputc.part.0+0x110>
80100489:	83 fe 0a             	cmp    $0xa,%esi
8010048c:	0f 84 16 01 00 00    	je     801005a8 <consputc.part.0+0x1a8>
      crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100492:	89 f0                	mov    %esi,%eax
80100494:	0f b6 c0             	movzbl %al,%eax
80100497:	80 cc 07             	or     $0x7,%ah
8010049a:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004a1:	80 
801004a2:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
801004a5:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
801004ab:	0f 8f 11 01 00 00    	jg     801005c2 <consputc.part.0+0x1c2>
  if((pos/80) >= 24){  // Scroll up.
801004b1:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004b7:	7f 67                	jg     80100520 <consputc.part.0+0x120>
  outb(CRTPORT+1, pos>>8);
801004b9:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
801004bc:	88 5d e7             	mov    %bl,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
801004bf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004c2:	bf d4 03 00 00       	mov    $0x3d4,%edi
801004c7:	b8 0e 00 00 00       	mov    $0xe,%eax
801004cc:	89 fa                	mov    %edi,%edx
801004ce:	ee                   	out    %al,(%dx)
801004cf:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004d4:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
801004d8:	89 ca                	mov    %ecx,%edx
801004da:	ee                   	out    %al,(%dx)
801004db:	b8 0f 00 00 00       	mov    $0xf,%eax
801004e0:	89 fa                	mov    %edi,%edx
801004e2:	ee                   	out    %al,(%dx)
801004e3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004e7:	89 ca                	mov    %ecx,%edx
801004e9:	ee                   	out    %al,(%dx)
  if (c == BACKSPACE)
801004ea:	81 fe 00 01 00 00    	cmp    $0x100,%esi
801004f0:	75 0d                	jne    801004ff <consputc.part.0+0xff>
    crt[pos] = ' ' | 0x0700;
801004f2:	b8 20 07 00 00       	mov    $0x720,%eax
801004f7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004fe:	80 
}
801004ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100502:	5b                   	pop    %ebx
80100503:	5e                   	pop    %esi
80100504:	5f                   	pop    %edi
80100505:	5d                   	pop    %ebp
80100506:	c3                   	ret    
80100507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010050e:	66 90                	xchg   %ax,%ax
      if(pos > 0) --pos;
80100510:	85 db                	test   %ebx,%ebx
80100512:	74 54                	je     80100568 <consputc.part.0+0x168>
80100514:	83 eb 01             	sub    $0x1,%ebx
80100517:	eb 8c                	jmp    801004a5 <consputc.part.0+0xa5>
80100519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100520:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100523:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100526:	68 60 0e 00 00       	push   $0xe60
8010052b:	68 a0 80 0b 80       	push   $0x800b80a0
80100530:	68 00 80 0b 80       	push   $0x800b8000
80100535:	e8 76 4d 00 00       	call   801052b0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010053a:	b8 80 07 00 00       	mov    $0x780,%eax
8010053f:	83 c4 0c             	add    $0xc,%esp
80100542:	29 d8                	sub    %ebx,%eax
80100544:	01 c0                	add    %eax,%eax
80100546:	50                   	push   %eax
80100547:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
8010054e:	6a 00                	push   $0x0
80100550:	50                   	push   %eax
80100551:	e8 ba 4c 00 00       	call   80105210 <memset>
  outb(CRTPORT+1, pos);
80100556:	88 5d e7             	mov    %bl,-0x19(%ebp)
80100559:	83 c4 10             	add    $0x10,%esp
8010055c:	c6 45 e0 07          	movb   $0x7,-0x20(%ebp)
80100560:	e9 5d ff ff ff       	jmp    801004c2 <consputc.part.0+0xc2>
80100565:	8d 76 00             	lea    0x0(%esi),%esi
80100568:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
8010056c:	c6 45 e0 00          	movb   $0x0,-0x20(%ebp)
80100570:	e9 4d ff ff ff       	jmp    801004c2 <consputc.part.0+0xc2>
80100575:	8d 76 00             	lea    0x0(%esi),%esi
      uartputc('\b');
80100578:	83 ec 0c             	sub    $0xc,%esp
8010057b:	6a 08                	push   $0x8
8010057d:	e8 de 62 00 00       	call   80106860 <uartputc>
      break;
80100582:	83 c4 10             	add    $0x10,%esp
80100585:	e9 bc fe ff ff       	jmp    80100446 <consputc.part.0+0x46>
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      uartputc(c);
80100590:	83 ec 0c             	sub    $0xc,%esp
80100593:	50                   	push   %eax
80100594:	e8 c7 62 00 00       	call   80106860 <uartputc>
80100599:	83 c4 10             	add    $0x10,%esp
8010059c:	e9 a5 fe ff ff       	jmp    80100446 <consputc.part.0+0x46>
801005a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      pos += 80 - pos%80;
801005a8:	89 d8                	mov    %ebx,%eax
801005aa:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801005af:	f7 e2                	mul    %edx
801005b1:	c1 ea 06             	shr    $0x6,%edx
801005b4:	8d 04 92             	lea    (%edx,%edx,4),%eax
801005b7:	c1 e0 04             	shl    $0x4,%eax
801005ba:	8d 58 50             	lea    0x50(%eax),%ebx
      break;
801005bd:	e9 e3 fe ff ff       	jmp    801004a5 <consputc.part.0+0xa5>
    panic("pos under/overflow");
801005c2:	83 ec 0c             	sub    $0xc,%esp
801005c5:	68 85 7d 10 80       	push   $0x80107d85
801005ca:	e8 b1 fd ff ff       	call   80100380 <panic>
801005cf:	90                   	nop

801005d0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801005d9:	ff 75 08             	push   0x8(%ebp)
{
801005dc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005df:	e8 2c 1e 00 00       	call   80102410 <iunlock>
  acquire(&cons.lock);
801005e4:	c7 04 24 20 0b 11 80 	movl   $0x80110b20,(%esp)
801005eb:	e8 60 4b 00 00       	call   80105150 <acquire>
  for(i = 0; i < n; i++)
801005f0:	83 c4 10             	add    $0x10,%esp
801005f3:	85 f6                	test   %esi,%esi
801005f5:	7e 25                	jle    8010061c <consolewrite+0x4c>
801005f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005fa:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005fd:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
    consputc(buf[i] & 0xff);
80100603:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
80100606:	85 d2                	test   %edx,%edx
80100608:	74 06                	je     80100610 <consolewrite+0x40>
  asm volatile("cli");
8010060a:	fa                   	cli    
    for(;;)
8010060b:	eb fe                	jmp    8010060b <consolewrite+0x3b>
8010060d:	8d 76 00             	lea    0x0(%esi),%esi
80100610:	e8 eb fd ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
80100615:	83 c3 01             	add    $0x1,%ebx
80100618:	39 df                	cmp    %ebx,%edi
8010061a:	75 e1                	jne    801005fd <consolewrite+0x2d>
  release(&cons.lock);
8010061c:	83 ec 0c             	sub    $0xc,%esp
8010061f:	68 20 0b 11 80       	push   $0x80110b20
80100624:	e8 c7 4a 00 00       	call   801050f0 <release>
  ilock(ip);
80100629:	58                   	pop    %eax
8010062a:	ff 75 08             	push   0x8(%ebp)
8010062d:	e8 fe 1c 00 00       	call   80102330 <ilock>

  return n;
}
80100632:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100635:	89 f0                	mov    %esi,%eax
80100637:	5b                   	pop    %ebx
80100638:	5e                   	pop    %esi
80100639:	5f                   	pop    %edi
8010063a:	5d                   	pop    %ebp
8010063b:	c3                   	ret    
8010063c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100640 <printint>:
{
80100640:	55                   	push   %ebp
80100641:	89 e5                	mov    %esp,%ebp
80100643:	57                   	push   %edi
80100644:	56                   	push   %esi
80100645:	53                   	push   %ebx
80100646:	83 ec 2c             	sub    $0x2c,%esp
80100649:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010064c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010064f:	85 c9                	test   %ecx,%ecx
80100651:	74 04                	je     80100657 <printint+0x17>
80100653:	85 c0                	test   %eax,%eax
80100655:	78 6d                	js     801006c4 <printint+0x84>
    x = xx;
80100657:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010065e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100660:	31 db                	xor    %ebx,%ebx
80100662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100668:	89 c8                	mov    %ecx,%eax
8010066a:	31 d2                	xor    %edx,%edx
8010066c:	89 de                	mov    %ebx,%esi
8010066e:	89 cf                	mov    %ecx,%edi
80100670:	f7 75 d4             	divl   -0x2c(%ebp)
80100673:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100676:	0f b6 92 b0 7d 10 80 	movzbl -0x7fef8250(%edx),%edx
  }while((x /= base) != 0);
8010067d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010067f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100683:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100686:	73 e0                	jae    80100668 <printint+0x28>
  if(sign)
80100688:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010068b:	85 c9                	test   %ecx,%ecx
8010068d:	74 0c                	je     8010069b <printint+0x5b>
    buf[i++] = '-';
8010068f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100694:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100696:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010069b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010069f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
801006a2:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
801006a8:	85 d2                	test   %edx,%edx
801006aa:	74 04                	je     801006b0 <printint+0x70>
801006ac:	fa                   	cli    
    for(;;)
801006ad:	eb fe                	jmp    801006ad <printint+0x6d>
801006af:	90                   	nop
801006b0:	e8 4b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
801006b5:	8d 45 d7             	lea    -0x29(%ebp),%eax
801006b8:	39 c3                	cmp    %eax,%ebx
801006ba:	74 0e                	je     801006ca <printint+0x8a>
    consputc(buf[i]);
801006bc:	0f be 03             	movsbl (%ebx),%eax
801006bf:	83 eb 01             	sub    $0x1,%ebx
801006c2:	eb de                	jmp    801006a2 <printint+0x62>
    x = -xx;
801006c4:	f7 d8                	neg    %eax
801006c6:	89 c1                	mov    %eax,%ecx
801006c8:	eb 96                	jmp    80100660 <printint+0x20>
}
801006ca:	83 c4 2c             	add    $0x2c,%esp
801006cd:	5b                   	pop    %ebx
801006ce:	5e                   	pop    %esi
801006cf:	5f                   	pop    %edi
801006d0:	5d                   	pop    %ebp
801006d1:	c3                   	ret    
801006d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006e0 <cprintf>:
{
801006e0:	55                   	push   %ebp
801006e1:	89 e5                	mov    %esp,%ebp
801006e3:	57                   	push   %edi
801006e4:	56                   	push   %esi
801006e5:	53                   	push   %ebx
801006e6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006e9:	a1 54 0b 11 80       	mov    0x80110b54,%eax
801006ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006f1:	85 c0                	test   %eax,%eax
801006f3:	0f 85 27 01 00 00    	jne    80100820 <cprintf+0x140>
  if (fmt == 0)
801006f9:	8b 75 08             	mov    0x8(%ebp),%esi
801006fc:	85 f6                	test   %esi,%esi
801006fe:	0f 84 ac 01 00 00    	je     801008b0 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100704:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100707:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010070a:	31 db                	xor    %ebx,%ebx
8010070c:	85 c0                	test   %eax,%eax
8010070e:	74 56                	je     80100766 <cprintf+0x86>
    if(c != '%'){
80100710:	83 f8 25             	cmp    $0x25,%eax
80100713:	0f 85 cf 00 00 00    	jne    801007e8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
80100719:	83 c3 01             	add    $0x1,%ebx
8010071c:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
80100720:	85 d2                	test   %edx,%edx
80100722:	74 42                	je     80100766 <cprintf+0x86>
    switch(c){
80100724:	83 fa 70             	cmp    $0x70,%edx
80100727:	0f 84 90 00 00 00    	je     801007bd <cprintf+0xdd>
8010072d:	7f 51                	jg     80100780 <cprintf+0xa0>
8010072f:	83 fa 25             	cmp    $0x25,%edx
80100732:	0f 84 c0 00 00 00    	je     801007f8 <cprintf+0x118>
80100738:	83 fa 64             	cmp    $0x64,%edx
8010073b:	0f 85 f4 00 00 00    	jne    80100835 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100741:	8d 47 04             	lea    0x4(%edi),%eax
80100744:	b9 01 00 00 00       	mov    $0x1,%ecx
80100749:	ba 0a 00 00 00       	mov    $0xa,%edx
8010074e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100751:	8b 07                	mov    (%edi),%eax
80100753:	e8 e8 fe ff ff       	call   80100640 <printint>
80100758:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010075b:	83 c3 01             	add    $0x1,%ebx
8010075e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100762:	85 c0                	test   %eax,%eax
80100764:	75 aa                	jne    80100710 <cprintf+0x30>
  if(locking)
80100766:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100769:	85 c0                	test   %eax,%eax
8010076b:	0f 85 22 01 00 00    	jne    80100893 <cprintf+0x1b3>
}
80100771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100774:	5b                   	pop    %ebx
80100775:	5e                   	pop    %esi
80100776:	5f                   	pop    %edi
80100777:	5d                   	pop    %ebp
80100778:	c3                   	ret    
80100779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100780:	83 fa 73             	cmp    $0x73,%edx
80100783:	75 33                	jne    801007b8 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100785:	8d 47 04             	lea    0x4(%edi),%eax
80100788:	8b 3f                	mov    (%edi),%edi
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	85 ff                	test   %edi,%edi
8010078f:	0f 84 e3 00 00 00    	je     80100878 <cprintf+0x198>
      for(; *s; s++)
80100795:	0f be 07             	movsbl (%edi),%eax
80100798:	84 c0                	test   %al,%al
8010079a:	0f 84 08 01 00 00    	je     801008a8 <cprintf+0x1c8>
  if(panicked){
801007a0:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
801007a6:	85 d2                	test   %edx,%edx
801007a8:	0f 84 b2 00 00 00    	je     80100860 <cprintf+0x180>
801007ae:	fa                   	cli    
    for(;;)
801007af:	eb fe                	jmp    801007af <cprintf+0xcf>
801007b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
801007b8:	83 fa 78             	cmp    $0x78,%edx
801007bb:	75 78                	jne    80100835 <cprintf+0x155>
      printint(*argp++, 16, 0);
801007bd:	8d 47 04             	lea    0x4(%edi),%eax
801007c0:	31 c9                	xor    %ecx,%ecx
801007c2:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007c7:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
801007ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007cd:	8b 07                	mov    (%edi),%eax
801007cf:	e8 6c fe ff ff       	call   80100640 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007d4:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
801007d8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007db:	85 c0                	test   %eax,%eax
801007dd:	0f 85 2d ff ff ff    	jne    80100710 <cprintf+0x30>
801007e3:	eb 81                	jmp    80100766 <cprintf+0x86>
801007e5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007e8:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
801007ee:	85 c9                	test   %ecx,%ecx
801007f0:	74 14                	je     80100806 <cprintf+0x126>
801007f2:	fa                   	cli    
    for(;;)
801007f3:	eb fe                	jmp    801007f3 <cprintf+0x113>
801007f5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007f8:	a1 58 0b 11 80       	mov    0x80110b58,%eax
801007fd:	85 c0                	test   %eax,%eax
801007ff:	75 6c                	jne    8010086d <cprintf+0x18d>
80100801:	b8 25 00 00 00       	mov    $0x25,%eax
80100806:	e8 f5 fb ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010080b:	83 c3 01             	add    $0x1,%ebx
8010080e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100812:	85 c0                	test   %eax,%eax
80100814:	0f 85 f6 fe ff ff    	jne    80100710 <cprintf+0x30>
8010081a:	e9 47 ff ff ff       	jmp    80100766 <cprintf+0x86>
8010081f:	90                   	nop
    acquire(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 20 0b 11 80       	push   $0x80110b20
80100828:	e8 23 49 00 00       	call   80105150 <acquire>
8010082d:	83 c4 10             	add    $0x10,%esp
80100830:	e9 c4 fe ff ff       	jmp    801006f9 <cprintf+0x19>
  if(panicked){
80100835:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
8010083b:	85 c9                	test   %ecx,%ecx
8010083d:	75 31                	jne    80100870 <cprintf+0x190>
8010083f:	b8 25 00 00 00       	mov    $0x25,%eax
80100844:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100847:	e8 b4 fb ff ff       	call   80100400 <consputc.part.0>
8010084c:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
80100852:	85 d2                	test   %edx,%edx
80100854:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100857:	74 2e                	je     80100887 <cprintf+0x1a7>
80100859:	fa                   	cli    
    for(;;)
8010085a:	eb fe                	jmp    8010085a <cprintf+0x17a>
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100860:	e8 9b fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100865:	83 c7 01             	add    $0x1,%edi
80100868:	e9 28 ff ff ff       	jmp    80100795 <cprintf+0xb5>
8010086d:	fa                   	cli    
    for(;;)
8010086e:	eb fe                	jmp    8010086e <cprintf+0x18e>
80100870:	fa                   	cli    
80100871:	eb fe                	jmp    80100871 <cprintf+0x191>
80100873:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100877:	90                   	nop
        s = "(null)";
80100878:	bf 98 7d 10 80       	mov    $0x80107d98,%edi
      for(; *s; s++)
8010087d:	b8 28 00 00 00       	mov    $0x28,%eax
80100882:	e9 19 ff ff ff       	jmp    801007a0 <cprintf+0xc0>
80100887:	89 d0                	mov    %edx,%eax
80100889:	e8 72 fb ff ff       	call   80100400 <consputc.part.0>
8010088e:	e9 c8 fe ff ff       	jmp    8010075b <cprintf+0x7b>
    release(&cons.lock);
80100893:	83 ec 0c             	sub    $0xc,%esp
80100896:	68 20 0b 11 80       	push   $0x80110b20
8010089b:	e8 50 48 00 00       	call   801050f0 <release>
801008a0:	83 c4 10             	add    $0x10,%esp
}
801008a3:	e9 c9 fe ff ff       	jmp    80100771 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
801008a8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801008ab:	e9 ab fe ff ff       	jmp    8010075b <cprintf+0x7b>
    panic("null fmt");
801008b0:	83 ec 0c             	sub    $0xc,%esp
801008b3:	68 9f 7d 10 80       	push   $0x80107d9f
801008b8:	e8 c3 fa ff ff       	call   80100380 <panic>
801008bd:	8d 76 00             	lea    0x0(%esi),%esi

801008c0 <copyCharsToBeMoved>:
  uint n = input.rightmost - input.r;
801008c0:	8b 0d 0c 0b 11 80    	mov    0x80110b0c,%ecx
  for (i = 0; i < n; i++)
801008c6:	2b 0d 00 0b 11 80    	sub    0x80110b00,%ecx
801008cc:	74 32                	je     80100900 <copyCharsToBeMoved+0x40>
void copyCharsToBeMoved() {
801008ce:	55                   	push   %ebp
  for (i = 0; i < n; i++)
801008cf:	31 c0                	xor    %eax,%eax
void copyCharsToBeMoved() {
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	53                   	push   %ebx
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801008d4:	8b 1d 08 0b 11 80    	mov    0x80110b08,%ebx
801008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801008e0:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  for (i = 0; i < n; i++)
801008e3:	83 c0 01             	add    $0x1,%eax
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801008e6:	83 e2 7f             	and    $0x7f,%edx
801008e9:	0f b6 92 80 0a 11 80 	movzbl -0x7feef580(%edx),%edx
801008f0:	88 90 ff 09 11 80    	mov    %dl,-0x7feef601(%eax)
  for (i = 0; i < n; i++)
801008f6:	39 c1                	cmp    %eax,%ecx
801008f8:	75 e6                	jne    801008e0 <copyCharsToBeMoved+0x20>
}
801008fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801008fd:	c9                   	leave  
801008fe:	c3                   	ret    
801008ff:	90                   	nop
80100900:	c3                   	ret    
80100901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100908:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010090f:	90                   	nop

80100910 <shiftbufleft>:
void shiftbufleft() {
80100910:	55                   	push   %ebp
  uint n = input.rightmost - input.e;
80100911:	a1 08 0b 11 80       	mov    0x80110b08,%eax
void shiftbufleft() {
80100916:	89 e5                	mov    %esp,%ebp
80100918:	56                   	push   %esi
  if(panicked){
80100919:	8b 35 58 0b 11 80    	mov    0x80110b58,%esi
void shiftbufleft() {
8010091f:	53                   	push   %ebx
  uint n = input.rightmost - input.e;
80100920:	8b 1d 0c 0b 11 80    	mov    0x80110b0c,%ebx
  if(panicked){
80100926:	85 f6                	test   %esi,%esi
80100928:	74 06                	je     80100930 <shiftbufleft+0x20>
8010092a:	fa                   	cli    
    for(;;)
8010092b:	eb fe                	jmp    8010092b <shiftbufleft+0x1b>
8010092d:	8d 76 00             	lea    0x0(%esi),%esi
  uint n = input.rightmost - input.e;
80100930:	29 c3                	sub    %eax,%ebx
80100932:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100937:	e8 c4 fa ff ff       	call   80100400 <consputc.part.0>
  input.e--;
8010093c:	a1 08 0b 11 80       	mov    0x80110b08,%eax
80100941:	83 e8 01             	sub    $0x1,%eax
80100944:	a3 08 0b 11 80       	mov    %eax,0x80110b08
  for (i = 0; i < n; i++) {
80100949:	85 db                	test   %ebx,%ebx
8010094b:	74 41                	je     8010098e <shiftbufleft+0x7e>
8010094d:	31 f6                	xor    %esi,%esi
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
8010094f:	01 f0                	add    %esi,%eax
  if(panicked){
80100951:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
80100957:	8d 50 01             	lea    0x1(%eax),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
8010095a:	83 e0 7f             	and    $0x7f,%eax
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
8010095d:	83 e2 7f             	and    $0x7f,%edx
80100960:	0f b6 92 80 0a 11 80 	movzbl -0x7feef580(%edx),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100967:	88 90 80 0a 11 80    	mov    %dl,-0x7feef580(%eax)
  if(panicked){
8010096d:	85 c9                	test   %ecx,%ecx
8010096f:	74 07                	je     80100978 <shiftbufleft+0x68>
80100971:	fa                   	cli    
    for(;;)
80100972:	eb fe                	jmp    80100972 <shiftbufleft+0x62>
80100974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(c);
80100978:	0f be c2             	movsbl %dl,%eax
  for (i = 0; i < n; i++) {
8010097b:	83 c6 01             	add    $0x1,%esi
8010097e:	e8 7d fa ff ff       	call   80100400 <consputc.part.0>
80100983:	39 f3                	cmp    %esi,%ebx
80100985:	74 07                	je     8010098e <shiftbufleft+0x7e>
    char c = input.buf[(input.e + i + 1) % INPUT_BUF];
80100987:	a1 08 0b 11 80       	mov    0x80110b08,%eax
8010098c:	eb c1                	jmp    8010094f <shiftbufleft+0x3f>
  if(panicked){
8010098e:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
  input.rightmost--;
80100994:	83 2d 0c 0b 11 80 01 	subl   $0x1,0x80110b0c
  if(panicked){
8010099b:	85 d2                	test   %edx,%edx
8010099d:	75 21                	jne    801009c0 <shiftbufleft+0xb0>
8010099f:	b8 20 00 00 00       	mov    $0x20,%eax
  for (i = 0; i <= n; i++) {
801009a4:	31 f6                	xor    %esi,%esi
801009a6:	e8 55 fa ff ff       	call   80100400 <consputc.part.0>
  if(panicked){
801009ab:	a1 58 0b 11 80       	mov    0x80110b58,%eax
801009b0:	85 c0                	test   %eax,%eax
801009b2:	74 14                	je     801009c8 <shiftbufleft+0xb8>
801009b4:	fa                   	cli    
    for(;;)
801009b5:	eb fe                	jmp    801009b5 <shiftbufleft+0xa5>
801009b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009be:	66 90                	xchg   %ax,%ax
801009c0:	fa                   	cli    
801009c1:	eb fe                	jmp    801009c1 <shiftbufleft+0xb1>
801009c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801009c7:	90                   	nop
801009c8:	b8 e4 00 00 00       	mov    $0xe4,%eax
  for (i = 0; i <= n; i++) {
801009cd:	83 c6 01             	add    $0x1,%esi
801009d0:	e8 2b fa ff ff       	call   80100400 <consputc.part.0>
801009d5:	39 f3                	cmp    %esi,%ebx
801009d7:	73 d2                	jae    801009ab <shiftbufleft+0x9b>
}
801009d9:	5b                   	pop    %ebx
801009da:	5e                   	pop    %esi
801009db:	5d                   	pop    %ebp
801009dc:	c3                   	ret    
801009dd:	8d 76 00             	lea    0x0(%esi),%esi

801009e0 <shiftbufright>:
void shiftbufright() {
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
801009e4:	56                   	push   %esi
801009e5:	53                   	push   %ebx
801009e6:	83 ec 0c             	sub    $0xc,%esp
  uint n = input.rightmost - input.e;
801009e9:	a1 08 0b 11 80       	mov    0x80110b08,%eax
  for (i = 0; i < n; i++) {
801009ee:	8b 1d 0c 0b 11 80    	mov    0x80110b0c,%ebx
801009f4:	29 c3                	sub    %eax,%ebx
801009f6:	74 7d                	je     80100a75 <shiftbufright+0x95>
801009f8:	31 f6                	xor    %esi,%esi
    char c = charsToBeMoved[i];
801009fa:	0f b6 96 00 0a 11 80 	movzbl -0x7feef600(%esi),%edx
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100a01:	01 f0                	add    %esi,%eax
  if(panicked){
80100a03:	8b 3d 58 0b 11 80    	mov    0x80110b58,%edi
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100a09:	83 e0 7f             	and    $0x7f,%eax
80100a0c:	88 90 80 0a 11 80    	mov    %dl,-0x7feef580(%eax)
  if(panicked){
80100a12:	85 ff                	test   %edi,%edi
80100a14:	74 0a                	je     80100a20 <shiftbufright+0x40>
80100a16:	fa                   	cli    
    for(;;)
80100a17:	eb fe                	jmp    80100a17 <shiftbufright+0x37>
80100a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(c);
80100a20:	0f be c2             	movsbl %dl,%eax
80100a23:	e8 d8 f9 ff ff       	call   80100400 <consputc.part.0>
  for (i = 0; i < n; i++) {
80100a28:	8d 56 01             	lea    0x1(%esi),%edx
80100a2b:	39 d3                	cmp    %edx,%ebx
80100a2d:	74 09                	je     80100a38 <shiftbufright+0x58>
    input.buf[(input.e + i) % INPUT_BUF] = c;
80100a2f:	a1 08 0b 11 80       	mov    0x80110b08,%eax
80100a34:	89 d6                	mov    %edx,%esi
80100a36:	eb c2                	jmp    801009fa <shiftbufright+0x1a>
  memset(charsToBeMoved, '\0', INPUT_BUF);
80100a38:	83 ec 04             	sub    $0x4,%esp
80100a3b:	68 80 00 00 00       	push   $0x80
80100a40:	6a 00                	push   $0x0
80100a42:	68 00 0a 11 80       	push   $0x80110a00
80100a47:	e8 c4 47 00 00       	call   80105210 <memset>
80100a4c:	83 c4 10             	add    $0x10,%esp
  if(panicked){
80100a4f:	a1 58 0b 11 80       	mov    0x80110b58,%eax
80100a54:	85 c0                	test   %eax,%eax
80100a56:	74 08                	je     80100a60 <shiftbufright+0x80>
80100a58:	fa                   	cli    
    for(;;)
80100a59:	eb fe                	jmp    80100a59 <shiftbufright+0x79>
80100a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop
80100a60:	b8 e4 00 00 00       	mov    $0xe4,%eax
80100a65:	e8 96 f9 ff ff       	call   80100400 <consputc.part.0>
  for (i = 0; i < n; i++) {
80100a6a:	8d 47 01             	lea    0x1(%edi),%eax
80100a6d:	39 fe                	cmp    %edi,%esi
80100a6f:	74 1b                	je     80100a8c <shiftbufright+0xac>
80100a71:	89 c7                	mov    %eax,%edi
80100a73:	eb da                	jmp    80100a4f <shiftbufright+0x6f>
  memset(charsToBeMoved, '\0', INPUT_BUF);
80100a75:	83 ec 04             	sub    $0x4,%esp
80100a78:	68 80 00 00 00       	push   $0x80
80100a7d:	6a 00                	push   $0x0
80100a7f:	68 00 0a 11 80       	push   $0x80110a00
80100a84:	e8 87 47 00 00       	call   80105210 <memset>
80100a89:	83 c4 10             	add    $0x10,%esp
}
80100a8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a8f:	5b                   	pop    %ebx
80100a90:	5e                   	pop    %esi
80100a91:	5f                   	pop    %edi
80100a92:	5d                   	pop    %ebp
80100a93:	c3                   	ret    
80100a94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a9f:	90                   	nop

80100aa0 <earaseCurrentLineOnScreen>:
    uint numToEarase = input.rightmost - input.r;
80100aa0:	a1 0c 0b 11 80       	mov    0x80110b0c,%eax
    for (i = 0; i < numToEarase; i++) {
80100aa5:	2b 05 00 0b 11 80    	sub    0x80110b00,%eax
80100aab:	74 30                	je     80100add <earaseCurrentLineOnScreen+0x3d>
earaseCurrentLineOnScreen(void){
80100aad:	55                   	push   %ebp
80100aae:	89 e5                	mov    %esp,%ebp
80100ab0:	56                   	push   %esi
    for (i = 0; i < numToEarase; i++) {
80100ab1:	31 f6                	xor    %esi,%esi
earaseCurrentLineOnScreen(void){
80100ab3:	53                   	push   %ebx
80100ab4:	89 c3                	mov    %eax,%ebx
  if(panicked){
80100ab6:	a1 58 0b 11 80       	mov    0x80110b58,%eax
80100abb:	85 c0                	test   %eax,%eax
80100abd:	74 09                	je     80100ac8 <earaseCurrentLineOnScreen+0x28>
80100abf:	fa                   	cli    
    for(;;)
80100ac0:	eb fe                	jmp    80100ac0 <earaseCurrentLineOnScreen+0x20>
80100ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ac8:	b8 00 01 00 00       	mov    $0x100,%eax
    for (i = 0; i < numToEarase; i++) {
80100acd:	83 c6 01             	add    $0x1,%esi
80100ad0:	e8 2b f9 ff ff       	call   80100400 <consputc.part.0>
80100ad5:	39 f3                	cmp    %esi,%ebx
80100ad7:	75 dd                	jne    80100ab6 <earaseCurrentLineOnScreen+0x16>
}
80100ad9:	5b                   	pop    %ebx
80100ada:	5e                   	pop    %esi
80100adb:	5d                   	pop    %ebp
80100adc:	c3                   	ret    
80100add:	c3                   	ret    
80100ade:	66 90                	xchg   %ax,%ax

80100ae0 <copyCharsToBeMovedToOldBuf>:
copyCharsToBeMovedToOldBuf(void){
80100ae0:	55                   	push   %ebp
    lengthOfOldBuf = input.rightmost - input.r;
80100ae1:	8b 0d 0c 0b 11 80    	mov    0x80110b0c,%ecx
copyCharsToBeMovedToOldBuf(void){
80100ae7:	89 e5                	mov    %esp,%ebp
80100ae9:	53                   	push   %ebx
    lengthOfOldBuf = input.rightmost - input.r;
80100aea:	8b 1d 00 0b 11 80    	mov    0x80110b00,%ebx
80100af0:	29 d9                	sub    %ebx,%ecx
80100af2:	89 0d 00 ff 10 80    	mov    %ecx,0x8010ff00
    for (i = 0; i < lengthOfOldBuf; i++) {
80100af8:	74 20                	je     80100b1a <copyCharsToBeMovedToOldBuf+0x3a>
80100afa:	31 c0                	xor    %eax,%eax
80100afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
80100b00:	8d 14 03             	lea    (%ebx,%eax,1),%edx
    for (i = 0; i < lengthOfOldBuf; i++) {
80100b03:	83 c0 01             	add    $0x1,%eax
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
80100b06:	83 e2 7f             	and    $0x7f,%edx
80100b09:	0f b6 92 80 0a 11 80 	movzbl -0x7feef580(%edx),%edx
80100b10:	88 90 1f ff 10 80    	mov    %dl,-0x7fef00e1(%eax)
    for (i = 0; i < lengthOfOldBuf; i++) {
80100b16:	39 c1                	cmp    %eax,%ecx
80100b18:	75 e6                	jne    80100b00 <copyCharsToBeMovedToOldBuf+0x20>
}
80100b1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100b1d:	c9                   	leave  
80100b1e:	c3                   	ret    
80100b1f:	90                   	nop

80100b20 <earaseContentOnInputBuf>:
  input.rightmost = input.r;
80100b20:	a1 00 0b 11 80       	mov    0x80110b00,%eax
80100b25:	a3 0c 0b 11 80       	mov    %eax,0x80110b0c
  input.e = input.r;
80100b2a:	a3 08 0b 11 80       	mov    %eax,0x80110b08
}
80100b2f:	c3                   	ret    

80100b30 <copyBufferToScreen>:
copyBufferToScreen(char * bufToPrintOnScreen, uint length){
80100b30:	55                   	push   %ebp
80100b31:	89 e5                	mov    %esp,%ebp
80100b33:	56                   	push   %esi
80100b34:	8b 75 0c             	mov    0xc(%ebp),%esi
80100b37:	53                   	push   %ebx
  for (i = 0; i < length; i++) {
80100b38:	85 f6                	test   %esi,%esi
80100b3a:	74 28                	je     80100b64 <copyBufferToScreen+0x34>
80100b3c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100b3f:	01 de                	add    %ebx,%esi
  if(panicked){
80100b41:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
    consputc(bufToPrintOnScreen[i]);
80100b47:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
80100b4a:	85 d2                	test   %edx,%edx
80100b4c:	74 0a                	je     80100b58 <copyBufferToScreen+0x28>
80100b4e:	fa                   	cli    
    for(;;)
80100b4f:	eb fe                	jmp    80100b4f <copyBufferToScreen+0x1f>
80100b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b58:	e8 a3 f8 ff ff       	call   80100400 <consputc.part.0>
  for (i = 0; i < length; i++) {
80100b5d:	83 c3 01             	add    $0x1,%ebx
80100b60:	39 f3                	cmp    %esi,%ebx
80100b62:	75 dd                	jne    80100b41 <copyBufferToScreen+0x11>
}
80100b64:	5b                   	pop    %ebx
80100b65:	5e                   	pop    %esi
80100b66:	5d                   	pop    %ebp
80100b67:	c3                   	ret    
80100b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b6f:	90                   	nop

80100b70 <copyBufferToInputBuf>:
copyBufferToInputBuf(char * bufToSaveInInput, uint length){
80100b70:	55                   	push   %ebp
  input.e = input.r+length;
80100b71:	8b 15 00 0b 11 80    	mov    0x80110b00,%edx
80100b77:	89 d0                	mov    %edx,%eax
copyBufferToInputBuf(char * bufToSaveInInput, uint length){
80100b79:	89 e5                	mov    %esp,%ebp
80100b7b:	56                   	push   %esi
80100b7c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b7f:	8b 75 08             	mov    0x8(%ebp),%esi
copyBufferToInputBuf(char * bufToSaveInInput, uint length){
80100b82:	53                   	push   %ebx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b83:	29 d6                	sub    %edx,%esi
80100b85:	8d 1c 11             	lea    (%ecx,%edx,1),%ebx
  for (i = 0; i < length; i++) {
80100b88:	85 c9                	test   %ecx,%ecx
80100b8a:	74 34                	je     80100bc0 <copyBufferToInputBuf+0x50>
80100b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b90:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80100b94:	89 c2                	mov    %eax,%edx
  for (i = 0; i < length; i++) {
80100b96:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80100b99:	83 e2 7f             	and    $0x7f,%edx
80100b9c:	88 8a 80 0a 11 80    	mov    %cl,-0x7feef580(%edx)
  for (i = 0; i < length; i++) {
80100ba2:	39 c3                	cmp    %eax,%ebx
80100ba4:	75 ea                	jne    80100b90 <copyBufferToInputBuf+0x20>
  input.e = input.r+length;
80100ba6:	89 1d 08 0b 11 80    	mov    %ebx,0x80110b08
  input.rightmost = input.e;
80100bac:	89 1d 0c 0b 11 80    	mov    %ebx,0x80110b0c
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
80100bd0:	55                   	push   %ebp
  if (historyBufferArray.numOfCommmandsInMem < MAX_HISTORY)
80100bd1:	a1 f4 09 11 80       	mov    0x801109f4,%eax
  historyBufferArray.currentHistory= -1;//reseting the users history current viewed
80100bd6:	c7 05 f8 09 11 80 ff 	movl   $0xffffffff,0x801109f8
80100bdd:	ff ff ff 
saveCommandInHistory(){
80100be0:	89 e5                	mov    %esp,%ebp
80100be2:	57                   	push   %edi
80100be3:	56                   	push   %esi
80100be4:	53                   	push   %ebx
  if (historyBufferArray.numOfCommmandsInMem < MAX_HISTORY)
80100be5:	83 f8 13             	cmp    $0x13,%eax
80100be8:	7f 08                	jg     80100bf2 <saveCommandInHistory+0x22>
    historyBufferArray.numOfCommmandsInMem++; //when we get to MAX_HISTORY commands in memory we keep on inserting to the array in a circular mution
80100bea:	83 c0 01             	add    $0x1,%eax
80100bed:	a3 f4 09 11 80       	mov    %eax,0x801109f4
  uint l = input.rightmost-input.r -1;
80100bf2:	a1 0c 0b 11 80       	mov    0x80110b0c,%eax
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100bf7:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  uint l = input.rightmost-input.r -1;
80100bfc:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
80100c02:	8d 58 ff             	lea    -0x1(%eax),%ebx
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c05:	a1 f0 09 11 80       	mov    0x801109f0,%eax
  uint l = input.rightmost-input.r -1;
80100c0a:	89 df                	mov    %ebx,%edi
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c0c:	8d 70 ff             	lea    -0x1(%eax),%esi
  uint l = input.rightmost-input.r -1;
80100c0f:	29 cf                	sub    %ecx,%edi
  historyBufferArray.lastCommandIndex = (historyBufferArray.lastCommandIndex - 1)%MAX_HISTORY;
80100c11:	89 f0                	mov    %esi,%eax
80100c13:	f7 e2                	mul    %edx
80100c15:	c1 ea 04             	shr    $0x4,%edx
80100c18:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100c1b:	c1 e0 02             	shl    $0x2,%eax
80100c1e:	29 c6                	sub    %eax,%esi
80100c20:	89 35 f0 09 11 80    	mov    %esi,0x801109f0
80100c26:	89 f2                	mov    %esi,%edx
  historyBufferArray.lengthsArr[historyBufferArray.lastCommandIndex] = l;
80100c28:	89 3c b5 a0 09 11 80 	mov    %edi,-0x7feef660(,%esi,4)
  for (i = 0; i < l; i++) { //do not want to save in memory the last char '/n'
80100c2f:	85 ff                	test   %edi,%edi
80100c31:	74 27                	je     80100c5a <saveCommandInHistory+0x8a>
80100c33:	c1 e2 07             	shl    $0x7,%edx
80100c36:	29 ca                	sub    %ecx,%edx
80100c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c3f:	90                   	nop
    historyBufferArray.bufferArr[historyBufferArray.lastCommandIndex][i] =  input.buf[(input.r+i)%INPUT_BUF];
80100c40:	89 c8                	mov    %ecx,%eax
80100c42:	83 e0 7f             	and    $0x7f,%eax
80100c45:	0f b6 80 80 0a 11 80 	movzbl -0x7feef580(%eax),%eax
80100c4c:	88 84 0a a0 ff 10 80 	mov    %al,-0x7fef0060(%edx,%ecx,1)
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
80100c60:	55                   	push   %ebp
80100c61:	89 e5                	mov    %esp,%ebp
80100c63:	56                   	push   %esi
80100c64:	8b 75 0c             	mov    0xc(%ebp),%esi
80100c67:	53                   	push   %ebx
80100c68:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (historyId < 0 || historyId > MAX_HISTORY - 1)
80100c6b:	83 fe 13             	cmp    $0x13,%esi
80100c6e:	77 70                	ja     80100ce0 <history+0x80>
  if (historyId >= historyBufferArray.numOfCommmandsInMem )
80100c70:	39 35 f4 09 11 80    	cmp    %esi,0x801109f4
80100c76:	7e 58                	jle    80100cd0 <history+0x70>
  memset(buffer, '\0', INPUT_BUF);
80100c78:	83 ec 04             	sub    $0x4,%esp
80100c7b:	68 80 00 00 00       	push   $0x80
80100c80:	6a 00                	push   $0x0
80100c82:	53                   	push   %ebx
80100c83:	e8 88 45 00 00       	call   80105210 <memset>
  int tempIndex = (historyBufferArray.lastCommandIndex + historyId) % MAX_HISTORY;
80100c88:	8b 0d f0 09 11 80    	mov    0x801109f0,%ecx
80100c8e:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  memmove(buffer, historyBufferArray.bufferArr[tempIndex], historyBufferArray.lengthsArr[tempIndex]);
80100c93:	83 c4 0c             	add    $0xc,%esp
  int tempIndex = (historyBufferArray.lastCommandIndex + historyId) % MAX_HISTORY;
80100c96:	01 f1                	add    %esi,%ecx
80100c98:	89 c8                	mov    %ecx,%eax
80100c9a:	f7 e2                	mul    %edx
80100c9c:	c1 ea 04             	shr    $0x4,%edx
80100c9f:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100ca2:	c1 e0 02             	shl    $0x2,%eax
80100ca5:	29 c1                	sub    %eax,%ecx
80100ca7:	89 ca                	mov    %ecx,%edx
  memmove(buffer, historyBufferArray.bufferArr[tempIndex], historyBufferArray.lengthsArr[tempIndex]);
80100ca9:	ff 34 8d a0 09 11 80 	push   -0x7feef660(,%ecx,4)
80100cb0:	c1 e2 07             	shl    $0x7,%edx
80100cb3:	81 c2 a0 ff 10 80    	add    $0x8010ffa0,%edx
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	e8 f0 45 00 00       	call   801052b0 <memmove>
  return 0;
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	31 c0                	xor    %eax,%eax
}
80100cc5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100cc8:	5b                   	pop    %ebx
80100cc9:	5e                   	pop    %esi
80100cca:	5d                   	pop    %ebp
80100ccb:	c3                   	ret    
80100ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80100cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100cd5:	eb ee                	jmp    80100cc5 <history+0x65>
80100cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cde:	66 90                	xchg   %ax,%ax
    return -2;
80100ce0:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80100ce5:	eb de                	jmp    80100cc5 <history+0x65>
80100ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100cee:	66 90                	xchg   %ax,%ax

80100cf0 <consoleintr>:
{
80100cf0:	55                   	push   %ebp
80100cf1:	89 e5                	mov    %esp,%ebp
80100cf3:	57                   	push   %edi
80100cf4:	56                   	push   %esi
80100cf5:	53                   	push   %ebx
80100cf6:	83 ec 38             	sub    $0x38,%esp
80100cf9:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
80100cfc:	68 20 0b 11 80       	push   $0x80110b20
80100d01:	e8 4a 44 00 00       	call   80105150 <acquire>
  int c, doprocdump = 0;
80100d06:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((c = getc()) >= 0){
80100d0d:	83 c4 10             	add    $0x10,%esp
80100d10:	ff d7                	call   *%edi
80100d12:	89 c3                	mov    %eax,%ebx
80100d14:	85 c0                	test   %eax,%eax
80100d16:	0f 88 c7 01 00 00    	js     80100ee3 <consoleintr+0x1f3>
    switch(c){
80100d1c:	83 fb 7f             	cmp    $0x7f,%ebx
80100d1f:	0f 84 5b 02 00 00    	je     80100f80 <consoleintr+0x290>
80100d25:	7e 69                	jle    80100d90 <consoleintr+0xa0>
80100d27:	81 fb e4 00 00 00    	cmp    $0xe4,%ebx
80100d2d:	0f 84 1d 02 00 00    	je     80100f50 <consoleintr+0x260>
80100d33:	0f 8f cf 00 00 00    	jg     80100e08 <consoleintr+0x118>
80100d39:	81 fb e2 00 00 00    	cmp    $0xe2,%ebx
80100d3f:	0f 84 cb 01 00 00    	je     80100f10 <consoleintr+0x220>
80100d45:	81 fb e3 00 00 00    	cmp    $0xe3,%ebx
80100d4b:	0f 85 62 02 00 00    	jne    80100fb3 <consoleintr+0x2c3>
        switch(historyBufferArray.currentHistory){
80100d51:	a1 f8 09 11 80       	mov    0x801109f8,%eax
80100d56:	83 f8 ff             	cmp    $0xffffffff,%eax
80100d59:	74 b5                	je     80100d10 <consoleintr+0x20>
80100d5b:	85 c0                	test   %eax,%eax
80100d5d:	0f 84 ad 02 00 00    	je     80101010 <consoleintr+0x320>
    uint numToEarase = input.rightmost - input.r;
80100d63:	8b 15 0c 0b 11 80    	mov    0x80110b0c,%edx
    for (i = 0; i < numToEarase; i++) {
80100d69:	2b 15 00 0b 11 80    	sub    0x80110b00,%edx
80100d6f:	89 d3                	mov    %edx,%ebx
80100d71:	0f 84 32 04 00 00    	je     801011a9 <consoleintr+0x4b9>
80100d77:	31 f6                	xor    %esi,%esi
  if(panicked){
80100d79:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
80100d7f:	85 c9                	test   %ecx,%ecx
80100d81:	0f 84 08 04 00 00    	je     8010118f <consoleintr+0x49f>
80100d87:	fa                   	cli    
    for(;;)
80100d88:	eb fe                	jmp    80100d88 <consoleintr+0x98>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100d90:	83 fb 10             	cmp    $0x10,%ebx
80100d93:	0f 84 37 01 00 00    	je     80100ed0 <consoleintr+0x1e0>
80100d99:	0f 8e a1 00 00 00    	jle    80100e40 <consoleintr+0x150>
80100d9f:	83 fb 15             	cmp    $0x15,%ebx
80100da2:	0f 85 0b 02 00 00    	jne    80100fb3 <consoleintr+0x2c3>
     if (input.rightmost > input.e) { // caret isn't at the end of the line
80100da8:	a1 0c 0b 11 80       	mov    0x80110b0c,%eax
          while(input.e != input.w &&
80100dad:	8b 35 04 0b 11 80    	mov    0x80110b04,%esi
     if (input.rightmost > input.e) { // caret isn't at the end of the line
80100db3:	8b 1d 08 0b 11 80    	mov    0x80110b08,%ebx
80100db9:	89 45 dc             	mov    %eax,-0x24(%ebp)
          while(input.e != input.w &&
80100dbc:	89 75 e0             	mov    %esi,-0x20(%ebp)
     if (input.rightmost > input.e) { // caret isn't at the end of the line
80100dbf:	39 d8                	cmp    %ebx,%eax
80100dc1:	0f 87 21 02 00 00    	ja     80100fe8 <consoleintr+0x2f8>
          while(input.e != input.w &&
80100dc7:	39 f3                	cmp    %esi,%ebx
80100dc9:	0f 84 41 ff ff ff    	je     80100d10 <consoleintr+0x20>
                input.buf[(input.e - 1) % INPUT_BUF] != '\n'){
80100dcf:	8d 43 ff             	lea    -0x1(%ebx),%eax
80100dd2:	89 c2                	mov    %eax,%edx
80100dd4:	83 e2 7f             	and    $0x7f,%edx
          while(input.e != input.w &&
80100dd7:	80 ba 80 0a 11 80 0a 	cmpb   $0xa,-0x7feef580(%edx)
80100dde:	0f 84 2c ff ff ff    	je     80100d10 <consoleintr+0x20>
  if(panicked){
80100de4:	8b 35 58 0b 11 80    	mov    0x80110b58,%esi
            input.rightmost--;
80100dea:	83 2d 0c 0b 11 80 01 	subl   $0x1,0x80110b0c
            input.e--;
80100df1:	a3 08 0b 11 80       	mov    %eax,0x80110b08
  if(panicked){
80100df6:	85 f6                	test   %esi,%esi
80100df8:	0f 84 9a 02 00 00    	je     80101098 <consoleintr+0x3a8>
80100dfe:	fa                   	cli    
    for(;;)
80100dff:	eb fe                	jmp    80100dff <consoleintr+0x10f>
80100e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100e08:	81 fb e5 00 00 00    	cmp    $0xe5,%ebx
80100e0e:	0f 85 9f 01 00 00    	jne    80100fb3 <consoleintr+0x2c3>
        if (input.e < input.rightmost) {
80100e14:	a1 08 0b 11 80       	mov    0x80110b08,%eax
80100e19:	3b 05 0c 0b 11 80    	cmp    0x80110b0c,%eax
80100e1f:	0f 82 53 02 00 00    	jb     80101078 <consoleintr+0x388>
        else if (input.e == input.rightmost){
80100e25:	0f 85 e5 fe ff ff    	jne    80100d10 <consoleintr+0x20>
  if(panicked){
80100e2b:	a1 58 0b 11 80       	mov    0x80110b58,%eax
80100e30:	85 c0                	test   %eax,%eax
80100e32:	0f 84 f4 05 00 00    	je     8010142c <consoleintr+0x73c>
80100e38:	fa                   	cli    
    for(;;)
80100e39:	eb fe                	jmp    80100e39 <consoleintr+0x149>
80100e3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e3f:	90                   	nop
    switch(c){
80100e40:	83 fb 08             	cmp    $0x8,%ebx
80100e43:	0f 84 37 01 00 00    	je     80100f80 <consoleintr+0x290>
80100e49:	83 fb 0d             	cmp    $0xd,%ebx
80100e4c:	0f 85 59 01 00 00    	jne    80100fab <consoleintr+0x2bb>
          input.e = input.rightmost;
80100e52:	8b 15 0c 0b 11 80    	mov    0x80110b0c,%edx
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100e58:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
80100e5e:	89 d0                	mov    %edx,%eax
          input.e = input.rightmost;
80100e60:	89 15 08 0b 11 80    	mov    %edx,0x80110b08
80100e66:	89 d6                	mov    %edx,%esi
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100e68:	29 c8                	sub    %ecx,%eax
80100e6a:	83 f8 7f             	cmp    $0x7f,%eax
80100e6d:	0f 87 9d fe ff ff    	ja     80100d10 <consoleintr+0x20>
80100e73:	c6 45 e0 0a          	movb   $0xa,-0x20(%ebp)
          c = (c == '\r') ? '\n' : c;
80100e77:	bb 0a 00 00 00       	mov    $0xa,%ebx
            input.buf[input.e++ % INPUT_BUF] = c;
80100e7c:	8d 46 01             	lea    0x1(%esi),%eax
80100e7f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100e82:	89 f0                	mov    %esi,%eax
80100e84:	83 e0 7f             	and    $0x7f,%eax
80100e87:	89 45 d8             	mov    %eax,-0x28(%ebp)
          if (input.rightmost > input.e) { // caret isn't at the end of the line
80100e8a:	39 d6                	cmp    %edx,%esi
80100e8c:	0f 82 07 05 00 00    	jb     80101399 <consoleintr+0x6a9>
            input.buf[input.e++ % INPUT_BUF] = c;
80100e92:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80100e95:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
80100e99:	8b 75 d8             	mov    -0x28(%ebp),%esi
80100e9c:	89 0d 08 0b 11 80    	mov    %ecx,0x80110b08
80100ea2:	88 86 80 0a 11 80    	mov    %al,-0x7feef580(%esi)
            input.rightmost = input.e - input.rightmost == 1 ? input.e : input.rightmost;
80100ea8:	89 c8                	mov    %ecx,%eax
80100eaa:	29 d0                	sub    %edx,%eax
80100eac:	83 f8 01             	cmp    $0x1,%eax
80100eaf:	0f 44 d1             	cmove  %ecx,%edx
80100eb2:	89 15 0c 0b 11 80    	mov    %edx,0x80110b0c
  if(panicked){
80100eb8:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
80100ebe:	85 d2                	test   %edx,%edx
80100ec0:	0f 84 8a 04 00 00    	je     80101350 <consoleintr+0x660>
80100ec6:	fa                   	cli    
    for(;;)
80100ec7:	eb fe                	jmp    80100ec7 <consoleintr+0x1d7>
80100ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100ed0:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  while((c = getc()) >= 0){
80100ed7:	ff d7                	call   *%edi
80100ed9:	89 c3                	mov    %eax,%ebx
80100edb:	85 c0                	test   %eax,%eax
80100edd:	0f 89 39 fe ff ff    	jns    80100d1c <consoleintr+0x2c>
  release(&cons.lock);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	68 20 0b 11 80       	push   $0x80110b20
80100eeb:	e8 00 42 00 00       	call   801050f0 <release>
  if(doprocdump) {
80100ef0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ef3:	83 c4 10             	add    $0x10,%esp
80100ef6:	85 c0                	test   %eax,%eax
80100ef8:	0f 85 42 01 00 00    	jne    80101040 <consoleintr+0x350>
}
80100efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f01:	5b                   	pop    %ebx
80100f02:	5e                   	pop    %esi
80100f03:	5f                   	pop    %edi
80100f04:	5d                   	pop    %ebp
80100f05:	c3                   	ret    
80100f06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f0d:	8d 76 00             	lea    0x0(%esi),%esi
       if (historyBufferArray.currentHistory < historyBufferArray.numOfCommmandsInMem-1 ){ // current history means the oldest possible will be MAX_HISTORY-1
80100f10:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80100f15:	8b 15 f8 09 11 80    	mov    0x801109f8,%edx
80100f1b:	83 e8 01             	sub    $0x1,%eax
80100f1e:	39 c2                	cmp    %eax,%edx
80100f20:	0f 8d ea fd ff ff    	jge    80100d10 <consoleintr+0x20>
    uint numToEarase = input.rightmost - input.r;
80100f26:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
    for (i = 0; i < numToEarase; i++) {
80100f2c:	8b 1d 0c 0b 11 80    	mov    0x80110b0c,%ebx
80100f32:	29 cb                	sub    %ecx,%ebx
80100f34:	0f 84 77 03 00 00    	je     801012b1 <consoleintr+0x5c1>
80100f3a:	31 f6                	xor    %esi,%esi
  if(panicked){
80100f3c:	a1 58 0b 11 80       	mov    0x80110b58,%eax
80100f41:	85 c0                	test   %eax,%eax
80100f43:	0f 84 47 03 00 00    	je     80101290 <consoleintr+0x5a0>
80100f49:	fa                   	cli    
    for(;;)
80100f4a:	eb fe                	jmp    80100f4a <consoleintr+0x25a>
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (input.e != input.w) {
80100f50:	a1 08 0b 11 80       	mov    0x80110b08,%eax
80100f55:	3b 05 04 0b 11 80    	cmp    0x80110b04,%eax
80100f5b:	0f 84 af fd ff ff    	je     80100d10 <consoleintr+0x20>
  if(panicked){
80100f61:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
          input.e--;
80100f67:	83 e8 01             	sub    $0x1,%eax
80100f6a:	a3 08 0b 11 80       	mov    %eax,0x80110b08
  if(panicked){
80100f6f:	85 c9                	test   %ecx,%ecx
80100f71:	0f 84 09 02 00 00    	je     80101180 <consoleintr+0x490>
80100f77:	fa                   	cli    
    for(;;)
80100f78:	eb fe                	jmp    80100f78 <consoleintr+0x288>
80100f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if (input.rightmost != input.e && input.e != input.w) { // caret isn't at the end of the line
80100f80:	a1 0c 0b 11 80       	mov    0x80110b0c,%eax
80100f85:	8b 15 08 0b 11 80    	mov    0x80110b08,%edx
          while(input.e != input.w &&
80100f8b:	8b 0d 04 0b 11 80    	mov    0x80110b04,%ecx
      if (input.rightmost != input.e && input.e != input.w) { // caret isn't at the end of the line
80100f91:	39 d0                	cmp    %edx,%eax
80100f93:	0f 84 b3 00 00 00    	je     8010104c <consoleintr+0x35c>
80100f99:	39 ca                	cmp    %ecx,%edx
80100f9b:	0f 84 6f fd ff ff    	je     80100d10 <consoleintr+0x20>
          shiftbufleft();
80100fa1:	e8 6a f9 ff ff       	call   80100910 <shiftbufleft>
          break;
80100fa6:	e9 65 fd ff ff       	jmp    80100d10 <consoleintr+0x20>
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100fab:	85 db                	test   %ebx,%ebx
80100fad:	0f 84 5d fd ff ff    	je     80100d10 <consoleintr+0x20>
     if (input.rightmost > input.e) { // caret isn't at the end of the line
80100fb3:	8b 35 08 0b 11 80    	mov    0x80110b08,%esi
        if(c != 0 && input.e-input.r < INPUT_BUF){
80100fb9:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
80100fbf:	89 f0                	mov    %esi,%eax
80100fc1:	29 c8                	sub    %ecx,%eax
80100fc3:	83 f8 7f             	cmp    $0x7f,%eax
80100fc6:	0f 87 44 fd ff ff    	ja     80100d10 <consoleintr+0x20>
          c = (c == '\r') ? '\n' : c;
80100fcc:	83 fb 0d             	cmp    $0xd,%ebx
80100fcf:	0f 84 08 06 00 00    	je     801015dd <consoleintr+0x8ed>
            input.buf[input.e++ % INPUT_BUF] = c;
80100fd5:	88 5d e0             	mov    %bl,-0x20(%ebp)
80100fd8:	8b 15 0c 0b 11 80    	mov    0x80110b0c,%edx
80100fde:	e9 99 fe ff ff       	jmp    80100e7c <consoleintr+0x18c>
80100fe3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100fe7:	90                   	nop
          for (i = 0; i < placestoshift; i++) {
80100fe8:	31 f6                	xor    %esi,%esi
80100fea:	89 d8                	mov    %ebx,%eax
80100fec:	2b 45 e0             	sub    -0x20(%ebp),%eax
80100fef:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100ff2:	0f 84 de 00 00 00    	je     801010d6 <consoleintr+0x3e6>
  if(panicked){
80100ff8:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
80100ffe:	85 c9                	test   %ecx,%ecx
80101000:	0f 84 ba 00 00 00    	je     801010c0 <consoleintr+0x3d0>
80101006:	fa                   	cli    
    for(;;)
80101007:	eb fe                	jmp    80101007 <consoleintr+0x317>
80101009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uint numToEarase = input.rightmost - input.r;
80101010:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
    for (i = 0; i < numToEarase; i++) {
80101016:	8b 1d 0c 0b 11 80    	mov    0x80110b0c,%ebx
8010101c:	29 cb                	sub    %ecx,%ebx
8010101e:	0f 84 07 02 00 00    	je     8010122b <consoleintr+0x53b>
80101024:	31 f6                	xor    %esi,%esi
  if(panicked){
80101026:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
8010102c:	85 c9                	test   %ecx,%ecx
8010102e:	0f 84 dc 01 00 00    	je     80101210 <consoleintr+0x520>
80101034:	fa                   	cli    
    for(;;)
80101035:	eb fe                	jmp    80101035 <consoleintr+0x345>
80101037:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010103e:	66 90                	xchg   %ax,%ax
}
80101040:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101043:	5b                   	pop    %ebx
80101044:	5e                   	pop    %esi
80101045:	5f                   	pop    %edi
80101046:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80101047:	e9 44 3d 00 00       	jmp    80104d90 <procdump>
        if(input.e != input.w){ // caret is at the end of the line - deleting last char
8010104c:	39 c8                	cmp    %ecx,%eax
8010104e:	0f 84 bc fc ff ff    	je     80100d10 <consoleintr+0x20>
  if(panicked){
80101054:	8b 1d 58 0b 11 80    	mov    0x80110b58,%ebx
          input.e--;
8010105a:	83 e8 01             	sub    $0x1,%eax
8010105d:	a3 08 0b 11 80       	mov    %eax,0x80110b08
          input.rightmost--;
80101062:	a3 0c 0b 11 80       	mov    %eax,0x80110b0c
  if(panicked){
80101067:	85 db                	test   %ebx,%ebx
80101069:	0f 84 d2 02 00 00    	je     80101341 <consoleintr+0x651>
8010106f:	fa                   	cli    
    for(;;)
80101070:	eb fe                	jmp    80101070 <consoleintr+0x380>
80101072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(panicked){
80101078:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
          consputc(input.buf[input.e % INPUT_BUF]);
8010107e:	83 e0 7f             	and    $0x7f,%eax
80101081:	0f be 80 80 0a 11 80 	movsbl -0x7feef580(%eax),%eax
  if(panicked){
80101088:	85 d2                	test   %edx,%edx
8010108a:	0f 84 a0 02 00 00    	je     80101330 <consoleintr+0x640>
80101090:	fa                   	cli    
    for(;;)
80101091:	eb fe                	jmp    80101091 <consoleintr+0x3a1>
80101093:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101097:	90                   	nop
80101098:	b8 00 01 00 00       	mov    $0x100,%eax
8010109d:	e8 5e f3 ff ff       	call   80100400 <consputc.part.0>
          while(input.e != input.w &&
801010a2:	8b 1d 08 0b 11 80    	mov    0x80110b08,%ebx
801010a8:	3b 1d 04 0b 11 80    	cmp    0x80110b04,%ebx
801010ae:	0f 85 1b fd ff ff    	jne    80100dcf <consoleintr+0xdf>
801010b4:	e9 57 fc ff ff       	jmp    80100d10 <consoleintr+0x20>
801010b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010c0:	b8 e4 00 00 00       	mov    $0xe4,%eax
          for (i = 0; i < placestoshift; i++) {
801010c5:	83 c6 01             	add    $0x1,%esi
801010c8:	e8 33 f3 ff ff       	call   80100400 <consputc.part.0>
801010cd:	39 75 d8             	cmp    %esi,-0x28(%ebp)
801010d0:	0f 85 22 ff ff ff    	jne    80100ff8 <consoleintr+0x308>
          memset(buf2, '\0', INPUT_BUF);
801010d6:	83 ec 04             	sub    $0x4,%esp
          uint numtoshift = input.rightmost - input.e;
801010d9:	8b 75 dc             	mov    -0x24(%ebp),%esi
          memset(buf2, '\0', INPUT_BUF);
801010dc:	68 80 00 00 00       	push   $0x80
801010e1:	6a 00                	push   $0x0
          uint numtoshift = input.rightmost - input.e;
801010e3:	29 de                	sub    %ebx,%esi
          memset(buf2, '\0', INPUT_BUF);
801010e5:	68 80 fe 10 80       	push   $0x8010fe80
801010ea:	e8 21 41 00 00       	call   80105210 <memset>
          for (i = 0; i < numtoshift; i++) {
801010ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
801010f2:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
801010f5:	83 c4 10             	add    $0x10,%esp
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
801010f8:	8b 0d 04 0b 11 80    	mov    0x80110b04,%ecx
801010fe:	8d 14 01             	lea    (%ecx,%eax,1),%edx
          for (i = 0; i < numtoshift; i++) {
80101101:	31 c0                	xor    %eax,%eax
80101103:	89 d3                	mov    %edx,%ebx
80101105:	8d 76 00             	lea    0x0(%esi),%esi
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
80101108:	8d 14 03             	lea    (%ebx,%eax,1),%edx
          for (i = 0; i < numtoshift; i++) {
8010110b:	83 c0 01             	add    $0x1,%eax
            buf2[i] = input.buf[(input.w + i + placestoshift) % INPUT_BUF];
8010110e:	83 e2 7f             	and    $0x7f,%edx
80101111:	0f b6 92 80 0a 11 80 	movzbl -0x7feef580(%edx),%edx
80101118:	88 90 7f fe 10 80    	mov    %dl,-0x7fef0181(%eax)
          for (i = 0; i < numtoshift; i++) {
8010111e:	39 c6                	cmp    %eax,%esi
80101120:	75 e6                	jne    80101108 <consoleintr+0x418>
          for (i = 0; i < numtoshift; i++) {
80101122:	31 c0                	xor    %eax,%eax
80101124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
80101128:	0f b6 98 80 fe 10 80 	movzbl -0x7fef0180(%eax),%ebx
8010112f:	8d 14 01             	lea    (%ecx,%eax,1),%edx
          for (i = 0; i < numtoshift; i++) {
80101132:	83 c0 01             	add    $0x1,%eax
            input.buf[(input.w + i) % INPUT_BUF] = buf2[i];
80101135:	83 e2 7f             	and    $0x7f,%edx
80101138:	88 9a 80 0a 11 80    	mov    %bl,-0x7feef580(%edx)
          for (i = 0; i < numtoshift; i++) {
8010113e:	39 c6                	cmp    %eax,%esi
80101140:	75 e6                	jne    80101128 <consoleintr+0x438>
80101142:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
          input.e -= placestoshift;
80101145:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101148:	8b 15 08 0b 11 80    	mov    0x80110b08,%edx
8010114e:	29 d8                	sub    %ebx,%eax
          input.rightmost -= placestoshift;
80101150:	01 05 0c 0b 11 80    	add    %eax,0x80110b0c
          for (i = 0; i < numtoshift; i++) { // repaint the chars
80101156:	31 db                	xor    %ebx,%ebx
          input.e -= placestoshift;
80101158:	01 c2                	add    %eax,%edx
8010115a:	89 15 08 0b 11 80    	mov    %edx,0x80110b08
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
80101160:	8d 04 13             	lea    (%ebx,%edx,1),%eax
  if(panicked){
80101163:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
80101169:	83 e0 7f             	and    $0x7f,%eax
8010116c:	0f be 80 80 0a 11 80 	movsbl -0x7feef580(%eax),%eax
  if(panicked){
80101173:	85 d2                	test   %edx,%edx
80101175:	0f 84 96 02 00 00    	je     80101411 <consoleintr+0x721>
8010117b:	fa                   	cli    
    for(;;)
8010117c:	eb fe                	jmp    8010117c <consoleintr+0x48c>
8010117e:	66 90                	xchg   %ax,%ax
80101180:	b8 e4 00 00 00       	mov    $0xe4,%eax
80101185:	e8 76 f2 ff ff       	call   80100400 <consputc.part.0>
8010118a:	e9 81 fb ff ff       	jmp    80100d10 <consoleintr+0x20>
8010118f:	b8 00 01 00 00       	mov    $0x100,%eax
    for (i = 0; i < numToEarase; i++) {
80101194:	83 c6 01             	add    $0x1,%esi
80101197:	e8 64 f2 ff ff       	call   80100400 <consputc.part.0>
8010119c:	39 f3                	cmp    %esi,%ebx
8010119e:	0f 85 d5 fb ff ff    	jne    80100d79 <consoleintr+0x89>
            historyBufferArray.currentHistory--;
801011a4:	a1 f8 09 11 80       	mov    0x801109f8,%eax
801011a9:	83 e8 01             	sub    $0x1,%eax
            tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory)%MAX_HISTORY;
801011ac:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
            historyBufferArray.currentHistory--;
801011b1:	a3 f8 09 11 80       	mov    %eax,0x801109f8
            tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory)%MAX_HISTORY;
801011b6:	03 05 f0 09 11 80    	add    0x801109f0,%eax
801011bc:	89 c1                	mov    %eax,%ecx
801011be:	f7 e2                	mul    %edx
801011c0:	89 d0                	mov    %edx,%eax
801011c2:	c1 e8 04             	shr    $0x4,%eax
801011c5:	8d 14 80             	lea    (%eax,%eax,4),%edx
801011c8:	89 c8                	mov    %ecx,%eax
801011ca:	c1 e2 02             	shl    $0x2,%edx
801011cd:	29 d0                	sub    %edx,%eax
            copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
801011cf:	8d 88 80 02 00 00    	lea    0x280(%eax),%ecx
801011d5:	c1 e0 07             	shl    $0x7,%eax
801011d8:	8b 34 8d a0 ff 10 80 	mov    -0x7fef0060(,%ecx,4),%esi
801011df:	8d 98 a0 ff 10 80    	lea    -0x7fef0060(%eax),%ebx
  for (i = 0; i < length; i++) {
801011e5:	85 f6                	test   %esi,%esi
801011e7:	0f 84 e5 03 00 00    	je     801015d2 <consoleintr+0x8e2>
801011ed:	89 7d e0             	mov    %edi,-0x20(%ebp)
801011f0:	01 de                	add    %ebx,%esi
801011f2:	89 df                	mov    %ebx,%edi
  if(panicked){
801011f4:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
    consputc(bufToPrintOnScreen[i]);
801011fa:	0f be 03             	movsbl (%ebx),%eax
  if(panicked){
801011fd:	85 d2                	test   %edx,%edx
801011ff:	0f 84 4b 02 00 00    	je     80101450 <consoleintr+0x760>
80101205:	fa                   	cli    
    for(;;)
80101206:	eb fe                	jmp    80101206 <consoleintr+0x516>
80101208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010120f:	90                   	nop
80101210:	b8 00 01 00 00       	mov    $0x100,%eax
    for (i = 0; i < numToEarase; i++) {
80101215:	83 c6 01             	add    $0x1,%esi
80101218:	e8 e3 f1 ff ff       	call   80100400 <consputc.part.0>
8010121d:	39 f3                	cmp    %esi,%ebx
8010121f:	0f 85 01 fe ff ff    	jne    80101026 <consoleintr+0x336>
  input.e = input.r+length;
80101225:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
            copyBufferToInputBuf(oldBuf, lengthOfOldBuf);
8010122b:	8b 1d 00 ff 10 80    	mov    0x8010ff00,%ebx
  input.e = input.r+length;
80101231:	8d 34 0b             	lea    (%ebx,%ecx,1),%esi
  for (i = 0; i < length; i++) {
80101234:	85 db                	test   %ebx,%ebx
80101236:	0f 84 68 03 00 00    	je     801015a4 <consoleintr+0x8b4>
8010123c:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010123f:	31 c0                	xor    %eax,%eax
80101241:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80101248:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010124b:	8d 14 08             	lea    (%eax,%ecx,1),%edx
8010124e:	0f b6 88 20 ff 10 80 	movzbl -0x7fef00e0(%eax),%ecx
  for (i = 0; i < length; i++) {
80101255:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80101258:	83 e2 7f             	and    $0x7f,%edx
8010125b:	88 8a 80 0a 11 80    	mov    %cl,-0x7feef580(%edx)
  for (i = 0; i < length; i++) {
80101261:	39 c3                	cmp    %eax,%ebx
80101263:	75 e3                	jne    80101248 <consoleintr+0x558>
  input.e = input.r+length;
80101265:	89 35 08 0b 11 80    	mov    %esi,0x80110b08
  input.rightmost = input.e;
8010126b:	89 35 0c 0b 11 80    	mov    %esi,0x80110b0c
80101271:	31 f6                	xor    %esi,%esi
  if(panicked){
80101273:	8b 15 58 0b 11 80    	mov    0x80110b58,%edx
    consputc(bufToPrintOnScreen[i]);
80101279:	0f be 86 20 ff 10 80 	movsbl -0x7fef00e0(%esi),%eax
  if(panicked){
80101280:	85 d2                	test   %edx,%edx
80101282:	0f 84 7b 02 00 00    	je     80101503 <consoleintr+0x813>
80101288:	fa                   	cli    
    for(;;)
80101289:	eb fe                	jmp    80101289 <consoleintr+0x599>
8010128b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010128f:	90                   	nop
80101290:	b8 00 01 00 00       	mov    $0x100,%eax
    for (i = 0; i < numToEarase; i++) {
80101295:	83 c6 01             	add    $0x1,%esi
80101298:	e8 63 f1 ff ff       	call   80100400 <consputc.part.0>
8010129d:	39 f3                	cmp    %esi,%ebx
8010129f:	0f 85 97 fc ff ff    	jne    80100f3c <consoleintr+0x24c>
          if (historyBufferArray.currentHistory == -1)
801012a5:	8b 15 f8 09 11 80    	mov    0x801109f8,%edx
    lengthOfOldBuf = input.rightmost - input.r;
801012ab:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
          if (historyBufferArray.currentHistory == -1)
801012b1:	83 fa ff             	cmp    $0xffffffff,%edx
801012b4:	0f 84 ae 02 00 00    	je     80101568 <consoleintr+0x878>
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
801012ba:	8b 35 f0 09 11 80    	mov    0x801109f0,%esi
          historyBufferArray.currentHistory++;
801012c0:	83 c2 01             	add    $0x1,%edx
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
801012c3:	bb cd cc cc cc       	mov    $0xcccccccd,%ebx
  input.rightmost = input.r;
801012c8:	89 0d 0c 0b 11 80    	mov    %ecx,0x80110b0c
          historyBufferArray.currentHistory++;
801012ce:	89 15 f8 09 11 80    	mov    %edx,0x801109f8
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
801012d4:	01 d6                	add    %edx,%esi
  input.e = input.r;
801012d6:	89 0d 08 0b 11 80    	mov    %ecx,0x80110b08
          tempIndex = (historyBufferArray.lastCommandIndex + historyBufferArray.currentHistory) %MAX_HISTORY;
801012dc:	89 f0                	mov    %esi,%eax
801012de:	f7 e3                	mul    %ebx
801012e0:	89 d3                	mov    %edx,%ebx
801012e2:	c1 eb 04             	shr    $0x4,%ebx
801012e5:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
801012e8:	c1 e0 02             	shl    $0x2,%eax
801012eb:	29 c6                	sub    %eax,%esi
801012ed:	89 f3                	mov    %esi,%ebx
          copyBufferToScreen(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
801012ef:	8d 96 80 02 00 00    	lea    0x280(%esi),%edx
801012f5:	8b 04 95 a0 ff 10 80 	mov    -0x7fef0060(,%edx,4),%eax
801012fc:	c1 e3 07             	shl    $0x7,%ebx
801012ff:	81 c3 a0 ff 10 80    	add    $0x8010ffa0,%ebx
  for (i = 0; i < length; i++) {
80101305:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80101308:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010130b:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010130e:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101311:	85 c0                	test   %eax,%eax
80101313:	0f 84 84 02 00 00    	je     8010159d <consoleintr+0x8ad>
  if(panicked){
80101319:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
    consputc(bufToPrintOnScreen[i]);
8010131f:	0f be 06             	movsbl (%esi),%eax
  if(panicked){
80101322:	85 c9                	test   %ecx,%ecx
80101324:	0f 84 80 01 00 00    	je     801014aa <consoleintr+0x7ba>
8010132a:	fa                   	cli    
    for(;;)
8010132b:	eb fe                	jmp    8010132b <consoleintr+0x63b>
8010132d:	8d 76 00             	lea    0x0(%esi),%esi
80101330:	e8 cb f0 ff ff       	call   80100400 <consputc.part.0>
          input.e++;
80101335:	83 05 08 0b 11 80 01 	addl   $0x1,0x80110b08
8010133c:	e9 cf f9 ff ff       	jmp    80100d10 <consoleintr+0x20>
80101341:	b8 00 01 00 00       	mov    $0x100,%eax
80101346:	e8 b5 f0 ff ff       	call   80100400 <consputc.part.0>
8010134b:	e9 c0 f9 ff ff       	jmp    80100d10 <consoleintr+0x20>
80101350:	89 d8                	mov    %ebx,%eax
80101352:	e8 a9 f0 ff ff       	call   80100400 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.rightmost == input.r + INPUT_BUF){
80101357:	83 fb 0a             	cmp    $0xa,%ebx
8010135a:	74 19                	je     80101375 <consoleintr+0x685>
8010135c:	83 fb 04             	cmp    $0x4,%ebx
8010135f:	74 14                	je     80101375 <consoleintr+0x685>
80101361:	a1 00 0b 11 80       	mov    0x80110b00,%eax
80101366:	83 e8 80             	sub    $0xffffff80,%eax
80101369:	39 05 0c 0b 11 80    	cmp    %eax,0x80110b0c
8010136f:	0f 85 9b f9 ff ff    	jne    80100d10 <consoleintr+0x20>
            saveCommandInHistory();
80101375:	e8 56 f8 ff ff       	call   80100bd0 <saveCommandInHistory>
            wakeup(&input.r);
8010137a:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.rightmost;
8010137d:	a1 0c 0b 11 80       	mov    0x80110b0c,%eax
            wakeup(&input.r);
80101382:	68 00 0b 11 80       	push   $0x80110b00
            input.w = input.rightmost;
80101387:	a3 04 0b 11 80       	mov    %eax,0x80110b04
            wakeup(&input.r);
8010138c:	e8 1f 39 00 00       	call   80104cb0 <wakeup>
80101391:	83 c4 10             	add    $0x10,%esp
80101394:	e9 77 f9 ff ff       	jmp    80100d10 <consoleintr+0x20>
  for (i = 0; i < n; i++)
80101399:	89 d0                	mov    %edx,%eax
8010139b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
801013a2:	29 c8                	sub    %ecx,%eax
801013a4:	89 c1                	mov    %eax,%ecx
801013a6:	74 25                	je     801013cd <consoleintr+0x6dd>
801013a8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
801013ab:	31 c0                	xor    %eax,%eax
801013ad:	89 cb                	mov    %ecx,%ebx
801013af:	90                   	nop
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801013b0:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
  for (i = 0; i < n; i++)
801013b3:	83 c0 01             	add    $0x1,%eax
    charsToBeMoved[i] = input.buf[(input.e + i) % INPUT_BUF];
801013b6:	83 e1 7f             	and    $0x7f,%ecx
801013b9:	0f b6 89 80 0a 11 80 	movzbl -0x7feef580(%ecx),%ecx
801013c0:	88 88 ff 09 11 80    	mov    %cl,-0x7feef601(%eax)
  for (i = 0; i < n; i++)
801013c6:	39 c3                	cmp    %eax,%ebx
801013c8:	75 e6                	jne    801013b0 <consoleintr+0x6c0>
801013ca:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
            input.buf[input.e++ % INPUT_BUF] = c;
801013cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013d0:	8b 4d d8             	mov    -0x28(%ebp),%ecx
            input.rightmost++;
801013d3:	83 c2 01             	add    $0x1,%edx
801013d6:	89 15 0c 0b 11 80    	mov    %edx,0x80110b0c
            input.buf[input.e++ % INPUT_BUF] = c;
801013dc:	a3 08 0b 11 80       	mov    %eax,0x80110b08
801013e1:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
801013e5:	88 81 80 0a 11 80    	mov    %al,-0x7feef580(%ecx)
  if(panicked){
801013eb:	8b 0d 58 0b 11 80    	mov    0x80110b58,%ecx
801013f1:	85 c9                	test   %ecx,%ecx
801013f3:	74 0b                	je     80101400 <consoleintr+0x710>
801013f5:	fa                   	cli    
    for(;;)
801013f6:	eb fe                	jmp    801013f6 <consoleintr+0x706>
801013f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013ff:	90                   	nop
80101400:	89 d8                	mov    %ebx,%eax
80101402:	e8 f9 ef ff ff       	call   80100400 <consputc.part.0>
            shiftbufright();
80101407:	e8 d4 f5 ff ff       	call   801009e0 <shiftbufright>
8010140c:	e9 46 ff ff ff       	jmp    80101357 <consoleintr+0x667>
80101411:	e8 ea ef ff ff       	call   80100400 <consputc.part.0>
          for (i = 0; i < numtoshift; i++) { // repaint the chars
80101416:	83 c3 01             	add    $0x1,%ebx
80101419:	39 de                	cmp    %ebx,%esi
8010141b:	0f 84 fe 00 00 00    	je     8010151f <consoleintr+0x82f>
            consputc(input.buf[(input.e + i) % INPUT_BUF]);
80101421:	8b 15 08 0b 11 80    	mov    0x80110b08,%edx
80101427:	e9 34 fd ff ff       	jmp    80101160 <consoleintr+0x470>
8010142c:	b8 20 00 00 00       	mov    $0x20,%eax
80101431:	e8 ca ef ff ff       	call   80100400 <consputc.part.0>
  if(panicked){
80101436:	a1 58 0b 11 80       	mov    0x80110b58,%eax
8010143b:	85 c0                	test   %eax,%eax
8010143d:	0f 84 3d fd ff ff    	je     80101180 <consoleintr+0x490>
80101443:	fa                   	cli    
    for(;;)
80101444:	eb fe                	jmp    80101444 <consoleintr+0x754>
80101446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010144d:	8d 76 00             	lea    0x0(%esi),%esi
  for (i = 0; i < length; i++) {
80101450:	83 c3 01             	add    $0x1,%ebx
80101453:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101456:	e8 a5 ef ff ff       	call   80100400 <consputc.part.0>
8010145b:	39 de                	cmp    %ebx,%esi
8010145d:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101460:	0f 85 8e fd ff ff    	jne    801011f4 <consoleintr+0x504>
            copyBufferToInputBuf(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101466:	8b 34 8d a0 ff 10 80 	mov    -0x7fef0060(,%ecx,4),%esi
8010146d:	89 fb                	mov    %edi,%ebx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
8010146f:	a1 00 0b 11 80       	mov    0x80110b00,%eax
            copyBufferToInputBuf(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
80101474:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for (i = 0; i < length; i++) {
80101477:	85 f6                	test   %esi,%esi
80101479:	0f 84 4c 01 00 00    	je     801015cb <consoleintr+0x8db>
8010147f:	01 c6                	add    %eax,%esi
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
80101481:	29 c3                	sub    %eax,%ebx
80101483:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
80101487:	89 c2                	mov    %eax,%edx
  for (i = 0; i < length; i++) {
80101489:	83 c0 01             	add    $0x1,%eax
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
8010148c:	83 e2 7f             	and    $0x7f,%edx
8010148f:	88 8a 80 0a 11 80    	mov    %cl,-0x7feef580(%edx)
  for (i = 0; i < length; i++) {
80101495:	39 c6                	cmp    %eax,%esi
80101497:	75 ea                	jne    80101483 <consoleintr+0x793>
  input.e = input.r+length;
80101499:	89 35 08 0b 11 80    	mov    %esi,0x80110b08
  input.rightmost = input.e;
8010149f:	89 35 0c 0b 11 80    	mov    %esi,0x80110b0c
}
801014a5:	e9 66 f8 ff ff       	jmp    80100d10 <consoleintr+0x20>
801014aa:	89 55 dc             	mov    %edx,-0x24(%ebp)
  for (i = 0; i < length; i++) {
801014ad:	83 c6 01             	add    $0x1,%esi
801014b0:	e8 4b ef ff ff       	call   80100400 <consputc.part.0>
801014b5:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801014b8:	8b 55 dc             	mov    -0x24(%ebp),%edx
801014bb:	0f 85 58 fe ff ff    	jne    80101319 <consoleintr+0x629>
          copyBufferToInputBuf(historyBufferArray.bufferArr[ tempIndex]  , historyBufferArray.lengthsArr[tempIndex]);
801014c1:	8b 04 95 a0 ff 10 80 	mov    -0x7fef0060(,%edx,4),%eax
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
801014c8:	8b 0d 00 0b 11 80    	mov    0x80110b00,%ecx
  for (i = 0; i < length; i++) {
801014ce:	85 c0                	test   %eax,%eax
801014d0:	0f 84 c7 00 00 00    	je     8010159d <consoleintr+0x8ad>
801014d6:	01 c8                	add    %ecx,%eax
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
801014d8:	29 cb                	sub    %ecx,%ebx
801014da:	89 c6                	mov    %eax,%esi
801014dc:	0f b6 04 0b          	movzbl (%ebx,%ecx,1),%eax
801014e0:	89 ca                	mov    %ecx,%edx
  for (i = 0; i < length; i++) {
801014e2:	83 c1 01             	add    $0x1,%ecx
    input.buf[(input.r+i)%INPUT_BUF] = bufToSaveInInput[i];
801014e5:	83 e2 7f             	and    $0x7f,%edx
801014e8:	88 82 80 0a 11 80    	mov    %al,-0x7feef580(%edx)
  for (i = 0; i < length; i++) {
801014ee:	39 ce                	cmp    %ecx,%esi
801014f0:	75 ea                	jne    801014dc <consoleintr+0x7ec>
801014f2:	89 f0                	mov    %esi,%eax
  input.e = input.r+length;
801014f4:	a3 08 0b 11 80       	mov    %eax,0x80110b08
  input.rightmost = input.e;
801014f9:	a3 0c 0b 11 80       	mov    %eax,0x80110b0c
}
801014fe:	e9 0d f8 ff ff       	jmp    80100d10 <consoleintr+0x20>
80101503:	e8 f8 ee ff ff       	call   80100400 <consputc.part.0>
  for (i = 0; i < length; i++) {
80101508:	83 c6 01             	add    $0x1,%esi
8010150b:	39 f3                	cmp    %esi,%ebx
8010150d:	0f 85 60 fd ff ff    	jne    80101273 <consoleintr+0x583>
            historyBufferArray.currentHistory--;
80101513:	83 2d f8 09 11 80 01 	subl   $0x1,0x801109f8
            break;
8010151a:	e9 f1 f7 ff ff       	jmp    80100d10 <consoleintr+0x20>
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
8010151f:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101522:	31 db                	xor    %ebx,%ebx
80101524:	85 c0                	test   %eax,%eax
80101526:	74 22                	je     8010154a <consoleintr+0x85a>
  if(panicked){
80101528:	a1 58 0b 11 80       	mov    0x80110b58,%eax
8010152d:	85 c0                	test   %eax,%eax
8010152f:	74 07                	je     80101538 <consoleintr+0x848>
80101531:	fa                   	cli    
    for(;;)
80101532:	eb fe                	jmp    80101532 <consoleintr+0x842>
80101534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101538:	b8 20 00 00 00       	mov    $0x20,%eax
          for (i = 0; i < placestoshift; i++) { // erase the leftover chars
8010153d:	83 c3 01             	add    $0x1,%ebx
80101540:	e8 bb ee ff ff       	call   80100400 <consputc.part.0>
80101545:	39 5d d8             	cmp    %ebx,-0x28(%ebp)
80101548:	75 de                	jne    80101528 <consoleintr+0x838>
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
8010154a:	8b 5d dc             	mov    -0x24(%ebp),%ebx
8010154d:	31 f6                	xor    %esi,%esi
8010154f:	2b 5d e0             	sub    -0x20(%ebp),%ebx
80101552:	0f 84 b8 f7 ff ff    	je     80100d10 <consoleintr+0x20>
  if(panicked){
80101558:	a1 58 0b 11 80       	mov    0x80110b58,%eax
8010155d:	85 c0                	test   %eax,%eax
8010155f:	74 54                	je     801015b5 <consoleintr+0x8c5>
80101561:	fa                   	cli    
    for(;;)
80101562:	eb fe                	jmp    80101562 <consoleintr+0x872>
80101564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lengthOfOldBuf = input.rightmost - input.r;
80101568:	8b 35 0c 0b 11 80    	mov    0x80110b0c,%esi
8010156e:	29 ce                	sub    %ecx,%esi
80101570:	89 35 00 ff 10 80    	mov    %esi,0x8010ff00
    for (i = 0; i < lengthOfOldBuf; i++) {
80101576:	0f 84 3e fd ff ff    	je     801012ba <consoleintr+0x5ca>
8010157c:	31 db                	xor    %ebx,%ebx
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
8010157e:	8d 04 0b             	lea    (%ebx,%ecx,1),%eax
    for (i = 0; i < lengthOfOldBuf; i++) {
80101581:	83 c3 01             	add    $0x1,%ebx
        oldBuf[i] = input.buf[(input.r+i)%INPUT_BUF];
80101584:	83 e0 7f             	and    $0x7f,%eax
80101587:	0f b6 80 80 0a 11 80 	movzbl -0x7feef580(%eax),%eax
8010158e:	88 83 1f ff 10 80    	mov    %al,-0x7fef00e1(%ebx)
    for (i = 0; i < lengthOfOldBuf; i++) {
80101594:	39 de                	cmp    %ebx,%esi
80101596:	75 e6                	jne    8010157e <consoleintr+0x88e>
80101598:	e9 1d fd ff ff       	jmp    801012ba <consoleintr+0x5ca>
8010159d:	89 c8                	mov    %ecx,%eax
8010159f:	e9 50 ff ff ff       	jmp    801014f4 <consoleintr+0x804>
  input.e = input.r+length;
801015a4:	89 35 08 0b 11 80    	mov    %esi,0x80110b08
  input.rightmost = input.e;
801015aa:	89 35 0c 0b 11 80    	mov    %esi,0x80110b0c
  for (i = 0; i < length; i++) {
801015b0:	e9 5e ff ff ff       	jmp    80101513 <consoleintr+0x823>
801015b5:	b8 e4 00 00 00       	mov    $0xe4,%eax
          for (i = 0; i < placestoshift + numtoshift; i++) { // move the caret back to the left
801015ba:	83 c6 01             	add    $0x1,%esi
801015bd:	e8 3e ee ff ff       	call   80100400 <consputc.part.0>
801015c2:	39 f3                	cmp    %esi,%ebx
801015c4:	75 92                	jne    80101558 <consoleintr+0x868>
801015c6:	e9 45 f7 ff ff       	jmp    80100d10 <consoleintr+0x20>
801015cb:	89 c6                	mov    %eax,%esi
801015cd:	e9 c7 fe ff ff       	jmp    80101499 <consoleintr+0x7a9>
  input.e = input.r+length;
801015d2:	8b 35 00 0b 11 80    	mov    0x80110b00,%esi
801015d8:	e9 bc fe ff ff       	jmp    80101499 <consoleintr+0x7a9>
801015dd:	c6 45 e0 0a          	movb   $0xa,-0x20(%ebp)
801015e1:	8b 15 0c 0b 11 80    	mov    0x80110b0c,%edx
          c = (c == '\r') ? '\n' : c;
801015e7:	bb 0a 00 00 00       	mov    $0xa,%ebx
801015ec:	e9 8b f8 ff ff       	jmp    80100e7c <consoleintr+0x18c>
801015f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ff:	90                   	nop

80101600 <consoleinit>:

void
consoleinit(void)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101606:	68 a8 7d 10 80       	push   $0x80107da8
8010160b:	68 20 0b 11 80       	push   $0x80110b20
80101610:	e8 6b 39 00 00       	call   80104f80 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80101615:	58                   	pop    %eax
80101616:	5a                   	pop    %edx
80101617:	6a 00                	push   $0x0
80101619:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
8010161b:	c7 05 0c 15 11 80 d0 	movl   $0x801005d0,0x8011150c
80101622:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80101625:	c7 05 08 15 11 80 80 	movl   $0x80100280,0x80111508
8010162c:	02 10 80 
  cons.locking = 1;
8010162f:	c7 05 54 0b 11 80 01 	movl   $0x1,0x80110b54
80101636:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101639:	e8 f2 19 00 00       	call   80103030 <ioapicenable>

  historyBufferArray.numOfCommmandsInMem=0;
  historyBufferArray.lastCommandIndex=0;
}
8010163e:	83 c4 10             	add    $0x10,%esp
  historyBufferArray.numOfCommmandsInMem=0;
80101641:	c7 05 f4 09 11 80 00 	movl   $0x0,0x801109f4
80101648:	00 00 00 
  historyBufferArray.lastCommandIndex=0;
8010164b:	c7 05 f0 09 11 80 00 	movl   $0x0,0x801109f0
80101652:	00 00 00 
}
80101655:	c9                   	leave  
80101656:	c3                   	ret    
80101657:	66 90                	xchg   %ax,%ax
80101659:	66 90                	xchg   %ax,%ax
8010165b:	66 90                	xchg   %ax,%ax
8010165d:	66 90                	xchg   %ax,%ax
8010165f:	90                   	nop

80101660 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	57                   	push   %edi
80101664:	56                   	push   %esi
80101665:	53                   	push   %ebx
80101666:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010166c:	e8 af 2e 00 00       	call   80104520 <myproc>
80101671:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101677:	e8 94 22 00 00       	call   80103910 <begin_op>

  if((ip = namei(path)) == 0){
8010167c:	83 ec 0c             	sub    $0xc,%esp
8010167f:	ff 75 08             	push   0x8(%ebp)
80101682:	e8 c9 15 00 00       	call   80102c50 <namei>
80101687:	83 c4 10             	add    $0x10,%esp
8010168a:	85 c0                	test   %eax,%eax
8010168c:	0f 84 02 03 00 00    	je     80101994 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101692:	83 ec 0c             	sub    $0xc,%esp
80101695:	89 c3                	mov    %eax,%ebx
80101697:	50                   	push   %eax
80101698:	e8 93 0c 00 00       	call   80102330 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010169d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801016a3:	6a 34                	push   $0x34
801016a5:	6a 00                	push   $0x0
801016a7:	50                   	push   %eax
801016a8:	53                   	push   %ebx
801016a9:	e8 92 0f 00 00       	call   80102640 <readi>
801016ae:	83 c4 20             	add    $0x20,%esp
801016b1:	83 f8 34             	cmp    $0x34,%eax
801016b4:	74 22                	je     801016d8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
801016b6:	83 ec 0c             	sub    $0xc,%esp
801016b9:	53                   	push   %ebx
801016ba:	e8 01 0f 00 00       	call   801025c0 <iunlockput>
    end_op();
801016bf:	e8 bc 22 00 00       	call   80103980 <end_op>
801016c4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
801016c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801016cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016cf:	5b                   	pop    %ebx
801016d0:	5e                   	pop    %esi
801016d1:	5f                   	pop    %edi
801016d2:	5d                   	pop    %ebp
801016d3:	c3                   	ret    
801016d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
801016d8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801016df:	45 4c 46 
801016e2:	75 d2                	jne    801016b6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
801016e4:	e8 07 63 00 00       	call   801079f0 <setupkvm>
801016e9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801016ef:	85 c0                	test   %eax,%eax
801016f1:	74 c3                	je     801016b6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801016f3:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801016fa:	00 
801016fb:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101701:	0f 84 ac 02 00 00    	je     801019b3 <exec+0x353>
  sz = 0;
80101707:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010170e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101711:	31 ff                	xor    %edi,%edi
80101713:	e9 8e 00 00 00       	jmp    801017a6 <exec+0x146>
80101718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101720:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101727:	75 6c                	jne    80101795 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101729:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010172f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101735:	0f 82 87 00 00 00    	jb     801017c2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010173b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101741:	72 7f                	jb     801017c2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101743:	83 ec 04             	sub    $0x4,%esp
80101746:	50                   	push   %eax
80101747:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
8010174d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101753:	e8 b8 60 00 00       	call   80107810 <allocuvm>
80101758:	83 c4 10             	add    $0x10,%esp
8010175b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101761:	85 c0                	test   %eax,%eax
80101763:	74 5d                	je     801017c2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101765:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010176b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101770:	75 50                	jne    801017c2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101772:	83 ec 0c             	sub    $0xc,%esp
80101775:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
8010177b:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101781:	53                   	push   %ebx
80101782:	50                   	push   %eax
80101783:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101789:	e8 92 5f 00 00       	call   80107720 <loaduvm>
8010178e:	83 c4 20             	add    $0x20,%esp
80101791:	85 c0                	test   %eax,%eax
80101793:	78 2d                	js     801017c2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101795:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010179c:	83 c7 01             	add    $0x1,%edi
8010179f:	83 c6 20             	add    $0x20,%esi
801017a2:	39 f8                	cmp    %edi,%eax
801017a4:	7e 3a                	jle    801017e0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801017a6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801017ac:	6a 20                	push   $0x20
801017ae:	56                   	push   %esi
801017af:	50                   	push   %eax
801017b0:	53                   	push   %ebx
801017b1:	e8 8a 0e 00 00       	call   80102640 <readi>
801017b6:	83 c4 10             	add    $0x10,%esp
801017b9:	83 f8 20             	cmp    $0x20,%eax
801017bc:	0f 84 5e ff ff ff    	je     80101720 <exec+0xc0>
    freevm(pgdir);
801017c2:	83 ec 0c             	sub    $0xc,%esp
801017c5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801017cb:	e8 a0 61 00 00       	call   80107970 <freevm>
  if(ip){
801017d0:	83 c4 10             	add    $0x10,%esp
801017d3:	e9 de fe ff ff       	jmp    801016b6 <exec+0x56>
801017d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017df:	90                   	nop
  sz = PGROUNDUP(sz);
801017e0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801017e6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801017ec:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801017f2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
801017f8:	83 ec 0c             	sub    $0xc,%esp
801017fb:	53                   	push   %ebx
801017fc:	e8 bf 0d 00 00       	call   801025c0 <iunlockput>
  end_op();
80101801:	e8 7a 21 00 00       	call   80103980 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101806:	83 c4 0c             	add    $0xc,%esp
80101809:	56                   	push   %esi
8010180a:	57                   	push   %edi
8010180b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101811:	57                   	push   %edi
80101812:	e8 f9 5f 00 00       	call   80107810 <allocuvm>
80101817:	83 c4 10             	add    $0x10,%esp
8010181a:	89 c6                	mov    %eax,%esi
8010181c:	85 c0                	test   %eax,%eax
8010181e:	0f 84 94 00 00 00    	je     801018b8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101824:	83 ec 08             	sub    $0x8,%esp
80101827:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010182d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010182f:	50                   	push   %eax
80101830:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101831:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101833:	e8 58 62 00 00       	call   80107a90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101838:	8b 45 0c             	mov    0xc(%ebp),%eax
8010183b:	83 c4 10             	add    $0x10,%esp
8010183e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101844:	8b 00                	mov    (%eax),%eax
80101846:	85 c0                	test   %eax,%eax
80101848:	0f 84 8b 00 00 00    	je     801018d9 <exec+0x279>
8010184e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101854:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010185a:	eb 23                	jmp    8010187f <exec+0x21f>
8010185c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101860:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101863:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010186a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010186d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101873:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101876:	85 c0                	test   %eax,%eax
80101878:	74 59                	je     801018d3 <exec+0x273>
    if(argc >= MAXARG)
8010187a:	83 ff 20             	cmp    $0x20,%edi
8010187d:	74 39                	je     801018b8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010187f:	83 ec 0c             	sub    $0xc,%esp
80101882:	50                   	push   %eax
80101883:	e8 88 3b 00 00       	call   80105410 <strlen>
80101888:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010188a:	58                   	pop    %eax
8010188b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010188e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101891:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101894:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101897:	e8 74 3b 00 00       	call   80105410 <strlen>
8010189c:	83 c0 01             	add    $0x1,%eax
8010189f:	50                   	push   %eax
801018a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801018a3:	ff 34 b8             	push   (%eax,%edi,4)
801018a6:	53                   	push   %ebx
801018a7:	56                   	push   %esi
801018a8:	e8 b3 63 00 00       	call   80107c60 <copyout>
801018ad:	83 c4 20             	add    $0x20,%esp
801018b0:	85 c0                	test   %eax,%eax
801018b2:	79 ac                	jns    80101860 <exec+0x200>
801018b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
801018b8:	83 ec 0c             	sub    $0xc,%esp
801018bb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801018c1:	e8 aa 60 00 00       	call   80107970 <freevm>
801018c6:	83 c4 10             	add    $0x10,%esp
  return -1;
801018c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801018ce:	e9 f9 fd ff ff       	jmp    801016cc <exec+0x6c>
801018d3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801018d9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801018e0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801018e2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801018e9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801018ed:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801018ef:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
801018f2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
801018f8:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801018fa:	50                   	push   %eax
801018fb:	52                   	push   %edx
801018fc:	53                   	push   %ebx
801018fd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101903:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010190a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010190d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101913:	e8 48 63 00 00       	call   80107c60 <copyout>
80101918:	83 c4 10             	add    $0x10,%esp
8010191b:	85 c0                	test   %eax,%eax
8010191d:	78 99                	js     801018b8 <exec+0x258>
  for(last=s=path; *s; s++)
8010191f:	8b 45 08             	mov    0x8(%ebp),%eax
80101922:	8b 55 08             	mov    0x8(%ebp),%edx
80101925:	0f b6 00             	movzbl (%eax),%eax
80101928:	84 c0                	test   %al,%al
8010192a:	74 13                	je     8010193f <exec+0x2df>
8010192c:	89 d1                	mov    %edx,%ecx
8010192e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101930:	83 c1 01             	add    $0x1,%ecx
80101933:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101935:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101938:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010193b:	84 c0                	test   %al,%al
8010193d:	75 f1                	jne    80101930 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010193f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101945:	83 ec 04             	sub    $0x4,%esp
80101948:	6a 10                	push   $0x10
8010194a:	89 f8                	mov    %edi,%eax
8010194c:	52                   	push   %edx
8010194d:	83 c0 6c             	add    $0x6c,%eax
80101950:	50                   	push   %eax
80101951:	e8 7a 3a 00 00       	call   801053d0 <safestrcpy>
  curproc->pgdir = pgdir;
80101956:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010195c:	89 f8                	mov    %edi,%eax
8010195e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101961:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101963:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101966:	89 c1                	mov    %eax,%ecx
80101968:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010196e:	8b 40 18             	mov    0x18(%eax),%eax
80101971:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101974:	8b 41 18             	mov    0x18(%ecx),%eax
80101977:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010197a:	89 0c 24             	mov    %ecx,(%esp)
8010197d:	e8 0e 5c 00 00       	call   80107590 <switchuvm>
  freevm(oldpgdir);
80101982:	89 3c 24             	mov    %edi,(%esp)
80101985:	e8 e6 5f 00 00       	call   80107970 <freevm>
  return 0;
8010198a:	83 c4 10             	add    $0x10,%esp
8010198d:	31 c0                	xor    %eax,%eax
8010198f:	e9 38 fd ff ff       	jmp    801016cc <exec+0x6c>
    end_op();
80101994:	e8 e7 1f 00 00       	call   80103980 <end_op>
    cprintf("exec: fail\n");
80101999:	83 ec 0c             	sub    $0xc,%esp
8010199c:	68 c1 7d 10 80       	push   $0x80107dc1
801019a1:	e8 3a ed ff ff       	call   801006e0 <cprintf>
    return -1;
801019a6:	83 c4 10             	add    $0x10,%esp
801019a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801019ae:	e9 19 fd ff ff       	jmp    801016cc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801019b3:	be 00 20 00 00       	mov    $0x2000,%esi
801019b8:	31 ff                	xor    %edi,%edi
801019ba:	e9 39 fe ff ff       	jmp    801017f8 <exec+0x198>
801019bf:	90                   	nop

801019c0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801019c6:	68 cd 7d 10 80       	push   $0x80107dcd
801019cb:	68 60 0b 11 80       	push   $0x80110b60
801019d0:	e8 ab 35 00 00       	call   80104f80 <initlock>
}
801019d5:	83 c4 10             	add    $0x10,%esp
801019d8:	c9                   	leave  
801019d9:	c3                   	ret    
801019da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801019e0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801019e4:	bb 94 0b 11 80       	mov    $0x80110b94,%ebx
{
801019e9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801019ec:	68 60 0b 11 80       	push   $0x80110b60
801019f1:	e8 5a 37 00 00       	call   80105150 <acquire>
801019f6:	83 c4 10             	add    $0x10,%esp
801019f9:	eb 10                	jmp    80101a0b <filealloc+0x2b>
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101a00:	83 c3 18             	add    $0x18,%ebx
80101a03:	81 fb f4 14 11 80    	cmp    $0x801114f4,%ebx
80101a09:	74 25                	je     80101a30 <filealloc+0x50>
    if(f->ref == 0){
80101a0b:	8b 43 04             	mov    0x4(%ebx),%eax
80101a0e:	85 c0                	test   %eax,%eax
80101a10:	75 ee                	jne    80101a00 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101a12:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101a15:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101a1c:	68 60 0b 11 80       	push   $0x80110b60
80101a21:	e8 ca 36 00 00       	call   801050f0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101a26:	89 d8                	mov    %ebx,%eax
      return f;
80101a28:	83 c4 10             	add    $0x10,%esp
}
80101a2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a2e:	c9                   	leave  
80101a2f:	c3                   	ret    
  release(&ftable.lock);
80101a30:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101a33:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101a35:	68 60 0b 11 80       	push   $0x80110b60
80101a3a:	e8 b1 36 00 00       	call   801050f0 <release>
}
80101a3f:	89 d8                	mov    %ebx,%eax
  return 0;
80101a41:	83 c4 10             	add    $0x10,%esp
}
80101a44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a47:	c9                   	leave  
80101a48:	c3                   	ret    
80101a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a50 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	53                   	push   %ebx
80101a54:	83 ec 10             	sub    $0x10,%esp
80101a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101a5a:	68 60 0b 11 80       	push   $0x80110b60
80101a5f:	e8 ec 36 00 00       	call   80105150 <acquire>
  if(f->ref < 1)
80101a64:	8b 43 04             	mov    0x4(%ebx),%eax
80101a67:	83 c4 10             	add    $0x10,%esp
80101a6a:	85 c0                	test   %eax,%eax
80101a6c:	7e 1a                	jle    80101a88 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101a6e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101a71:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101a74:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101a77:	68 60 0b 11 80       	push   $0x80110b60
80101a7c:	e8 6f 36 00 00       	call   801050f0 <release>
  return f;
}
80101a81:	89 d8                	mov    %ebx,%eax
80101a83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a86:	c9                   	leave  
80101a87:	c3                   	ret    
    panic("filedup");
80101a88:	83 ec 0c             	sub    $0xc,%esp
80101a8b:	68 d4 7d 10 80       	push   $0x80107dd4
80101a90:	e8 eb e8 ff ff       	call   80100380 <panic>
80101a95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101aa0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 28             	sub    $0x28,%esp
80101aa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101aac:	68 60 0b 11 80       	push   $0x80110b60
80101ab1:	e8 9a 36 00 00       	call   80105150 <acquire>
  if(f->ref < 1)
80101ab6:	8b 53 04             	mov    0x4(%ebx),%edx
80101ab9:	83 c4 10             	add    $0x10,%esp
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 8e a5 00 00 00    	jle    80101b69 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101ac4:	83 ea 01             	sub    $0x1,%edx
80101ac7:	89 53 04             	mov    %edx,0x4(%ebx)
80101aca:	75 44                	jne    80101b10 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101acc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101ad0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101ad3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101ad5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80101adb:	8b 73 0c             	mov    0xc(%ebx),%esi
80101ade:	88 45 e7             	mov    %al,-0x19(%ebp)
80101ae1:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101ae4:	68 60 0b 11 80       	push   $0x80110b60
  ff = *f;
80101ae9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101aec:	e8 ff 35 00 00       	call   801050f0 <release>

  if(ff.type == FD_PIPE)
80101af1:	83 c4 10             	add    $0x10,%esp
80101af4:	83 ff 01             	cmp    $0x1,%edi
80101af7:	74 57                	je     80101b50 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101af9:	83 ff 02             	cmp    $0x2,%edi
80101afc:	74 2a                	je     80101b28 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101afe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b01:	5b                   	pop    %ebx
80101b02:	5e                   	pop    %esi
80101b03:	5f                   	pop    %edi
80101b04:	5d                   	pop    %ebp
80101b05:	c3                   	ret    
80101b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b0d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101b10:	c7 45 08 60 0b 11 80 	movl   $0x80110b60,0x8(%ebp)
}
80101b17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b1a:	5b                   	pop    %ebx
80101b1b:	5e                   	pop    %esi
80101b1c:	5f                   	pop    %edi
80101b1d:	5d                   	pop    %ebp
    release(&ftable.lock);
80101b1e:	e9 cd 35 00 00       	jmp    801050f0 <release>
80101b23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b27:	90                   	nop
    begin_op();
80101b28:	e8 e3 1d 00 00       	call   80103910 <begin_op>
    iput(ff.ip);
80101b2d:	83 ec 0c             	sub    $0xc,%esp
80101b30:	ff 75 e0             	push   -0x20(%ebp)
80101b33:	e8 28 09 00 00       	call   80102460 <iput>
    end_op();
80101b38:	83 c4 10             	add    $0x10,%esp
}
80101b3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b3e:	5b                   	pop    %ebx
80101b3f:	5e                   	pop    %esi
80101b40:	5f                   	pop    %edi
80101b41:	5d                   	pop    %ebp
    end_op();
80101b42:	e9 39 1e 00 00       	jmp    80103980 <end_op>
80101b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b4e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101b50:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101b54:	83 ec 08             	sub    $0x8,%esp
80101b57:	53                   	push   %ebx
80101b58:	56                   	push   %esi
80101b59:	e8 82 25 00 00       	call   801040e0 <pipeclose>
80101b5e:	83 c4 10             	add    $0x10,%esp
}
80101b61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b64:	5b                   	pop    %ebx
80101b65:	5e                   	pop    %esi
80101b66:	5f                   	pop    %edi
80101b67:	5d                   	pop    %ebp
80101b68:	c3                   	ret    
    panic("fileclose");
80101b69:	83 ec 0c             	sub    $0xc,%esp
80101b6c:	68 dc 7d 10 80       	push   $0x80107ddc
80101b71:	e8 0a e8 ff ff       	call   80100380 <panic>
80101b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi

80101b80 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	53                   	push   %ebx
80101b84:	83 ec 04             	sub    $0x4,%esp
80101b87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101b8a:	83 3b 02             	cmpl   $0x2,(%ebx)
80101b8d:	75 31                	jne    80101bc0 <filestat+0x40>
    ilock(f->ip);
80101b8f:	83 ec 0c             	sub    $0xc,%esp
80101b92:	ff 73 10             	push   0x10(%ebx)
80101b95:	e8 96 07 00 00       	call   80102330 <ilock>
    stati(f->ip, st);
80101b9a:	58                   	pop    %eax
80101b9b:	5a                   	pop    %edx
80101b9c:	ff 75 0c             	push   0xc(%ebp)
80101b9f:	ff 73 10             	push   0x10(%ebx)
80101ba2:	e8 69 0a 00 00       	call   80102610 <stati>
    iunlock(f->ip);
80101ba7:	59                   	pop    %ecx
80101ba8:	ff 73 10             	push   0x10(%ebx)
80101bab:	e8 60 08 00 00       	call   80102410 <iunlock>
    return 0;
  }
  return -1;
}
80101bb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101bb3:	83 c4 10             	add    $0x10,%esp
80101bb6:	31 c0                	xor    %eax,%eax
}
80101bb8:	c9                   	leave  
80101bb9:	c3                   	ret    
80101bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101bc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101bc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101bc8:	c9                   	leave  
80101bc9:	c3                   	ret    
80101bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101bd0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	57                   	push   %edi
80101bd4:	56                   	push   %esi
80101bd5:	53                   	push   %ebx
80101bd6:	83 ec 0c             	sub    $0xc,%esp
80101bd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bdc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bdf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101be2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101be6:	74 60                	je     80101c48 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101be8:	8b 03                	mov    (%ebx),%eax
80101bea:	83 f8 01             	cmp    $0x1,%eax
80101bed:	74 41                	je     80101c30 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101bef:	83 f8 02             	cmp    $0x2,%eax
80101bf2:	75 5b                	jne    80101c4f <fileread+0x7f>
    ilock(f->ip);
80101bf4:	83 ec 0c             	sub    $0xc,%esp
80101bf7:	ff 73 10             	push   0x10(%ebx)
80101bfa:	e8 31 07 00 00       	call   80102330 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101bff:	57                   	push   %edi
80101c00:	ff 73 14             	push   0x14(%ebx)
80101c03:	56                   	push   %esi
80101c04:	ff 73 10             	push   0x10(%ebx)
80101c07:	e8 34 0a 00 00       	call   80102640 <readi>
80101c0c:	83 c4 20             	add    $0x20,%esp
80101c0f:	89 c6                	mov    %eax,%esi
80101c11:	85 c0                	test   %eax,%eax
80101c13:	7e 03                	jle    80101c18 <fileread+0x48>
      f->off += r;
80101c15:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101c18:	83 ec 0c             	sub    $0xc,%esp
80101c1b:	ff 73 10             	push   0x10(%ebx)
80101c1e:	e8 ed 07 00 00       	call   80102410 <iunlock>
    return r;
80101c23:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101c26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c29:	89 f0                	mov    %esi,%eax
80101c2b:	5b                   	pop    %ebx
80101c2c:	5e                   	pop    %esi
80101c2d:	5f                   	pop    %edi
80101c2e:	5d                   	pop    %ebp
80101c2f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101c30:	8b 43 0c             	mov    0xc(%ebx),%eax
80101c33:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101c36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c39:	5b                   	pop    %ebx
80101c3a:	5e                   	pop    %esi
80101c3b:	5f                   	pop    %edi
80101c3c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101c3d:	e9 3e 26 00 00       	jmp    80104280 <piperead>
80101c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101c48:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101c4d:	eb d7                	jmp    80101c26 <fileread+0x56>
  panic("fileread");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 e6 7d 10 80       	push   $0x80107de6
80101c57:	e8 24 e7 ff ff       	call   80100380 <panic>
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c60 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	57                   	push   %edi
80101c64:	56                   	push   %esi
80101c65:	53                   	push   %ebx
80101c66:	83 ec 1c             	sub    $0x1c,%esp
80101c69:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101c72:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101c75:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101c79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101c7c:	0f 84 bd 00 00 00    	je     80101d3f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101c82:	8b 03                	mov    (%ebx),%eax
80101c84:	83 f8 01             	cmp    $0x1,%eax
80101c87:	0f 84 bf 00 00 00    	je     80101d4c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101c8d:	83 f8 02             	cmp    $0x2,%eax
80101c90:	0f 85 c8 00 00 00    	jne    80101d5e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101c96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101c99:	31 f6                	xor    %esi,%esi
    while(i < n){
80101c9b:	85 c0                	test   %eax,%eax
80101c9d:	7f 30                	jg     80101ccf <filewrite+0x6f>
80101c9f:	e9 94 00 00 00       	jmp    80101d38 <filewrite+0xd8>
80101ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101ca8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
80101cab:	83 ec 0c             	sub    $0xc,%esp
80101cae:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101cb1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101cb4:	e8 57 07 00 00       	call   80102410 <iunlock>
      end_op();
80101cb9:	e8 c2 1c 00 00       	call   80103980 <end_op>

      if(r < 0)
        break;
      if(r != n1)
80101cbe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101cc1:	83 c4 10             	add    $0x10,%esp
80101cc4:	39 c7                	cmp    %eax,%edi
80101cc6:	75 5c                	jne    80101d24 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101cc8:	01 fe                	add    %edi,%esi
    while(i < n){
80101cca:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101ccd:	7e 69                	jle    80101d38 <filewrite+0xd8>
      int n1 = n - i;
80101ccf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101cd2:	b8 00 06 00 00       	mov    $0x600,%eax
80101cd7:	29 f7                	sub    %esi,%edi
80101cd9:	39 c7                	cmp    %eax,%edi
80101cdb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
80101cde:	e8 2d 1c 00 00       	call   80103910 <begin_op>
      ilock(f->ip);
80101ce3:	83 ec 0c             	sub    $0xc,%esp
80101ce6:	ff 73 10             	push   0x10(%ebx)
80101ce9:	e8 42 06 00 00       	call   80102330 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101cee:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101cf1:	57                   	push   %edi
80101cf2:	ff 73 14             	push   0x14(%ebx)
80101cf5:	01 f0                	add    %esi,%eax
80101cf7:	50                   	push   %eax
80101cf8:	ff 73 10             	push   0x10(%ebx)
80101cfb:	e8 40 0a 00 00       	call   80102740 <writei>
80101d00:	83 c4 20             	add    $0x20,%esp
80101d03:	85 c0                	test   %eax,%eax
80101d05:	7f a1                	jg     80101ca8 <filewrite+0x48>
      iunlock(f->ip);
80101d07:	83 ec 0c             	sub    $0xc,%esp
80101d0a:	ff 73 10             	push   0x10(%ebx)
80101d0d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d10:	e8 fb 06 00 00       	call   80102410 <iunlock>
      end_op();
80101d15:	e8 66 1c 00 00       	call   80103980 <end_op>
      if(r < 0)
80101d1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d1d:	83 c4 10             	add    $0x10,%esp
80101d20:	85 c0                	test   %eax,%eax
80101d22:	75 1b                	jne    80101d3f <filewrite+0xdf>
        panic("short filewrite");
80101d24:	83 ec 0c             	sub    $0xc,%esp
80101d27:	68 ef 7d 10 80       	push   $0x80107def
80101d2c:	e8 4f e6 ff ff       	call   80100380 <panic>
80101d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101d38:	89 f0                	mov    %esi,%eax
80101d3a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80101d3d:	74 05                	je     80101d44 <filewrite+0xe4>
80101d3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d47:	5b                   	pop    %ebx
80101d48:	5e                   	pop    %esi
80101d49:	5f                   	pop    %edi
80101d4a:	5d                   	pop    %ebp
80101d4b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101d4c:	8b 43 0c             	mov    0xc(%ebx),%eax
80101d4f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101d52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d55:	5b                   	pop    %ebx
80101d56:	5e                   	pop    %esi
80101d57:	5f                   	pop    %edi
80101d58:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101d59:	e9 22 24 00 00       	jmp    80104180 <pipewrite>
  panic("filewrite");
80101d5e:	83 ec 0c             	sub    $0xc,%esp
80101d61:	68 f5 7d 10 80       	push   $0x80107df5
80101d66:	e8 15 e6 ff ff       	call   80100380 <panic>
80101d6b:	66 90                	xchg   %ax,%ax
80101d6d:	66 90                	xchg   %ax,%ax
80101d6f:	90                   	nop

80101d70 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101d70:	55                   	push   %ebp
80101d71:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101d73:	89 d0                	mov    %edx,%eax
80101d75:	c1 e8 0c             	shr    $0xc,%eax
80101d78:	03 05 cc 31 11 80    	add    0x801131cc,%eax
{
80101d7e:	89 e5                	mov    %esp,%ebp
80101d80:	56                   	push   %esi
80101d81:	53                   	push   %ebx
80101d82:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101d84:	83 ec 08             	sub    $0x8,%esp
80101d87:	50                   	push   %eax
80101d88:	51                   	push   %ecx
80101d89:	e8 42 e3 ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101d8e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101d90:	c1 fb 03             	sar    $0x3,%ebx
80101d93:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101d96:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101d98:	83 e1 07             	and    $0x7,%ecx
80101d9b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101da0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101da6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101da8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101dad:	85 c1                	test   %eax,%ecx
80101daf:	74 23                	je     80101dd4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101db1:	f7 d0                	not    %eax
  log_write(bp);
80101db3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101db6:	21 c8                	and    %ecx,%eax
80101db8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101dbc:	56                   	push   %esi
80101dbd:	e8 2e 1d 00 00       	call   80103af0 <log_write>
  brelse(bp);
80101dc2:	89 34 24             	mov    %esi,(%esp)
80101dc5:	e8 26 e4 ff ff       	call   801001f0 <brelse>
}
80101dca:	83 c4 10             	add    $0x10,%esp
80101dcd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101dd0:	5b                   	pop    %ebx
80101dd1:	5e                   	pop    %esi
80101dd2:	5d                   	pop    %ebp
80101dd3:	c3                   	ret    
    panic("freeing free block");
80101dd4:	83 ec 0c             	sub    $0xc,%esp
80101dd7:	68 ff 7d 10 80       	push   $0x80107dff
80101ddc:	e8 9f e5 ff ff       	call   80100380 <panic>
80101de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101def:	90                   	nop

80101df0 <balloc>:
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101df9:	8b 0d b4 31 11 80    	mov    0x801131b4,%ecx
{
80101dff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101e02:	85 c9                	test   %ecx,%ecx
80101e04:	0f 84 87 00 00 00    	je     80101e91 <balloc+0xa1>
80101e0a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101e11:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101e14:	83 ec 08             	sub    $0x8,%esp
80101e17:	89 f0                	mov    %esi,%eax
80101e19:	c1 f8 0c             	sar    $0xc,%eax
80101e1c:	03 05 cc 31 11 80    	add    0x801131cc,%eax
80101e22:	50                   	push   %eax
80101e23:	ff 75 d8             	push   -0x28(%ebp)
80101e26:	e8 a5 e2 ff ff       	call   801000d0 <bread>
80101e2b:	83 c4 10             	add    $0x10,%esp
80101e2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101e31:	a1 b4 31 11 80       	mov    0x801131b4,%eax
80101e36:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e39:	31 c0                	xor    %eax,%eax
80101e3b:	eb 2f                	jmp    80101e6c <balloc+0x7c>
80101e3d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101e40:	89 c1                	mov    %eax,%ecx
80101e42:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101e47:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101e4a:	83 e1 07             	and    $0x7,%ecx
80101e4d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101e4f:	89 c1                	mov    %eax,%ecx
80101e51:	c1 f9 03             	sar    $0x3,%ecx
80101e54:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101e59:	89 fa                	mov    %edi,%edx
80101e5b:	85 df                	test   %ebx,%edi
80101e5d:	74 41                	je     80101ea0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101e5f:	83 c0 01             	add    $0x1,%eax
80101e62:	83 c6 01             	add    $0x1,%esi
80101e65:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101e6a:	74 05                	je     80101e71 <balloc+0x81>
80101e6c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
80101e6f:	77 cf                	ja     80101e40 <balloc+0x50>
    brelse(bp);
80101e71:	83 ec 0c             	sub    $0xc,%esp
80101e74:	ff 75 e4             	push   -0x1c(%ebp)
80101e77:	e8 74 e3 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101e7c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101e83:	83 c4 10             	add    $0x10,%esp
80101e86:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e89:	39 05 b4 31 11 80    	cmp    %eax,0x801131b4
80101e8f:	77 80                	ja     80101e11 <balloc+0x21>
  panic("balloc: out of blocks");
80101e91:	83 ec 0c             	sub    $0xc,%esp
80101e94:	68 12 7e 10 80       	push   $0x80107e12
80101e99:	e8 e2 e4 ff ff       	call   80100380 <panic>
80101e9e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101ea0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101ea3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101ea6:	09 da                	or     %ebx,%edx
80101ea8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101eac:	57                   	push   %edi
80101ead:	e8 3e 1c 00 00       	call   80103af0 <log_write>
        brelse(bp);
80101eb2:	89 3c 24             	mov    %edi,(%esp)
80101eb5:	e8 36 e3 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101eba:	58                   	pop    %eax
80101ebb:	5a                   	pop    %edx
80101ebc:	56                   	push   %esi
80101ebd:	ff 75 d8             	push   -0x28(%ebp)
80101ec0:	e8 0b e2 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101ec5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101ec8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101eca:	8d 40 5c             	lea    0x5c(%eax),%eax
80101ecd:	68 00 02 00 00       	push   $0x200
80101ed2:	6a 00                	push   $0x0
80101ed4:	50                   	push   %eax
80101ed5:	e8 36 33 00 00       	call   80105210 <memset>
  log_write(bp);
80101eda:	89 1c 24             	mov    %ebx,(%esp)
80101edd:	e8 0e 1c 00 00       	call   80103af0 <log_write>
  brelse(bp);
80101ee2:	89 1c 24             	mov    %ebx,(%esp)
80101ee5:	e8 06 e3 ff ff       	call   801001f0 <brelse>
}
80101eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101eed:	89 f0                	mov    %esi,%eax
80101eef:	5b                   	pop    %ebx
80101ef0:	5e                   	pop    %esi
80101ef1:	5f                   	pop    %edi
80101ef2:	5d                   	pop    %ebp
80101ef3:	c3                   	ret    
80101ef4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101efb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101eff:	90                   	nop

80101f00 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	89 c7                	mov    %eax,%edi
80101f06:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101f07:	31 f6                	xor    %esi,%esi
{
80101f09:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f0a:	bb 94 15 11 80       	mov    $0x80111594,%ebx
{
80101f0f:	83 ec 28             	sub    $0x28,%esp
80101f12:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101f15:	68 60 15 11 80       	push   $0x80111560
80101f1a:	e8 31 32 00 00       	call   80105150 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f1f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101f22:	83 c4 10             	add    $0x10,%esp
80101f25:	eb 1b                	jmp    80101f42 <iget+0x42>
80101f27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f2e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101f30:	39 3b                	cmp    %edi,(%ebx)
80101f32:	74 6c                	je     80101fa0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f34:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101f3a:	81 fb b4 31 11 80    	cmp    $0x801131b4,%ebx
80101f40:	73 26                	jae    80101f68 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101f42:	8b 43 08             	mov    0x8(%ebx),%eax
80101f45:	85 c0                	test   %eax,%eax
80101f47:	7f e7                	jg     80101f30 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101f49:	85 f6                	test   %esi,%esi
80101f4b:	75 e7                	jne    80101f34 <iget+0x34>
80101f4d:	85 c0                	test   %eax,%eax
80101f4f:	75 76                	jne    80101fc7 <iget+0xc7>
80101f51:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101f53:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101f59:	81 fb b4 31 11 80    	cmp    $0x801131b4,%ebx
80101f5f:	72 e1                	jb     80101f42 <iget+0x42>
80101f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101f68:	85 f6                	test   %esi,%esi
80101f6a:	74 79                	je     80101fe5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101f6c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101f6f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101f71:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101f74:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101f7b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101f82:	68 60 15 11 80       	push   $0x80111560
80101f87:	e8 64 31 00 00       	call   801050f0 <release>

  return ip;
80101f8c:	83 c4 10             	add    $0x10,%esp
}
80101f8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f92:	89 f0                	mov    %esi,%eax
80101f94:	5b                   	pop    %ebx
80101f95:	5e                   	pop    %esi
80101f96:	5f                   	pop    %edi
80101f97:	5d                   	pop    %ebp
80101f98:	c3                   	ret    
80101f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101fa0:	39 53 04             	cmp    %edx,0x4(%ebx)
80101fa3:	75 8f                	jne    80101f34 <iget+0x34>
      release(&icache.lock);
80101fa5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101fa8:	83 c0 01             	add    $0x1,%eax
      return ip;
80101fab:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101fad:	68 60 15 11 80       	push   $0x80111560
      ip->ref++;
80101fb2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101fb5:	e8 36 31 00 00       	call   801050f0 <release>
      return ip;
80101fba:	83 c4 10             	add    $0x10,%esp
}
80101fbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fc0:	89 f0                	mov    %esi,%eax
80101fc2:	5b                   	pop    %ebx
80101fc3:	5e                   	pop    %esi
80101fc4:	5f                   	pop    %edi
80101fc5:	5d                   	pop    %ebp
80101fc6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101fc7:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101fcd:	81 fb b4 31 11 80    	cmp    $0x801131b4,%ebx
80101fd3:	73 10                	jae    80101fe5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101fd5:	8b 43 08             	mov    0x8(%ebx),%eax
80101fd8:	85 c0                	test   %eax,%eax
80101fda:	0f 8f 50 ff ff ff    	jg     80101f30 <iget+0x30>
80101fe0:	e9 68 ff ff ff       	jmp    80101f4d <iget+0x4d>
    panic("iget: no inodes");
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	68 28 7e 10 80       	push   $0x80107e28
80101fed:	e8 8e e3 ff ff       	call   80100380 <panic>
80101ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102000 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	89 c6                	mov    %eax,%esi
80102007:	53                   	push   %ebx
80102008:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010200b:	83 fa 0b             	cmp    $0xb,%edx
8010200e:	0f 86 8c 00 00 00    	jbe    801020a0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102014:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102017:	83 fb 7f             	cmp    $0x7f,%ebx
8010201a:	0f 87 a2 00 00 00    	ja     801020c2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102020:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102026:	85 c0                	test   %eax,%eax
80102028:	74 5e                	je     80102088 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010202a:	83 ec 08             	sub    $0x8,%esp
8010202d:	50                   	push   %eax
8010202e:	ff 36                	push   (%esi)
80102030:	e8 9b e0 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102035:	83 c4 10             	add    $0x10,%esp
80102038:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010203c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010203e:	8b 3b                	mov    (%ebx),%edi
80102040:	85 ff                	test   %edi,%edi
80102042:	74 1c                	je     80102060 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102044:	83 ec 0c             	sub    $0xc,%esp
80102047:	52                   	push   %edx
80102048:	e8 a3 e1 ff ff       	call   801001f0 <brelse>
8010204d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80102050:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102053:	89 f8                	mov    %edi,%eax
80102055:	5b                   	pop    %ebx
80102056:	5e                   	pop    %esi
80102057:	5f                   	pop    %edi
80102058:	5d                   	pop    %ebp
80102059:	c3                   	ret    
8010205a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102060:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80102063:	8b 06                	mov    (%esi),%eax
80102065:	e8 86 fd ff ff       	call   80101df0 <balloc>
      log_write(bp);
8010206a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010206d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80102070:	89 03                	mov    %eax,(%ebx)
80102072:	89 c7                	mov    %eax,%edi
      log_write(bp);
80102074:	52                   	push   %edx
80102075:	e8 76 1a 00 00       	call   80103af0 <log_write>
8010207a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010207d:	83 c4 10             	add    $0x10,%esp
80102080:	eb c2                	jmp    80102044 <bmap+0x44>
80102082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102088:	8b 06                	mov    (%esi),%eax
8010208a:	e8 61 fd ff ff       	call   80101df0 <balloc>
8010208f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102095:	eb 93                	jmp    8010202a <bmap+0x2a>
80102097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010209e:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801020a0:	8d 5a 14             	lea    0x14(%edx),%ebx
801020a3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801020a7:	85 ff                	test   %edi,%edi
801020a9:	75 a5                	jne    80102050 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801020ab:	8b 00                	mov    (%eax),%eax
801020ad:	e8 3e fd ff ff       	call   80101df0 <balloc>
801020b2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801020b6:	89 c7                	mov    %eax,%edi
}
801020b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020bb:	5b                   	pop    %ebx
801020bc:	89 f8                	mov    %edi,%eax
801020be:	5e                   	pop    %esi
801020bf:	5f                   	pop    %edi
801020c0:	5d                   	pop    %ebp
801020c1:	c3                   	ret    
  panic("bmap: out of range");
801020c2:	83 ec 0c             	sub    $0xc,%esp
801020c5:	68 38 7e 10 80       	push   $0x80107e38
801020ca:	e8 b1 e2 ff ff       	call   80100380 <panic>
801020cf:	90                   	nop

801020d0 <readsb>:
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	56                   	push   %esi
801020d4:	53                   	push   %ebx
801020d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801020d8:	83 ec 08             	sub    $0x8,%esp
801020db:	6a 01                	push   $0x1
801020dd:	ff 75 08             	push   0x8(%ebp)
801020e0:	e8 eb df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801020e5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801020e8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801020ea:	8d 40 5c             	lea    0x5c(%eax),%eax
801020ed:	6a 1c                	push   $0x1c
801020ef:	50                   	push   %eax
801020f0:	56                   	push   %esi
801020f1:	e8 ba 31 00 00       	call   801052b0 <memmove>
  brelse(bp);
801020f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801020f9:	83 c4 10             	add    $0x10,%esp
}
801020fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801020ff:	5b                   	pop    %ebx
80102100:	5e                   	pop    %esi
80102101:	5d                   	pop    %ebp
  brelse(bp);
80102102:	e9 e9 e0 ff ff       	jmp    801001f0 <brelse>
80102107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010210e:	66 90                	xchg   %ax,%ax

80102110 <iinit>:
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	53                   	push   %ebx
80102114:	bb a0 15 11 80       	mov    $0x801115a0,%ebx
80102119:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010211c:	68 4b 7e 10 80       	push   $0x80107e4b
80102121:	68 60 15 11 80       	push   $0x80111560
80102126:	e8 55 2e 00 00       	call   80104f80 <initlock>
  for(i = 0; i < NINODE; i++) {
8010212b:	83 c4 10             	add    $0x10,%esp
8010212e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80102130:	83 ec 08             	sub    $0x8,%esp
80102133:	68 52 7e 10 80       	push   $0x80107e52
80102138:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80102139:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010213f:	e8 0c 2d 00 00       	call   80104e50 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80102144:	83 c4 10             	add    $0x10,%esp
80102147:	81 fb c0 31 11 80    	cmp    $0x801131c0,%ebx
8010214d:	75 e1                	jne    80102130 <iinit+0x20>
  bp = bread(dev, 1);
8010214f:	83 ec 08             	sub    $0x8,%esp
80102152:	6a 01                	push   $0x1
80102154:	ff 75 08             	push   0x8(%ebp)
80102157:	e8 74 df ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010215c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010215f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102161:	8d 40 5c             	lea    0x5c(%eax),%eax
80102164:	6a 1c                	push   $0x1c
80102166:	50                   	push   %eax
80102167:	68 b4 31 11 80       	push   $0x801131b4
8010216c:	e8 3f 31 00 00       	call   801052b0 <memmove>
  brelse(bp);
80102171:	89 1c 24             	mov    %ebx,(%esp)
80102174:	e8 77 e0 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80102179:	ff 35 cc 31 11 80    	push   0x801131cc
8010217f:	ff 35 c8 31 11 80    	push   0x801131c8
80102185:	ff 35 c4 31 11 80    	push   0x801131c4
8010218b:	ff 35 c0 31 11 80    	push   0x801131c0
80102191:	ff 35 bc 31 11 80    	push   0x801131bc
80102197:	ff 35 b8 31 11 80    	push   0x801131b8
8010219d:	ff 35 b4 31 11 80    	push   0x801131b4
801021a3:	68 b8 7e 10 80       	push   $0x80107eb8
801021a8:	e8 33 e5 ff ff       	call   801006e0 <cprintf>
}
801021ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021b0:	83 c4 30             	add    $0x30,%esp
801021b3:	c9                   	leave  
801021b4:	c3                   	ret    
801021b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ialloc>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	57                   	push   %edi
801021c4:	56                   	push   %esi
801021c5:	53                   	push   %ebx
801021c6:	83 ec 1c             	sub    $0x1c,%esp
801021c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801021cc:	83 3d bc 31 11 80 01 	cmpl   $0x1,0x801131bc
{
801021d3:	8b 75 08             	mov    0x8(%ebp),%esi
801021d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801021d9:	0f 86 91 00 00 00    	jbe    80102270 <ialloc+0xb0>
801021df:	bf 01 00 00 00       	mov    $0x1,%edi
801021e4:	eb 21                	jmp    80102207 <ialloc+0x47>
801021e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ed:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801021f0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801021f3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801021f6:	53                   	push   %ebx
801021f7:	e8 f4 df ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801021fc:	83 c4 10             	add    $0x10,%esp
801021ff:	3b 3d bc 31 11 80    	cmp    0x801131bc,%edi
80102205:	73 69                	jae    80102270 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102207:	89 f8                	mov    %edi,%eax
80102209:	83 ec 08             	sub    $0x8,%esp
8010220c:	c1 e8 03             	shr    $0x3,%eax
8010220f:	03 05 c8 31 11 80    	add    0x801131c8,%eax
80102215:	50                   	push   %eax
80102216:	56                   	push   %esi
80102217:	e8 b4 de ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010221c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010221f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102221:	89 f8                	mov    %edi,%eax
80102223:	83 e0 07             	and    $0x7,%eax
80102226:	c1 e0 06             	shl    $0x6,%eax
80102229:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010222d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102231:	75 bd                	jne    801021f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102233:	83 ec 04             	sub    $0x4,%esp
80102236:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102239:	6a 40                	push   $0x40
8010223b:	6a 00                	push   $0x0
8010223d:	51                   	push   %ecx
8010223e:	e8 cd 2f 00 00       	call   80105210 <memset>
      dip->type = type;
80102243:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102247:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010224a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010224d:	89 1c 24             	mov    %ebx,(%esp)
80102250:	e8 9b 18 00 00       	call   80103af0 <log_write>
      brelse(bp);
80102255:	89 1c 24             	mov    %ebx,(%esp)
80102258:	e8 93 df ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010225d:	83 c4 10             	add    $0x10,%esp
}
80102260:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80102263:	89 fa                	mov    %edi,%edx
}
80102265:	5b                   	pop    %ebx
      return iget(dev, inum);
80102266:	89 f0                	mov    %esi,%eax
}
80102268:	5e                   	pop    %esi
80102269:	5f                   	pop    %edi
8010226a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010226b:	e9 90 fc ff ff       	jmp    80101f00 <iget>
  panic("ialloc: no inodes");
80102270:	83 ec 0c             	sub    $0xc,%esp
80102273:	68 58 7e 10 80       	push   $0x80107e58
80102278:	e8 03 e1 ff ff       	call   80100380 <panic>
8010227d:	8d 76 00             	lea    0x0(%esi),%esi

80102280 <iupdate>:
{
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	56                   	push   %esi
80102284:	53                   	push   %ebx
80102285:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102288:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010228b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010228e:	83 ec 08             	sub    $0x8,%esp
80102291:	c1 e8 03             	shr    $0x3,%eax
80102294:	03 05 c8 31 11 80    	add    0x801131c8,%eax
8010229a:	50                   	push   %eax
8010229b:	ff 73 a4             	push   -0x5c(%ebx)
8010229e:	e8 2d de ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801022a3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801022a7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801022aa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801022ac:	8b 43 a8             	mov    -0x58(%ebx),%eax
801022af:	83 e0 07             	and    $0x7,%eax
801022b2:	c1 e0 06             	shl    $0x6,%eax
801022b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801022b9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801022bc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801022c0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801022c3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801022c7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801022cb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801022cf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801022d3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801022d7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801022da:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801022dd:	6a 34                	push   $0x34
801022df:	53                   	push   %ebx
801022e0:	50                   	push   %eax
801022e1:	e8 ca 2f 00 00       	call   801052b0 <memmove>
  log_write(bp);
801022e6:	89 34 24             	mov    %esi,(%esp)
801022e9:	e8 02 18 00 00       	call   80103af0 <log_write>
  brelse(bp);
801022ee:	89 75 08             	mov    %esi,0x8(%ebp)
801022f1:	83 c4 10             	add    $0x10,%esp
}
801022f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f7:	5b                   	pop    %ebx
801022f8:	5e                   	pop    %esi
801022f9:	5d                   	pop    %ebp
  brelse(bp);
801022fa:	e9 f1 de ff ff       	jmp    801001f0 <brelse>
801022ff:	90                   	nop

80102300 <idup>:
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	53                   	push   %ebx
80102304:	83 ec 10             	sub    $0x10,%esp
80102307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010230a:	68 60 15 11 80       	push   $0x80111560
8010230f:	e8 3c 2e 00 00       	call   80105150 <acquire>
  ip->ref++;
80102314:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102318:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
8010231f:	e8 cc 2d 00 00       	call   801050f0 <release>
}
80102324:	89 d8                	mov    %ebx,%eax
80102326:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102329:	c9                   	leave  
8010232a:	c3                   	ret    
8010232b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010232f:	90                   	nop

80102330 <ilock>:
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	56                   	push   %esi
80102334:	53                   	push   %ebx
80102335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80102338:	85 db                	test   %ebx,%ebx
8010233a:	0f 84 b7 00 00 00    	je     801023f7 <ilock+0xc7>
80102340:	8b 53 08             	mov    0x8(%ebx),%edx
80102343:	85 d2                	test   %edx,%edx
80102345:	0f 8e ac 00 00 00    	jle    801023f7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010234b:	83 ec 0c             	sub    $0xc,%esp
8010234e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102351:	50                   	push   %eax
80102352:	e8 39 2b 00 00       	call   80104e90 <acquiresleep>
  if(ip->valid == 0){
80102357:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010235a:	83 c4 10             	add    $0x10,%esp
8010235d:	85 c0                	test   %eax,%eax
8010235f:	74 0f                	je     80102370 <ilock+0x40>
}
80102361:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102364:	5b                   	pop    %ebx
80102365:	5e                   	pop    %esi
80102366:	5d                   	pop    %ebp
80102367:	c3                   	ret    
80102368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010236f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102370:	8b 43 04             	mov    0x4(%ebx),%eax
80102373:	83 ec 08             	sub    $0x8,%esp
80102376:	c1 e8 03             	shr    $0x3,%eax
80102379:	03 05 c8 31 11 80    	add    0x801131c8,%eax
8010237f:	50                   	push   %eax
80102380:	ff 33                	push   (%ebx)
80102382:	e8 49 dd ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102387:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010238a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010238c:	8b 43 04             	mov    0x4(%ebx),%eax
8010238f:	83 e0 07             	and    $0x7,%eax
80102392:	c1 e0 06             	shl    $0x6,%eax
80102395:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102399:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010239c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010239f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801023a3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801023a7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801023ab:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801023af:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801023b3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801023b7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801023bb:	8b 50 fc             	mov    -0x4(%eax),%edx
801023be:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801023c1:	6a 34                	push   $0x34
801023c3:	50                   	push   %eax
801023c4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801023c7:	50                   	push   %eax
801023c8:	e8 e3 2e 00 00       	call   801052b0 <memmove>
    brelse(bp);
801023cd:	89 34 24             	mov    %esi,(%esp)
801023d0:	e8 1b de ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
801023d5:	83 c4 10             	add    $0x10,%esp
801023d8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801023dd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801023e4:	0f 85 77 ff ff ff    	jne    80102361 <ilock+0x31>
      panic("ilock: no type");
801023ea:	83 ec 0c             	sub    $0xc,%esp
801023ed:	68 70 7e 10 80       	push   $0x80107e70
801023f2:	e8 89 df ff ff       	call   80100380 <panic>
    panic("ilock");
801023f7:	83 ec 0c             	sub    $0xc,%esp
801023fa:	68 6a 7e 10 80       	push   $0x80107e6a
801023ff:	e8 7c df ff ff       	call   80100380 <panic>
80102404:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010240b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010240f:	90                   	nop

80102410 <iunlock>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102418:	85 db                	test   %ebx,%ebx
8010241a:	74 28                	je     80102444 <iunlock+0x34>
8010241c:	83 ec 0c             	sub    $0xc,%esp
8010241f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102422:	56                   	push   %esi
80102423:	e8 08 2b 00 00       	call   80104f30 <holdingsleep>
80102428:	83 c4 10             	add    $0x10,%esp
8010242b:	85 c0                	test   %eax,%eax
8010242d:	74 15                	je     80102444 <iunlock+0x34>
8010242f:	8b 43 08             	mov    0x8(%ebx),%eax
80102432:	85 c0                	test   %eax,%eax
80102434:	7e 0e                	jle    80102444 <iunlock+0x34>
  releasesleep(&ip->lock);
80102436:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102439:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010243c:	5b                   	pop    %ebx
8010243d:	5e                   	pop    %esi
8010243e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010243f:	e9 ac 2a 00 00       	jmp    80104ef0 <releasesleep>
    panic("iunlock");
80102444:	83 ec 0c             	sub    $0xc,%esp
80102447:	68 7f 7e 10 80       	push   $0x80107e7f
8010244c:	e8 2f df ff ff       	call   80100380 <panic>
80102451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010245f:	90                   	nop

80102460 <iput>:
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	57                   	push   %edi
80102464:	56                   	push   %esi
80102465:	53                   	push   %ebx
80102466:	83 ec 28             	sub    $0x28,%esp
80102469:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010246c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010246f:	57                   	push   %edi
80102470:	e8 1b 2a 00 00       	call   80104e90 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102475:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102478:	83 c4 10             	add    $0x10,%esp
8010247b:	85 d2                	test   %edx,%edx
8010247d:	74 07                	je     80102486 <iput+0x26>
8010247f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102484:	74 32                	je     801024b8 <iput+0x58>
  releasesleep(&ip->lock);
80102486:	83 ec 0c             	sub    $0xc,%esp
80102489:	57                   	push   %edi
8010248a:	e8 61 2a 00 00       	call   80104ef0 <releasesleep>
  acquire(&icache.lock);
8010248f:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
80102496:	e8 b5 2c 00 00       	call   80105150 <acquire>
  ip->ref--;
8010249b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010249f:	83 c4 10             	add    $0x10,%esp
801024a2:	c7 45 08 60 15 11 80 	movl   $0x80111560,0x8(%ebp)
}
801024a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024ac:	5b                   	pop    %ebx
801024ad:	5e                   	pop    %esi
801024ae:	5f                   	pop    %edi
801024af:	5d                   	pop    %ebp
  release(&icache.lock);
801024b0:	e9 3b 2c 00 00       	jmp    801050f0 <release>
801024b5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801024b8:	83 ec 0c             	sub    $0xc,%esp
801024bb:	68 60 15 11 80       	push   $0x80111560
801024c0:	e8 8b 2c 00 00       	call   80105150 <acquire>
    int r = ip->ref;
801024c5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
801024c8:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
801024cf:	e8 1c 2c 00 00       	call   801050f0 <release>
    if(r == 1){
801024d4:	83 c4 10             	add    $0x10,%esp
801024d7:	83 fe 01             	cmp    $0x1,%esi
801024da:	75 aa                	jne    80102486 <iput+0x26>
801024dc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801024e2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801024e5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801024e8:	89 cf                	mov    %ecx,%edi
801024ea:	eb 0b                	jmp    801024f7 <iput+0x97>
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801024f0:	83 c6 04             	add    $0x4,%esi
801024f3:	39 fe                	cmp    %edi,%esi
801024f5:	74 19                	je     80102510 <iput+0xb0>
    if(ip->addrs[i]){
801024f7:	8b 16                	mov    (%esi),%edx
801024f9:	85 d2                	test   %edx,%edx
801024fb:	74 f3                	je     801024f0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801024fd:	8b 03                	mov    (%ebx),%eax
801024ff:	e8 6c f8 ff ff       	call   80101d70 <bfree>
      ip->addrs[i] = 0;
80102504:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010250a:	eb e4                	jmp    801024f0 <iput+0x90>
8010250c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102510:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80102516:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102519:	85 c0                	test   %eax,%eax
8010251b:	75 2d                	jne    8010254a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010251d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102520:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102527:	53                   	push   %ebx
80102528:	e8 53 fd ff ff       	call   80102280 <iupdate>
      ip->type = 0;
8010252d:	31 c0                	xor    %eax,%eax
8010252f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102533:	89 1c 24             	mov    %ebx,(%esp)
80102536:	e8 45 fd ff ff       	call   80102280 <iupdate>
      ip->valid = 0;
8010253b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102542:	83 c4 10             	add    $0x10,%esp
80102545:	e9 3c ff ff ff       	jmp    80102486 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010254a:	83 ec 08             	sub    $0x8,%esp
8010254d:	50                   	push   %eax
8010254e:	ff 33                	push   (%ebx)
80102550:	e8 7b db ff ff       	call   801000d0 <bread>
80102555:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102558:	83 c4 10             	add    $0x10,%esp
8010255b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102561:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102564:	8d 70 5c             	lea    0x5c(%eax),%esi
80102567:	89 cf                	mov    %ecx,%edi
80102569:	eb 0c                	jmp    80102577 <iput+0x117>
8010256b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010256f:	90                   	nop
80102570:	83 c6 04             	add    $0x4,%esi
80102573:	39 f7                	cmp    %esi,%edi
80102575:	74 0f                	je     80102586 <iput+0x126>
      if(a[j])
80102577:	8b 16                	mov    (%esi),%edx
80102579:	85 d2                	test   %edx,%edx
8010257b:	74 f3                	je     80102570 <iput+0x110>
        bfree(ip->dev, a[j]);
8010257d:	8b 03                	mov    (%ebx),%eax
8010257f:	e8 ec f7 ff ff       	call   80101d70 <bfree>
80102584:	eb ea                	jmp    80102570 <iput+0x110>
    brelse(bp);
80102586:	83 ec 0c             	sub    $0xc,%esp
80102589:	ff 75 e4             	push   -0x1c(%ebp)
8010258c:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010258f:	e8 5c dc ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102594:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010259a:	8b 03                	mov    (%ebx),%eax
8010259c:	e8 cf f7 ff ff       	call   80101d70 <bfree>
    ip->addrs[NDIRECT] = 0;
801025a1:	83 c4 10             	add    $0x10,%esp
801025a4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801025ab:	00 00 00 
801025ae:	e9 6a ff ff ff       	jmp    8010251d <iput+0xbd>
801025b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801025c0 <iunlockput>:
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	56                   	push   %esi
801025c4:	53                   	push   %ebx
801025c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801025c8:	85 db                	test   %ebx,%ebx
801025ca:	74 34                	je     80102600 <iunlockput+0x40>
801025cc:	83 ec 0c             	sub    $0xc,%esp
801025cf:	8d 73 0c             	lea    0xc(%ebx),%esi
801025d2:	56                   	push   %esi
801025d3:	e8 58 29 00 00       	call   80104f30 <holdingsleep>
801025d8:	83 c4 10             	add    $0x10,%esp
801025db:	85 c0                	test   %eax,%eax
801025dd:	74 21                	je     80102600 <iunlockput+0x40>
801025df:	8b 43 08             	mov    0x8(%ebx),%eax
801025e2:	85 c0                	test   %eax,%eax
801025e4:	7e 1a                	jle    80102600 <iunlockput+0x40>
  releasesleep(&ip->lock);
801025e6:	83 ec 0c             	sub    $0xc,%esp
801025e9:	56                   	push   %esi
801025ea:	e8 01 29 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
801025ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
801025f2:	83 c4 10             	add    $0x10,%esp
}
801025f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025f8:	5b                   	pop    %ebx
801025f9:	5e                   	pop    %esi
801025fa:	5d                   	pop    %ebp
  iput(ip);
801025fb:	e9 60 fe ff ff       	jmp    80102460 <iput>
    panic("iunlock");
80102600:	83 ec 0c             	sub    $0xc,%esp
80102603:	68 7f 7e 10 80       	push   $0x80107e7f
80102608:	e8 73 dd ff ff       	call   80100380 <panic>
8010260d:	8d 76 00             	lea    0x0(%esi),%esi

80102610 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	8b 55 08             	mov    0x8(%ebp),%edx
80102616:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102619:	8b 0a                	mov    (%edx),%ecx
8010261b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010261e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102621:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102624:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102628:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010262b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010262f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102633:	8b 52 58             	mov    0x58(%edx),%edx
80102636:	89 50 10             	mov    %edx,0x10(%eax)
}
80102639:	5d                   	pop    %ebp
8010263a:	c3                   	ret    
8010263b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010263f:	90                   	nop

80102640 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102640:	55                   	push   %ebp
80102641:	89 e5                	mov    %esp,%ebp
80102643:	57                   	push   %edi
80102644:	56                   	push   %esi
80102645:	53                   	push   %ebx
80102646:	83 ec 1c             	sub    $0x1c,%esp
80102649:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010264c:	8b 45 08             	mov    0x8(%ebp),%eax
8010264f:	8b 75 10             	mov    0x10(%ebp),%esi
80102652:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102655:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102658:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
8010265d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102660:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80102663:	0f 84 a7 00 00 00    	je     80102710 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102669:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010266c:	8b 40 58             	mov    0x58(%eax),%eax
8010266f:	39 c6                	cmp    %eax,%esi
80102671:	0f 87 ba 00 00 00    	ja     80102731 <readi+0xf1>
80102677:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010267a:	31 c9                	xor    %ecx,%ecx
8010267c:	89 da                	mov    %ebx,%edx
8010267e:	01 f2                	add    %esi,%edx
80102680:	0f 92 c1             	setb   %cl
80102683:	89 cf                	mov    %ecx,%edi
80102685:	0f 82 a6 00 00 00    	jb     80102731 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010268b:	89 c1                	mov    %eax,%ecx
8010268d:	29 f1                	sub    %esi,%ecx
8010268f:	39 d0                	cmp    %edx,%eax
80102691:	0f 43 cb             	cmovae %ebx,%ecx
80102694:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102697:	85 c9                	test   %ecx,%ecx
80102699:	74 67                	je     80102702 <readi+0xc2>
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801026a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801026a3:	89 f2                	mov    %esi,%edx
801026a5:	c1 ea 09             	shr    $0x9,%edx
801026a8:	89 d8                	mov    %ebx,%eax
801026aa:	e8 51 f9 ff ff       	call   80102000 <bmap>
801026af:	83 ec 08             	sub    $0x8,%esp
801026b2:	50                   	push   %eax
801026b3:	ff 33                	push   (%ebx)
801026b5:	e8 16 da ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801026ba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801026bd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801026c2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801026c4:	89 f0                	mov    %esi,%eax
801026c6:	25 ff 01 00 00       	and    $0x1ff,%eax
801026cb:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801026cd:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
801026d0:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
801026d2:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801026d6:	39 d9                	cmp    %ebx,%ecx
801026d8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801026db:	83 c4 0c             	add    $0xc,%esp
801026de:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801026df:	01 df                	add    %ebx,%edi
801026e1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
801026e3:	50                   	push   %eax
801026e4:	ff 75 e0             	push   -0x20(%ebp)
801026e7:	e8 c4 2b 00 00       	call   801052b0 <memmove>
    brelse(bp);
801026ec:	8b 55 dc             	mov    -0x24(%ebp),%edx
801026ef:	89 14 24             	mov    %edx,(%esp)
801026f2:	e8 f9 da ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801026f7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801026fa:	83 c4 10             	add    $0x10,%esp
801026fd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102700:	77 9e                	ja     801026a0 <readi+0x60>
  }
  return n;
80102702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102705:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102708:	5b                   	pop    %ebx
80102709:	5e                   	pop    %esi
8010270a:	5f                   	pop    %edi
8010270b:	5d                   	pop    %ebp
8010270c:	c3                   	ret    
8010270d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102710:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102714:	66 83 f8 09          	cmp    $0x9,%ax
80102718:	77 17                	ja     80102731 <readi+0xf1>
8010271a:	8b 04 c5 00 15 11 80 	mov    -0x7feeeb00(,%eax,8),%eax
80102721:	85 c0                	test   %eax,%eax
80102723:	74 0c                	je     80102731 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102725:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102728:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010272b:	5b                   	pop    %ebx
8010272c:	5e                   	pop    %esi
8010272d:	5f                   	pop    %edi
8010272e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010272f:	ff e0                	jmp    *%eax
      return -1;
80102731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102736:	eb cd                	jmp    80102705 <readi+0xc5>
80102738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010273f:	90                   	nop

80102740 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102740:	55                   	push   %ebp
80102741:	89 e5                	mov    %esp,%ebp
80102743:	57                   	push   %edi
80102744:	56                   	push   %esi
80102745:	53                   	push   %ebx
80102746:	83 ec 1c             	sub    $0x1c,%esp
80102749:	8b 45 08             	mov    0x8(%ebp),%eax
8010274c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010274f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102752:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102757:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010275a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010275d:	8b 75 10             	mov    0x10(%ebp),%esi
80102760:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102763:	0f 84 b7 00 00 00    	je     80102820 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102769:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010276c:	3b 70 58             	cmp    0x58(%eax),%esi
8010276f:	0f 87 e7 00 00 00    	ja     8010285c <writei+0x11c>
80102775:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102778:	31 d2                	xor    %edx,%edx
8010277a:	89 f8                	mov    %edi,%eax
8010277c:	01 f0                	add    %esi,%eax
8010277e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102781:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102786:	0f 87 d0 00 00 00    	ja     8010285c <writei+0x11c>
8010278c:	85 d2                	test   %edx,%edx
8010278e:	0f 85 c8 00 00 00    	jne    8010285c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102794:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010279b:	85 ff                	test   %edi,%edi
8010279d:	74 72                	je     80102811 <writei+0xd1>
8010279f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801027a0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801027a3:	89 f2                	mov    %esi,%edx
801027a5:	c1 ea 09             	shr    $0x9,%edx
801027a8:	89 f8                	mov    %edi,%eax
801027aa:	e8 51 f8 ff ff       	call   80102000 <bmap>
801027af:	83 ec 08             	sub    $0x8,%esp
801027b2:	50                   	push   %eax
801027b3:	ff 37                	push   (%edi)
801027b5:	e8 16 d9 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801027ba:	b9 00 02 00 00       	mov    $0x200,%ecx
801027bf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801027c2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801027c5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801027c7:	89 f0                	mov    %esi,%eax
801027c9:	25 ff 01 00 00       	and    $0x1ff,%eax
801027ce:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801027d0:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801027d4:	39 d9                	cmp    %ebx,%ecx
801027d6:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801027d9:	83 c4 0c             	add    $0xc,%esp
801027dc:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801027dd:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
801027df:	ff 75 dc             	push   -0x24(%ebp)
801027e2:	50                   	push   %eax
801027e3:	e8 c8 2a 00 00       	call   801052b0 <memmove>
    log_write(bp);
801027e8:	89 3c 24             	mov    %edi,(%esp)
801027eb:	e8 00 13 00 00       	call   80103af0 <log_write>
    brelse(bp);
801027f0:	89 3c 24             	mov    %edi,(%esp)
801027f3:	e8 f8 d9 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801027f8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801027fb:	83 c4 10             	add    $0x10,%esp
801027fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102801:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102804:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102807:	77 97                	ja     801027a0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102809:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010280c:	3b 70 58             	cmp    0x58(%eax),%esi
8010280f:	77 37                	ja     80102848 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102811:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102814:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102817:	5b                   	pop    %ebx
80102818:	5e                   	pop    %esi
80102819:	5f                   	pop    %edi
8010281a:	5d                   	pop    %ebp
8010281b:	c3                   	ret    
8010281c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102820:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102824:	66 83 f8 09          	cmp    $0x9,%ax
80102828:	77 32                	ja     8010285c <writei+0x11c>
8010282a:	8b 04 c5 04 15 11 80 	mov    -0x7feeeafc(,%eax,8),%eax
80102831:	85 c0                	test   %eax,%eax
80102833:	74 27                	je     8010285c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102835:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102838:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010283b:	5b                   	pop    %ebx
8010283c:	5e                   	pop    %esi
8010283d:	5f                   	pop    %edi
8010283e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010283f:	ff e0                	jmp    *%eax
80102841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102848:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010284b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010284e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102851:	50                   	push   %eax
80102852:	e8 29 fa ff ff       	call   80102280 <iupdate>
80102857:	83 c4 10             	add    $0x10,%esp
8010285a:	eb b5                	jmp    80102811 <writei+0xd1>
      return -1;
8010285c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102861:	eb b1                	jmp    80102814 <writei+0xd4>
80102863:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102870 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102876:	6a 0e                	push   $0xe
80102878:	ff 75 0c             	push   0xc(%ebp)
8010287b:	ff 75 08             	push   0x8(%ebp)
8010287e:	e8 9d 2a 00 00       	call   80105320 <strncmp>
}
80102883:	c9                   	leave  
80102884:	c3                   	ret    
80102885:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010288c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102890 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102890:	55                   	push   %ebp
80102891:	89 e5                	mov    %esp,%ebp
80102893:	57                   	push   %edi
80102894:	56                   	push   %esi
80102895:	53                   	push   %ebx
80102896:	83 ec 1c             	sub    $0x1c,%esp
80102899:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010289c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801028a1:	0f 85 85 00 00 00    	jne    8010292c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801028a7:	8b 53 58             	mov    0x58(%ebx),%edx
801028aa:	31 ff                	xor    %edi,%edi
801028ac:	8d 75 d8             	lea    -0x28(%ebp),%esi
801028af:	85 d2                	test   %edx,%edx
801028b1:	74 3e                	je     801028f1 <dirlookup+0x61>
801028b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028b7:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801028b8:	6a 10                	push   $0x10
801028ba:	57                   	push   %edi
801028bb:	56                   	push   %esi
801028bc:	53                   	push   %ebx
801028bd:	e8 7e fd ff ff       	call   80102640 <readi>
801028c2:	83 c4 10             	add    $0x10,%esp
801028c5:	83 f8 10             	cmp    $0x10,%eax
801028c8:	75 55                	jne    8010291f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
801028ca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801028cf:	74 18                	je     801028e9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
801028d1:	83 ec 04             	sub    $0x4,%esp
801028d4:	8d 45 da             	lea    -0x26(%ebp),%eax
801028d7:	6a 0e                	push   $0xe
801028d9:	50                   	push   %eax
801028da:	ff 75 0c             	push   0xc(%ebp)
801028dd:	e8 3e 2a 00 00       	call   80105320 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801028e2:	83 c4 10             	add    $0x10,%esp
801028e5:	85 c0                	test   %eax,%eax
801028e7:	74 17                	je     80102900 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
801028e9:	83 c7 10             	add    $0x10,%edi
801028ec:	3b 7b 58             	cmp    0x58(%ebx),%edi
801028ef:	72 c7                	jb     801028b8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801028f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801028f4:	31 c0                	xor    %eax,%eax
}
801028f6:	5b                   	pop    %ebx
801028f7:	5e                   	pop    %esi
801028f8:	5f                   	pop    %edi
801028f9:	5d                   	pop    %ebp
801028fa:	c3                   	ret    
801028fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028ff:	90                   	nop
      if(poff)
80102900:	8b 45 10             	mov    0x10(%ebp),%eax
80102903:	85 c0                	test   %eax,%eax
80102905:	74 05                	je     8010290c <dirlookup+0x7c>
        *poff = off;
80102907:	8b 45 10             	mov    0x10(%ebp),%eax
8010290a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010290c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102910:	8b 03                	mov    (%ebx),%eax
80102912:	e8 e9 f5 ff ff       	call   80101f00 <iget>
}
80102917:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010291a:	5b                   	pop    %ebx
8010291b:	5e                   	pop    %esi
8010291c:	5f                   	pop    %edi
8010291d:	5d                   	pop    %ebp
8010291e:	c3                   	ret    
      panic("dirlookup read");
8010291f:	83 ec 0c             	sub    $0xc,%esp
80102922:	68 99 7e 10 80       	push   $0x80107e99
80102927:	e8 54 da ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
8010292c:	83 ec 0c             	sub    $0xc,%esp
8010292f:	68 87 7e 10 80       	push   $0x80107e87
80102934:	e8 47 da ff ff       	call   80100380 <panic>
80102939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102940 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	57                   	push   %edi
80102944:	56                   	push   %esi
80102945:	53                   	push   %ebx
80102946:	89 c3                	mov    %eax,%ebx
80102948:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010294b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010294e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102951:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102954:	0f 84 64 01 00 00    	je     80102abe <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010295a:	e8 c1 1b 00 00       	call   80104520 <myproc>
  acquire(&icache.lock);
8010295f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102962:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102965:	68 60 15 11 80       	push   $0x80111560
8010296a:	e8 e1 27 00 00       	call   80105150 <acquire>
  ip->ref++;
8010296f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102973:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
8010297a:	e8 71 27 00 00       	call   801050f0 <release>
8010297f:	83 c4 10             	add    $0x10,%esp
80102982:	eb 07                	jmp    8010298b <namex+0x4b>
80102984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102988:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010298b:	0f b6 03             	movzbl (%ebx),%eax
8010298e:	3c 2f                	cmp    $0x2f,%al
80102990:	74 f6                	je     80102988 <namex+0x48>
  if(*path == 0)
80102992:	84 c0                	test   %al,%al
80102994:	0f 84 06 01 00 00    	je     80102aa0 <namex+0x160>
  while(*path != '/' && *path != 0)
8010299a:	0f b6 03             	movzbl (%ebx),%eax
8010299d:	84 c0                	test   %al,%al
8010299f:	0f 84 10 01 00 00    	je     80102ab5 <namex+0x175>
801029a5:	89 df                	mov    %ebx,%edi
801029a7:	3c 2f                	cmp    $0x2f,%al
801029a9:	0f 84 06 01 00 00    	je     80102ab5 <namex+0x175>
801029af:	90                   	nop
801029b0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801029b4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
801029b7:	3c 2f                	cmp    $0x2f,%al
801029b9:	74 04                	je     801029bf <namex+0x7f>
801029bb:	84 c0                	test   %al,%al
801029bd:	75 f1                	jne    801029b0 <namex+0x70>
  len = path - s;
801029bf:	89 f8                	mov    %edi,%eax
801029c1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801029c3:	83 f8 0d             	cmp    $0xd,%eax
801029c6:	0f 8e ac 00 00 00    	jle    80102a78 <namex+0x138>
    memmove(name, s, DIRSIZ);
801029cc:	83 ec 04             	sub    $0x4,%esp
801029cf:	6a 0e                	push   $0xe
801029d1:	53                   	push   %ebx
    path++;
801029d2:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
801029d4:	ff 75 e4             	push   -0x1c(%ebp)
801029d7:	e8 d4 28 00 00       	call   801052b0 <memmove>
801029dc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801029df:	80 3f 2f             	cmpb   $0x2f,(%edi)
801029e2:	75 0c                	jne    801029f0 <namex+0xb0>
801029e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801029e8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801029eb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801029ee:	74 f8                	je     801029e8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	56                   	push   %esi
801029f4:	e8 37 f9 ff ff       	call   80102330 <ilock>
    if(ip->type != T_DIR){
801029f9:	83 c4 10             	add    $0x10,%esp
801029fc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102a01:	0f 85 cd 00 00 00    	jne    80102ad4 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102a07:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102a0a:	85 c0                	test   %eax,%eax
80102a0c:	74 09                	je     80102a17 <namex+0xd7>
80102a0e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102a11:	0f 84 22 01 00 00    	je     80102b39 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102a17:	83 ec 04             	sub    $0x4,%esp
80102a1a:	6a 00                	push   $0x0
80102a1c:	ff 75 e4             	push   -0x1c(%ebp)
80102a1f:	56                   	push   %esi
80102a20:	e8 6b fe ff ff       	call   80102890 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102a25:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102a28:	83 c4 10             	add    $0x10,%esp
80102a2b:	89 c7                	mov    %eax,%edi
80102a2d:	85 c0                	test   %eax,%eax
80102a2f:	0f 84 e1 00 00 00    	je     80102b16 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102a35:	83 ec 0c             	sub    $0xc,%esp
80102a38:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102a3b:	52                   	push   %edx
80102a3c:	e8 ef 24 00 00       	call   80104f30 <holdingsleep>
80102a41:	83 c4 10             	add    $0x10,%esp
80102a44:	85 c0                	test   %eax,%eax
80102a46:	0f 84 30 01 00 00    	je     80102b7c <namex+0x23c>
80102a4c:	8b 56 08             	mov    0x8(%esi),%edx
80102a4f:	85 d2                	test   %edx,%edx
80102a51:	0f 8e 25 01 00 00    	jle    80102b7c <namex+0x23c>
  releasesleep(&ip->lock);
80102a57:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102a5a:	83 ec 0c             	sub    $0xc,%esp
80102a5d:	52                   	push   %edx
80102a5e:	e8 8d 24 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
80102a63:	89 34 24             	mov    %esi,(%esp)
80102a66:	89 fe                	mov    %edi,%esi
80102a68:	e8 f3 f9 ff ff       	call   80102460 <iput>
80102a6d:	83 c4 10             	add    $0x10,%esp
80102a70:	e9 16 ff ff ff       	jmp    8010298b <namex+0x4b>
80102a75:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102a78:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102a7b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80102a7e:	83 ec 04             	sub    $0x4,%esp
80102a81:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102a84:	50                   	push   %eax
80102a85:	53                   	push   %ebx
    name[len] = 0;
80102a86:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102a88:	ff 75 e4             	push   -0x1c(%ebp)
80102a8b:	e8 20 28 00 00       	call   801052b0 <memmove>
    name[len] = 0;
80102a90:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102a93:	83 c4 10             	add    $0x10,%esp
80102a96:	c6 02 00             	movb   $0x0,(%edx)
80102a99:	e9 41 ff ff ff       	jmp    801029df <namex+0x9f>
80102a9e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102aa0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102aa3:	85 c0                	test   %eax,%eax
80102aa5:	0f 85 be 00 00 00    	jne    80102b69 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80102aab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aae:	89 f0                	mov    %esi,%eax
80102ab0:	5b                   	pop    %ebx
80102ab1:	5e                   	pop    %esi
80102ab2:	5f                   	pop    %edi
80102ab3:	5d                   	pop    %ebp
80102ab4:	c3                   	ret    
  while(*path != '/' && *path != 0)
80102ab5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102ab8:	89 df                	mov    %ebx,%edi
80102aba:	31 c0                	xor    %eax,%eax
80102abc:	eb c0                	jmp    80102a7e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80102abe:	ba 01 00 00 00       	mov    $0x1,%edx
80102ac3:	b8 01 00 00 00       	mov    $0x1,%eax
80102ac8:	e8 33 f4 ff ff       	call   80101f00 <iget>
80102acd:	89 c6                	mov    %eax,%esi
80102acf:	e9 b7 fe ff ff       	jmp    8010298b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102ad4:	83 ec 0c             	sub    $0xc,%esp
80102ad7:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102ada:	53                   	push   %ebx
80102adb:	e8 50 24 00 00       	call   80104f30 <holdingsleep>
80102ae0:	83 c4 10             	add    $0x10,%esp
80102ae3:	85 c0                	test   %eax,%eax
80102ae5:	0f 84 91 00 00 00    	je     80102b7c <namex+0x23c>
80102aeb:	8b 46 08             	mov    0x8(%esi),%eax
80102aee:	85 c0                	test   %eax,%eax
80102af0:	0f 8e 86 00 00 00    	jle    80102b7c <namex+0x23c>
  releasesleep(&ip->lock);
80102af6:	83 ec 0c             	sub    $0xc,%esp
80102af9:	53                   	push   %ebx
80102afa:	e8 f1 23 00 00       	call   80104ef0 <releasesleep>
  iput(ip);
80102aff:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102b02:	31 f6                	xor    %esi,%esi
  iput(ip);
80102b04:	e8 57 f9 ff ff       	call   80102460 <iput>
      return 0;
80102b09:	83 c4 10             	add    $0x10,%esp
}
80102b0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b0f:	89 f0                	mov    %esi,%eax
80102b11:	5b                   	pop    %ebx
80102b12:	5e                   	pop    %esi
80102b13:	5f                   	pop    %edi
80102b14:	5d                   	pop    %ebp
80102b15:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b16:	83 ec 0c             	sub    $0xc,%esp
80102b19:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102b1c:	52                   	push   %edx
80102b1d:	e8 0e 24 00 00       	call   80104f30 <holdingsleep>
80102b22:	83 c4 10             	add    $0x10,%esp
80102b25:	85 c0                	test   %eax,%eax
80102b27:	74 53                	je     80102b7c <namex+0x23c>
80102b29:	8b 4e 08             	mov    0x8(%esi),%ecx
80102b2c:	85 c9                	test   %ecx,%ecx
80102b2e:	7e 4c                	jle    80102b7c <namex+0x23c>
  releasesleep(&ip->lock);
80102b30:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102b33:	83 ec 0c             	sub    $0xc,%esp
80102b36:	52                   	push   %edx
80102b37:	eb c1                	jmp    80102afa <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102b39:	83 ec 0c             	sub    $0xc,%esp
80102b3c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102b3f:	53                   	push   %ebx
80102b40:	e8 eb 23 00 00       	call   80104f30 <holdingsleep>
80102b45:	83 c4 10             	add    $0x10,%esp
80102b48:	85 c0                	test   %eax,%eax
80102b4a:	74 30                	je     80102b7c <namex+0x23c>
80102b4c:	8b 7e 08             	mov    0x8(%esi),%edi
80102b4f:	85 ff                	test   %edi,%edi
80102b51:	7e 29                	jle    80102b7c <namex+0x23c>
  releasesleep(&ip->lock);
80102b53:	83 ec 0c             	sub    $0xc,%esp
80102b56:	53                   	push   %ebx
80102b57:	e8 94 23 00 00       	call   80104ef0 <releasesleep>
}
80102b5c:	83 c4 10             	add    $0x10,%esp
}
80102b5f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b62:	89 f0                	mov    %esi,%eax
80102b64:	5b                   	pop    %ebx
80102b65:	5e                   	pop    %esi
80102b66:	5f                   	pop    %edi
80102b67:	5d                   	pop    %ebp
80102b68:	c3                   	ret    
    iput(ip);
80102b69:	83 ec 0c             	sub    $0xc,%esp
80102b6c:	56                   	push   %esi
    return 0;
80102b6d:	31 f6                	xor    %esi,%esi
    iput(ip);
80102b6f:	e8 ec f8 ff ff       	call   80102460 <iput>
    return 0;
80102b74:	83 c4 10             	add    $0x10,%esp
80102b77:	e9 2f ff ff ff       	jmp    80102aab <namex+0x16b>
    panic("iunlock");
80102b7c:	83 ec 0c             	sub    $0xc,%esp
80102b7f:	68 7f 7e 10 80       	push   $0x80107e7f
80102b84:	e8 f7 d7 ff ff       	call   80100380 <panic>
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102b90 <dirlink>:
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	57                   	push   %edi
80102b94:	56                   	push   %esi
80102b95:	53                   	push   %ebx
80102b96:	83 ec 20             	sub    $0x20,%esp
80102b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102b9c:	6a 00                	push   $0x0
80102b9e:	ff 75 0c             	push   0xc(%ebp)
80102ba1:	53                   	push   %ebx
80102ba2:	e8 e9 fc ff ff       	call   80102890 <dirlookup>
80102ba7:	83 c4 10             	add    $0x10,%esp
80102baa:	85 c0                	test   %eax,%eax
80102bac:	75 67                	jne    80102c15 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102bae:	8b 7b 58             	mov    0x58(%ebx),%edi
80102bb1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102bb4:	85 ff                	test   %edi,%edi
80102bb6:	74 29                	je     80102be1 <dirlink+0x51>
80102bb8:	31 ff                	xor    %edi,%edi
80102bba:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102bbd:	eb 09                	jmp    80102bc8 <dirlink+0x38>
80102bbf:	90                   	nop
80102bc0:	83 c7 10             	add    $0x10,%edi
80102bc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102bc6:	73 19                	jae    80102be1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bc8:	6a 10                	push   $0x10
80102bca:	57                   	push   %edi
80102bcb:	56                   	push   %esi
80102bcc:	53                   	push   %ebx
80102bcd:	e8 6e fa ff ff       	call   80102640 <readi>
80102bd2:	83 c4 10             	add    $0x10,%esp
80102bd5:	83 f8 10             	cmp    $0x10,%eax
80102bd8:	75 4e                	jne    80102c28 <dirlink+0x98>
    if(de.inum == 0)
80102bda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102bdf:	75 df                	jne    80102bc0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102be1:	83 ec 04             	sub    $0x4,%esp
80102be4:	8d 45 da             	lea    -0x26(%ebp),%eax
80102be7:	6a 0e                	push   $0xe
80102be9:	ff 75 0c             	push   0xc(%ebp)
80102bec:	50                   	push   %eax
80102bed:	e8 7e 27 00 00       	call   80105370 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bf2:	6a 10                	push   $0x10
  de.inum = inum;
80102bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bf7:	57                   	push   %edi
80102bf8:	56                   	push   %esi
80102bf9:	53                   	push   %ebx
  de.inum = inum;
80102bfa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bfe:	e8 3d fb ff ff       	call   80102740 <writei>
80102c03:	83 c4 20             	add    $0x20,%esp
80102c06:	83 f8 10             	cmp    $0x10,%eax
80102c09:	75 2a                	jne    80102c35 <dirlink+0xa5>
  return 0;
80102c0b:	31 c0                	xor    %eax,%eax
}
80102c0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c10:	5b                   	pop    %ebx
80102c11:	5e                   	pop    %esi
80102c12:	5f                   	pop    %edi
80102c13:	5d                   	pop    %ebp
80102c14:	c3                   	ret    
    iput(ip);
80102c15:	83 ec 0c             	sub    $0xc,%esp
80102c18:	50                   	push   %eax
80102c19:	e8 42 f8 ff ff       	call   80102460 <iput>
    return -1;
80102c1e:	83 c4 10             	add    $0x10,%esp
80102c21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c26:	eb e5                	jmp    80102c0d <dirlink+0x7d>
      panic("dirlink read");
80102c28:	83 ec 0c             	sub    $0xc,%esp
80102c2b:	68 a8 7e 10 80       	push   $0x80107ea8
80102c30:	e8 4b d7 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102c35:	83 ec 0c             	sub    $0xc,%esp
80102c38:	68 7e 84 10 80       	push   $0x8010847e
80102c3d:	e8 3e d7 ff ff       	call   80100380 <panic>
80102c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c50 <namei>:

struct inode*
namei(char *path)
{
80102c50:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102c51:	31 d2                	xor    %edx,%edx
{
80102c53:	89 e5                	mov    %esp,%ebp
80102c55:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102c58:	8b 45 08             	mov    0x8(%ebp),%eax
80102c5b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102c5e:	e8 dd fc ff ff       	call   80102940 <namex>
}
80102c63:	c9                   	leave  
80102c64:	c3                   	ret    
80102c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102c70 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102c70:	55                   	push   %ebp
  return namex(path, 1, name);
80102c71:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102c76:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102c78:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102c7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102c7e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102c7f:	e9 bc fc ff ff       	jmp    80102940 <namex>
80102c84:	66 90                	xchg   %ax,%ax
80102c86:	66 90                	xchg   %ax,%ax
80102c88:	66 90                	xchg   %ax,%ax
80102c8a:	66 90                	xchg   %ax,%ax
80102c8c:	66 90                	xchg   %ax,%ax
80102c8e:	66 90                	xchg   %ax,%ax

80102c90 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102c90:	55                   	push   %ebp
80102c91:	89 e5                	mov    %esp,%ebp
80102c93:	57                   	push   %edi
80102c94:	56                   	push   %esi
80102c95:	53                   	push   %ebx
80102c96:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102c99:	85 c0                	test   %eax,%eax
80102c9b:	0f 84 b4 00 00 00    	je     80102d55 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ca1:	8b 70 08             	mov    0x8(%eax),%esi
80102ca4:	89 c3                	mov    %eax,%ebx
80102ca6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102cac:	0f 87 96 00 00 00    	ja     80102d48 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cb2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102cb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cbe:	66 90                	xchg   %ax,%ax
80102cc0:	89 ca                	mov    %ecx,%edx
80102cc2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102cc3:	83 e0 c0             	and    $0xffffffc0,%eax
80102cc6:	3c 40                	cmp    $0x40,%al
80102cc8:	75 f6                	jne    80102cc0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cca:	31 ff                	xor    %edi,%edi
80102ccc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102cd1:	89 f8                	mov    %edi,%eax
80102cd3:	ee                   	out    %al,(%dx)
80102cd4:	b8 01 00 00 00       	mov    $0x1,%eax
80102cd9:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102cde:	ee                   	out    %al,(%dx)
80102cdf:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102ce4:	89 f0                	mov    %esi,%eax
80102ce6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102ce7:	89 f0                	mov    %esi,%eax
80102ce9:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102cee:	c1 f8 08             	sar    $0x8,%eax
80102cf1:	ee                   	out    %al,(%dx)
80102cf2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102cf7:	89 f8                	mov    %edi,%eax
80102cf9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102cfa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102cfe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d03:	c1 e0 04             	shl    $0x4,%eax
80102d06:	83 e0 10             	and    $0x10,%eax
80102d09:	83 c8 e0             	or     $0xffffffe0,%eax
80102d0c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102d0d:	f6 03 04             	testb  $0x4,(%ebx)
80102d10:	75 16                	jne    80102d28 <idestart+0x98>
80102d12:	b8 20 00 00 00       	mov    $0x20,%eax
80102d17:	89 ca                	mov    %ecx,%edx
80102d19:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102d1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d1d:	5b                   	pop    %ebx
80102d1e:	5e                   	pop    %esi
80102d1f:	5f                   	pop    %edi
80102d20:	5d                   	pop    %ebp
80102d21:	c3                   	ret    
80102d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d28:	b8 30 00 00 00       	mov    $0x30,%eax
80102d2d:	89 ca                	mov    %ecx,%edx
80102d2f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102d30:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102d35:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102d38:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102d3d:	fc                   	cld    
80102d3e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102d40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d43:	5b                   	pop    %ebx
80102d44:	5e                   	pop    %esi
80102d45:	5f                   	pop    %edi
80102d46:	5d                   	pop    %ebp
80102d47:	c3                   	ret    
    panic("incorrect blockno");
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	68 14 7f 10 80       	push   $0x80107f14
80102d50:	e8 2b d6 ff ff       	call   80100380 <panic>
    panic("idestart");
80102d55:	83 ec 0c             	sub    $0xc,%esp
80102d58:	68 0b 7f 10 80       	push   $0x80107f0b
80102d5d:	e8 1e d6 ff ff       	call   80100380 <panic>
80102d62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d70 <ideinit>:
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102d76:	68 26 7f 10 80       	push   $0x80107f26
80102d7b:	68 00 32 11 80       	push   $0x80113200
80102d80:	e8 fb 21 00 00       	call   80104f80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102d85:	58                   	pop    %eax
80102d86:	a1 84 33 11 80       	mov    0x80113384,%eax
80102d8b:	5a                   	pop    %edx
80102d8c:	83 e8 01             	sub    $0x1,%eax
80102d8f:	50                   	push   %eax
80102d90:	6a 0e                	push   $0xe
80102d92:	e8 99 02 00 00       	call   80103030 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102d97:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d9a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102d9f:	90                   	nop
80102da0:	ec                   	in     (%dx),%al
80102da1:	83 e0 c0             	and    $0xffffffc0,%eax
80102da4:	3c 40                	cmp    $0x40,%al
80102da6:	75 f8                	jne    80102da0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102da8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102dad:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102db2:	ee                   	out    %al,(%dx)
80102db3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102db8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102dbd:	eb 06                	jmp    80102dc5 <ideinit+0x55>
80102dbf:	90                   	nop
  for(i=0; i<1000; i++){
80102dc0:	83 e9 01             	sub    $0x1,%ecx
80102dc3:	74 0f                	je     80102dd4 <ideinit+0x64>
80102dc5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102dc6:	84 c0                	test   %al,%al
80102dc8:	74 f6                	je     80102dc0 <ideinit+0x50>
      havedisk1 = 1;
80102dca:	c7 05 e0 31 11 80 01 	movl   $0x1,0x801131e0
80102dd1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102dd9:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102dde:	ee                   	out    %al,(%dx)
}
80102ddf:	c9                   	leave  
80102de0:	c3                   	ret    
80102de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102def:	90                   	nop

80102df0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	57                   	push   %edi
80102df4:	56                   	push   %esi
80102df5:	53                   	push   %ebx
80102df6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102df9:	68 00 32 11 80       	push   $0x80113200
80102dfe:	e8 4d 23 00 00       	call   80105150 <acquire>

  if((b = idequeue) == 0){
80102e03:	8b 1d e4 31 11 80    	mov    0x801131e4,%ebx
80102e09:	83 c4 10             	add    $0x10,%esp
80102e0c:	85 db                	test   %ebx,%ebx
80102e0e:	74 63                	je     80102e73 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102e10:	8b 43 58             	mov    0x58(%ebx),%eax
80102e13:	a3 e4 31 11 80       	mov    %eax,0x801131e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e18:	8b 33                	mov    (%ebx),%esi
80102e1a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102e20:	75 2f                	jne    80102e51 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e22:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e2e:	66 90                	xchg   %ax,%ax
80102e30:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e31:	89 c1                	mov    %eax,%ecx
80102e33:	83 e1 c0             	and    $0xffffffc0,%ecx
80102e36:	80 f9 40             	cmp    $0x40,%cl
80102e39:	75 f5                	jne    80102e30 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102e3b:	a8 21                	test   $0x21,%al
80102e3d:	75 12                	jne    80102e51 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
80102e3f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102e42:	b9 80 00 00 00       	mov    $0x80,%ecx
80102e47:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102e4c:	fc                   	cld    
80102e4d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102e4f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102e51:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102e54:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102e57:	83 ce 02             	or     $0x2,%esi
80102e5a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102e5c:	53                   	push   %ebx
80102e5d:	e8 4e 1e 00 00       	call   80104cb0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102e62:	a1 e4 31 11 80       	mov    0x801131e4,%eax
80102e67:	83 c4 10             	add    $0x10,%esp
80102e6a:	85 c0                	test   %eax,%eax
80102e6c:	74 05                	je     80102e73 <ideintr+0x83>
    idestart(idequeue);
80102e6e:	e8 1d fe ff ff       	call   80102c90 <idestart>
    release(&idelock);
80102e73:	83 ec 0c             	sub    $0xc,%esp
80102e76:	68 00 32 11 80       	push   $0x80113200
80102e7b:	e8 70 22 00 00       	call   801050f0 <release>

  release(&idelock);
}
80102e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e83:	5b                   	pop    %ebx
80102e84:	5e                   	pop    %esi
80102e85:	5f                   	pop    %edi
80102e86:	5d                   	pop    %ebp
80102e87:	c3                   	ret    
80102e88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e8f:	90                   	nop

80102e90 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102e90:	55                   	push   %ebp
80102e91:	89 e5                	mov    %esp,%ebp
80102e93:	53                   	push   %ebx
80102e94:	83 ec 10             	sub    $0x10,%esp
80102e97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102e9a:	8d 43 0c             	lea    0xc(%ebx),%eax
80102e9d:	50                   	push   %eax
80102e9e:	e8 8d 20 00 00       	call   80104f30 <holdingsleep>
80102ea3:	83 c4 10             	add    $0x10,%esp
80102ea6:	85 c0                	test   %eax,%eax
80102ea8:	0f 84 c3 00 00 00    	je     80102f71 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102eae:	8b 03                	mov    (%ebx),%eax
80102eb0:	83 e0 06             	and    $0x6,%eax
80102eb3:	83 f8 02             	cmp    $0x2,%eax
80102eb6:	0f 84 a8 00 00 00    	je     80102f64 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102ebc:	8b 53 04             	mov    0x4(%ebx),%edx
80102ebf:	85 d2                	test   %edx,%edx
80102ec1:	74 0d                	je     80102ed0 <iderw+0x40>
80102ec3:	a1 e0 31 11 80       	mov    0x801131e0,%eax
80102ec8:	85 c0                	test   %eax,%eax
80102eca:	0f 84 87 00 00 00    	je     80102f57 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102ed0:	83 ec 0c             	sub    $0xc,%esp
80102ed3:	68 00 32 11 80       	push   $0x80113200
80102ed8:	e8 73 22 00 00       	call   80105150 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102edd:	a1 e4 31 11 80       	mov    0x801131e4,%eax
  b->qnext = 0;
80102ee2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102ee9:	83 c4 10             	add    $0x10,%esp
80102eec:	85 c0                	test   %eax,%eax
80102eee:	74 60                	je     80102f50 <iderw+0xc0>
80102ef0:	89 c2                	mov    %eax,%edx
80102ef2:	8b 40 58             	mov    0x58(%eax),%eax
80102ef5:	85 c0                	test   %eax,%eax
80102ef7:	75 f7                	jne    80102ef0 <iderw+0x60>
80102ef9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102efc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102efe:	39 1d e4 31 11 80    	cmp    %ebx,0x801131e4
80102f04:	74 3a                	je     80102f40 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f06:	8b 03                	mov    (%ebx),%eax
80102f08:	83 e0 06             	and    $0x6,%eax
80102f0b:	83 f8 02             	cmp    $0x2,%eax
80102f0e:	74 1b                	je     80102f2b <iderw+0x9b>
    sleep(b, &idelock);
80102f10:	83 ec 08             	sub    $0x8,%esp
80102f13:	68 00 32 11 80       	push   $0x80113200
80102f18:	53                   	push   %ebx
80102f19:	e8 d2 1c 00 00       	call   80104bf0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f1e:	8b 03                	mov    (%ebx),%eax
80102f20:	83 c4 10             	add    $0x10,%esp
80102f23:	83 e0 06             	and    $0x6,%eax
80102f26:	83 f8 02             	cmp    $0x2,%eax
80102f29:	75 e5                	jne    80102f10 <iderw+0x80>
  }


  release(&idelock);
80102f2b:	c7 45 08 00 32 11 80 	movl   $0x80113200,0x8(%ebp)
}
80102f32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f35:	c9                   	leave  
  release(&idelock);
80102f36:	e9 b5 21 00 00       	jmp    801050f0 <release>
80102f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop
    idestart(b);
80102f40:	89 d8                	mov    %ebx,%eax
80102f42:	e8 49 fd ff ff       	call   80102c90 <idestart>
80102f47:	eb bd                	jmp    80102f06 <iderw+0x76>
80102f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f50:	ba e4 31 11 80       	mov    $0x801131e4,%edx
80102f55:	eb a5                	jmp    80102efc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102f57:	83 ec 0c             	sub    $0xc,%esp
80102f5a:	68 55 7f 10 80       	push   $0x80107f55
80102f5f:	e8 1c d4 ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102f64:	83 ec 0c             	sub    $0xc,%esp
80102f67:	68 40 7f 10 80       	push   $0x80107f40
80102f6c:	e8 0f d4 ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102f71:	83 ec 0c             	sub    $0xc,%esp
80102f74:	68 2a 7f 10 80       	push   $0x80107f2a
80102f79:	e8 02 d4 ff ff       	call   80100380 <panic>
80102f7e:	66 90                	xchg   %ax,%ax

80102f80 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102f80:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102f81:	c7 05 34 32 11 80 00 	movl   $0xfec00000,0x80113234
80102f88:	00 c0 fe 
{
80102f8b:	89 e5                	mov    %esp,%ebp
80102f8d:	56                   	push   %esi
80102f8e:	53                   	push   %ebx
  ioapic->reg = reg;
80102f8f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102f96:	00 00 00 
  return ioapic->data;
80102f99:	8b 15 34 32 11 80    	mov    0x80113234,%edx
80102f9f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102fa2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102fa8:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102fae:	0f b6 15 80 33 11 80 	movzbl 0x80113380,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102fb5:	c1 ee 10             	shr    $0x10,%esi
80102fb8:	89 f0                	mov    %esi,%eax
80102fba:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
80102fbd:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102fc0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102fc3:	39 c2                	cmp    %eax,%edx
80102fc5:	74 16                	je     80102fdd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102fc7:	83 ec 0c             	sub    $0xc,%esp
80102fca:	68 74 7f 10 80       	push   $0x80107f74
80102fcf:	e8 0c d7 ff ff       	call   801006e0 <cprintf>
  ioapic->reg = reg;
80102fd4:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
80102fda:	83 c4 10             	add    $0x10,%esp
80102fdd:	83 c6 21             	add    $0x21,%esi
{
80102fe0:	ba 10 00 00 00       	mov    $0x10,%edx
80102fe5:	b8 20 00 00 00       	mov    $0x20,%eax
80102fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102ff0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102ff2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102ff4:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
  for(i = 0; i <= maxintr; i++){
80102ffa:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102ffd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80103003:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80103006:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80103009:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010300c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010300e:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
80103014:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010301b:	39 f0                	cmp    %esi,%eax
8010301d:	75 d1                	jne    80102ff0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010301f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103022:	5b                   	pop    %ebx
80103023:	5e                   	pop    %esi
80103024:	5d                   	pop    %ebp
80103025:	c3                   	ret    
80103026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010302d:	8d 76 00             	lea    0x0(%esi),%esi

80103030 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103030:	55                   	push   %ebp
  ioapic->reg = reg;
80103031:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
{
80103037:	89 e5                	mov    %esp,%ebp
80103039:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010303c:	8d 50 20             	lea    0x20(%eax),%edx
8010303f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103043:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103045:	8b 0d 34 32 11 80    	mov    0x80113234,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010304b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010304e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103051:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103054:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103056:	a1 34 32 11 80       	mov    0x80113234,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010305b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010305e:	89 50 10             	mov    %edx,0x10(%eax)
}
80103061:	5d                   	pop    %ebp
80103062:	c3                   	ret    
80103063:	66 90                	xchg   %ax,%ax
80103065:	66 90                	xchg   %ax,%ax
80103067:	66 90                	xchg   %ax,%ax
80103069:	66 90                	xchg   %ax,%ax
8010306b:	66 90                	xchg   %ax,%ax
8010306d:	66 90                	xchg   %ax,%ax
8010306f:	90                   	nop

80103070 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103070:	55                   	push   %ebp
80103071:	89 e5                	mov    %esp,%ebp
80103073:	53                   	push   %ebx
80103074:	83 ec 04             	sub    $0x4,%esp
80103077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010307a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103080:	75 76                	jne    801030f8 <kfree+0x88>
80103082:	81 fb d0 70 11 80    	cmp    $0x801170d0,%ebx
80103088:	72 6e                	jb     801030f8 <kfree+0x88>
8010308a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103090:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103095:	77 61                	ja     801030f8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103097:	83 ec 04             	sub    $0x4,%esp
8010309a:	68 00 10 00 00       	push   $0x1000
8010309f:	6a 01                	push   $0x1
801030a1:	53                   	push   %ebx
801030a2:	e8 69 21 00 00       	call   80105210 <memset>

  if(kmem.use_lock)
801030a7:	8b 15 74 32 11 80    	mov    0x80113274,%edx
801030ad:	83 c4 10             	add    $0x10,%esp
801030b0:	85 d2                	test   %edx,%edx
801030b2:	75 1c                	jne    801030d0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801030b4:	a1 78 32 11 80       	mov    0x80113278,%eax
801030b9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801030bb:	a1 74 32 11 80       	mov    0x80113274,%eax
  kmem.freelist = r;
801030c0:	89 1d 78 32 11 80    	mov    %ebx,0x80113278
  if(kmem.use_lock)
801030c6:	85 c0                	test   %eax,%eax
801030c8:	75 1e                	jne    801030e8 <kfree+0x78>
    release(&kmem.lock);
}
801030ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030cd:	c9                   	leave  
801030ce:	c3                   	ret    
801030cf:	90                   	nop
    acquire(&kmem.lock);
801030d0:	83 ec 0c             	sub    $0xc,%esp
801030d3:	68 40 32 11 80       	push   $0x80113240
801030d8:	e8 73 20 00 00       	call   80105150 <acquire>
801030dd:	83 c4 10             	add    $0x10,%esp
801030e0:	eb d2                	jmp    801030b4 <kfree+0x44>
801030e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801030e8:	c7 45 08 40 32 11 80 	movl   $0x80113240,0x8(%ebp)
}
801030ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030f2:	c9                   	leave  
    release(&kmem.lock);
801030f3:	e9 f8 1f 00 00       	jmp    801050f0 <release>
    panic("kfree");
801030f8:	83 ec 0c             	sub    $0xc,%esp
801030fb:	68 a6 7f 10 80       	push   $0x80107fa6
80103100:	e8 7b d2 ff ff       	call   80100380 <panic>
80103105:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010310c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103110 <freerange>:
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103114:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103117:	8b 75 0c             	mov    0xc(%ebp),%esi
8010311a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010311b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103121:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103127:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010312d:	39 de                	cmp    %ebx,%esi
8010312f:	72 23                	jb     80103154 <freerange+0x44>
80103131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103138:	83 ec 0c             	sub    $0xc,%esp
8010313b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103141:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103147:	50                   	push   %eax
80103148:	e8 23 ff ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010314d:	83 c4 10             	add    $0x10,%esp
80103150:	39 f3                	cmp    %esi,%ebx
80103152:	76 e4                	jbe    80103138 <freerange+0x28>
}
80103154:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103157:	5b                   	pop    %ebx
80103158:	5e                   	pop    %esi
80103159:	5d                   	pop    %ebp
8010315a:	c3                   	ret    
8010315b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010315f:	90                   	nop

80103160 <kinit2>:
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80103164:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103167:	8b 75 0c             	mov    0xc(%ebp),%esi
8010316a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010316b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103171:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103177:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010317d:	39 de                	cmp    %ebx,%esi
8010317f:	72 23                	jb     801031a4 <kinit2+0x44>
80103181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103188:	83 ec 0c             	sub    $0xc,%esp
8010318b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103191:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103197:	50                   	push   %eax
80103198:	e8 d3 fe ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010319d:	83 c4 10             	add    $0x10,%esp
801031a0:	39 de                	cmp    %ebx,%esi
801031a2:	73 e4                	jae    80103188 <kinit2+0x28>
  kmem.use_lock = 1;
801031a4:	c7 05 74 32 11 80 01 	movl   $0x1,0x80113274
801031ab:	00 00 00 
}
801031ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031b1:	5b                   	pop    %ebx
801031b2:	5e                   	pop    %esi
801031b3:	5d                   	pop    %ebp
801031b4:	c3                   	ret    
801031b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031c0 <kinit1>:
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	56                   	push   %esi
801031c4:	53                   	push   %ebx
801031c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801031c8:	83 ec 08             	sub    $0x8,%esp
801031cb:	68 ac 7f 10 80       	push   $0x80107fac
801031d0:	68 40 32 11 80       	push   $0x80113240
801031d5:	e8 a6 1d 00 00       	call   80104f80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801031da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031dd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801031e0:	c7 05 74 32 11 80 00 	movl   $0x0,0x80113274
801031e7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801031ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801031f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801031fc:	39 de                	cmp    %ebx,%esi
801031fe:	72 1c                	jb     8010321c <kinit1+0x5c>
    kfree(p);
80103200:	83 ec 0c             	sub    $0xc,%esp
80103203:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103209:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010320f:	50                   	push   %eax
80103210:	e8 5b fe ff ff       	call   80103070 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103215:	83 c4 10             	add    $0x10,%esp
80103218:	39 de                	cmp    %ebx,%esi
8010321a:	73 e4                	jae    80103200 <kinit1+0x40>
}
8010321c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010321f:	5b                   	pop    %ebx
80103220:	5e                   	pop    %esi
80103221:	5d                   	pop    %ebp
80103222:	c3                   	ret    
80103223:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010322a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103230 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80103230:	a1 74 32 11 80       	mov    0x80113274,%eax
80103235:	85 c0                	test   %eax,%eax
80103237:	75 1f                	jne    80103258 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103239:	a1 78 32 11 80       	mov    0x80113278,%eax
  if(r)
8010323e:	85 c0                	test   %eax,%eax
80103240:	74 0e                	je     80103250 <kalloc+0x20>
    kmem.freelist = r->next;
80103242:	8b 10                	mov    (%eax),%edx
80103244:	89 15 78 32 11 80    	mov    %edx,0x80113278
  if(kmem.use_lock)
8010324a:	c3                   	ret    
8010324b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010324f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80103250:	c3                   	ret    
80103251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80103258:	55                   	push   %ebp
80103259:	89 e5                	mov    %esp,%ebp
8010325b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010325e:	68 40 32 11 80       	push   $0x80113240
80103263:	e8 e8 1e 00 00       	call   80105150 <acquire>
  r = kmem.freelist;
80103268:	a1 78 32 11 80       	mov    0x80113278,%eax
  if(kmem.use_lock)
8010326d:	8b 15 74 32 11 80    	mov    0x80113274,%edx
  if(r)
80103273:	83 c4 10             	add    $0x10,%esp
80103276:	85 c0                	test   %eax,%eax
80103278:	74 08                	je     80103282 <kalloc+0x52>
    kmem.freelist = r->next;
8010327a:	8b 08                	mov    (%eax),%ecx
8010327c:	89 0d 78 32 11 80    	mov    %ecx,0x80113278
  if(kmem.use_lock)
80103282:	85 d2                	test   %edx,%edx
80103284:	74 16                	je     8010329c <kalloc+0x6c>
    release(&kmem.lock);
80103286:	83 ec 0c             	sub    $0xc,%esp
80103289:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010328c:	68 40 32 11 80       	push   $0x80113240
80103291:	e8 5a 1e 00 00       	call   801050f0 <release>
  return (char*)r;
80103296:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80103299:	83 c4 10             	add    $0x10,%esp
}
8010329c:	c9                   	leave  
8010329d:	c3                   	ret    
8010329e:	66 90                	xchg   %ax,%ax

801032a0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032a0:	ba 64 00 00 00       	mov    $0x64,%edx
801032a5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801032a6:	a8 01                	test   $0x1,%al
801032a8:	0f 84 c2 00 00 00    	je     80103370 <kbdgetc+0xd0>
{
801032ae:	55                   	push   %ebp
801032af:	ba 60 00 00 00       	mov    $0x60,%edx
801032b4:	89 e5                	mov    %esp,%ebp
801032b6:	53                   	push   %ebx
801032b7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801032b8:	8b 1d 7c 32 11 80    	mov    0x8011327c,%ebx
  data = inb(KBDATAP);
801032be:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801032c1:	3c e0                	cmp    $0xe0,%al
801032c3:	74 5b                	je     80103320 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801032c5:	89 da                	mov    %ebx,%edx
801032c7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801032ca:	84 c0                	test   %al,%al
801032cc:	78 62                	js     80103330 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801032ce:	85 d2                	test   %edx,%edx
801032d0:	74 09                	je     801032db <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801032d2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801032d5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801032d8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801032db:	0f b6 91 e0 80 10 80 	movzbl -0x7fef7f20(%ecx),%edx
  shift ^= togglecode[data];
801032e2:	0f b6 81 e0 7f 10 80 	movzbl -0x7fef8020(%ecx),%eax
  shift |= shiftcode[data];
801032e9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801032eb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801032ed:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801032ef:	89 15 7c 32 11 80    	mov    %edx,0x8011327c
  c = charcode[shift & (CTL | SHIFT)][data];
801032f5:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801032f8:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801032fb:	8b 04 85 c0 7f 10 80 	mov    -0x7fef8040(,%eax,4),%eax
80103302:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80103306:	74 0b                	je     80103313 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80103308:	8d 50 9f             	lea    -0x61(%eax),%edx
8010330b:	83 fa 19             	cmp    $0x19,%edx
8010330e:	77 48                	ja     80103358 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103310:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103313:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103316:	c9                   	leave  
80103317:	c3                   	ret    
80103318:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010331f:	90                   	nop
    shift |= E0ESC;
80103320:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103323:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103325:	89 1d 7c 32 11 80    	mov    %ebx,0x8011327c
}
8010332b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010332e:	c9                   	leave  
8010332f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80103330:	83 e0 7f             	and    $0x7f,%eax
80103333:	85 d2                	test   %edx,%edx
80103335:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103338:	0f b6 81 e0 80 10 80 	movzbl -0x7fef7f20(%ecx),%eax
8010333f:	83 c8 40             	or     $0x40,%eax
80103342:	0f b6 c0             	movzbl %al,%eax
80103345:	f7 d0                	not    %eax
80103347:	21 d8                	and    %ebx,%eax
}
80103349:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010334c:	a3 7c 32 11 80       	mov    %eax,0x8011327c
    return 0;
80103351:	31 c0                	xor    %eax,%eax
}
80103353:	c9                   	leave  
80103354:	c3                   	ret    
80103355:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80103358:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010335b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010335e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103361:	c9                   	leave  
      c += 'a' - 'A';
80103362:	83 f9 1a             	cmp    $0x1a,%ecx
80103365:	0f 42 c2             	cmovb  %edx,%eax
}
80103368:	c3                   	ret    
80103369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80103370:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103375:	c3                   	ret    
80103376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010337d:	8d 76 00             	lea    0x0(%esi),%esi

80103380 <kbdintr>:

void
kbdintr(void)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103386:	68 a0 32 10 80       	push   $0x801032a0
8010338b:	e8 60 d9 ff ff       	call   80100cf0 <consoleintr>
}
80103390:	83 c4 10             	add    $0x10,%esp
80103393:	c9                   	leave  
80103394:	c3                   	ret    
80103395:	66 90                	xchg   %ax,%ax
80103397:	66 90                	xchg   %ax,%ax
80103399:	66 90                	xchg   %ax,%ax
8010339b:	66 90                	xchg   %ax,%ax
8010339d:	66 90                	xchg   %ax,%ax
8010339f:	90                   	nop

801033a0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801033a0:	a1 80 32 11 80       	mov    0x80113280,%eax
801033a5:	85 c0                	test   %eax,%eax
801033a7:	0f 84 cb 00 00 00    	je     80103478 <lapicinit+0xd8>
  lapic[index] = value;
801033ad:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801033b4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033b7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033ba:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801033c1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033c4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033c7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801033ce:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801033d1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033d4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801033db:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801033de:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033e1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801033e8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801033eb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801033ee:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801033f5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801033f8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801033fb:	8b 50 30             	mov    0x30(%eax),%edx
801033fe:	c1 ea 10             	shr    $0x10,%edx
80103401:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80103407:	75 77                	jne    80103480 <lapicinit+0xe0>
  lapic[index] = value;
80103409:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103410:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103413:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103416:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010341d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103420:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103423:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010342a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010342d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103430:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103437:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010343a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010343d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103444:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103447:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010344a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103451:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103454:	8b 50 20             	mov    0x20(%eax),%edx
80103457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010345e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103460:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103466:	80 e6 10             	and    $0x10,%dh
80103469:	75 f5                	jne    80103460 <lapicinit+0xc0>
  lapic[index] = value;
8010346b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103472:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103475:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103478:	c3                   	ret    
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80103480:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103487:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010348a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010348d:	e9 77 ff ff ff       	jmp    80103409 <lapicinit+0x69>
80103492:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034a0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801034a0:	a1 80 32 11 80       	mov    0x80113280,%eax
801034a5:	85 c0                	test   %eax,%eax
801034a7:	74 07                	je     801034b0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801034a9:	8b 40 20             	mov    0x20(%eax),%eax
801034ac:	c1 e8 18             	shr    $0x18,%eax
801034af:	c3                   	ret    
    return 0;
801034b0:	31 c0                	xor    %eax,%eax
}
801034b2:	c3                   	ret    
801034b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801034c0:	a1 80 32 11 80       	mov    0x80113280,%eax
801034c5:	85 c0                	test   %eax,%eax
801034c7:	74 0d                	je     801034d6 <lapiceoi+0x16>
  lapic[index] = value;
801034c9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801034d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034d3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801034d6:	c3                   	ret    
801034d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034de:	66 90                	xchg   %ax,%ax

801034e0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801034e0:	c3                   	ret    
801034e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034ef:	90                   	nop

801034f0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801034f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801034f6:	ba 70 00 00 00       	mov    $0x70,%edx
801034fb:	89 e5                	mov    %esp,%ebp
801034fd:	53                   	push   %ebx
801034fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103501:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103504:	ee                   	out    %al,(%dx)
80103505:	b8 0a 00 00 00       	mov    $0xa,%eax
8010350a:	ba 71 00 00 00       	mov    $0x71,%edx
8010350f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103510:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103512:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103515:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010351b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010351d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80103520:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103522:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103525:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103528:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010352e:	a1 80 32 11 80       	mov    0x80113280,%eax
80103533:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103539:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010353c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103543:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103546:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103549:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103550:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103553:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103556:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010355c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010355f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103565:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103568:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010356e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103571:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103577:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010357a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010357d:	c9                   	leave  
8010357e:	c3                   	ret    
8010357f:	90                   	nop

80103580 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103580:	55                   	push   %ebp
80103581:	b8 0b 00 00 00       	mov    $0xb,%eax
80103586:	ba 70 00 00 00       	mov    $0x70,%edx
8010358b:	89 e5                	mov    %esp,%ebp
8010358d:	57                   	push   %edi
8010358e:	56                   	push   %esi
8010358f:	53                   	push   %ebx
80103590:	83 ec 4c             	sub    $0x4c,%esp
80103593:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103594:	ba 71 00 00 00       	mov    $0x71,%edx
80103599:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010359a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010359d:	bb 70 00 00 00       	mov    $0x70,%ebx
801035a2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801035a5:	8d 76 00             	lea    0x0(%esi),%esi
801035a8:	31 c0                	xor    %eax,%eax
801035aa:	89 da                	mov    %ebx,%edx
801035ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ad:	b9 71 00 00 00       	mov    $0x71,%ecx
801035b2:	89 ca                	mov    %ecx,%edx
801035b4:	ec                   	in     (%dx),%al
801035b5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035b8:	89 da                	mov    %ebx,%edx
801035ba:	b8 02 00 00 00       	mov    $0x2,%eax
801035bf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035c0:	89 ca                	mov    %ecx,%edx
801035c2:	ec                   	in     (%dx),%al
801035c3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035c6:	89 da                	mov    %ebx,%edx
801035c8:	b8 04 00 00 00       	mov    $0x4,%eax
801035cd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ce:	89 ca                	mov    %ecx,%edx
801035d0:	ec                   	in     (%dx),%al
801035d1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035d4:	89 da                	mov    %ebx,%edx
801035d6:	b8 07 00 00 00       	mov    $0x7,%eax
801035db:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035dc:	89 ca                	mov    %ecx,%edx
801035de:	ec                   	in     (%dx),%al
801035df:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035e2:	89 da                	mov    %ebx,%edx
801035e4:	b8 08 00 00 00       	mov    $0x8,%eax
801035e9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ea:	89 ca                	mov    %ecx,%edx
801035ec:	ec                   	in     (%dx),%al
801035ed:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035ef:	89 da                	mov    %ebx,%edx
801035f1:	b8 09 00 00 00       	mov    $0x9,%eax
801035f6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035f7:	89 ca                	mov    %ecx,%edx
801035f9:	ec                   	in     (%dx),%al
801035fa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035fc:	89 da                	mov    %ebx,%edx
801035fe:	b8 0a 00 00 00       	mov    $0xa,%eax
80103603:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103604:	89 ca                	mov    %ecx,%edx
80103606:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103607:	84 c0                	test   %al,%al
80103609:	78 9d                	js     801035a8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010360b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010360f:	89 fa                	mov    %edi,%edx
80103611:	0f b6 fa             	movzbl %dl,%edi
80103614:	89 f2                	mov    %esi,%edx
80103616:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103619:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
8010361d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103620:	89 da                	mov    %ebx,%edx
80103622:	89 7d c8             	mov    %edi,-0x38(%ebp)
80103625:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103628:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010362c:	89 75 cc             	mov    %esi,-0x34(%ebp)
8010362f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103632:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103636:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103639:	31 c0                	xor    %eax,%eax
8010363b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010363c:	89 ca                	mov    %ecx,%edx
8010363e:	ec                   	in     (%dx),%al
8010363f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103642:	89 da                	mov    %ebx,%edx
80103644:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103647:	b8 02 00 00 00       	mov    $0x2,%eax
8010364c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010364d:	89 ca                	mov    %ecx,%edx
8010364f:	ec                   	in     (%dx),%al
80103650:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103653:	89 da                	mov    %ebx,%edx
80103655:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103658:	b8 04 00 00 00       	mov    $0x4,%eax
8010365d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010365e:	89 ca                	mov    %ecx,%edx
80103660:	ec                   	in     (%dx),%al
80103661:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103664:	89 da                	mov    %ebx,%edx
80103666:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103669:	b8 07 00 00 00       	mov    $0x7,%eax
8010366e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010366f:	89 ca                	mov    %ecx,%edx
80103671:	ec                   	in     (%dx),%al
80103672:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103675:	89 da                	mov    %ebx,%edx
80103677:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010367a:	b8 08 00 00 00       	mov    $0x8,%eax
8010367f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103680:	89 ca                	mov    %ecx,%edx
80103682:	ec                   	in     (%dx),%al
80103683:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103686:	89 da                	mov    %ebx,%edx
80103688:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010368b:	b8 09 00 00 00       	mov    $0x9,%eax
80103690:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103691:	89 ca                	mov    %ecx,%edx
80103693:	ec                   	in     (%dx),%al
80103694:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103697:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010369a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010369d:	8d 45 d0             	lea    -0x30(%ebp),%eax
801036a0:	6a 18                	push   $0x18
801036a2:	50                   	push   %eax
801036a3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801036a6:	50                   	push   %eax
801036a7:	e8 b4 1b 00 00       	call   80105260 <memcmp>
801036ac:	83 c4 10             	add    $0x10,%esp
801036af:	85 c0                	test   %eax,%eax
801036b1:	0f 85 f1 fe ff ff    	jne    801035a8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801036b7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801036bb:	75 78                	jne    80103735 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801036bd:	8b 45 b8             	mov    -0x48(%ebp),%eax
801036c0:	89 c2                	mov    %eax,%edx
801036c2:	83 e0 0f             	and    $0xf,%eax
801036c5:	c1 ea 04             	shr    $0x4,%edx
801036c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801036d1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801036d4:	89 c2                	mov    %eax,%edx
801036d6:	83 e0 0f             	and    $0xf,%eax
801036d9:	c1 ea 04             	shr    $0x4,%edx
801036dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036e2:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801036e5:	8b 45 c0             	mov    -0x40(%ebp),%eax
801036e8:	89 c2                	mov    %eax,%edx
801036ea:	83 e0 0f             	and    $0xf,%eax
801036ed:	c1 ea 04             	shr    $0x4,%edx
801036f0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036f3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036f6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801036f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801036fc:	89 c2                	mov    %eax,%edx
801036fe:	83 e0 0f             	and    $0xf,%eax
80103701:	c1 ea 04             	shr    $0x4,%edx
80103704:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103707:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010370a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010370d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103710:	89 c2                	mov    %eax,%edx
80103712:	83 e0 0f             	and    $0xf,%eax
80103715:	c1 ea 04             	shr    $0x4,%edx
80103718:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010371b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010371e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103721:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103724:	89 c2                	mov    %eax,%edx
80103726:	83 e0 0f             	and    $0xf,%eax
80103729:	c1 ea 04             	shr    $0x4,%edx
8010372c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010372f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103732:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103735:	8b 75 08             	mov    0x8(%ebp),%esi
80103738:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010373b:	89 06                	mov    %eax,(%esi)
8010373d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103740:	89 46 04             	mov    %eax,0x4(%esi)
80103743:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103746:	89 46 08             	mov    %eax,0x8(%esi)
80103749:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010374c:	89 46 0c             	mov    %eax,0xc(%esi)
8010374f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103752:	89 46 10             	mov    %eax,0x10(%esi)
80103755:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103758:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010375b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103765:	5b                   	pop    %ebx
80103766:	5e                   	pop    %esi
80103767:	5f                   	pop    %edi
80103768:	5d                   	pop    %ebp
80103769:	c3                   	ret    
8010376a:	66 90                	xchg   %ax,%ax
8010376c:	66 90                	xchg   %ax,%ax
8010376e:	66 90                	xchg   %ax,%ax

80103770 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103770:	8b 0d e8 32 11 80    	mov    0x801132e8,%ecx
80103776:	85 c9                	test   %ecx,%ecx
80103778:	0f 8e 8a 00 00 00    	jle    80103808 <install_trans+0x98>
{
8010377e:	55                   	push   %ebp
8010377f:	89 e5                	mov    %esp,%ebp
80103781:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103782:	31 ff                	xor    %edi,%edi
{
80103784:	56                   	push   %esi
80103785:	53                   	push   %ebx
80103786:	83 ec 0c             	sub    $0xc,%esp
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103790:	a1 d4 32 11 80       	mov    0x801132d4,%eax
80103795:	83 ec 08             	sub    $0x8,%esp
80103798:	01 f8                	add    %edi,%eax
8010379a:	83 c0 01             	add    $0x1,%eax
8010379d:	50                   	push   %eax
8010379e:	ff 35 e4 32 11 80    	push   0x801132e4
801037a4:	e8 27 c9 ff ff       	call   801000d0 <bread>
801037a9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037ab:	58                   	pop    %eax
801037ac:	5a                   	pop    %edx
801037ad:	ff 34 bd ec 32 11 80 	push   -0x7feecd14(,%edi,4)
801037b4:	ff 35 e4 32 11 80    	push   0x801132e4
  for (tail = 0; tail < log.lh.n; tail++) {
801037ba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037bd:	e8 0e c9 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801037c2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037c5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801037c7:	8d 46 5c             	lea    0x5c(%esi),%eax
801037ca:	68 00 02 00 00       	push   $0x200
801037cf:	50                   	push   %eax
801037d0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801037d3:	50                   	push   %eax
801037d4:	e8 d7 1a 00 00       	call   801052b0 <memmove>
    bwrite(dbuf);  // write dst to disk
801037d9:	89 1c 24             	mov    %ebx,(%esp)
801037dc:	e8 cf c9 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801037e1:	89 34 24             	mov    %esi,(%esp)
801037e4:	e8 07 ca ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801037e9:	89 1c 24             	mov    %ebx,(%esp)
801037ec:	e8 ff c9 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801037f1:	83 c4 10             	add    $0x10,%esp
801037f4:	39 3d e8 32 11 80    	cmp    %edi,0x801132e8
801037fa:	7f 94                	jg     80103790 <install_trans+0x20>
  }
}
801037fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037ff:	5b                   	pop    %ebx
80103800:	5e                   	pop    %esi
80103801:	5f                   	pop    %edi
80103802:	5d                   	pop    %ebp
80103803:	c3                   	ret    
80103804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103808:	c3                   	ret    
80103809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103810 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103817:	ff 35 d4 32 11 80    	push   0x801132d4
8010381d:	ff 35 e4 32 11 80    	push   0x801132e4
80103823:	e8 a8 c8 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103828:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010382b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010382d:	a1 e8 32 11 80       	mov    0x801132e8,%eax
80103832:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103835:	85 c0                	test   %eax,%eax
80103837:	7e 19                	jle    80103852 <write_head+0x42>
80103839:	31 d2                	xor    %edx,%edx
8010383b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010383f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103840:	8b 0c 95 ec 32 11 80 	mov    -0x7feecd14(,%edx,4),%ecx
80103847:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010384b:	83 c2 01             	add    $0x1,%edx
8010384e:	39 d0                	cmp    %edx,%eax
80103850:	75 ee                	jne    80103840 <write_head+0x30>
  }
  bwrite(buf);
80103852:	83 ec 0c             	sub    $0xc,%esp
80103855:	53                   	push   %ebx
80103856:	e8 55 c9 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010385b:	89 1c 24             	mov    %ebx,(%esp)
8010385e:	e8 8d c9 ff ff       	call   801001f0 <brelse>
}
80103863:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103866:	83 c4 10             	add    $0x10,%esp
80103869:	c9                   	leave  
8010386a:	c3                   	ret    
8010386b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010386f:	90                   	nop

80103870 <initlog>:
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	53                   	push   %ebx
80103874:	83 ec 2c             	sub    $0x2c,%esp
80103877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010387a:	68 e0 81 10 80       	push   $0x801081e0
8010387f:	68 a0 32 11 80       	push   $0x801132a0
80103884:	e8 f7 16 00 00       	call   80104f80 <initlock>
  readsb(dev, &sb);
80103889:	58                   	pop    %eax
8010388a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010388d:	5a                   	pop    %edx
8010388e:	50                   	push   %eax
8010388f:	53                   	push   %ebx
80103890:	e8 3b e8 ff ff       	call   801020d0 <readsb>
  log.start = sb.logstart;
80103895:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103898:	59                   	pop    %ecx
  log.dev = dev;
80103899:	89 1d e4 32 11 80    	mov    %ebx,0x801132e4
  log.size = sb.nlog;
8010389f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801038a2:	a3 d4 32 11 80       	mov    %eax,0x801132d4
  log.size = sb.nlog;
801038a7:	89 15 d8 32 11 80    	mov    %edx,0x801132d8
  struct buf *buf = bread(log.dev, log.start);
801038ad:	5a                   	pop    %edx
801038ae:	50                   	push   %eax
801038af:	53                   	push   %ebx
801038b0:	e8 1b c8 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801038b5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801038b8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801038bb:	89 1d e8 32 11 80    	mov    %ebx,0x801132e8
  for (i = 0; i < log.lh.n; i++) {
801038c1:	85 db                	test   %ebx,%ebx
801038c3:	7e 1d                	jle    801038e2 <initlog+0x72>
801038c5:	31 d2                	xor    %edx,%edx
801038c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
801038d0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801038d4:	89 0c 95 ec 32 11 80 	mov    %ecx,-0x7feecd14(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801038db:	83 c2 01             	add    $0x1,%edx
801038de:	39 d3                	cmp    %edx,%ebx
801038e0:	75 ee                	jne    801038d0 <initlog+0x60>
  brelse(buf);
801038e2:	83 ec 0c             	sub    $0xc,%esp
801038e5:	50                   	push   %eax
801038e6:	e8 05 c9 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801038eb:	e8 80 fe ff ff       	call   80103770 <install_trans>
  log.lh.n = 0;
801038f0:	c7 05 e8 32 11 80 00 	movl   $0x0,0x801132e8
801038f7:	00 00 00 
  write_head(); // clear the log
801038fa:	e8 11 ff ff ff       	call   80103810 <write_head>
}
801038ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103902:	83 c4 10             	add    $0x10,%esp
80103905:	c9                   	leave  
80103906:	c3                   	ret    
80103907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010390e:	66 90                	xchg   %ax,%ax

80103910 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103916:	68 a0 32 11 80       	push   $0x801132a0
8010391b:	e8 30 18 00 00       	call   80105150 <acquire>
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	eb 18                	jmp    8010393d <begin_op+0x2d>
80103925:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103928:	83 ec 08             	sub    $0x8,%esp
8010392b:	68 a0 32 11 80       	push   $0x801132a0
80103930:	68 a0 32 11 80       	push   $0x801132a0
80103935:	e8 b6 12 00 00       	call   80104bf0 <sleep>
8010393a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010393d:	a1 e0 32 11 80       	mov    0x801132e0,%eax
80103942:	85 c0                	test   %eax,%eax
80103944:	75 e2                	jne    80103928 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103946:	a1 dc 32 11 80       	mov    0x801132dc,%eax
8010394b:	8b 15 e8 32 11 80    	mov    0x801132e8,%edx
80103951:	83 c0 01             	add    $0x1,%eax
80103954:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103957:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010395a:	83 fa 1e             	cmp    $0x1e,%edx
8010395d:	7f c9                	jg     80103928 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010395f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103962:	a3 dc 32 11 80       	mov    %eax,0x801132dc
      release(&log.lock);
80103967:	68 a0 32 11 80       	push   $0x801132a0
8010396c:	e8 7f 17 00 00       	call   801050f0 <release>
      break;
    }
  }
}
80103971:	83 c4 10             	add    $0x10,%esp
80103974:	c9                   	leave  
80103975:	c3                   	ret    
80103976:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010397d:	8d 76 00             	lea    0x0(%esi),%esi

80103980 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103989:	68 a0 32 11 80       	push   $0x801132a0
8010398e:	e8 bd 17 00 00       	call   80105150 <acquire>
  log.outstanding -= 1;
80103993:	a1 dc 32 11 80       	mov    0x801132dc,%eax
  if(log.committing)
80103998:	8b 35 e0 32 11 80    	mov    0x801132e0,%esi
8010399e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801039a1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801039a4:	89 1d dc 32 11 80    	mov    %ebx,0x801132dc
  if(log.committing)
801039aa:	85 f6                	test   %esi,%esi
801039ac:	0f 85 22 01 00 00    	jne    80103ad4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801039b2:	85 db                	test   %ebx,%ebx
801039b4:	0f 85 f6 00 00 00    	jne    80103ab0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801039ba:	c7 05 e0 32 11 80 01 	movl   $0x1,0x801132e0
801039c1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801039c4:	83 ec 0c             	sub    $0xc,%esp
801039c7:	68 a0 32 11 80       	push   $0x801132a0
801039cc:	e8 1f 17 00 00       	call   801050f0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801039d1:	8b 0d e8 32 11 80    	mov    0x801132e8,%ecx
801039d7:	83 c4 10             	add    $0x10,%esp
801039da:	85 c9                	test   %ecx,%ecx
801039dc:	7f 42                	jg     80103a20 <end_op+0xa0>
    acquire(&log.lock);
801039de:	83 ec 0c             	sub    $0xc,%esp
801039e1:	68 a0 32 11 80       	push   $0x801132a0
801039e6:	e8 65 17 00 00       	call   80105150 <acquire>
    wakeup(&log);
801039eb:	c7 04 24 a0 32 11 80 	movl   $0x801132a0,(%esp)
    log.committing = 0;
801039f2:	c7 05 e0 32 11 80 00 	movl   $0x0,0x801132e0
801039f9:	00 00 00 
    wakeup(&log);
801039fc:	e8 af 12 00 00       	call   80104cb0 <wakeup>
    release(&log.lock);
80103a01:	c7 04 24 a0 32 11 80 	movl   $0x801132a0,(%esp)
80103a08:	e8 e3 16 00 00       	call   801050f0 <release>
80103a0d:	83 c4 10             	add    $0x10,%esp
}
80103a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a13:	5b                   	pop    %ebx
80103a14:	5e                   	pop    %esi
80103a15:	5f                   	pop    %edi
80103a16:	5d                   	pop    %ebp
80103a17:	c3                   	ret    
80103a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a1f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103a20:	a1 d4 32 11 80       	mov    0x801132d4,%eax
80103a25:	83 ec 08             	sub    $0x8,%esp
80103a28:	01 d8                	add    %ebx,%eax
80103a2a:	83 c0 01             	add    $0x1,%eax
80103a2d:	50                   	push   %eax
80103a2e:	ff 35 e4 32 11 80    	push   0x801132e4
80103a34:	e8 97 c6 ff ff       	call   801000d0 <bread>
80103a39:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a3b:	58                   	pop    %eax
80103a3c:	5a                   	pop    %edx
80103a3d:	ff 34 9d ec 32 11 80 	push   -0x7feecd14(,%ebx,4)
80103a44:	ff 35 e4 32 11 80    	push   0x801132e4
  for (tail = 0; tail < log.lh.n; tail++) {
80103a4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a4d:	e8 7e c6 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103a52:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a55:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103a57:	8d 40 5c             	lea    0x5c(%eax),%eax
80103a5a:	68 00 02 00 00       	push   $0x200
80103a5f:	50                   	push   %eax
80103a60:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a63:	50                   	push   %eax
80103a64:	e8 47 18 00 00       	call   801052b0 <memmove>
    bwrite(to);  // write the log
80103a69:	89 34 24             	mov    %esi,(%esp)
80103a6c:	e8 3f c7 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103a71:	89 3c 24             	mov    %edi,(%esp)
80103a74:	e8 77 c7 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103a79:	89 34 24             	mov    %esi,(%esp)
80103a7c:	e8 6f c7 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103a81:	83 c4 10             	add    $0x10,%esp
80103a84:	3b 1d e8 32 11 80    	cmp    0x801132e8,%ebx
80103a8a:	7c 94                	jl     80103a20 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103a8c:	e8 7f fd ff ff       	call   80103810 <write_head>
    install_trans(); // Now install writes to home locations
80103a91:	e8 da fc ff ff       	call   80103770 <install_trans>
    log.lh.n = 0;
80103a96:	c7 05 e8 32 11 80 00 	movl   $0x0,0x801132e8
80103a9d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103aa0:	e8 6b fd ff ff       	call   80103810 <write_head>
80103aa5:	e9 34 ff ff ff       	jmp    801039de <end_op+0x5e>
80103aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103ab0:	83 ec 0c             	sub    $0xc,%esp
80103ab3:	68 a0 32 11 80       	push   $0x801132a0
80103ab8:	e8 f3 11 00 00       	call   80104cb0 <wakeup>
  release(&log.lock);
80103abd:	c7 04 24 a0 32 11 80 	movl   $0x801132a0,(%esp)
80103ac4:	e8 27 16 00 00       	call   801050f0 <release>
80103ac9:	83 c4 10             	add    $0x10,%esp
}
80103acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103acf:	5b                   	pop    %ebx
80103ad0:	5e                   	pop    %esi
80103ad1:	5f                   	pop    %edi
80103ad2:	5d                   	pop    %ebp
80103ad3:	c3                   	ret    
    panic("log.committing");
80103ad4:	83 ec 0c             	sub    $0xc,%esp
80103ad7:	68 e4 81 10 80       	push   $0x801081e4
80103adc:	e8 9f c8 ff ff       	call   80100380 <panic>
80103ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aef:	90                   	nop

80103af0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103af7:	8b 15 e8 32 11 80    	mov    0x801132e8,%edx
{
80103afd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b00:	83 fa 1d             	cmp    $0x1d,%edx
80103b03:	0f 8f 85 00 00 00    	jg     80103b8e <log_write+0x9e>
80103b09:	a1 d8 32 11 80       	mov    0x801132d8,%eax
80103b0e:	83 e8 01             	sub    $0x1,%eax
80103b11:	39 c2                	cmp    %eax,%edx
80103b13:	7d 79                	jge    80103b8e <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103b15:	a1 dc 32 11 80       	mov    0x801132dc,%eax
80103b1a:	85 c0                	test   %eax,%eax
80103b1c:	7e 7d                	jle    80103b9b <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103b1e:	83 ec 0c             	sub    $0xc,%esp
80103b21:	68 a0 32 11 80       	push   $0x801132a0
80103b26:	e8 25 16 00 00       	call   80105150 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103b2b:	8b 15 e8 32 11 80    	mov    0x801132e8,%edx
80103b31:	83 c4 10             	add    $0x10,%esp
80103b34:	85 d2                	test   %edx,%edx
80103b36:	7e 4a                	jle    80103b82 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b38:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103b3b:	31 c0                	xor    %eax,%eax
80103b3d:	eb 08                	jmp    80103b47 <log_write+0x57>
80103b3f:	90                   	nop
80103b40:	83 c0 01             	add    $0x1,%eax
80103b43:	39 c2                	cmp    %eax,%edx
80103b45:	74 29                	je     80103b70 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b47:	39 0c 85 ec 32 11 80 	cmp    %ecx,-0x7feecd14(,%eax,4)
80103b4e:	75 f0                	jne    80103b40 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103b50:	89 0c 85 ec 32 11 80 	mov    %ecx,-0x7feecd14(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103b57:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103b5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103b5d:	c7 45 08 a0 32 11 80 	movl   $0x801132a0,0x8(%ebp)
}
80103b64:	c9                   	leave  
  release(&log.lock);
80103b65:	e9 86 15 00 00       	jmp    801050f0 <release>
80103b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103b70:	89 0c 95 ec 32 11 80 	mov    %ecx,-0x7feecd14(,%edx,4)
    log.lh.n++;
80103b77:	83 c2 01             	add    $0x1,%edx
80103b7a:	89 15 e8 32 11 80    	mov    %edx,0x801132e8
80103b80:	eb d5                	jmp    80103b57 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80103b82:	8b 43 08             	mov    0x8(%ebx),%eax
80103b85:	a3 ec 32 11 80       	mov    %eax,0x801132ec
  if (i == log.lh.n)
80103b8a:	75 cb                	jne    80103b57 <log_write+0x67>
80103b8c:	eb e9                	jmp    80103b77 <log_write+0x87>
    panic("too big a transaction");
80103b8e:	83 ec 0c             	sub    $0xc,%esp
80103b91:	68 f3 81 10 80       	push   $0x801081f3
80103b96:	e8 e5 c7 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80103b9b:	83 ec 0c             	sub    $0xc,%esp
80103b9e:	68 09 82 10 80       	push   $0x80108209
80103ba3:	e8 d8 c7 ff ff       	call   80100380 <panic>
80103ba8:	66 90                	xchg   %ax,%ax
80103baa:	66 90                	xchg   %ax,%ax
80103bac:	66 90                	xchg   %ax,%ax
80103bae:	66 90                	xchg   %ax,%ax

80103bb0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	53                   	push   %ebx
80103bb4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103bb7:	e8 44 09 00 00       	call   80104500 <cpuid>
80103bbc:	89 c3                	mov    %eax,%ebx
80103bbe:	e8 3d 09 00 00       	call   80104500 <cpuid>
80103bc3:	83 ec 04             	sub    $0x4,%esp
80103bc6:	53                   	push   %ebx
80103bc7:	50                   	push   %eax
80103bc8:	68 24 82 10 80       	push   $0x80108224
80103bcd:	e8 0e cb ff ff       	call   801006e0 <cprintf>
  idtinit();       // load idt register
80103bd2:	e8 b9 28 00 00       	call   80106490 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103bd7:	e8 c4 08 00 00       	call   801044a0 <mycpu>
80103bdc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103bde:	b8 01 00 00 00       	mov    $0x1,%eax
80103be3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103bea:	e8 f1 0b 00 00       	call   801047e0 <scheduler>
80103bef:	90                   	nop

80103bf0 <mpenter>:
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103bf6:	e8 85 39 00 00       	call   80107580 <switchkvm>
  seginit();
80103bfb:	e8 f0 38 00 00       	call   801074f0 <seginit>
  lapicinit();
80103c00:	e8 9b f7 ff ff       	call   801033a0 <lapicinit>
  mpmain();
80103c05:	e8 a6 ff ff ff       	call   80103bb0 <mpmain>
80103c0a:	66 90                	xchg   %ax,%ax
80103c0c:	66 90                	xchg   %ax,%ax
80103c0e:	66 90                	xchg   %ax,%ax

80103c10 <main>:
{
80103c10:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103c14:	83 e4 f0             	and    $0xfffffff0,%esp
80103c17:	ff 71 fc             	push   -0x4(%ecx)
80103c1a:	55                   	push   %ebp
80103c1b:	89 e5                	mov    %esp,%ebp
80103c1d:	53                   	push   %ebx
80103c1e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103c1f:	83 ec 08             	sub    $0x8,%esp
80103c22:	68 00 00 40 80       	push   $0x80400000
80103c27:	68 d0 70 11 80       	push   $0x801170d0
80103c2c:	e8 8f f5 ff ff       	call   801031c0 <kinit1>
  kvmalloc();      // kernel page table
80103c31:	e8 3a 3e 00 00       	call   80107a70 <kvmalloc>
  mpinit();        // detect other processors
80103c36:	e8 85 01 00 00       	call   80103dc0 <mpinit>
  lapicinit();     // interrupt controller
80103c3b:	e8 60 f7 ff ff       	call   801033a0 <lapicinit>
  seginit();       // segment descriptors
80103c40:	e8 ab 38 00 00       	call   801074f0 <seginit>
  picinit();       // disable pic
80103c45:	e8 76 03 00 00       	call   80103fc0 <picinit>
  ioapicinit();    // another interrupt controller
80103c4a:	e8 31 f3 ff ff       	call   80102f80 <ioapicinit>
  consoleinit();   // console hardware
80103c4f:	e8 ac d9 ff ff       	call   80101600 <consoleinit>
  uartinit();      // serial port
80103c54:	e8 27 2b 00 00       	call   80106780 <uartinit>
  pinit();         // process table
80103c59:	e8 22 08 00 00       	call   80104480 <pinit>
  tvinit();        // trap vectors
80103c5e:	e8 ad 27 00 00       	call   80106410 <tvinit>
  binit();         // buffer cache
80103c63:	e8 d8 c3 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103c68:	e8 53 dd ff ff       	call   801019c0 <fileinit>
  ideinit();       // disk 
80103c6d:	e8 fe f0 ff ff       	call   80102d70 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103c72:	83 c4 0c             	add    $0xc,%esp
80103c75:	68 8a 00 00 00       	push   $0x8a
80103c7a:	68 8c b4 10 80       	push   $0x8010b48c
80103c7f:	68 00 70 00 80       	push   $0x80007000
80103c84:	e8 27 16 00 00       	call   801052b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103c89:	83 c4 10             	add    $0x10,%esp
80103c8c:	69 05 84 33 11 80 b0 	imul   $0xb0,0x80113384,%eax
80103c93:	00 00 00 
80103c96:	05 a0 33 11 80       	add    $0x801133a0,%eax
80103c9b:	3d a0 33 11 80       	cmp    $0x801133a0,%eax
80103ca0:	76 7e                	jbe    80103d20 <main+0x110>
80103ca2:	bb a0 33 11 80       	mov    $0x801133a0,%ebx
80103ca7:	eb 20                	jmp    80103cc9 <main+0xb9>
80103ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb0:	69 05 84 33 11 80 b0 	imul   $0xb0,0x80113384,%eax
80103cb7:	00 00 00 
80103cba:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103cc0:	05 a0 33 11 80       	add    $0x801133a0,%eax
80103cc5:	39 c3                	cmp    %eax,%ebx
80103cc7:	73 57                	jae    80103d20 <main+0x110>
    if(c == mycpu())  // We've started already.
80103cc9:	e8 d2 07 00 00       	call   801044a0 <mycpu>
80103cce:	39 c3                	cmp    %eax,%ebx
80103cd0:	74 de                	je     80103cb0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103cd2:	e8 59 f5 ff ff       	call   80103230 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103cd7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103cda:	c7 05 f8 6f 00 80 f0 	movl   $0x80103bf0,0x80006ff8
80103ce1:	3b 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103ce4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103ceb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103cee:	05 00 10 00 00       	add    $0x1000,%eax
80103cf3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103cf8:	0f b6 03             	movzbl (%ebx),%eax
80103cfb:	68 00 70 00 00       	push   $0x7000
80103d00:	50                   	push   %eax
80103d01:	e8 ea f7 ff ff       	call   801034f0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103d06:	83 c4 10             	add    $0x10,%esp
80103d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d10:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103d16:	85 c0                	test   %eax,%eax
80103d18:	74 f6                	je     80103d10 <main+0x100>
80103d1a:	eb 94                	jmp    80103cb0 <main+0xa0>
80103d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103d20:	83 ec 08             	sub    $0x8,%esp
80103d23:	68 00 00 00 8e       	push   $0x8e000000
80103d28:	68 00 00 40 80       	push   $0x80400000
80103d2d:	e8 2e f4 ff ff       	call   80103160 <kinit2>
  userinit();      // first user process
80103d32:	e8 19 08 00 00       	call   80104550 <userinit>
  mpmain();        // finish this processor's setup
80103d37:	e8 74 fe ff ff       	call   80103bb0 <mpmain>
80103d3c:	66 90                	xchg   %ax,%ax
80103d3e:	66 90                	xchg   %ax,%ax

80103d40 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	57                   	push   %edi
80103d44:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103d45:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103d4b:	53                   	push   %ebx
  e = addr+len;
80103d4c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103d4f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103d52:	39 de                	cmp    %ebx,%esi
80103d54:	72 10                	jb     80103d66 <mpsearch1+0x26>
80103d56:	eb 50                	jmp    80103da8 <mpsearch1+0x68>
80103d58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d5f:	90                   	nop
80103d60:	89 fe                	mov    %edi,%esi
80103d62:	39 fb                	cmp    %edi,%ebx
80103d64:	76 42                	jbe    80103da8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d66:	83 ec 04             	sub    $0x4,%esp
80103d69:	8d 7e 10             	lea    0x10(%esi),%edi
80103d6c:	6a 04                	push   $0x4
80103d6e:	68 38 82 10 80       	push   $0x80108238
80103d73:	56                   	push   %esi
80103d74:	e8 e7 14 00 00       	call   80105260 <memcmp>
80103d79:	83 c4 10             	add    $0x10,%esp
80103d7c:	85 c0                	test   %eax,%eax
80103d7e:	75 e0                	jne    80103d60 <mpsearch1+0x20>
80103d80:	89 f2                	mov    %esi,%edx
80103d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103d88:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103d8b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103d8e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103d90:	39 fa                	cmp    %edi,%edx
80103d92:	75 f4                	jne    80103d88 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d94:	84 c0                	test   %al,%al
80103d96:	75 c8                	jne    80103d60 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103d98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d9b:	89 f0                	mov    %esi,%eax
80103d9d:	5b                   	pop    %ebx
80103d9e:	5e                   	pop    %esi
80103d9f:	5f                   	pop    %edi
80103da0:	5d                   	pop    %ebp
80103da1:	c3                   	ret    
80103da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103dab:	31 f6                	xor    %esi,%esi
}
80103dad:	5b                   	pop    %ebx
80103dae:	89 f0                	mov    %esi,%eax
80103db0:	5e                   	pop    %esi
80103db1:	5f                   	pop    %edi
80103db2:	5d                   	pop    %ebp
80103db3:	c3                   	ret    
80103db4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dbf:	90                   	nop

80103dc0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103dc9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103dd0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103dd7:	c1 e0 08             	shl    $0x8,%eax
80103dda:	09 d0                	or     %edx,%eax
80103ddc:	c1 e0 04             	shl    $0x4,%eax
80103ddf:	75 1b                	jne    80103dfc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103de1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103de8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103def:	c1 e0 08             	shl    $0x8,%eax
80103df2:	09 d0                	or     %edx,%eax
80103df4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103df7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103dfc:	ba 00 04 00 00       	mov    $0x400,%edx
80103e01:	e8 3a ff ff ff       	call   80103d40 <mpsearch1>
80103e06:	89 c3                	mov    %eax,%ebx
80103e08:	85 c0                	test   %eax,%eax
80103e0a:	0f 84 40 01 00 00    	je     80103f50 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103e10:	8b 73 04             	mov    0x4(%ebx),%esi
80103e13:	85 f6                	test   %esi,%esi
80103e15:	0f 84 25 01 00 00    	je     80103f40 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
80103e1b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103e1e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103e24:	6a 04                	push   $0x4
80103e26:	68 3d 82 10 80       	push   $0x8010823d
80103e2b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103e2c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103e2f:	e8 2c 14 00 00       	call   80105260 <memcmp>
80103e34:	83 c4 10             	add    $0x10,%esp
80103e37:	85 c0                	test   %eax,%eax
80103e39:	0f 85 01 01 00 00    	jne    80103f40 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
80103e3f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103e46:	3c 01                	cmp    $0x1,%al
80103e48:	74 08                	je     80103e52 <mpinit+0x92>
80103e4a:	3c 04                	cmp    $0x4,%al
80103e4c:	0f 85 ee 00 00 00    	jne    80103f40 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103e52:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103e59:	66 85 d2             	test   %dx,%dx
80103e5c:	74 22                	je     80103e80 <mpinit+0xc0>
80103e5e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103e61:	89 f0                	mov    %esi,%eax
  sum = 0;
80103e63:	31 d2                	xor    %edx,%edx
80103e65:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103e68:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103e6f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103e72:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103e74:	39 c7                	cmp    %eax,%edi
80103e76:	75 f0                	jne    80103e68 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103e78:	84 d2                	test   %dl,%dl
80103e7a:	0f 85 c0 00 00 00    	jne    80103f40 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103e80:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103e86:	a3 80 32 11 80       	mov    %eax,0x80113280
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e8b:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103e92:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
80103e98:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e9d:	03 55 e4             	add    -0x1c(%ebp),%edx
80103ea0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103ea3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea7:	90                   	nop
80103ea8:	39 d0                	cmp    %edx,%eax
80103eaa:	73 15                	jae    80103ec1 <mpinit+0x101>
    switch(*p){
80103eac:	0f b6 08             	movzbl (%eax),%ecx
80103eaf:	80 f9 02             	cmp    $0x2,%cl
80103eb2:	74 4c                	je     80103f00 <mpinit+0x140>
80103eb4:	77 3a                	ja     80103ef0 <mpinit+0x130>
80103eb6:	84 c9                	test   %cl,%cl
80103eb8:	74 56                	je     80103f10 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103eba:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ebd:	39 d0                	cmp    %edx,%eax
80103ebf:	72 eb                	jb     80103eac <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103ec1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103ec4:	85 f6                	test   %esi,%esi
80103ec6:	0f 84 d9 00 00 00    	je     80103fa5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103ecc:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103ed0:	74 15                	je     80103ee7 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ed2:	b8 70 00 00 00       	mov    $0x70,%eax
80103ed7:	ba 22 00 00 00       	mov    $0x22,%edx
80103edc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103edd:	ba 23 00 00 00       	mov    $0x23,%edx
80103ee2:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103ee3:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ee6:	ee                   	out    %al,(%dx)
  }
}
80103ee7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103eea:	5b                   	pop    %ebx
80103eeb:	5e                   	pop    %esi
80103eec:	5f                   	pop    %edi
80103eed:	5d                   	pop    %ebp
80103eee:	c3                   	ret    
80103eef:	90                   	nop
    switch(*p){
80103ef0:	83 e9 03             	sub    $0x3,%ecx
80103ef3:	80 f9 01             	cmp    $0x1,%cl
80103ef6:	76 c2                	jbe    80103eba <mpinit+0xfa>
80103ef8:	31 f6                	xor    %esi,%esi
80103efa:	eb ac                	jmp    80103ea8 <mpinit+0xe8>
80103efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103f00:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103f04:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103f07:	88 0d 80 33 11 80    	mov    %cl,0x80113380
      continue;
80103f0d:	eb 99                	jmp    80103ea8 <mpinit+0xe8>
80103f0f:	90                   	nop
      if(ncpu < NCPU) {
80103f10:	8b 0d 84 33 11 80    	mov    0x80113384,%ecx
80103f16:	83 f9 07             	cmp    $0x7,%ecx
80103f19:	7f 19                	jg     80103f34 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f1b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103f21:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103f25:	83 c1 01             	add    $0x1,%ecx
80103f28:	89 0d 84 33 11 80    	mov    %ecx,0x80113384
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f2e:	88 9f a0 33 11 80    	mov    %bl,-0x7feecc60(%edi)
      p += sizeof(struct mpproc);
80103f34:	83 c0 14             	add    $0x14,%eax
      continue;
80103f37:	e9 6c ff ff ff       	jmp    80103ea8 <mpinit+0xe8>
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103f40:	83 ec 0c             	sub    $0xc,%esp
80103f43:	68 42 82 10 80       	push   $0x80108242
80103f48:	e8 33 c4 ff ff       	call   80100380 <panic>
80103f4d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103f50:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103f55:	eb 13                	jmp    80103f6a <mpinit+0x1aa>
80103f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f5e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103f60:	89 f3                	mov    %esi,%ebx
80103f62:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103f68:	74 d6                	je     80103f40 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f6a:	83 ec 04             	sub    $0x4,%esp
80103f6d:	8d 73 10             	lea    0x10(%ebx),%esi
80103f70:	6a 04                	push   $0x4
80103f72:	68 38 82 10 80       	push   $0x80108238
80103f77:	53                   	push   %ebx
80103f78:	e8 e3 12 00 00       	call   80105260 <memcmp>
80103f7d:	83 c4 10             	add    $0x10,%esp
80103f80:	85 c0                	test   %eax,%eax
80103f82:	75 dc                	jne    80103f60 <mpinit+0x1a0>
80103f84:	89 da                	mov    %ebx,%edx
80103f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f8d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103f90:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103f93:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103f96:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103f98:	39 d6                	cmp    %edx,%esi
80103f9a:	75 f4                	jne    80103f90 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f9c:	84 c0                	test   %al,%al
80103f9e:	75 c0                	jne    80103f60 <mpinit+0x1a0>
80103fa0:	e9 6b fe ff ff       	jmp    80103e10 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103fa5:	83 ec 0c             	sub    $0xc,%esp
80103fa8:	68 5c 82 10 80       	push   $0x8010825c
80103fad:	e8 ce c3 ff ff       	call   80100380 <panic>
80103fb2:	66 90                	xchg   %ax,%ax
80103fb4:	66 90                	xchg   %ax,%ax
80103fb6:	66 90                	xchg   %ax,%ax
80103fb8:	66 90                	xchg   %ax,%ax
80103fba:	66 90                	xchg   %ax,%ax
80103fbc:	66 90                	xchg   %ax,%ax
80103fbe:	66 90                	xchg   %ax,%ax

80103fc0 <picinit>:
80103fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fc5:	ba 21 00 00 00       	mov    $0x21,%edx
80103fca:	ee                   	out    %al,(%dx)
80103fcb:	ba a1 00 00 00       	mov    $0xa1,%edx
80103fd0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103fd1:	c3                   	ret    
80103fd2:	66 90                	xchg   %ax,%ax
80103fd4:	66 90                	xchg   %ax,%ax
80103fd6:	66 90                	xchg   %ax,%ax
80103fd8:	66 90                	xchg   %ax,%ax
80103fda:	66 90                	xchg   %ax,%ax
80103fdc:	66 90                	xchg   %ax,%ax
80103fde:	66 90                	xchg   %ax,%ax

80103fe0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	57                   	push   %edi
80103fe4:	56                   	push   %esi
80103fe5:	53                   	push   %ebx
80103fe6:	83 ec 0c             	sub    $0xc,%esp
80103fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103fec:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103fef:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103ff5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103ffb:	e8 e0 d9 ff ff       	call   801019e0 <filealloc>
80104000:	89 03                	mov    %eax,(%ebx)
80104002:	85 c0                	test   %eax,%eax
80104004:	0f 84 a8 00 00 00    	je     801040b2 <pipealloc+0xd2>
8010400a:	e8 d1 d9 ff ff       	call   801019e0 <filealloc>
8010400f:	89 06                	mov    %eax,(%esi)
80104011:	85 c0                	test   %eax,%eax
80104013:	0f 84 87 00 00 00    	je     801040a0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104019:	e8 12 f2 ff ff       	call   80103230 <kalloc>
8010401e:	89 c7                	mov    %eax,%edi
80104020:	85 c0                	test   %eax,%eax
80104022:	0f 84 b0 00 00 00    	je     801040d8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80104028:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010402f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104032:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104035:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010403c:	00 00 00 
  p->nwrite = 0;
8010403f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104046:	00 00 00 
  p->nread = 0;
80104049:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104050:	00 00 00 
  initlock(&p->lock, "pipe");
80104053:	68 7b 82 10 80       	push   $0x8010827b
80104058:	50                   	push   %eax
80104059:	e8 22 0f 00 00       	call   80104f80 <initlock>
  (*f0)->type = FD_PIPE;
8010405e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104060:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104063:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104069:	8b 03                	mov    (%ebx),%eax
8010406b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010406f:	8b 03                	mov    (%ebx),%eax
80104071:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104075:	8b 03                	mov    (%ebx),%eax
80104077:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010407a:	8b 06                	mov    (%esi),%eax
8010407c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104082:	8b 06                	mov    (%esi),%eax
80104084:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104088:	8b 06                	mov    (%esi),%eax
8010408a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010408e:	8b 06                	mov    (%esi),%eax
80104090:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104093:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80104096:	31 c0                	xor    %eax,%eax
}
80104098:	5b                   	pop    %ebx
80104099:	5e                   	pop    %esi
8010409a:	5f                   	pop    %edi
8010409b:	5d                   	pop    %ebp
8010409c:	c3                   	ret    
8010409d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801040a0:	8b 03                	mov    (%ebx),%eax
801040a2:	85 c0                	test   %eax,%eax
801040a4:	74 1e                	je     801040c4 <pipealloc+0xe4>
    fileclose(*f0);
801040a6:	83 ec 0c             	sub    $0xc,%esp
801040a9:	50                   	push   %eax
801040aa:	e8 f1 d9 ff ff       	call   80101aa0 <fileclose>
801040af:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801040b2:	8b 06                	mov    (%esi),%eax
801040b4:	85 c0                	test   %eax,%eax
801040b6:	74 0c                	je     801040c4 <pipealloc+0xe4>
    fileclose(*f1);
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	50                   	push   %eax
801040bc:	e8 df d9 ff ff       	call   80101aa0 <fileclose>
801040c1:	83 c4 10             	add    $0x10,%esp
}
801040c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801040c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040cc:	5b                   	pop    %ebx
801040cd:	5e                   	pop    %esi
801040ce:	5f                   	pop    %edi
801040cf:	5d                   	pop    %ebp
801040d0:	c3                   	ret    
801040d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801040d8:	8b 03                	mov    (%ebx),%eax
801040da:	85 c0                	test   %eax,%eax
801040dc:	75 c8                	jne    801040a6 <pipealloc+0xc6>
801040de:	eb d2                	jmp    801040b2 <pipealloc+0xd2>

801040e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
801040e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801040e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801040eb:	83 ec 0c             	sub    $0xc,%esp
801040ee:	53                   	push   %ebx
801040ef:	e8 5c 10 00 00       	call   80105150 <acquire>
  if(writable){
801040f4:	83 c4 10             	add    $0x10,%esp
801040f7:	85 f6                	test   %esi,%esi
801040f9:	74 65                	je     80104160 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801040fb:	83 ec 0c             	sub    $0xc,%esp
801040fe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104104:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010410b:	00 00 00 
    wakeup(&p->nread);
8010410e:	50                   	push   %eax
8010410f:	e8 9c 0b 00 00       	call   80104cb0 <wakeup>
80104114:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104117:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010411d:	85 d2                	test   %edx,%edx
8010411f:	75 0a                	jne    8010412b <pipeclose+0x4b>
80104121:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104127:	85 c0                	test   %eax,%eax
80104129:	74 15                	je     80104140 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010412b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010412e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104131:	5b                   	pop    %ebx
80104132:	5e                   	pop    %esi
80104133:	5d                   	pop    %ebp
    release(&p->lock);
80104134:	e9 b7 0f 00 00       	jmp    801050f0 <release>
80104139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104140:	83 ec 0c             	sub    $0xc,%esp
80104143:	53                   	push   %ebx
80104144:	e8 a7 0f 00 00       	call   801050f0 <release>
    kfree((char*)p);
80104149:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010414c:	83 c4 10             	add    $0x10,%esp
}
8010414f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104152:	5b                   	pop    %ebx
80104153:	5e                   	pop    %esi
80104154:	5d                   	pop    %ebp
    kfree((char*)p);
80104155:	e9 16 ef ff ff       	jmp    80103070 <kfree>
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104160:	83 ec 0c             	sub    $0xc,%esp
80104163:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104169:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104170:	00 00 00 
    wakeup(&p->nwrite);
80104173:	50                   	push   %eax
80104174:	e8 37 0b 00 00       	call   80104cb0 <wakeup>
80104179:	83 c4 10             	add    $0x10,%esp
8010417c:	eb 99                	jmp    80104117 <pipeclose+0x37>
8010417e:	66 90                	xchg   %ax,%ax

80104180 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	57                   	push   %edi
80104184:	56                   	push   %esi
80104185:	53                   	push   %ebx
80104186:	83 ec 28             	sub    $0x28,%esp
80104189:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010418c:	53                   	push   %ebx
8010418d:	e8 be 0f 00 00       	call   80105150 <acquire>
  for(i = 0; i < n; i++){
80104192:	8b 45 10             	mov    0x10(%ebp),%eax
80104195:	83 c4 10             	add    $0x10,%esp
80104198:	85 c0                	test   %eax,%eax
8010419a:	0f 8e c0 00 00 00    	jle    80104260 <pipewrite+0xe0>
801041a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041a3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801041a9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801041af:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801041b2:	03 45 10             	add    0x10(%ebp),%eax
801041b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041b8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041be:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041c4:	89 ca                	mov    %ecx,%edx
801041c6:	05 00 02 00 00       	add    $0x200,%eax
801041cb:	39 c1                	cmp    %eax,%ecx
801041cd:	74 3f                	je     8010420e <pipewrite+0x8e>
801041cf:	eb 67                	jmp    80104238 <pipewrite+0xb8>
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801041d8:	e8 43 03 00 00       	call   80104520 <myproc>
801041dd:	8b 48 24             	mov    0x24(%eax),%ecx
801041e0:	85 c9                	test   %ecx,%ecx
801041e2:	75 34                	jne    80104218 <pipewrite+0x98>
      wakeup(&p->nread);
801041e4:	83 ec 0c             	sub    $0xc,%esp
801041e7:	57                   	push   %edi
801041e8:	e8 c3 0a 00 00       	call   80104cb0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041ed:	58                   	pop    %eax
801041ee:	5a                   	pop    %edx
801041ef:	53                   	push   %ebx
801041f0:	56                   	push   %esi
801041f1:	e8 fa 09 00 00       	call   80104bf0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041f6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801041fc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80104202:	83 c4 10             	add    $0x10,%esp
80104205:	05 00 02 00 00       	add    $0x200,%eax
8010420a:	39 c2                	cmp    %eax,%edx
8010420c:	75 2a                	jne    80104238 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010420e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80104214:	85 c0                	test   %eax,%eax
80104216:	75 c0                	jne    801041d8 <pipewrite+0x58>
        release(&p->lock);
80104218:	83 ec 0c             	sub    $0xc,%esp
8010421b:	53                   	push   %ebx
8010421c:	e8 cf 0e 00 00       	call   801050f0 <release>
        return -1;
80104221:	83 c4 10             	add    $0x10,%esp
80104224:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104229:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010422c:	5b                   	pop    %ebx
8010422d:	5e                   	pop    %esi
8010422e:	5f                   	pop    %edi
8010422f:	5d                   	pop    %ebp
80104230:	c3                   	ret    
80104231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104238:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010423b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010423e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104244:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010424a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010424d:	83 c6 01             	add    $0x1,%esi
80104250:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104253:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104257:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010425a:	0f 85 58 ff ff ff    	jne    801041b8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104260:	83 ec 0c             	sub    $0xc,%esp
80104263:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104269:	50                   	push   %eax
8010426a:	e8 41 0a 00 00       	call   80104cb0 <wakeup>
  release(&p->lock);
8010426f:	89 1c 24             	mov    %ebx,(%esp)
80104272:	e8 79 0e 00 00       	call   801050f0 <release>
  return n;
80104277:	8b 45 10             	mov    0x10(%ebp),%eax
8010427a:	83 c4 10             	add    $0x10,%esp
8010427d:	eb aa                	jmp    80104229 <pipewrite+0xa9>
8010427f:	90                   	nop

80104280 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	57                   	push   %edi
80104284:	56                   	push   %esi
80104285:	53                   	push   %ebx
80104286:	83 ec 18             	sub    $0x18,%esp
80104289:	8b 75 08             	mov    0x8(%ebp),%esi
8010428c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010428f:	56                   	push   %esi
80104290:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80104296:	e8 b5 0e 00 00       	call   80105150 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010429b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801042a1:	83 c4 10             	add    $0x10,%esp
801042a4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801042aa:	74 2f                	je     801042db <piperead+0x5b>
801042ac:	eb 37                	jmp    801042e5 <piperead+0x65>
801042ae:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801042b0:	e8 6b 02 00 00       	call   80104520 <myproc>
801042b5:	8b 48 24             	mov    0x24(%eax),%ecx
801042b8:	85 c9                	test   %ecx,%ecx
801042ba:	0f 85 80 00 00 00    	jne    80104340 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801042c0:	83 ec 08             	sub    $0x8,%esp
801042c3:	56                   	push   %esi
801042c4:	53                   	push   %ebx
801042c5:	e8 26 09 00 00       	call   80104bf0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801042ca:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
801042d0:	83 c4 10             	add    $0x10,%esp
801042d3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
801042d9:	75 0a                	jne    801042e5 <piperead+0x65>
801042db:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
801042e1:	85 c0                	test   %eax,%eax
801042e3:	75 cb                	jne    801042b0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042e5:	8b 55 10             	mov    0x10(%ebp),%edx
801042e8:	31 db                	xor    %ebx,%ebx
801042ea:	85 d2                	test   %edx,%edx
801042ec:	7f 20                	jg     8010430e <piperead+0x8e>
801042ee:	eb 2c                	jmp    8010431c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801042f0:	8d 48 01             	lea    0x1(%eax),%ecx
801042f3:	25 ff 01 00 00       	and    $0x1ff,%eax
801042f8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801042fe:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104303:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104306:	83 c3 01             	add    $0x1,%ebx
80104309:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010430c:	74 0e                	je     8010431c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010430e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104314:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010431a:	75 d4                	jne    801042f0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010431c:	83 ec 0c             	sub    $0xc,%esp
8010431f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104325:	50                   	push   %eax
80104326:	e8 85 09 00 00       	call   80104cb0 <wakeup>
  release(&p->lock);
8010432b:	89 34 24             	mov    %esi,(%esp)
8010432e:	e8 bd 0d 00 00       	call   801050f0 <release>
  return i;
80104333:	83 c4 10             	add    $0x10,%esp
}
80104336:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104339:	89 d8                	mov    %ebx,%eax
8010433b:	5b                   	pop    %ebx
8010433c:	5e                   	pop    %esi
8010433d:	5f                   	pop    %edi
8010433e:	5d                   	pop    %ebp
8010433f:	c3                   	ret    
      release(&p->lock);
80104340:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104343:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104348:	56                   	push   %esi
80104349:	e8 a2 0d 00 00       	call   801050f0 <release>
      return -1;
8010434e:	83 c4 10             	add    $0x10,%esp
}
80104351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104354:	89 d8                	mov    %ebx,%eax
80104356:	5b                   	pop    %ebx
80104357:	5e                   	pop    %esi
80104358:	5f                   	pop    %edi
80104359:	5d                   	pop    %ebp
8010435a:	c3                   	ret    
8010435b:	66 90                	xchg   %ax,%ax
8010435d:	66 90                	xchg   %ax,%ax
8010435f:	90                   	nop

80104360 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104364:	bb 54 39 11 80       	mov    $0x80113954,%ebx
{
80104369:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010436c:	68 20 39 11 80       	push   $0x80113920
80104371:	e8 da 0d 00 00       	call   80105150 <acquire>
80104376:	83 c4 10             	add    $0x10,%esp
80104379:	eb 10                	jmp    8010438b <allocproc+0x2b>
8010437b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010437f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104380:	83 c3 7c             	add    $0x7c,%ebx
80104383:	81 fb 54 58 11 80    	cmp    $0x80115854,%ebx
80104389:	74 75                	je     80104400 <allocproc+0xa0>
    if(p->state == UNUSED)
8010438b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010438e:	85 c0                	test   %eax,%eax
80104390:	75 ee                	jne    80104380 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104392:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80104397:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
8010439a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801043a1:	89 43 10             	mov    %eax,0x10(%ebx)
801043a4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801043a7:	68 20 39 11 80       	push   $0x80113920
  p->pid = nextpid++;
801043ac:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
801043b2:	e8 39 0d 00 00       	call   801050f0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043b7:	e8 74 ee ff ff       	call   80103230 <kalloc>
801043bc:	83 c4 10             	add    $0x10,%esp
801043bf:	89 43 08             	mov    %eax,0x8(%ebx)
801043c2:	85 c0                	test   %eax,%eax
801043c4:	74 53                	je     80104419 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043c6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801043cc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801043cf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801043d4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801043d7:	c7 40 14 02 64 10 80 	movl   $0x80106402,0x14(%eax)
  p->context = (struct context*)sp;
801043de:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801043e1:	6a 14                	push   $0x14
801043e3:	6a 00                	push   $0x0
801043e5:	50                   	push   %eax
801043e6:	e8 25 0e 00 00       	call   80105210 <memset>
  p->context->eip = (uint)forkret;
801043eb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801043ee:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
801043f1:	c7 40 10 30 44 10 80 	movl   $0x80104430,0x10(%eax)
}
801043f8:	89 d8                	mov    %ebx,%eax
801043fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043fd:	c9                   	leave  
801043fe:	c3                   	ret    
801043ff:	90                   	nop
  release(&ptable.lock);
80104400:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104403:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104405:	68 20 39 11 80       	push   $0x80113920
8010440a:	e8 e1 0c 00 00       	call   801050f0 <release>
}
8010440f:	89 d8                	mov    %ebx,%eax
  return 0;
80104411:	83 c4 10             	add    $0x10,%esp
}
80104414:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104417:	c9                   	leave  
80104418:	c3                   	ret    
    p->state = UNUSED;
80104419:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104420:	31 db                	xor    %ebx,%ebx
}
80104422:	89 d8                	mov    %ebx,%eax
80104424:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104427:	c9                   	leave  
80104428:	c3                   	ret    
80104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104430 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104436:	68 20 39 11 80       	push   $0x80113920
8010443b:	e8 b0 0c 00 00       	call   801050f0 <release>

  if (first) {
80104440:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104445:	83 c4 10             	add    $0x10,%esp
80104448:	85 c0                	test   %eax,%eax
8010444a:	75 04                	jne    80104450 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010444c:	c9                   	leave  
8010444d:	c3                   	ret    
8010444e:	66 90                	xchg   %ax,%ax
    first = 0;
80104450:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104457:	00 00 00 
    iinit(ROOTDEV);
8010445a:	83 ec 0c             	sub    $0xc,%esp
8010445d:	6a 01                	push   $0x1
8010445f:	e8 ac dc ff ff       	call   80102110 <iinit>
    initlog(ROOTDEV);
80104464:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010446b:	e8 00 f4 ff ff       	call   80103870 <initlog>
}
80104470:	83 c4 10             	add    $0x10,%esp
80104473:	c9                   	leave  
80104474:	c3                   	ret    
80104475:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104480 <pinit>:
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104486:	68 80 82 10 80       	push   $0x80108280
8010448b:	68 20 39 11 80       	push   $0x80113920
80104490:	e8 eb 0a 00 00       	call   80104f80 <initlock>
}
80104495:	83 c4 10             	add    $0x10,%esp
80104498:	c9                   	leave  
80104499:	c3                   	ret    
8010449a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044a0 <mycpu>:
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044a5:	9c                   	pushf  
801044a6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801044a7:	f6 c4 02             	test   $0x2,%ah
801044aa:	75 46                	jne    801044f2 <mycpu+0x52>
  apicid = lapicid();
801044ac:	e8 ef ef ff ff       	call   801034a0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801044b1:	8b 35 84 33 11 80    	mov    0x80113384,%esi
801044b7:	85 f6                	test   %esi,%esi
801044b9:	7e 2a                	jle    801044e5 <mycpu+0x45>
801044bb:	31 d2                	xor    %edx,%edx
801044bd:	eb 08                	jmp    801044c7 <mycpu+0x27>
801044bf:	90                   	nop
801044c0:	83 c2 01             	add    $0x1,%edx
801044c3:	39 f2                	cmp    %esi,%edx
801044c5:	74 1e                	je     801044e5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801044c7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801044cd:	0f b6 99 a0 33 11 80 	movzbl -0x7feecc60(%ecx),%ebx
801044d4:	39 c3                	cmp    %eax,%ebx
801044d6:	75 e8                	jne    801044c0 <mycpu+0x20>
}
801044d8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801044db:	8d 81 a0 33 11 80    	lea    -0x7feecc60(%ecx),%eax
}
801044e1:	5b                   	pop    %ebx
801044e2:	5e                   	pop    %esi
801044e3:	5d                   	pop    %ebp
801044e4:	c3                   	ret    
  panic("unknown apicid\n");
801044e5:	83 ec 0c             	sub    $0xc,%esp
801044e8:	68 87 82 10 80       	push   $0x80108287
801044ed:	e8 8e be ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
801044f2:	83 ec 0c             	sub    $0xc,%esp
801044f5:	68 64 83 10 80       	push   $0x80108364
801044fa:	e8 81 be ff ff       	call   80100380 <panic>
801044ff:	90                   	nop

80104500 <cpuid>:
cpuid() {
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104506:	e8 95 ff ff ff       	call   801044a0 <mycpu>
}
8010450b:	c9                   	leave  
  return mycpu()-cpus;
8010450c:	2d a0 33 11 80       	sub    $0x801133a0,%eax
80104511:	c1 f8 04             	sar    $0x4,%eax
80104514:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010451a:	c3                   	ret    
8010451b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop

80104520 <myproc>:
myproc(void) {
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	53                   	push   %ebx
80104524:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104527:	e8 d4 0a 00 00       	call   80105000 <pushcli>
  c = mycpu();
8010452c:	e8 6f ff ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104531:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104537:	e8 14 0b 00 00       	call   80105050 <popcli>
}
8010453c:	89 d8                	mov    %ebx,%eax
8010453e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104541:	c9                   	leave  
80104542:	c3                   	ret    
80104543:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104550 <userinit>:
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104557:	e8 04 fe ff ff       	call   80104360 <allocproc>
8010455c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010455e:	a3 54 58 11 80       	mov    %eax,0x80115854
  if((p->pgdir = setupkvm()) == 0)
80104563:	e8 88 34 00 00       	call   801079f0 <setupkvm>
80104568:	89 43 04             	mov    %eax,0x4(%ebx)
8010456b:	85 c0                	test   %eax,%eax
8010456d:	0f 84 bd 00 00 00    	je     80104630 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104573:	83 ec 04             	sub    $0x4,%esp
80104576:	68 2c 00 00 00       	push   $0x2c
8010457b:	68 60 b4 10 80       	push   $0x8010b460
80104580:	50                   	push   %eax
80104581:	e8 1a 31 00 00       	call   801076a0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104586:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104589:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010458f:	6a 4c                	push   $0x4c
80104591:	6a 00                	push   $0x0
80104593:	ff 73 18             	push   0x18(%ebx)
80104596:	e8 75 0c 00 00       	call   80105210 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010459b:	8b 43 18             	mov    0x18(%ebx),%eax
8010459e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801045a3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045a6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045ab:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045af:	8b 43 18             	mov    0x18(%ebx),%eax
801045b2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801045b6:	8b 43 18             	mov    0x18(%ebx),%eax
801045b9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045bd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801045c1:	8b 43 18             	mov    0x18(%ebx),%eax
801045c4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045c8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801045cc:	8b 43 18             	mov    0x18(%ebx),%eax
801045cf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801045d6:	8b 43 18             	mov    0x18(%ebx),%eax
801045d9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801045e0:	8b 43 18             	mov    0x18(%ebx),%eax
801045e3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801045ea:	8d 43 6c             	lea    0x6c(%ebx),%eax
801045ed:	6a 10                	push   $0x10
801045ef:	68 b0 82 10 80       	push   $0x801082b0
801045f4:	50                   	push   %eax
801045f5:	e8 d6 0d 00 00       	call   801053d0 <safestrcpy>
  p->cwd = namei("/");
801045fa:	c7 04 24 b9 82 10 80 	movl   $0x801082b9,(%esp)
80104601:	e8 4a e6 ff ff       	call   80102c50 <namei>
80104606:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104609:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104610:	e8 3b 0b 00 00       	call   80105150 <acquire>
  p->state = RUNNABLE;
80104615:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010461c:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104623:	e8 c8 0a 00 00       	call   801050f0 <release>
}
80104628:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010462b:	83 c4 10             	add    $0x10,%esp
8010462e:	c9                   	leave  
8010462f:	c3                   	ret    
    panic("userinit: out of memory?");
80104630:	83 ec 0c             	sub    $0xc,%esp
80104633:	68 97 82 10 80       	push   $0x80108297
80104638:	e8 43 bd ff ff       	call   80100380 <panic>
8010463d:	8d 76 00             	lea    0x0(%esi),%esi

80104640 <growproc>:
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
80104645:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104648:	e8 b3 09 00 00       	call   80105000 <pushcli>
  c = mycpu();
8010464d:	e8 4e fe ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104652:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104658:	e8 f3 09 00 00       	call   80105050 <popcli>
  sz = curproc->sz;
8010465d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
8010465f:	85 f6                	test   %esi,%esi
80104661:	7f 1d                	jg     80104680 <growproc+0x40>
  } else if(n < 0){
80104663:	75 3b                	jne    801046a0 <growproc+0x60>
  switchuvm(curproc);
80104665:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104668:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010466a:	53                   	push   %ebx
8010466b:	e8 20 2f 00 00       	call   80107590 <switchuvm>
  return 0;
80104670:	83 c4 10             	add    $0x10,%esp
80104673:	31 c0                	xor    %eax,%eax
}
80104675:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104678:	5b                   	pop    %ebx
80104679:	5e                   	pop    %esi
8010467a:	5d                   	pop    %ebp
8010467b:	c3                   	ret    
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104680:	83 ec 04             	sub    $0x4,%esp
80104683:	01 c6                	add    %eax,%esi
80104685:	56                   	push   %esi
80104686:	50                   	push   %eax
80104687:	ff 73 04             	push   0x4(%ebx)
8010468a:	e8 81 31 00 00       	call   80107810 <allocuvm>
8010468f:	83 c4 10             	add    $0x10,%esp
80104692:	85 c0                	test   %eax,%eax
80104694:	75 cf                	jne    80104665 <growproc+0x25>
      return -1;
80104696:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010469b:	eb d8                	jmp    80104675 <growproc+0x35>
8010469d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801046a0:	83 ec 04             	sub    $0x4,%esp
801046a3:	01 c6                	add    %eax,%esi
801046a5:	56                   	push   %esi
801046a6:	50                   	push   %eax
801046a7:	ff 73 04             	push   0x4(%ebx)
801046aa:	e8 91 32 00 00       	call   80107940 <deallocuvm>
801046af:	83 c4 10             	add    $0x10,%esp
801046b2:	85 c0                	test   %eax,%eax
801046b4:	75 af                	jne    80104665 <growproc+0x25>
801046b6:	eb de                	jmp    80104696 <growproc+0x56>
801046b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046bf:	90                   	nop

801046c0 <fork>:
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	57                   	push   %edi
801046c4:	56                   	push   %esi
801046c5:	53                   	push   %ebx
801046c6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801046c9:	e8 32 09 00 00       	call   80105000 <pushcli>
  c = mycpu();
801046ce:	e8 cd fd ff ff       	call   801044a0 <mycpu>
  p = c->proc;
801046d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046d9:	e8 72 09 00 00       	call   80105050 <popcli>
  if((np = allocproc()) == 0){
801046de:	e8 7d fc ff ff       	call   80104360 <allocproc>
801046e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801046e6:	85 c0                	test   %eax,%eax
801046e8:	0f 84 b7 00 00 00    	je     801047a5 <fork+0xe5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801046ee:	83 ec 08             	sub    $0x8,%esp
801046f1:	ff 33                	push   (%ebx)
801046f3:	89 c7                	mov    %eax,%edi
801046f5:	ff 73 04             	push   0x4(%ebx)
801046f8:	e8 e3 33 00 00       	call   80107ae0 <copyuvm>
801046fd:	83 c4 10             	add    $0x10,%esp
80104700:	89 47 04             	mov    %eax,0x4(%edi)
80104703:	85 c0                	test   %eax,%eax
80104705:	0f 84 a1 00 00 00    	je     801047ac <fork+0xec>
  np->sz = curproc->sz;
8010470b:	8b 03                	mov    (%ebx),%eax
8010470d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104710:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104712:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104715:	89 c8                	mov    %ecx,%eax
80104717:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010471a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010471f:	8b 73 18             	mov    0x18(%ebx),%esi
80104722:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104724:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104726:	8b 40 18             	mov    0x18(%eax),%eax
80104729:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104730:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104734:	85 c0                	test   %eax,%eax
80104736:	74 13                	je     8010474b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	50                   	push   %eax
8010473c:	e8 0f d3 ff ff       	call   80101a50 <filedup>
80104741:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104744:	83 c4 10             	add    $0x10,%esp
80104747:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010474b:	83 c6 01             	add    $0x1,%esi
8010474e:	83 fe 10             	cmp    $0x10,%esi
80104751:	75 dd                	jne    80104730 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104753:	83 ec 0c             	sub    $0xc,%esp
80104756:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104759:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010475c:	e8 9f db ff ff       	call   80102300 <idup>
80104761:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104764:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104767:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010476a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010476d:	6a 10                	push   $0x10
8010476f:	53                   	push   %ebx
80104770:	50                   	push   %eax
80104771:	e8 5a 0c 00 00       	call   801053d0 <safestrcpy>
  pid = np->pid;
80104776:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104779:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104780:	e8 cb 09 00 00       	call   80105150 <acquire>
  np->state = RUNNABLE;
80104785:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010478c:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104793:	e8 58 09 00 00       	call   801050f0 <release>
  return pid;
80104798:	83 c4 10             	add    $0x10,%esp
}
8010479b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010479e:	89 d8                	mov    %ebx,%eax
801047a0:	5b                   	pop    %ebx
801047a1:	5e                   	pop    %esi
801047a2:	5f                   	pop    %edi
801047a3:	5d                   	pop    %ebp
801047a4:	c3                   	ret    
    return -1;
801047a5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801047aa:	eb ef                	jmp    8010479b <fork+0xdb>
    kfree(np->kstack);
801047ac:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801047af:	83 ec 0c             	sub    $0xc,%esp
801047b2:	ff 73 08             	push   0x8(%ebx)
801047b5:	e8 b6 e8 ff ff       	call   80103070 <kfree>
    np->kstack = 0;
801047ba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801047c1:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801047c4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801047cb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801047d0:	eb c9                	jmp    8010479b <fork+0xdb>
801047d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047e0 <scheduler>:
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	53                   	push   %ebx
801047e6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801047e9:	e8 b2 fc ff ff       	call   801044a0 <mycpu>
  c->proc = 0;
801047ee:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801047f5:	00 00 00 
  struct cpu *c = mycpu();
801047f8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801047fa:	8d 78 04             	lea    0x4(%eax),%edi
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104800:	fb                   	sti    
    acquire(&ptable.lock);
80104801:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104804:	bb 54 39 11 80       	mov    $0x80113954,%ebx
    acquire(&ptable.lock);
80104809:	68 20 39 11 80       	push   $0x80113920
8010480e:	e8 3d 09 00 00       	call   80105150 <acquire>
80104813:	83 c4 10             	add    $0x10,%esp
80104816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010481d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80104820:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104824:	75 33                	jne    80104859 <scheduler+0x79>
      switchuvm(p);
80104826:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104829:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010482f:	53                   	push   %ebx
80104830:	e8 5b 2d 00 00       	call   80107590 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104835:	58                   	pop    %eax
80104836:	5a                   	pop    %edx
80104837:	ff 73 1c             	push   0x1c(%ebx)
8010483a:	57                   	push   %edi
      p->state = RUNNING;
8010483b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104842:	e8 e4 0b 00 00       	call   8010542b <swtch>
      switchkvm();
80104847:	e8 34 2d 00 00       	call   80107580 <switchkvm>
      c->proc = 0;
8010484c:	83 c4 10             	add    $0x10,%esp
8010484f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104856:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104859:	83 c3 7c             	add    $0x7c,%ebx
8010485c:	81 fb 54 58 11 80    	cmp    $0x80115854,%ebx
80104862:	75 bc                	jne    80104820 <scheduler+0x40>
    release(&ptable.lock);
80104864:	83 ec 0c             	sub    $0xc,%esp
80104867:	68 20 39 11 80       	push   $0x80113920
8010486c:	e8 7f 08 00 00       	call   801050f0 <release>
    sti();
80104871:	83 c4 10             	add    $0x10,%esp
80104874:	eb 8a                	jmp    80104800 <scheduler+0x20>
80104876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010487d:	8d 76 00             	lea    0x0(%esi),%esi

80104880 <sched>:
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	53                   	push   %ebx
  pushcli();
80104885:	e8 76 07 00 00       	call   80105000 <pushcli>
  c = mycpu();
8010488a:	e8 11 fc ff ff       	call   801044a0 <mycpu>
  p = c->proc;
8010488f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104895:	e8 b6 07 00 00       	call   80105050 <popcli>
  if(!holding(&ptable.lock))
8010489a:	83 ec 0c             	sub    $0xc,%esp
8010489d:	68 20 39 11 80       	push   $0x80113920
801048a2:	e8 09 08 00 00       	call   801050b0 <holding>
801048a7:	83 c4 10             	add    $0x10,%esp
801048aa:	85 c0                	test   %eax,%eax
801048ac:	74 4f                	je     801048fd <sched+0x7d>
  if(mycpu()->ncli != 1)
801048ae:	e8 ed fb ff ff       	call   801044a0 <mycpu>
801048b3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801048ba:	75 68                	jne    80104924 <sched+0xa4>
  if(p->state == RUNNING)
801048bc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801048c0:	74 55                	je     80104917 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801048c2:	9c                   	pushf  
801048c3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801048c4:	f6 c4 02             	test   $0x2,%ah
801048c7:	75 41                	jne    8010490a <sched+0x8a>
  intena = mycpu()->intena;
801048c9:	e8 d2 fb ff ff       	call   801044a0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801048ce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801048d1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801048d7:	e8 c4 fb ff ff       	call   801044a0 <mycpu>
801048dc:	83 ec 08             	sub    $0x8,%esp
801048df:	ff 70 04             	push   0x4(%eax)
801048e2:	53                   	push   %ebx
801048e3:	e8 43 0b 00 00       	call   8010542b <swtch>
  mycpu()->intena = intena;
801048e8:	e8 b3 fb ff ff       	call   801044a0 <mycpu>
}
801048ed:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801048f0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801048f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f9:	5b                   	pop    %ebx
801048fa:	5e                   	pop    %esi
801048fb:	5d                   	pop    %ebp
801048fc:	c3                   	ret    
    panic("sched ptable.lock");
801048fd:	83 ec 0c             	sub    $0xc,%esp
80104900:	68 bb 82 10 80       	push   $0x801082bb
80104905:	e8 76 ba ff ff       	call   80100380 <panic>
    panic("sched interruptible");
8010490a:	83 ec 0c             	sub    $0xc,%esp
8010490d:	68 e7 82 10 80       	push   $0x801082e7
80104912:	e8 69 ba ff ff       	call   80100380 <panic>
    panic("sched running");
80104917:	83 ec 0c             	sub    $0xc,%esp
8010491a:	68 d9 82 10 80       	push   $0x801082d9
8010491f:	e8 5c ba ff ff       	call   80100380 <panic>
    panic("sched locks");
80104924:	83 ec 0c             	sub    $0xc,%esp
80104927:	68 cd 82 10 80       	push   $0x801082cd
8010492c:	e8 4f ba ff ff       	call   80100380 <panic>
80104931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010493f:	90                   	nop

80104940 <exit>:
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	57                   	push   %edi
80104944:	56                   	push   %esi
80104945:	53                   	push   %ebx
80104946:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104949:	e8 d2 fb ff ff       	call   80104520 <myproc>
  if(curproc == initproc)
8010494e:	39 05 54 58 11 80    	cmp    %eax,0x80115854
80104954:	0f 84 fd 00 00 00    	je     80104a57 <exit+0x117>
8010495a:	89 c3                	mov    %eax,%ebx
8010495c:	8d 70 28             	lea    0x28(%eax),%esi
8010495f:	8d 78 68             	lea    0x68(%eax),%edi
80104962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104968:	8b 06                	mov    (%esi),%eax
8010496a:	85 c0                	test   %eax,%eax
8010496c:	74 12                	je     80104980 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010496e:	83 ec 0c             	sub    $0xc,%esp
80104971:	50                   	push   %eax
80104972:	e8 29 d1 ff ff       	call   80101aa0 <fileclose>
      curproc->ofile[fd] = 0;
80104977:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010497d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104980:	83 c6 04             	add    $0x4,%esi
80104983:	39 f7                	cmp    %esi,%edi
80104985:	75 e1                	jne    80104968 <exit+0x28>
  begin_op();
80104987:	e8 84 ef ff ff       	call   80103910 <begin_op>
  iput(curproc->cwd);
8010498c:	83 ec 0c             	sub    $0xc,%esp
8010498f:	ff 73 68             	push   0x68(%ebx)
80104992:	e8 c9 da ff ff       	call   80102460 <iput>
  end_op();
80104997:	e8 e4 ef ff ff       	call   80103980 <end_op>
  curproc->cwd = 0;
8010499c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
801049a3:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
801049aa:	e8 a1 07 00 00       	call   80105150 <acquire>
  wakeup1(curproc->parent);
801049af:	8b 53 14             	mov    0x14(%ebx),%edx
801049b2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049b5:	b8 54 39 11 80       	mov    $0x80113954,%eax
801049ba:	eb 0e                	jmp    801049ca <exit+0x8a>
801049bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049c0:	83 c0 7c             	add    $0x7c,%eax
801049c3:	3d 54 58 11 80       	cmp    $0x80115854,%eax
801049c8:	74 1c                	je     801049e6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
801049ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801049ce:	75 f0                	jne    801049c0 <exit+0x80>
801049d0:	3b 50 20             	cmp    0x20(%eax),%edx
801049d3:	75 eb                	jne    801049c0 <exit+0x80>
      p->state = RUNNABLE;
801049d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049dc:	83 c0 7c             	add    $0x7c,%eax
801049df:	3d 54 58 11 80       	cmp    $0x80115854,%eax
801049e4:	75 e4                	jne    801049ca <exit+0x8a>
      p->parent = initproc;
801049e6:	8b 0d 54 58 11 80    	mov    0x80115854,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049ec:	ba 54 39 11 80       	mov    $0x80113954,%edx
801049f1:	eb 10                	jmp    80104a03 <exit+0xc3>
801049f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f7:	90                   	nop
801049f8:	83 c2 7c             	add    $0x7c,%edx
801049fb:	81 fa 54 58 11 80    	cmp    $0x80115854,%edx
80104a01:	74 3b                	je     80104a3e <exit+0xfe>
    if(p->parent == curproc){
80104a03:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104a06:	75 f0                	jne    801049f8 <exit+0xb8>
      if(p->state == ZOMBIE)
80104a08:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104a0c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104a0f:	75 e7                	jne    801049f8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a11:	b8 54 39 11 80       	mov    $0x80113954,%eax
80104a16:	eb 12                	jmp    80104a2a <exit+0xea>
80104a18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a1f:	90                   	nop
80104a20:	83 c0 7c             	add    $0x7c,%eax
80104a23:	3d 54 58 11 80       	cmp    $0x80115854,%eax
80104a28:	74 ce                	je     801049f8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80104a2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a2e:	75 f0                	jne    80104a20 <exit+0xe0>
80104a30:	3b 48 20             	cmp    0x20(%eax),%ecx
80104a33:	75 eb                	jne    80104a20 <exit+0xe0>
      p->state = RUNNABLE;
80104a35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104a3c:	eb e2                	jmp    80104a20 <exit+0xe0>
  curproc->state = ZOMBIE;
80104a3e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104a45:	e8 36 fe ff ff       	call   80104880 <sched>
  panic("zombie exit");
80104a4a:	83 ec 0c             	sub    $0xc,%esp
80104a4d:	68 08 83 10 80       	push   $0x80108308
80104a52:	e8 29 b9 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104a57:	83 ec 0c             	sub    $0xc,%esp
80104a5a:	68 fb 82 10 80       	push   $0x801082fb
80104a5f:	e8 1c b9 ff ff       	call   80100380 <panic>
80104a64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a6f:	90                   	nop

80104a70 <wait>:
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	56                   	push   %esi
80104a74:	53                   	push   %ebx
  pushcli();
80104a75:	e8 86 05 00 00       	call   80105000 <pushcli>
  c = mycpu();
80104a7a:	e8 21 fa ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104a7f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104a85:	e8 c6 05 00 00       	call   80105050 <popcli>
  acquire(&ptable.lock);
80104a8a:	83 ec 0c             	sub    $0xc,%esp
80104a8d:	68 20 39 11 80       	push   $0x80113920
80104a92:	e8 b9 06 00 00       	call   80105150 <acquire>
80104a97:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104a9a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a9c:	bb 54 39 11 80       	mov    $0x80113954,%ebx
80104aa1:	eb 10                	jmp    80104ab3 <wait+0x43>
80104aa3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104aa7:	90                   	nop
80104aa8:	83 c3 7c             	add    $0x7c,%ebx
80104aab:	81 fb 54 58 11 80    	cmp    $0x80115854,%ebx
80104ab1:	74 1b                	je     80104ace <wait+0x5e>
      if(p->parent != curproc)
80104ab3:	39 73 14             	cmp    %esi,0x14(%ebx)
80104ab6:	75 f0                	jne    80104aa8 <wait+0x38>
      if(p->state == ZOMBIE){
80104ab8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104abc:	74 62                	je     80104b20 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104abe:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104ac1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac6:	81 fb 54 58 11 80    	cmp    $0x80115854,%ebx
80104acc:	75 e5                	jne    80104ab3 <wait+0x43>
    if(!havekids || curproc->killed){
80104ace:	85 c0                	test   %eax,%eax
80104ad0:	0f 84 a0 00 00 00    	je     80104b76 <wait+0x106>
80104ad6:	8b 46 24             	mov    0x24(%esi),%eax
80104ad9:	85 c0                	test   %eax,%eax
80104adb:	0f 85 95 00 00 00    	jne    80104b76 <wait+0x106>
  pushcli();
80104ae1:	e8 1a 05 00 00       	call   80105000 <pushcli>
  c = mycpu();
80104ae6:	e8 b5 f9 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104aeb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104af1:	e8 5a 05 00 00       	call   80105050 <popcli>
  if(p == 0)
80104af6:	85 db                	test   %ebx,%ebx
80104af8:	0f 84 8f 00 00 00    	je     80104b8d <wait+0x11d>
  p->chan = chan;
80104afe:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104b01:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104b08:	e8 73 fd ff ff       	call   80104880 <sched>
  p->chan = 0;
80104b0d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104b14:	eb 84                	jmp    80104a9a <wait+0x2a>
80104b16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104b20:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104b23:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104b26:	ff 73 08             	push   0x8(%ebx)
80104b29:	e8 42 e5 ff ff       	call   80103070 <kfree>
        p->kstack = 0;
80104b2e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104b35:	5a                   	pop    %edx
80104b36:	ff 73 04             	push   0x4(%ebx)
80104b39:	e8 32 2e 00 00       	call   80107970 <freevm>
        p->pid = 0;
80104b3e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104b45:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104b4c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104b50:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104b57:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104b5e:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104b65:	e8 86 05 00 00       	call   801050f0 <release>
        return pid;
80104b6a:	83 c4 10             	add    $0x10,%esp
}
80104b6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b70:	89 f0                	mov    %esi,%eax
80104b72:	5b                   	pop    %ebx
80104b73:	5e                   	pop    %esi
80104b74:	5d                   	pop    %ebp
80104b75:	c3                   	ret    
      release(&ptable.lock);
80104b76:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104b79:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104b7e:	68 20 39 11 80       	push   $0x80113920
80104b83:	e8 68 05 00 00       	call   801050f0 <release>
      return -1;
80104b88:	83 c4 10             	add    $0x10,%esp
80104b8b:	eb e0                	jmp    80104b6d <wait+0xfd>
    panic("sleep");
80104b8d:	83 ec 0c             	sub    $0xc,%esp
80104b90:	68 14 83 10 80       	push   $0x80108314
80104b95:	e8 e6 b7 ff ff       	call   80100380 <panic>
80104b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ba0 <yield>:
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	53                   	push   %ebx
80104ba4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104ba7:	68 20 39 11 80       	push   $0x80113920
80104bac:	e8 9f 05 00 00       	call   80105150 <acquire>
  pushcli();
80104bb1:	e8 4a 04 00 00       	call   80105000 <pushcli>
  c = mycpu();
80104bb6:	e8 e5 f8 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104bbb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104bc1:	e8 8a 04 00 00       	call   80105050 <popcli>
  myproc()->state = RUNNABLE;
80104bc6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104bcd:	e8 ae fc ff ff       	call   80104880 <sched>
  release(&ptable.lock);
80104bd2:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104bd9:	e8 12 05 00 00       	call   801050f0 <release>
}
80104bde:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104be1:	83 c4 10             	add    $0x10,%esp
80104be4:	c9                   	leave  
80104be5:	c3                   	ret    
80104be6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bed:	8d 76 00             	lea    0x0(%esi),%esi

80104bf0 <sleep>:
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	57                   	push   %edi
80104bf4:	56                   	push   %esi
80104bf5:	53                   	push   %ebx
80104bf6:	83 ec 0c             	sub    $0xc,%esp
80104bf9:	8b 7d 08             	mov    0x8(%ebp),%edi
80104bfc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104bff:	e8 fc 03 00 00       	call   80105000 <pushcli>
  c = mycpu();
80104c04:	e8 97 f8 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104c09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c0f:	e8 3c 04 00 00       	call   80105050 <popcli>
  if(p == 0)
80104c14:	85 db                	test   %ebx,%ebx
80104c16:	0f 84 87 00 00 00    	je     80104ca3 <sleep+0xb3>
  if(lk == 0)
80104c1c:	85 f6                	test   %esi,%esi
80104c1e:	74 76                	je     80104c96 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104c20:	81 fe 20 39 11 80    	cmp    $0x80113920,%esi
80104c26:	74 50                	je     80104c78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104c28:	83 ec 0c             	sub    $0xc,%esp
80104c2b:	68 20 39 11 80       	push   $0x80113920
80104c30:	e8 1b 05 00 00       	call   80105150 <acquire>
    release(lk);
80104c35:	89 34 24             	mov    %esi,(%esp)
80104c38:	e8 b3 04 00 00       	call   801050f0 <release>
  p->chan = chan;
80104c3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104c47:	e8 34 fc ff ff       	call   80104880 <sched>
  p->chan = 0;
80104c4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104c53:	c7 04 24 20 39 11 80 	movl   $0x80113920,(%esp)
80104c5a:	e8 91 04 00 00       	call   801050f0 <release>
    acquire(lk);
80104c5f:	89 75 08             	mov    %esi,0x8(%ebp)
80104c62:	83 c4 10             	add    $0x10,%esp
}
80104c65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c68:	5b                   	pop    %ebx
80104c69:	5e                   	pop    %esi
80104c6a:	5f                   	pop    %edi
80104c6b:	5d                   	pop    %ebp
    acquire(lk);
80104c6c:	e9 df 04 00 00       	jmp    80105150 <acquire>
80104c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104c78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104c82:	e8 f9 fb ff ff       	call   80104880 <sched>
  p->chan = 0;
80104c87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104c8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c91:	5b                   	pop    %ebx
80104c92:	5e                   	pop    %esi
80104c93:	5f                   	pop    %edi
80104c94:	5d                   	pop    %ebp
80104c95:	c3                   	ret    
    panic("sleep without lk");
80104c96:	83 ec 0c             	sub    $0xc,%esp
80104c99:	68 1a 83 10 80       	push   $0x8010831a
80104c9e:	e8 dd b6 ff ff       	call   80100380 <panic>
    panic("sleep");
80104ca3:	83 ec 0c             	sub    $0xc,%esp
80104ca6:	68 14 83 10 80       	push   $0x80108314
80104cab:	e8 d0 b6 ff ff       	call   80100380 <panic>

80104cb0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104cb0:	55                   	push   %ebp
80104cb1:	89 e5                	mov    %esp,%ebp
80104cb3:	53                   	push   %ebx
80104cb4:	83 ec 10             	sub    $0x10,%esp
80104cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104cba:	68 20 39 11 80       	push   $0x80113920
80104cbf:	e8 8c 04 00 00       	call   80105150 <acquire>
80104cc4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cc7:	b8 54 39 11 80       	mov    $0x80113954,%eax
80104ccc:	eb 0c                	jmp    80104cda <wakeup+0x2a>
80104cce:	66 90                	xchg   %ax,%ax
80104cd0:	83 c0 7c             	add    $0x7c,%eax
80104cd3:	3d 54 58 11 80       	cmp    $0x80115854,%eax
80104cd8:	74 1c                	je     80104cf6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104cda:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104cde:	75 f0                	jne    80104cd0 <wakeup+0x20>
80104ce0:	3b 58 20             	cmp    0x20(%eax),%ebx
80104ce3:	75 eb                	jne    80104cd0 <wakeup+0x20>
      p->state = RUNNABLE;
80104ce5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cec:	83 c0 7c             	add    $0x7c,%eax
80104cef:	3d 54 58 11 80       	cmp    $0x80115854,%eax
80104cf4:	75 e4                	jne    80104cda <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104cf6:	c7 45 08 20 39 11 80 	movl   $0x80113920,0x8(%ebp)
}
80104cfd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d00:	c9                   	leave  
  release(&ptable.lock);
80104d01:	e9 ea 03 00 00       	jmp    801050f0 <release>
80104d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0d:	8d 76 00             	lea    0x0(%esi),%esi

80104d10 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	53                   	push   %ebx
80104d14:	83 ec 10             	sub    $0x10,%esp
80104d17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104d1a:	68 20 39 11 80       	push   $0x80113920
80104d1f:	e8 2c 04 00 00       	call   80105150 <acquire>
80104d24:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d27:	b8 54 39 11 80       	mov    $0x80113954,%eax
80104d2c:	eb 0c                	jmp    80104d3a <kill+0x2a>
80104d2e:	66 90                	xchg   %ax,%ax
80104d30:	83 c0 7c             	add    $0x7c,%eax
80104d33:	3d 54 58 11 80       	cmp    $0x80115854,%eax
80104d38:	74 36                	je     80104d70 <kill+0x60>
    if(p->pid == pid){
80104d3a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104d3d:	75 f1                	jne    80104d30 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d3f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104d43:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104d4a:	75 07                	jne    80104d53 <kill+0x43>
        p->state = RUNNABLE;
80104d4c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104d53:	83 ec 0c             	sub    $0xc,%esp
80104d56:	68 20 39 11 80       	push   $0x80113920
80104d5b:	e8 90 03 00 00       	call   801050f0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104d60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104d63:	83 c4 10             	add    $0x10,%esp
80104d66:	31 c0                	xor    %eax,%eax
}
80104d68:	c9                   	leave  
80104d69:	c3                   	ret    
80104d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104d70:	83 ec 0c             	sub    $0xc,%esp
80104d73:	68 20 39 11 80       	push   $0x80113920
80104d78:	e8 73 03 00 00       	call   801050f0 <release>
}
80104d7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104d80:	83 c4 10             	add    $0x10,%esp
80104d83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d88:	c9                   	leave  
80104d89:	c3                   	ret    
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d90 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	56                   	push   %esi
80104d95:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104d98:	53                   	push   %ebx
80104d99:	bb c0 39 11 80       	mov    $0x801139c0,%ebx
80104d9e:	83 ec 3c             	sub    $0x3c,%esp
80104da1:	eb 24                	jmp    80104dc7 <procdump+0x37>
80104da3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104da8:	83 ec 0c             	sub    $0xc,%esp
80104dab:	68 97 86 10 80       	push   $0x80108697
80104db0:	e8 2b b9 ff ff       	call   801006e0 <cprintf>
80104db5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104db8:	83 c3 7c             	add    $0x7c,%ebx
80104dbb:	81 fb c0 58 11 80    	cmp    $0x801158c0,%ebx
80104dc1:	0f 84 81 00 00 00    	je     80104e48 <procdump+0xb8>
    if(p->state == UNUSED)
80104dc7:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	74 ea                	je     80104db8 <procdump+0x28>
      state = "???";
80104dce:	ba 2b 83 10 80       	mov    $0x8010832b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dd3:	83 f8 05             	cmp    $0x5,%eax
80104dd6:	77 11                	ja     80104de9 <procdump+0x59>
80104dd8:	8b 14 85 8c 83 10 80 	mov    -0x7fef7c74(,%eax,4),%edx
      state = "???";
80104ddf:	b8 2b 83 10 80       	mov    $0x8010832b,%eax
80104de4:	85 d2                	test   %edx,%edx
80104de6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104de9:	53                   	push   %ebx
80104dea:	52                   	push   %edx
80104deb:	ff 73 a4             	push   -0x5c(%ebx)
80104dee:	68 2f 83 10 80       	push   $0x8010832f
80104df3:	e8 e8 b8 ff ff       	call   801006e0 <cprintf>
    if(p->state == SLEEPING){
80104df8:	83 c4 10             	add    $0x10,%esp
80104dfb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104dff:	75 a7                	jne    80104da8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e01:	83 ec 08             	sub    $0x8,%esp
80104e04:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104e07:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104e0a:	50                   	push   %eax
80104e0b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104e0e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e11:	83 c0 08             	add    $0x8,%eax
80104e14:	50                   	push   %eax
80104e15:	e8 86 01 00 00       	call   80104fa0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104e1a:	83 c4 10             	add    $0x10,%esp
80104e1d:	8d 76 00             	lea    0x0(%esi),%esi
80104e20:	8b 17                	mov    (%edi),%edx
80104e22:	85 d2                	test   %edx,%edx
80104e24:	74 82                	je     80104da8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104e26:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104e29:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104e2c:	52                   	push   %edx
80104e2d:	68 81 7d 10 80       	push   $0x80107d81
80104e32:	e8 a9 b8 ff ff       	call   801006e0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104e37:	83 c4 10             	add    $0x10,%esp
80104e3a:	39 fe                	cmp    %edi,%esi
80104e3c:	75 e2                	jne    80104e20 <procdump+0x90>
80104e3e:	e9 65 ff ff ff       	jmp    80104da8 <procdump+0x18>
80104e43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e47:	90                   	nop
  }
}
80104e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e4b:	5b                   	pop    %ebx
80104e4c:	5e                   	pop    %esi
80104e4d:	5f                   	pop    %edi
80104e4e:	5d                   	pop    %ebp
80104e4f:	c3                   	ret    

80104e50 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 0c             	sub    $0xc,%esp
80104e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e5a:	68 a4 83 10 80       	push   $0x801083a4
80104e5f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e62:	50                   	push   %eax
80104e63:	e8 18 01 00 00       	call   80104f80 <initlock>
  lk->name = name;
80104e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e6b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e71:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e74:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e7b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e81:	c9                   	leave  
80104e82:	c3                   	ret    
80104e83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e90 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e98:	8d 73 04             	lea    0x4(%ebx),%esi
80104e9b:	83 ec 0c             	sub    $0xc,%esp
80104e9e:	56                   	push   %esi
80104e9f:	e8 ac 02 00 00       	call   80105150 <acquire>
  while (lk->locked) {
80104ea4:	8b 13                	mov    (%ebx),%edx
80104ea6:	83 c4 10             	add    $0x10,%esp
80104ea9:	85 d2                	test   %edx,%edx
80104eab:	74 16                	je     80104ec3 <acquiresleep+0x33>
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104eb0:	83 ec 08             	sub    $0x8,%esp
80104eb3:	56                   	push   %esi
80104eb4:	53                   	push   %ebx
80104eb5:	e8 36 fd ff ff       	call   80104bf0 <sleep>
  while (lk->locked) {
80104eba:	8b 03                	mov    (%ebx),%eax
80104ebc:	83 c4 10             	add    $0x10,%esp
80104ebf:	85 c0                	test   %eax,%eax
80104ec1:	75 ed                	jne    80104eb0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104ec3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ec9:	e8 52 f6 ff ff       	call   80104520 <myproc>
80104ece:	8b 40 10             	mov    0x10(%eax),%eax
80104ed1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ed4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ed7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eda:	5b                   	pop    %ebx
80104edb:	5e                   	pop    %esi
80104edc:	5d                   	pop    %ebp
  release(&lk->lk);
80104edd:	e9 0e 02 00 00       	jmp    801050f0 <release>
80104ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ef8:	8d 73 04             	lea    0x4(%ebx),%esi
80104efb:	83 ec 0c             	sub    $0xc,%esp
80104efe:	56                   	push   %esi
80104eff:	e8 4c 02 00 00       	call   80105150 <acquire>
  lk->locked = 0;
80104f04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f11:	89 1c 24             	mov    %ebx,(%esp)
80104f14:	e8 97 fd ff ff       	call   80104cb0 <wakeup>
  release(&lk->lk);
80104f19:	89 75 08             	mov    %esi,0x8(%ebp)
80104f1c:	83 c4 10             	add    $0x10,%esp
}
80104f1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5d                   	pop    %ebp
  release(&lk->lk);
80104f25:	e9 c6 01 00 00       	jmp    801050f0 <release>
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	31 ff                	xor    %edi,%edi
80104f36:	56                   	push   %esi
80104f37:	53                   	push   %ebx
80104f38:	83 ec 18             	sub    $0x18,%esp
80104f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104f3e:	8d 73 04             	lea    0x4(%ebx),%esi
80104f41:	56                   	push   %esi
80104f42:	e8 09 02 00 00       	call   80105150 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104f47:	8b 03                	mov    (%ebx),%eax
80104f49:	83 c4 10             	add    $0x10,%esp
80104f4c:	85 c0                	test   %eax,%eax
80104f4e:	75 18                	jne    80104f68 <holdingsleep+0x38>
  release(&lk->lk);
80104f50:	83 ec 0c             	sub    $0xc,%esp
80104f53:	56                   	push   %esi
80104f54:	e8 97 01 00 00       	call   801050f0 <release>
  return r;
}
80104f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f5c:	89 f8                	mov    %edi,%eax
80104f5e:	5b                   	pop    %ebx
80104f5f:	5e                   	pop    %esi
80104f60:	5f                   	pop    %edi
80104f61:	5d                   	pop    %ebp
80104f62:	c3                   	ret    
80104f63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f67:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104f68:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f6b:	e8 b0 f5 ff ff       	call   80104520 <myproc>
80104f70:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f73:	0f 94 c0             	sete   %al
80104f76:	0f b6 c0             	movzbl %al,%eax
80104f79:	89 c7                	mov    %eax,%edi
80104f7b:	eb d3                	jmp    80104f50 <holdingsleep+0x20>
80104f7d:	66 90                	xchg   %ax,%ax
80104f7f:	90                   	nop

80104f80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f99:	5d                   	pop    %ebp
80104f9a:	c3                   	ret    
80104f9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f9f:	90                   	nop

80104fa0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104fa0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104fa1:	31 d2                	xor    %edx,%edx
{
80104fa3:	89 e5                	mov    %esp,%ebp
80104fa5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104fa6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104fa9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104fac:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104faf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104fb0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104fb6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104fbc:	77 1a                	ja     80104fd8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104fbe:	8b 58 04             	mov    0x4(%eax),%ebx
80104fc1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104fc4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104fc7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104fc9:	83 fa 0a             	cmp    $0xa,%edx
80104fcc:	75 e2                	jne    80104fb0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104fce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fd1:	c9                   	leave  
80104fd2:	c3                   	ret    
80104fd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fd7:	90                   	nop
  for(; i < 10; i++)
80104fd8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104fdb:	8d 51 28             	lea    0x28(%ecx),%edx
80104fde:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104fe0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104fe6:	83 c0 04             	add    $0x4,%eax
80104fe9:	39 d0                	cmp    %edx,%eax
80104feb:	75 f3                	jne    80104fe0 <getcallerpcs+0x40>
}
80104fed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ff0:	c9                   	leave  
80104ff1:	c3                   	ret    
80104ff2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105000 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	53                   	push   %ebx
80105004:	83 ec 04             	sub    $0x4,%esp
80105007:	9c                   	pushf  
80105008:	5b                   	pop    %ebx
  asm volatile("cli");
80105009:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010500a:	e8 91 f4 ff ff       	call   801044a0 <mycpu>
8010500f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105015:	85 c0                	test   %eax,%eax
80105017:	74 17                	je     80105030 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105019:	e8 82 f4 ff ff       	call   801044a0 <mycpu>
8010501e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105025:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105028:	c9                   	leave  
80105029:	c3                   	ret    
8010502a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105030:	e8 6b f4 ff ff       	call   801044a0 <mycpu>
80105035:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010503b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105041:	eb d6                	jmp    80105019 <pushcli+0x19>
80105043:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010504a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105050 <popcli>:

void
popcli(void)
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105056:	9c                   	pushf  
80105057:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105058:	f6 c4 02             	test   $0x2,%ah
8010505b:	75 35                	jne    80105092 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010505d:	e8 3e f4 ff ff       	call   801044a0 <mycpu>
80105062:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105069:	78 34                	js     8010509f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010506b:	e8 30 f4 ff ff       	call   801044a0 <mycpu>
80105070:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105076:	85 d2                	test   %edx,%edx
80105078:	74 06                	je     80105080 <popcli+0x30>
    sti();
}
8010507a:	c9                   	leave  
8010507b:	c3                   	ret    
8010507c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105080:	e8 1b f4 ff ff       	call   801044a0 <mycpu>
80105085:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010508b:	85 c0                	test   %eax,%eax
8010508d:	74 eb                	je     8010507a <popcli+0x2a>
  asm volatile("sti");
8010508f:	fb                   	sti    
}
80105090:	c9                   	leave  
80105091:	c3                   	ret    
    panic("popcli - interruptible");
80105092:	83 ec 0c             	sub    $0xc,%esp
80105095:	68 af 83 10 80       	push   $0x801083af
8010509a:	e8 e1 b2 ff ff       	call   80100380 <panic>
    panic("popcli");
8010509f:	83 ec 0c             	sub    $0xc,%esp
801050a2:	68 c6 83 10 80       	push   $0x801083c6
801050a7:	e8 d4 b2 ff ff       	call   80100380 <panic>
801050ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050b0 <holding>:
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
801050b5:	8b 75 08             	mov    0x8(%ebp),%esi
801050b8:	31 db                	xor    %ebx,%ebx
  pushcli();
801050ba:	e8 41 ff ff ff       	call   80105000 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050bf:	8b 06                	mov    (%esi),%eax
801050c1:	85 c0                	test   %eax,%eax
801050c3:	75 0b                	jne    801050d0 <holding+0x20>
  popcli();
801050c5:	e8 86 ff ff ff       	call   80105050 <popcli>
}
801050ca:	89 d8                	mov    %ebx,%eax
801050cc:	5b                   	pop    %ebx
801050cd:	5e                   	pop    %esi
801050ce:	5d                   	pop    %ebp
801050cf:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
801050d0:	8b 5e 08             	mov    0x8(%esi),%ebx
801050d3:	e8 c8 f3 ff ff       	call   801044a0 <mycpu>
801050d8:	39 c3                	cmp    %eax,%ebx
801050da:	0f 94 c3             	sete   %bl
  popcli();
801050dd:	e8 6e ff ff ff       	call   80105050 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801050e2:	0f b6 db             	movzbl %bl,%ebx
}
801050e5:	89 d8                	mov    %ebx,%eax
801050e7:	5b                   	pop    %ebx
801050e8:	5e                   	pop    %esi
801050e9:	5d                   	pop    %ebp
801050ea:	c3                   	ret    
801050eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050ef:	90                   	nop

801050f0 <release>:
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
801050f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801050f8:	e8 03 ff ff ff       	call   80105000 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050fd:	8b 03                	mov    (%ebx),%eax
801050ff:	85 c0                	test   %eax,%eax
80105101:	75 15                	jne    80105118 <release+0x28>
  popcli();
80105103:	e8 48 ff ff ff       	call   80105050 <popcli>
    panic("release");
80105108:	83 ec 0c             	sub    $0xc,%esp
8010510b:	68 cd 83 10 80       	push   $0x801083cd
80105110:	e8 6b b2 ff ff       	call   80100380 <panic>
80105115:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105118:	8b 73 08             	mov    0x8(%ebx),%esi
8010511b:	e8 80 f3 ff ff       	call   801044a0 <mycpu>
80105120:	39 c6                	cmp    %eax,%esi
80105122:	75 df                	jne    80105103 <release+0x13>
  popcli();
80105124:	e8 27 ff ff ff       	call   80105050 <popcli>
  lk->pcs[0] = 0;
80105129:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105130:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105137:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010513c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105142:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105145:	5b                   	pop    %ebx
80105146:	5e                   	pop    %esi
80105147:	5d                   	pop    %ebp
  popcli();
80105148:	e9 03 ff ff ff       	jmp    80105050 <popcli>
8010514d:	8d 76 00             	lea    0x0(%esi),%esi

80105150 <acquire>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	53                   	push   %ebx
80105154:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105157:	e8 a4 fe ff ff       	call   80105000 <pushcli>
  if(holding(lk))
8010515c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010515f:	e8 9c fe ff ff       	call   80105000 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105164:	8b 03                	mov    (%ebx),%eax
80105166:	85 c0                	test   %eax,%eax
80105168:	75 7e                	jne    801051e8 <acquire+0x98>
  popcli();
8010516a:	e8 e1 fe ff ff       	call   80105050 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010516f:	b9 01 00 00 00       	mov    $0x1,%ecx
80105174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105178:	8b 55 08             	mov    0x8(%ebp),%edx
8010517b:	89 c8                	mov    %ecx,%eax
8010517d:	f0 87 02             	lock xchg %eax,(%edx)
80105180:	85 c0                	test   %eax,%eax
80105182:	75 f4                	jne    80105178 <acquire+0x28>
  __sync_synchronize();
80105184:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105189:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010518c:	e8 0f f3 ff ff       	call   801044a0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105191:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105194:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105196:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105199:	31 c0                	xor    %eax,%eax
8010519b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010519f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051a0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801051a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801051ac:	77 1a                	ja     801051c8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801051ae:	8b 5a 04             	mov    0x4(%edx),%ebx
801051b1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801051b5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801051b8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801051ba:	83 f8 0a             	cmp    $0xa,%eax
801051bd:	75 e1                	jne    801051a0 <acquire+0x50>
}
801051bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051c2:	c9                   	leave  
801051c3:	c3                   	ret    
801051c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801051c8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801051cc:	8d 51 34             	lea    0x34(%ecx),%edx
801051cf:	90                   	nop
    pcs[i] = 0;
801051d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801051d6:	83 c0 04             	add    $0x4,%eax
801051d9:	39 c2                	cmp    %eax,%edx
801051db:	75 f3                	jne    801051d0 <acquire+0x80>
}
801051dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051e0:	c9                   	leave  
801051e1:	c3                   	ret    
801051e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801051e8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801051eb:	e8 b0 f2 ff ff       	call   801044a0 <mycpu>
801051f0:	39 c3                	cmp    %eax,%ebx
801051f2:	0f 85 72 ff ff ff    	jne    8010516a <acquire+0x1a>
  popcli();
801051f8:	e8 53 fe ff ff       	call   80105050 <popcli>
    panic("acquire");
801051fd:	83 ec 0c             	sub    $0xc,%esp
80105200:	68 d5 83 10 80       	push   $0x801083d5
80105205:	e8 76 b1 ff ff       	call   80100380 <panic>
8010520a:	66 90                	xchg   %ax,%ax
8010520c:	66 90                	xchg   %ax,%ax
8010520e:	66 90                	xchg   %ax,%ax

80105210 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	57                   	push   %edi
80105214:	8b 55 08             	mov    0x8(%ebp),%edx
80105217:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010521a:	53                   	push   %ebx
8010521b:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
8010521e:	89 d7                	mov    %edx,%edi
80105220:	09 cf                	or     %ecx,%edi
80105222:	83 e7 03             	and    $0x3,%edi
80105225:	75 29                	jne    80105250 <memset+0x40>
    c &= 0xFF;
80105227:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010522a:	c1 e0 18             	shl    $0x18,%eax
8010522d:	89 fb                	mov    %edi,%ebx
8010522f:	c1 e9 02             	shr    $0x2,%ecx
80105232:	c1 e3 10             	shl    $0x10,%ebx
80105235:	09 d8                	or     %ebx,%eax
80105237:	09 f8                	or     %edi,%eax
80105239:	c1 e7 08             	shl    $0x8,%edi
8010523c:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
8010523e:	89 d7                	mov    %edx,%edi
80105240:	fc                   	cld    
80105241:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105243:	5b                   	pop    %ebx
80105244:	89 d0                	mov    %edx,%eax
80105246:	5f                   	pop    %edi
80105247:	5d                   	pop    %ebp
80105248:	c3                   	ret    
80105249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105250:	89 d7                	mov    %edx,%edi
80105252:	fc                   	cld    
80105253:	f3 aa                	rep stos %al,%es:(%edi)
80105255:	5b                   	pop    %ebx
80105256:	89 d0                	mov    %edx,%eax
80105258:	5f                   	pop    %edi
80105259:	5d                   	pop    %ebp
8010525a:	c3                   	ret    
8010525b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010525f:	90                   	nop

80105260 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	56                   	push   %esi
80105264:	8b 75 10             	mov    0x10(%ebp),%esi
80105267:	8b 55 08             	mov    0x8(%ebp),%edx
8010526a:	53                   	push   %ebx
8010526b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010526e:	85 f6                	test   %esi,%esi
80105270:	74 2e                	je     801052a0 <memcmp+0x40>
80105272:	01 c6                	add    %eax,%esi
80105274:	eb 14                	jmp    8010528a <memcmp+0x2a>
80105276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010527d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105280:	83 c0 01             	add    $0x1,%eax
80105283:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105286:	39 f0                	cmp    %esi,%eax
80105288:	74 16                	je     801052a0 <memcmp+0x40>
    if(*s1 != *s2)
8010528a:	0f b6 0a             	movzbl (%edx),%ecx
8010528d:	0f b6 18             	movzbl (%eax),%ebx
80105290:	38 d9                	cmp    %bl,%cl
80105292:	74 ec                	je     80105280 <memcmp+0x20>
      return *s1 - *s2;
80105294:	0f b6 c1             	movzbl %cl,%eax
80105297:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105299:	5b                   	pop    %ebx
8010529a:	5e                   	pop    %esi
8010529b:	5d                   	pop    %ebp
8010529c:	c3                   	ret    
8010529d:	8d 76 00             	lea    0x0(%esi),%esi
801052a0:	5b                   	pop    %ebx
  return 0;
801052a1:	31 c0                	xor    %eax,%eax
}
801052a3:	5e                   	pop    %esi
801052a4:	5d                   	pop    %ebp
801052a5:	c3                   	ret    
801052a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ad:	8d 76 00             	lea    0x0(%esi),%esi

801052b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	57                   	push   %edi
801052b4:	8b 55 08             	mov    0x8(%ebp),%edx
801052b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801052ba:	56                   	push   %esi
801052bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801052be:	39 d6                	cmp    %edx,%esi
801052c0:	73 26                	jae    801052e8 <memmove+0x38>
801052c2:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801052c5:	39 fa                	cmp    %edi,%edx
801052c7:	73 1f                	jae    801052e8 <memmove+0x38>
801052c9:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
801052cc:	85 c9                	test   %ecx,%ecx
801052ce:	74 0c                	je     801052dc <memmove+0x2c>
      *--d = *--s;
801052d0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801052d4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801052d7:	83 e8 01             	sub    $0x1,%eax
801052da:	73 f4                	jae    801052d0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801052dc:	5e                   	pop    %esi
801052dd:	89 d0                	mov    %edx,%eax
801052df:	5f                   	pop    %edi
801052e0:	5d                   	pop    %ebp
801052e1:	c3                   	ret    
801052e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801052e8:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801052eb:	89 d7                	mov    %edx,%edi
801052ed:	85 c9                	test   %ecx,%ecx
801052ef:	74 eb                	je     801052dc <memmove+0x2c>
801052f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801052f8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801052f9:	39 c6                	cmp    %eax,%esi
801052fb:	75 fb                	jne    801052f8 <memmove+0x48>
}
801052fd:	5e                   	pop    %esi
801052fe:	89 d0                	mov    %edx,%eax
80105300:	5f                   	pop    %edi
80105301:	5d                   	pop    %ebp
80105302:	c3                   	ret    
80105303:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010530a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105310 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105310:	eb 9e                	jmp    801052b0 <memmove>
80105312:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	8b 75 10             	mov    0x10(%ebp),%esi
80105327:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010532a:	53                   	push   %ebx
8010532b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
8010532e:	85 f6                	test   %esi,%esi
80105330:	74 2e                	je     80105360 <strncmp+0x40>
80105332:	01 d6                	add    %edx,%esi
80105334:	eb 18                	jmp    8010534e <strncmp+0x2e>
80105336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010533d:	8d 76 00             	lea    0x0(%esi),%esi
80105340:	38 d8                	cmp    %bl,%al
80105342:	75 14                	jne    80105358 <strncmp+0x38>
    n--, p++, q++;
80105344:	83 c2 01             	add    $0x1,%edx
80105347:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010534a:	39 f2                	cmp    %esi,%edx
8010534c:	74 12                	je     80105360 <strncmp+0x40>
8010534e:	0f b6 01             	movzbl (%ecx),%eax
80105351:	0f b6 1a             	movzbl (%edx),%ebx
80105354:	84 c0                	test   %al,%al
80105356:	75 e8                	jne    80105340 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105358:	29 d8                	sub    %ebx,%eax
}
8010535a:	5b                   	pop    %ebx
8010535b:	5e                   	pop    %esi
8010535c:	5d                   	pop    %ebp
8010535d:	c3                   	ret    
8010535e:	66 90                	xchg   %ax,%ax
80105360:	5b                   	pop    %ebx
    return 0;
80105361:	31 c0                	xor    %eax,%eax
}
80105363:	5e                   	pop    %esi
80105364:	5d                   	pop    %ebp
80105365:	c3                   	ret    
80105366:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010536d:	8d 76 00             	lea    0x0(%esi),%esi

80105370 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
80105375:	8b 75 08             	mov    0x8(%ebp),%esi
80105378:	53                   	push   %ebx
80105379:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010537c:	89 f0                	mov    %esi,%eax
8010537e:	eb 15                	jmp    80105395 <strncpy+0x25>
80105380:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105384:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105387:	83 c0 01             	add    $0x1,%eax
8010538a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
8010538e:	88 50 ff             	mov    %dl,-0x1(%eax)
80105391:	84 d2                	test   %dl,%dl
80105393:	74 09                	je     8010539e <strncpy+0x2e>
80105395:	89 cb                	mov    %ecx,%ebx
80105397:	83 e9 01             	sub    $0x1,%ecx
8010539a:	85 db                	test   %ebx,%ebx
8010539c:	7f e2                	jg     80105380 <strncpy+0x10>
    ;
  while(n-- > 0)
8010539e:	89 c2                	mov    %eax,%edx
801053a0:	85 c9                	test   %ecx,%ecx
801053a2:	7e 17                	jle    801053bb <strncpy+0x4b>
801053a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801053a8:	83 c2 01             	add    $0x1,%edx
801053ab:	89 c1                	mov    %eax,%ecx
801053ad:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
801053b1:	29 d1                	sub    %edx,%ecx
801053b3:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
801053b7:	85 c9                	test   %ecx,%ecx
801053b9:	7f ed                	jg     801053a8 <strncpy+0x38>
  return os;
}
801053bb:	5b                   	pop    %ebx
801053bc:	89 f0                	mov    %esi,%eax
801053be:	5e                   	pop    %esi
801053bf:	5f                   	pop    %edi
801053c0:	5d                   	pop    %ebp
801053c1:	c3                   	ret    
801053c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	56                   	push   %esi
801053d4:	8b 55 10             	mov    0x10(%ebp),%edx
801053d7:	8b 75 08             	mov    0x8(%ebp),%esi
801053da:	53                   	push   %ebx
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
801053de:	85 d2                	test   %edx,%edx
801053e0:	7e 25                	jle    80105407 <safestrcpy+0x37>
801053e2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801053e6:	89 f2                	mov    %esi,%edx
801053e8:	eb 16                	jmp    80105400 <safestrcpy+0x30>
801053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801053f0:	0f b6 08             	movzbl (%eax),%ecx
801053f3:	83 c0 01             	add    $0x1,%eax
801053f6:	83 c2 01             	add    $0x1,%edx
801053f9:	88 4a ff             	mov    %cl,-0x1(%edx)
801053fc:	84 c9                	test   %cl,%cl
801053fe:	74 04                	je     80105404 <safestrcpy+0x34>
80105400:	39 d8                	cmp    %ebx,%eax
80105402:	75 ec                	jne    801053f0 <safestrcpy+0x20>
    ;
  *s = 0;
80105404:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105407:	89 f0                	mov    %esi,%eax
80105409:	5b                   	pop    %ebx
8010540a:	5e                   	pop    %esi
8010540b:	5d                   	pop    %ebp
8010540c:	c3                   	ret    
8010540d:	8d 76 00             	lea    0x0(%esi),%esi

80105410 <strlen>:

int
strlen(const char *s)
{
80105410:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105411:	31 c0                	xor    %eax,%eax
{
80105413:	89 e5                	mov    %esp,%ebp
80105415:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105418:	80 3a 00             	cmpb   $0x0,(%edx)
8010541b:	74 0c                	je     80105429 <strlen+0x19>
8010541d:	8d 76 00             	lea    0x0(%esi),%esi
80105420:	83 c0 01             	add    $0x1,%eax
80105423:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105427:	75 f7                	jne    80105420 <strlen+0x10>
    ;
  return n;
}
80105429:	5d                   	pop    %ebp
8010542a:	c3                   	ret    

8010542b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010542b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010542f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105433:	55                   	push   %ebp
  pushl %ebx
80105434:	53                   	push   %ebx
  pushl %esi
80105435:	56                   	push   %esi
  pushl %edi
80105436:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105437:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105439:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010543b:	5f                   	pop    %edi
  popl %esi
8010543c:	5e                   	pop    %esi
  popl %ebx
8010543d:	5b                   	pop    %ebx
  popl %ebp
8010543e:	5d                   	pop    %ebp
  ret
8010543f:	c3                   	ret    

80105440 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	83 ec 04             	sub    $0x4,%esp
80105447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010544a:	e8 d1 f0 ff ff       	call   80104520 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010544f:	8b 00                	mov    (%eax),%eax
80105451:	39 d8                	cmp    %ebx,%eax
80105453:	76 1b                	jbe    80105470 <fetchint+0x30>
80105455:	8d 53 04             	lea    0x4(%ebx),%edx
80105458:	39 d0                	cmp    %edx,%eax
8010545a:	72 14                	jb     80105470 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010545c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010545f:	8b 13                	mov    (%ebx),%edx
80105461:	89 10                	mov    %edx,(%eax)
  return 0;
80105463:	31 c0                	xor    %eax,%eax
}
80105465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105468:	c9                   	leave  
80105469:	c3                   	ret    
8010546a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105475:	eb ee                	jmp    80105465 <fetchint+0x25>
80105477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010547e:	66 90                	xchg   %ax,%ax

80105480 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	53                   	push   %ebx
80105484:	83 ec 04             	sub    $0x4,%esp
80105487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010548a:	e8 91 f0 ff ff       	call   80104520 <myproc>

  if(addr >= curproc->sz)
8010548f:	39 18                	cmp    %ebx,(%eax)
80105491:	76 2d                	jbe    801054c0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105493:	8b 55 0c             	mov    0xc(%ebp),%edx
80105496:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105498:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010549a:	39 d3                	cmp    %edx,%ebx
8010549c:	73 22                	jae    801054c0 <fetchstr+0x40>
8010549e:	89 d8                	mov    %ebx,%eax
801054a0:	eb 0d                	jmp    801054af <fetchstr+0x2f>
801054a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054a8:	83 c0 01             	add    $0x1,%eax
801054ab:	39 c2                	cmp    %eax,%edx
801054ad:	76 11                	jbe    801054c0 <fetchstr+0x40>
    if(*s == 0)
801054af:	80 38 00             	cmpb   $0x0,(%eax)
801054b2:	75 f4                	jne    801054a8 <fetchstr+0x28>
      return s - *pp;
801054b4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801054b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054b9:	c9                   	leave  
801054ba:	c3                   	ret    
801054bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054bf:	90                   	nop
801054c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801054c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054c8:	c9                   	leave  
801054c9:	c3                   	ret    
801054ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801054d0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	56                   	push   %esi
801054d4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054d5:	e8 46 f0 ff ff       	call   80104520 <myproc>
801054da:	8b 55 08             	mov    0x8(%ebp),%edx
801054dd:	8b 40 18             	mov    0x18(%eax),%eax
801054e0:	8b 40 44             	mov    0x44(%eax),%eax
801054e3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054e6:	e8 35 f0 ff ff       	call   80104520 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054eb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054ee:	8b 00                	mov    (%eax),%eax
801054f0:	39 c6                	cmp    %eax,%esi
801054f2:	73 1c                	jae    80105510 <argint+0x40>
801054f4:	8d 53 08             	lea    0x8(%ebx),%edx
801054f7:	39 d0                	cmp    %edx,%eax
801054f9:	72 15                	jb     80105510 <argint+0x40>
  *ip = *(int*)(addr);
801054fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801054fe:	8b 53 04             	mov    0x4(%ebx),%edx
80105501:	89 10                	mov    %edx,(%eax)
  return 0;
80105503:	31 c0                	xor    %eax,%eax
}
80105505:	5b                   	pop    %ebx
80105506:	5e                   	pop    %esi
80105507:	5d                   	pop    %ebp
80105508:	c3                   	ret    
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105515:	eb ee                	jmp    80105505 <argint+0x35>
80105517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551e:	66 90                	xchg   %ax,%ax

80105520 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	57                   	push   %edi
80105524:	56                   	push   %esi
80105525:	53                   	push   %ebx
80105526:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105529:	e8 f2 ef ff ff       	call   80104520 <myproc>
8010552e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105530:	e8 eb ef ff ff       	call   80104520 <myproc>
80105535:	8b 55 08             	mov    0x8(%ebp),%edx
80105538:	8b 40 18             	mov    0x18(%eax),%eax
8010553b:	8b 40 44             	mov    0x44(%eax),%eax
8010553e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105541:	e8 da ef ff ff       	call   80104520 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105546:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105549:	8b 00                	mov    (%eax),%eax
8010554b:	39 c7                	cmp    %eax,%edi
8010554d:	73 31                	jae    80105580 <argptr+0x60>
8010554f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105552:	39 c8                	cmp    %ecx,%eax
80105554:	72 2a                	jb     80105580 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105556:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105559:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010555c:	85 d2                	test   %edx,%edx
8010555e:	78 20                	js     80105580 <argptr+0x60>
80105560:	8b 16                	mov    (%esi),%edx
80105562:	39 c2                	cmp    %eax,%edx
80105564:	76 1a                	jbe    80105580 <argptr+0x60>
80105566:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105569:	01 c3                	add    %eax,%ebx
8010556b:	39 da                	cmp    %ebx,%edx
8010556d:	72 11                	jb     80105580 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010556f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105572:	89 02                	mov    %eax,(%edx)
  return 0;
80105574:	31 c0                	xor    %eax,%eax
}
80105576:	83 c4 0c             	add    $0xc,%esp
80105579:	5b                   	pop    %ebx
8010557a:	5e                   	pop    %esi
8010557b:	5f                   	pop    %edi
8010557c:	5d                   	pop    %ebp
8010557d:	c3                   	ret    
8010557e:	66 90                	xchg   %ax,%ax
    return -1;
80105580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105585:	eb ef                	jmp    80105576 <argptr+0x56>
80105587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010558e:	66 90                	xchg   %ax,%ax

80105590 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	56                   	push   %esi
80105594:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105595:	e8 86 ef ff ff       	call   80104520 <myproc>
8010559a:	8b 55 08             	mov    0x8(%ebp),%edx
8010559d:	8b 40 18             	mov    0x18(%eax),%eax
801055a0:	8b 40 44             	mov    0x44(%eax),%eax
801055a3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801055a6:	e8 75 ef ff ff       	call   80104520 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055ab:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055ae:	8b 00                	mov    (%eax),%eax
801055b0:	39 c6                	cmp    %eax,%esi
801055b2:	73 44                	jae    801055f8 <argstr+0x68>
801055b4:	8d 53 08             	lea    0x8(%ebx),%edx
801055b7:	39 d0                	cmp    %edx,%eax
801055b9:	72 3d                	jb     801055f8 <argstr+0x68>
  *ip = *(int*)(addr);
801055bb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801055be:	e8 5d ef ff ff       	call   80104520 <myproc>
  if(addr >= curproc->sz)
801055c3:	3b 18                	cmp    (%eax),%ebx
801055c5:	73 31                	jae    801055f8 <argstr+0x68>
  *pp = (char*)addr;
801055c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801055ca:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801055cc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801055ce:	39 d3                	cmp    %edx,%ebx
801055d0:	73 26                	jae    801055f8 <argstr+0x68>
801055d2:	89 d8                	mov    %ebx,%eax
801055d4:	eb 11                	jmp    801055e7 <argstr+0x57>
801055d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055dd:	8d 76 00             	lea    0x0(%esi),%esi
801055e0:	83 c0 01             	add    $0x1,%eax
801055e3:	39 c2                	cmp    %eax,%edx
801055e5:	76 11                	jbe    801055f8 <argstr+0x68>
    if(*s == 0)
801055e7:	80 38 00             	cmpb   $0x0,(%eax)
801055ea:	75 f4                	jne    801055e0 <argstr+0x50>
      return s - *pp;
801055ec:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801055ee:	5b                   	pop    %ebx
801055ef:	5e                   	pop    %esi
801055f0:	5d                   	pop    %ebp
801055f1:	c3                   	ret    
801055f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801055f8:	5b                   	pop    %ebx
    return -1;
801055f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055fe:	5e                   	pop    %esi
801055ff:	5d                   	pop    %ebp
80105600:	c3                   	ret    
80105601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010560f:	90                   	nop

80105610 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	53                   	push   %ebx
80105614:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105617:	e8 04 ef ff ff       	call   80104520 <myproc>
8010561c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010561e:	8b 40 18             	mov    0x18(%eax),%eax
80105621:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105624:	8d 50 ff             	lea    -0x1(%eax),%edx
80105627:	83 fa 14             	cmp    $0x14,%edx
8010562a:	77 24                	ja     80105650 <syscall+0x40>
8010562c:	8b 14 85 00 84 10 80 	mov    -0x7fef7c00(,%eax,4),%edx
80105633:	85 d2                	test   %edx,%edx
80105635:	74 19                	je     80105650 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105637:	ff d2                	call   *%edx
80105639:	89 c2                	mov    %eax,%edx
8010563b:	8b 43 18             	mov    0x18(%ebx),%eax
8010563e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105641:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105644:	c9                   	leave  
80105645:	c3                   	ret    
80105646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105650:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105651:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105654:	50                   	push   %eax
80105655:	ff 73 10             	push   0x10(%ebx)
80105658:	68 dd 83 10 80       	push   $0x801083dd
8010565d:	e8 7e b0 ff ff       	call   801006e0 <cprintf>
    curproc->tf->eax = -1;
80105662:	8b 43 18             	mov    0x18(%ebx),%eax
80105665:	83 c4 10             	add    $0x10,%esp
80105668:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010566f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105672:	c9                   	leave  
80105673:	c3                   	ret    
80105674:	66 90                	xchg   %ax,%ax
80105676:	66 90                	xchg   %ax,%ax
80105678:	66 90                	xchg   %ax,%ax
8010567a:	66 90                	xchg   %ax,%ax
8010567c:	66 90                	xchg   %ax,%ax
8010567e:	66 90                	xchg   %ax,%ax

80105680 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105685:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105688:	53                   	push   %ebx
80105689:	83 ec 34             	sub    $0x34,%esp
8010568c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010568f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105692:	57                   	push   %edi
80105693:	50                   	push   %eax
{
80105694:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105697:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010569a:	e8 d1 d5 ff ff       	call   80102c70 <nameiparent>
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	85 c0                	test   %eax,%eax
801056a4:	0f 84 46 01 00 00    	je     801057f0 <create+0x170>
    return 0;
  ilock(dp);
801056aa:	83 ec 0c             	sub    $0xc,%esp
801056ad:	89 c3                	mov    %eax,%ebx
801056af:	50                   	push   %eax
801056b0:	e8 7b cc ff ff       	call   80102330 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801056b5:	83 c4 0c             	add    $0xc,%esp
801056b8:	6a 00                	push   $0x0
801056ba:	57                   	push   %edi
801056bb:	53                   	push   %ebx
801056bc:	e8 cf d1 ff ff       	call   80102890 <dirlookup>
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	89 c6                	mov    %eax,%esi
801056c6:	85 c0                	test   %eax,%eax
801056c8:	74 56                	je     80105720 <create+0xa0>
    iunlockput(dp);
801056ca:	83 ec 0c             	sub    $0xc,%esp
801056cd:	53                   	push   %ebx
801056ce:	e8 ed ce ff ff       	call   801025c0 <iunlockput>
    ilock(ip);
801056d3:	89 34 24             	mov    %esi,(%esp)
801056d6:	e8 55 cc ff ff       	call   80102330 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801056db:	83 c4 10             	add    $0x10,%esp
801056de:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801056e3:	75 1b                	jne    80105700 <create+0x80>
801056e5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801056ea:	75 14                	jne    80105700 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801056ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056ef:	89 f0                	mov    %esi,%eax
801056f1:	5b                   	pop    %ebx
801056f2:	5e                   	pop    %esi
801056f3:	5f                   	pop    %edi
801056f4:	5d                   	pop    %ebp
801056f5:	c3                   	ret    
801056f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	56                   	push   %esi
    return 0;
80105704:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105706:	e8 b5 ce ff ff       	call   801025c0 <iunlockput>
    return 0;
8010570b:	83 c4 10             	add    $0x10,%esp
}
8010570e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105711:	89 f0                	mov    %esi,%eax
80105713:	5b                   	pop    %ebx
80105714:	5e                   	pop    %esi
80105715:	5f                   	pop    %edi
80105716:	5d                   	pop    %ebp
80105717:	c3                   	ret    
80105718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010571f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105720:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105724:	83 ec 08             	sub    $0x8,%esp
80105727:	50                   	push   %eax
80105728:	ff 33                	push   (%ebx)
8010572a:	e8 91 ca ff ff       	call   801021c0 <ialloc>
8010572f:	83 c4 10             	add    $0x10,%esp
80105732:	89 c6                	mov    %eax,%esi
80105734:	85 c0                	test   %eax,%eax
80105736:	0f 84 cd 00 00 00    	je     80105809 <create+0x189>
  ilock(ip);
8010573c:	83 ec 0c             	sub    $0xc,%esp
8010573f:	50                   	push   %eax
80105740:	e8 eb cb ff ff       	call   80102330 <ilock>
  ip->major = major;
80105745:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105749:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010574d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105751:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105755:	b8 01 00 00 00       	mov    $0x1,%eax
8010575a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010575e:	89 34 24             	mov    %esi,(%esp)
80105761:	e8 1a cb ff ff       	call   80102280 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105766:	83 c4 10             	add    $0x10,%esp
80105769:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010576e:	74 30                	je     801057a0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105770:	83 ec 04             	sub    $0x4,%esp
80105773:	ff 76 04             	push   0x4(%esi)
80105776:	57                   	push   %edi
80105777:	53                   	push   %ebx
80105778:	e8 13 d4 ff ff       	call   80102b90 <dirlink>
8010577d:	83 c4 10             	add    $0x10,%esp
80105780:	85 c0                	test   %eax,%eax
80105782:	78 78                	js     801057fc <create+0x17c>
  iunlockput(dp);
80105784:	83 ec 0c             	sub    $0xc,%esp
80105787:	53                   	push   %ebx
80105788:	e8 33 ce ff ff       	call   801025c0 <iunlockput>
  return ip;
8010578d:	83 c4 10             	add    $0x10,%esp
}
80105790:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105793:	89 f0                	mov    %esi,%eax
80105795:	5b                   	pop    %ebx
80105796:	5e                   	pop    %esi
80105797:	5f                   	pop    %edi
80105798:	5d                   	pop    %ebp
80105799:	c3                   	ret    
8010579a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801057a0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801057a3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801057a8:	53                   	push   %ebx
801057a9:	e8 d2 ca ff ff       	call   80102280 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801057ae:	83 c4 0c             	add    $0xc,%esp
801057b1:	ff 76 04             	push   0x4(%esi)
801057b4:	68 74 84 10 80       	push   $0x80108474
801057b9:	56                   	push   %esi
801057ba:	e8 d1 d3 ff ff       	call   80102b90 <dirlink>
801057bf:	83 c4 10             	add    $0x10,%esp
801057c2:	85 c0                	test   %eax,%eax
801057c4:	78 18                	js     801057de <create+0x15e>
801057c6:	83 ec 04             	sub    $0x4,%esp
801057c9:	ff 73 04             	push   0x4(%ebx)
801057cc:	68 73 84 10 80       	push   $0x80108473
801057d1:	56                   	push   %esi
801057d2:	e8 b9 d3 ff ff       	call   80102b90 <dirlink>
801057d7:	83 c4 10             	add    $0x10,%esp
801057da:	85 c0                	test   %eax,%eax
801057dc:	79 92                	jns    80105770 <create+0xf0>
      panic("create dots");
801057de:	83 ec 0c             	sub    $0xc,%esp
801057e1:	68 67 84 10 80       	push   $0x80108467
801057e6:	e8 95 ab ff ff       	call   80100380 <panic>
801057eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057ef:	90                   	nop
}
801057f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801057f3:	31 f6                	xor    %esi,%esi
}
801057f5:	5b                   	pop    %ebx
801057f6:	89 f0                	mov    %esi,%eax
801057f8:	5e                   	pop    %esi
801057f9:	5f                   	pop    %edi
801057fa:	5d                   	pop    %ebp
801057fb:	c3                   	ret    
    panic("create: dirlink");
801057fc:	83 ec 0c             	sub    $0xc,%esp
801057ff:	68 76 84 10 80       	push   $0x80108476
80105804:	e8 77 ab ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105809:	83 ec 0c             	sub    $0xc,%esp
8010580c:	68 58 84 10 80       	push   $0x80108458
80105811:	e8 6a ab ff ff       	call   80100380 <panic>
80105816:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010581d:	8d 76 00             	lea    0x0(%esi),%esi

80105820 <sys_dup>:
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
80105823:	56                   	push   %esi
80105824:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105825:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105828:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010582b:	50                   	push   %eax
8010582c:	6a 00                	push   $0x0
8010582e:	e8 9d fc ff ff       	call   801054d0 <argint>
80105833:	83 c4 10             	add    $0x10,%esp
80105836:	85 c0                	test   %eax,%eax
80105838:	78 36                	js     80105870 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010583a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010583e:	77 30                	ja     80105870 <sys_dup+0x50>
80105840:	e8 db ec ff ff       	call   80104520 <myproc>
80105845:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105848:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010584c:	85 f6                	test   %esi,%esi
8010584e:	74 20                	je     80105870 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105850:	e8 cb ec ff ff       	call   80104520 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105855:	31 db                	xor    %ebx,%ebx
80105857:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105860:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105864:	85 d2                	test   %edx,%edx
80105866:	74 18                	je     80105880 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105868:	83 c3 01             	add    $0x1,%ebx
8010586b:	83 fb 10             	cmp    $0x10,%ebx
8010586e:	75 f0                	jne    80105860 <sys_dup+0x40>
}
80105870:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105873:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105878:	89 d8                	mov    %ebx,%eax
8010587a:	5b                   	pop    %ebx
8010587b:	5e                   	pop    %esi
8010587c:	5d                   	pop    %ebp
8010587d:	c3                   	ret    
8010587e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105880:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105883:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105887:	56                   	push   %esi
80105888:	e8 c3 c1 ff ff       	call   80101a50 <filedup>
  return fd;
8010588d:	83 c4 10             	add    $0x10,%esp
}
80105890:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105893:	89 d8                	mov    %ebx,%eax
80105895:	5b                   	pop    %ebx
80105896:	5e                   	pop    %esi
80105897:	5d                   	pop    %ebp
80105898:	c3                   	ret    
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058a0 <sys_read>:
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	56                   	push   %esi
801058a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801058a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058ab:	53                   	push   %ebx
801058ac:	6a 00                	push   $0x0
801058ae:	e8 1d fc ff ff       	call   801054d0 <argint>
801058b3:	83 c4 10             	add    $0x10,%esp
801058b6:	85 c0                	test   %eax,%eax
801058b8:	78 5e                	js     80105918 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058be:	77 58                	ja     80105918 <sys_read+0x78>
801058c0:	e8 5b ec ff ff       	call   80104520 <myproc>
801058c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801058cc:	85 f6                	test   %esi,%esi
801058ce:	74 48                	je     80105918 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058d0:	83 ec 08             	sub    $0x8,%esp
801058d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058d6:	50                   	push   %eax
801058d7:	6a 02                	push   $0x2
801058d9:	e8 f2 fb ff ff       	call   801054d0 <argint>
801058de:	83 c4 10             	add    $0x10,%esp
801058e1:	85 c0                	test   %eax,%eax
801058e3:	78 33                	js     80105918 <sys_read+0x78>
801058e5:	83 ec 04             	sub    $0x4,%esp
801058e8:	ff 75 f0             	push   -0x10(%ebp)
801058eb:	53                   	push   %ebx
801058ec:	6a 01                	push   $0x1
801058ee:	e8 2d fc ff ff       	call   80105520 <argptr>
801058f3:	83 c4 10             	add    $0x10,%esp
801058f6:	85 c0                	test   %eax,%eax
801058f8:	78 1e                	js     80105918 <sys_read+0x78>
  return fileread(f, p, n);
801058fa:	83 ec 04             	sub    $0x4,%esp
801058fd:	ff 75 f0             	push   -0x10(%ebp)
80105900:	ff 75 f4             	push   -0xc(%ebp)
80105903:	56                   	push   %esi
80105904:	e8 c7 c2 ff ff       	call   80101bd0 <fileread>
80105909:	83 c4 10             	add    $0x10,%esp
}
8010590c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010590f:	5b                   	pop    %ebx
80105910:	5e                   	pop    %esi
80105911:	5d                   	pop    %ebp
80105912:	c3                   	ret    
80105913:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105917:	90                   	nop
    return -1;
80105918:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010591d:	eb ed                	jmp    8010590c <sys_read+0x6c>
8010591f:	90                   	nop

80105920 <sys_write>:
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	56                   	push   %esi
80105924:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105925:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105928:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010592b:	53                   	push   %ebx
8010592c:	6a 00                	push   $0x0
8010592e:	e8 9d fb ff ff       	call   801054d0 <argint>
80105933:	83 c4 10             	add    $0x10,%esp
80105936:	85 c0                	test   %eax,%eax
80105938:	78 5e                	js     80105998 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010593a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010593e:	77 58                	ja     80105998 <sys_write+0x78>
80105940:	e8 db eb ff ff       	call   80104520 <myproc>
80105945:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105948:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010594c:	85 f6                	test   %esi,%esi
8010594e:	74 48                	je     80105998 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105950:	83 ec 08             	sub    $0x8,%esp
80105953:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105956:	50                   	push   %eax
80105957:	6a 02                	push   $0x2
80105959:	e8 72 fb ff ff       	call   801054d0 <argint>
8010595e:	83 c4 10             	add    $0x10,%esp
80105961:	85 c0                	test   %eax,%eax
80105963:	78 33                	js     80105998 <sys_write+0x78>
80105965:	83 ec 04             	sub    $0x4,%esp
80105968:	ff 75 f0             	push   -0x10(%ebp)
8010596b:	53                   	push   %ebx
8010596c:	6a 01                	push   $0x1
8010596e:	e8 ad fb ff ff       	call   80105520 <argptr>
80105973:	83 c4 10             	add    $0x10,%esp
80105976:	85 c0                	test   %eax,%eax
80105978:	78 1e                	js     80105998 <sys_write+0x78>
  return filewrite(f, p, n);
8010597a:	83 ec 04             	sub    $0x4,%esp
8010597d:	ff 75 f0             	push   -0x10(%ebp)
80105980:	ff 75 f4             	push   -0xc(%ebp)
80105983:	56                   	push   %esi
80105984:	e8 d7 c2 ff ff       	call   80101c60 <filewrite>
80105989:	83 c4 10             	add    $0x10,%esp
}
8010598c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010598f:	5b                   	pop    %ebx
80105990:	5e                   	pop    %esi
80105991:	5d                   	pop    %ebp
80105992:	c3                   	ret    
80105993:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105997:	90                   	nop
    return -1;
80105998:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010599d:	eb ed                	jmp    8010598c <sys_write+0x6c>
8010599f:	90                   	nop

801059a0 <sys_close>:
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	56                   	push   %esi
801059a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801059a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801059ab:	50                   	push   %eax
801059ac:	6a 00                	push   $0x0
801059ae:	e8 1d fb ff ff       	call   801054d0 <argint>
801059b3:	83 c4 10             	add    $0x10,%esp
801059b6:	85 c0                	test   %eax,%eax
801059b8:	78 3e                	js     801059f8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801059ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059be:	77 38                	ja     801059f8 <sys_close+0x58>
801059c0:	e8 5b eb ff ff       	call   80104520 <myproc>
801059c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059c8:	8d 5a 08             	lea    0x8(%edx),%ebx
801059cb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801059cf:	85 f6                	test   %esi,%esi
801059d1:	74 25                	je     801059f8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801059d3:	e8 48 eb ff ff       	call   80104520 <myproc>
  fileclose(f);
801059d8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801059db:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801059e2:	00 
  fileclose(f);
801059e3:	56                   	push   %esi
801059e4:	e8 b7 c0 ff ff       	call   80101aa0 <fileclose>
  return 0;
801059e9:	83 c4 10             	add    $0x10,%esp
801059ec:	31 c0                	xor    %eax,%eax
}
801059ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059f1:	5b                   	pop    %ebx
801059f2:	5e                   	pop    %esi
801059f3:	5d                   	pop    %ebp
801059f4:	c3                   	ret    
801059f5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801059f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059fd:	eb ef                	jmp    801059ee <sys_close+0x4e>
801059ff:	90                   	nop

80105a00 <sys_fstat>:
{
80105a00:	55                   	push   %ebp
80105a01:	89 e5                	mov    %esp,%ebp
80105a03:	56                   	push   %esi
80105a04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a05:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a0b:	53                   	push   %ebx
80105a0c:	6a 00                	push   $0x0
80105a0e:	e8 bd fa ff ff       	call   801054d0 <argint>
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 46                	js     80105a60 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a1e:	77 40                	ja     80105a60 <sys_fstat+0x60>
80105a20:	e8 fb ea ff ff       	call   80104520 <myproc>
80105a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a2c:	85 f6                	test   %esi,%esi
80105a2e:	74 30                	je     80105a60 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a30:	83 ec 04             	sub    $0x4,%esp
80105a33:	6a 14                	push   $0x14
80105a35:	53                   	push   %ebx
80105a36:	6a 01                	push   $0x1
80105a38:	e8 e3 fa ff ff       	call   80105520 <argptr>
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	85 c0                	test   %eax,%eax
80105a42:	78 1c                	js     80105a60 <sys_fstat+0x60>
  return filestat(f, st);
80105a44:	83 ec 08             	sub    $0x8,%esp
80105a47:	ff 75 f4             	push   -0xc(%ebp)
80105a4a:	56                   	push   %esi
80105a4b:	e8 30 c1 ff ff       	call   80101b80 <filestat>
80105a50:	83 c4 10             	add    $0x10,%esp
}
80105a53:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a56:	5b                   	pop    %ebx
80105a57:	5e                   	pop    %esi
80105a58:	5d                   	pop    %ebp
80105a59:	c3                   	ret    
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a65:	eb ec                	jmp    80105a53 <sys_fstat+0x53>
80105a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a6e:	66 90                	xchg   %ax,%ax

80105a70 <sys_link>:
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	57                   	push   %edi
80105a74:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a75:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105a78:	53                   	push   %ebx
80105a79:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a7c:	50                   	push   %eax
80105a7d:	6a 00                	push   $0x0
80105a7f:	e8 0c fb ff ff       	call   80105590 <argstr>
80105a84:	83 c4 10             	add    $0x10,%esp
80105a87:	85 c0                	test   %eax,%eax
80105a89:	0f 88 fb 00 00 00    	js     80105b8a <sys_link+0x11a>
80105a8f:	83 ec 08             	sub    $0x8,%esp
80105a92:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105a95:	50                   	push   %eax
80105a96:	6a 01                	push   $0x1
80105a98:	e8 f3 fa ff ff       	call   80105590 <argstr>
80105a9d:	83 c4 10             	add    $0x10,%esp
80105aa0:	85 c0                	test   %eax,%eax
80105aa2:	0f 88 e2 00 00 00    	js     80105b8a <sys_link+0x11a>
  begin_op();
80105aa8:	e8 63 de ff ff       	call   80103910 <begin_op>
  if((ip = namei(old)) == 0){
80105aad:	83 ec 0c             	sub    $0xc,%esp
80105ab0:	ff 75 d4             	push   -0x2c(%ebp)
80105ab3:	e8 98 d1 ff ff       	call   80102c50 <namei>
80105ab8:	83 c4 10             	add    $0x10,%esp
80105abb:	89 c3                	mov    %eax,%ebx
80105abd:	85 c0                	test   %eax,%eax
80105abf:	0f 84 e4 00 00 00    	je     80105ba9 <sys_link+0x139>
  ilock(ip);
80105ac5:	83 ec 0c             	sub    $0xc,%esp
80105ac8:	50                   	push   %eax
80105ac9:	e8 62 c8 ff ff       	call   80102330 <ilock>
  if(ip->type == T_DIR){
80105ace:	83 c4 10             	add    $0x10,%esp
80105ad1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ad6:	0f 84 b5 00 00 00    	je     80105b91 <sys_link+0x121>
  iupdate(ip);
80105adc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105adf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105ae4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105ae7:	53                   	push   %ebx
80105ae8:	e8 93 c7 ff ff       	call   80102280 <iupdate>
  iunlock(ip);
80105aed:	89 1c 24             	mov    %ebx,(%esp)
80105af0:	e8 1b c9 ff ff       	call   80102410 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105af5:	58                   	pop    %eax
80105af6:	5a                   	pop    %edx
80105af7:	57                   	push   %edi
80105af8:	ff 75 d0             	push   -0x30(%ebp)
80105afb:	e8 70 d1 ff ff       	call   80102c70 <nameiparent>
80105b00:	83 c4 10             	add    $0x10,%esp
80105b03:	89 c6                	mov    %eax,%esi
80105b05:	85 c0                	test   %eax,%eax
80105b07:	74 5b                	je     80105b64 <sys_link+0xf4>
  ilock(dp);
80105b09:	83 ec 0c             	sub    $0xc,%esp
80105b0c:	50                   	push   %eax
80105b0d:	e8 1e c8 ff ff       	call   80102330 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b12:	8b 03                	mov    (%ebx),%eax
80105b14:	83 c4 10             	add    $0x10,%esp
80105b17:	39 06                	cmp    %eax,(%esi)
80105b19:	75 3d                	jne    80105b58 <sys_link+0xe8>
80105b1b:	83 ec 04             	sub    $0x4,%esp
80105b1e:	ff 73 04             	push   0x4(%ebx)
80105b21:	57                   	push   %edi
80105b22:	56                   	push   %esi
80105b23:	e8 68 d0 ff ff       	call   80102b90 <dirlink>
80105b28:	83 c4 10             	add    $0x10,%esp
80105b2b:	85 c0                	test   %eax,%eax
80105b2d:	78 29                	js     80105b58 <sys_link+0xe8>
  iunlockput(dp);
80105b2f:	83 ec 0c             	sub    $0xc,%esp
80105b32:	56                   	push   %esi
80105b33:	e8 88 ca ff ff       	call   801025c0 <iunlockput>
  iput(ip);
80105b38:	89 1c 24             	mov    %ebx,(%esp)
80105b3b:	e8 20 c9 ff ff       	call   80102460 <iput>
  end_op();
80105b40:	e8 3b de ff ff       	call   80103980 <end_op>
  return 0;
80105b45:	83 c4 10             	add    $0x10,%esp
80105b48:	31 c0                	xor    %eax,%eax
}
80105b4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b4d:	5b                   	pop    %ebx
80105b4e:	5e                   	pop    %esi
80105b4f:	5f                   	pop    %edi
80105b50:	5d                   	pop    %ebp
80105b51:	c3                   	ret    
80105b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b58:	83 ec 0c             	sub    $0xc,%esp
80105b5b:	56                   	push   %esi
80105b5c:	e8 5f ca ff ff       	call   801025c0 <iunlockput>
    goto bad;
80105b61:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105b64:	83 ec 0c             	sub    $0xc,%esp
80105b67:	53                   	push   %ebx
80105b68:	e8 c3 c7 ff ff       	call   80102330 <ilock>
  ip->nlink--;
80105b6d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b72:	89 1c 24             	mov    %ebx,(%esp)
80105b75:	e8 06 c7 ff ff       	call   80102280 <iupdate>
  iunlockput(ip);
80105b7a:	89 1c 24             	mov    %ebx,(%esp)
80105b7d:	e8 3e ca ff ff       	call   801025c0 <iunlockput>
  end_op();
80105b82:	e8 f9 dd ff ff       	call   80103980 <end_op>
  return -1;
80105b87:	83 c4 10             	add    $0x10,%esp
80105b8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b8f:	eb b9                	jmp    80105b4a <sys_link+0xda>
    iunlockput(ip);
80105b91:	83 ec 0c             	sub    $0xc,%esp
80105b94:	53                   	push   %ebx
80105b95:	e8 26 ca ff ff       	call   801025c0 <iunlockput>
    end_op();
80105b9a:	e8 e1 dd ff ff       	call   80103980 <end_op>
    return -1;
80105b9f:	83 c4 10             	add    $0x10,%esp
80105ba2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ba7:	eb a1                	jmp    80105b4a <sys_link+0xda>
    end_op();
80105ba9:	e8 d2 dd ff ff       	call   80103980 <end_op>
    return -1;
80105bae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bb3:	eb 95                	jmp    80105b4a <sys_link+0xda>
80105bb5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bc0 <sys_unlink>:
{
80105bc0:	55                   	push   %ebp
80105bc1:	89 e5                	mov    %esp,%ebp
80105bc3:	57                   	push   %edi
80105bc4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105bc5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105bc8:	53                   	push   %ebx
80105bc9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105bcc:	50                   	push   %eax
80105bcd:	6a 00                	push   $0x0
80105bcf:	e8 bc f9 ff ff       	call   80105590 <argstr>
80105bd4:	83 c4 10             	add    $0x10,%esp
80105bd7:	85 c0                	test   %eax,%eax
80105bd9:	0f 88 7a 01 00 00    	js     80105d59 <sys_unlink+0x199>
  begin_op();
80105bdf:	e8 2c dd ff ff       	call   80103910 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105be4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105be7:	83 ec 08             	sub    $0x8,%esp
80105bea:	53                   	push   %ebx
80105beb:	ff 75 c0             	push   -0x40(%ebp)
80105bee:	e8 7d d0 ff ff       	call   80102c70 <nameiparent>
80105bf3:	83 c4 10             	add    $0x10,%esp
80105bf6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105bf9:	85 c0                	test   %eax,%eax
80105bfb:	0f 84 62 01 00 00    	je     80105d63 <sys_unlink+0x1a3>
  ilock(dp);
80105c01:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105c04:	83 ec 0c             	sub    $0xc,%esp
80105c07:	57                   	push   %edi
80105c08:	e8 23 c7 ff ff       	call   80102330 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c0d:	58                   	pop    %eax
80105c0e:	5a                   	pop    %edx
80105c0f:	68 74 84 10 80       	push   $0x80108474
80105c14:	53                   	push   %ebx
80105c15:	e8 56 cc ff ff       	call   80102870 <namecmp>
80105c1a:	83 c4 10             	add    $0x10,%esp
80105c1d:	85 c0                	test   %eax,%eax
80105c1f:	0f 84 fb 00 00 00    	je     80105d20 <sys_unlink+0x160>
80105c25:	83 ec 08             	sub    $0x8,%esp
80105c28:	68 73 84 10 80       	push   $0x80108473
80105c2d:	53                   	push   %ebx
80105c2e:	e8 3d cc ff ff       	call   80102870 <namecmp>
80105c33:	83 c4 10             	add    $0x10,%esp
80105c36:	85 c0                	test   %eax,%eax
80105c38:	0f 84 e2 00 00 00    	je     80105d20 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c3e:	83 ec 04             	sub    $0x4,%esp
80105c41:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c44:	50                   	push   %eax
80105c45:	53                   	push   %ebx
80105c46:	57                   	push   %edi
80105c47:	e8 44 cc ff ff       	call   80102890 <dirlookup>
80105c4c:	83 c4 10             	add    $0x10,%esp
80105c4f:	89 c3                	mov    %eax,%ebx
80105c51:	85 c0                	test   %eax,%eax
80105c53:	0f 84 c7 00 00 00    	je     80105d20 <sys_unlink+0x160>
  ilock(ip);
80105c59:	83 ec 0c             	sub    $0xc,%esp
80105c5c:	50                   	push   %eax
80105c5d:	e8 ce c6 ff ff       	call   80102330 <ilock>
  if(ip->nlink < 1)
80105c62:	83 c4 10             	add    $0x10,%esp
80105c65:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105c6a:	0f 8e 1c 01 00 00    	jle    80105d8c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c70:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c75:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105c78:	74 66                	je     80105ce0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105c7a:	83 ec 04             	sub    $0x4,%esp
80105c7d:	6a 10                	push   $0x10
80105c7f:	6a 00                	push   $0x0
80105c81:	57                   	push   %edi
80105c82:	e8 89 f5 ff ff       	call   80105210 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c87:	6a 10                	push   $0x10
80105c89:	ff 75 c4             	push   -0x3c(%ebp)
80105c8c:	57                   	push   %edi
80105c8d:	ff 75 b4             	push   -0x4c(%ebp)
80105c90:	e8 ab ca ff ff       	call   80102740 <writei>
80105c95:	83 c4 20             	add    $0x20,%esp
80105c98:	83 f8 10             	cmp    $0x10,%eax
80105c9b:	0f 85 de 00 00 00    	jne    80105d7f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105ca1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ca6:	0f 84 94 00 00 00    	je     80105d40 <sys_unlink+0x180>
  iunlockput(dp);
80105cac:	83 ec 0c             	sub    $0xc,%esp
80105caf:	ff 75 b4             	push   -0x4c(%ebp)
80105cb2:	e8 09 c9 ff ff       	call   801025c0 <iunlockput>
  ip->nlink--;
80105cb7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cbc:	89 1c 24             	mov    %ebx,(%esp)
80105cbf:	e8 bc c5 ff ff       	call   80102280 <iupdate>
  iunlockput(ip);
80105cc4:	89 1c 24             	mov    %ebx,(%esp)
80105cc7:	e8 f4 c8 ff ff       	call   801025c0 <iunlockput>
  end_op();
80105ccc:	e8 af dc ff ff       	call   80103980 <end_op>
  return 0;
80105cd1:	83 c4 10             	add    $0x10,%esp
80105cd4:	31 c0                	xor    %eax,%eax
}
80105cd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cd9:	5b                   	pop    %ebx
80105cda:	5e                   	pop    %esi
80105cdb:	5f                   	pop    %edi
80105cdc:	5d                   	pop    %ebp
80105cdd:	c3                   	ret    
80105cde:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ce0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105ce4:	76 94                	jbe    80105c7a <sys_unlink+0xba>
80105ce6:	be 20 00 00 00       	mov    $0x20,%esi
80105ceb:	eb 0b                	jmp    80105cf8 <sys_unlink+0x138>
80105ced:	8d 76 00             	lea    0x0(%esi),%esi
80105cf0:	83 c6 10             	add    $0x10,%esi
80105cf3:	3b 73 58             	cmp    0x58(%ebx),%esi
80105cf6:	73 82                	jae    80105c7a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cf8:	6a 10                	push   $0x10
80105cfa:	56                   	push   %esi
80105cfb:	57                   	push   %edi
80105cfc:	53                   	push   %ebx
80105cfd:	e8 3e c9 ff ff       	call   80102640 <readi>
80105d02:	83 c4 10             	add    $0x10,%esp
80105d05:	83 f8 10             	cmp    $0x10,%eax
80105d08:	75 68                	jne    80105d72 <sys_unlink+0x1b2>
    if(de.inum != 0)
80105d0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d0f:	74 df                	je     80105cf0 <sys_unlink+0x130>
    iunlockput(ip);
80105d11:	83 ec 0c             	sub    $0xc,%esp
80105d14:	53                   	push   %ebx
80105d15:	e8 a6 c8 ff ff       	call   801025c0 <iunlockput>
    goto bad;
80105d1a:	83 c4 10             	add    $0x10,%esp
80105d1d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	ff 75 b4             	push   -0x4c(%ebp)
80105d26:	e8 95 c8 ff ff       	call   801025c0 <iunlockput>
  end_op();
80105d2b:	e8 50 dc ff ff       	call   80103980 <end_op>
  return -1;
80105d30:	83 c4 10             	add    $0x10,%esp
80105d33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d38:	eb 9c                	jmp    80105cd6 <sys_unlink+0x116>
80105d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105d40:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105d43:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105d46:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105d4b:	50                   	push   %eax
80105d4c:	e8 2f c5 ff ff       	call   80102280 <iupdate>
80105d51:	83 c4 10             	add    $0x10,%esp
80105d54:	e9 53 ff ff ff       	jmp    80105cac <sys_unlink+0xec>
    return -1;
80105d59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d5e:	e9 73 ff ff ff       	jmp    80105cd6 <sys_unlink+0x116>
    end_op();
80105d63:	e8 18 dc ff ff       	call   80103980 <end_op>
    return -1;
80105d68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d6d:	e9 64 ff ff ff       	jmp    80105cd6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105d72:	83 ec 0c             	sub    $0xc,%esp
80105d75:	68 98 84 10 80       	push   $0x80108498
80105d7a:	e8 01 a6 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105d7f:	83 ec 0c             	sub    $0xc,%esp
80105d82:	68 aa 84 10 80       	push   $0x801084aa
80105d87:	e8 f4 a5 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105d8c:	83 ec 0c             	sub    $0xc,%esp
80105d8f:	68 86 84 10 80       	push   $0x80108486
80105d94:	e8 e7 a5 ff ff       	call   80100380 <panic>
80105d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105da0 <sys_open>:

int
sys_open(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105da5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105da8:	53                   	push   %ebx
80105da9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dac:	50                   	push   %eax
80105dad:	6a 00                	push   $0x0
80105daf:	e8 dc f7 ff ff       	call   80105590 <argstr>
80105db4:	83 c4 10             	add    $0x10,%esp
80105db7:	85 c0                	test   %eax,%eax
80105db9:	0f 88 8e 00 00 00    	js     80105e4d <sys_open+0xad>
80105dbf:	83 ec 08             	sub    $0x8,%esp
80105dc2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105dc5:	50                   	push   %eax
80105dc6:	6a 01                	push   $0x1
80105dc8:	e8 03 f7 ff ff       	call   801054d0 <argint>
80105dcd:	83 c4 10             	add    $0x10,%esp
80105dd0:	85 c0                	test   %eax,%eax
80105dd2:	78 79                	js     80105e4d <sys_open+0xad>
    return -1;

  begin_op();
80105dd4:	e8 37 db ff ff       	call   80103910 <begin_op>

  if(omode & O_CREATE){
80105dd9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105ddd:	75 79                	jne    80105e58 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105ddf:	83 ec 0c             	sub    $0xc,%esp
80105de2:	ff 75 e0             	push   -0x20(%ebp)
80105de5:	e8 66 ce ff ff       	call   80102c50 <namei>
80105dea:	83 c4 10             	add    $0x10,%esp
80105ded:	89 c6                	mov    %eax,%esi
80105def:	85 c0                	test   %eax,%eax
80105df1:	0f 84 7e 00 00 00    	je     80105e75 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105df7:	83 ec 0c             	sub    $0xc,%esp
80105dfa:	50                   	push   %eax
80105dfb:	e8 30 c5 ff ff       	call   80102330 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e08:	0f 84 c2 00 00 00    	je     80105ed0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e0e:	e8 cd bb ff ff       	call   801019e0 <filealloc>
80105e13:	89 c7                	mov    %eax,%edi
80105e15:	85 c0                	test   %eax,%eax
80105e17:	74 23                	je     80105e3c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105e19:	e8 02 e7 ff ff       	call   80104520 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e1e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105e20:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e24:	85 d2                	test   %edx,%edx
80105e26:	74 60                	je     80105e88 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105e28:	83 c3 01             	add    $0x1,%ebx
80105e2b:	83 fb 10             	cmp    $0x10,%ebx
80105e2e:	75 f0                	jne    80105e20 <sys_open+0x80>
    if(f)
      fileclose(f);
80105e30:	83 ec 0c             	sub    $0xc,%esp
80105e33:	57                   	push   %edi
80105e34:	e8 67 bc ff ff       	call   80101aa0 <fileclose>
80105e39:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e3c:	83 ec 0c             	sub    $0xc,%esp
80105e3f:	56                   	push   %esi
80105e40:	e8 7b c7 ff ff       	call   801025c0 <iunlockput>
    end_op();
80105e45:	e8 36 db ff ff       	call   80103980 <end_op>
    return -1;
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e52:	eb 6d                	jmp    80105ec1 <sys_open+0x121>
80105e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105e58:	83 ec 0c             	sub    $0xc,%esp
80105e5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e5e:	31 c9                	xor    %ecx,%ecx
80105e60:	ba 02 00 00 00       	mov    $0x2,%edx
80105e65:	6a 00                	push   $0x0
80105e67:	e8 14 f8 ff ff       	call   80105680 <create>
    if(ip == 0){
80105e6c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105e6f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105e71:	85 c0                	test   %eax,%eax
80105e73:	75 99                	jne    80105e0e <sys_open+0x6e>
      end_op();
80105e75:	e8 06 db ff ff       	call   80103980 <end_op>
      return -1;
80105e7a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e7f:	eb 40                	jmp    80105ec1 <sys_open+0x121>
80105e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105e88:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105e8b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105e8f:	56                   	push   %esi
80105e90:	e8 7b c5 ff ff       	call   80102410 <iunlock>
  end_op();
80105e95:	e8 e6 da ff ff       	call   80103980 <end_op>

  f->type = FD_INODE;
80105e9a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105ea0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ea3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105ea6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105ea9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105eab:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105eb2:	f7 d0                	not    %eax
80105eb4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eb7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105eba:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ebd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105ec1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ec4:	89 d8                	mov    %ebx,%eax
80105ec6:	5b                   	pop    %ebx
80105ec7:	5e                   	pop    %esi
80105ec8:	5f                   	pop    %edi
80105ec9:	5d                   	pop    %ebp
80105eca:	c3                   	ret    
80105ecb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ecf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ed0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105ed3:	85 c9                	test   %ecx,%ecx
80105ed5:	0f 84 33 ff ff ff    	je     80105e0e <sys_open+0x6e>
80105edb:	e9 5c ff ff ff       	jmp    80105e3c <sys_open+0x9c>

80105ee0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ee6:	e8 25 da ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105eeb:	83 ec 08             	sub    $0x8,%esp
80105eee:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ef1:	50                   	push   %eax
80105ef2:	6a 00                	push   $0x0
80105ef4:	e8 97 f6 ff ff       	call   80105590 <argstr>
80105ef9:	83 c4 10             	add    $0x10,%esp
80105efc:	85 c0                	test   %eax,%eax
80105efe:	78 30                	js     80105f30 <sys_mkdir+0x50>
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f06:	31 c9                	xor    %ecx,%ecx
80105f08:	ba 01 00 00 00       	mov    $0x1,%edx
80105f0d:	6a 00                	push   $0x0
80105f0f:	e8 6c f7 ff ff       	call   80105680 <create>
80105f14:	83 c4 10             	add    $0x10,%esp
80105f17:	85 c0                	test   %eax,%eax
80105f19:	74 15                	je     80105f30 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f1b:	83 ec 0c             	sub    $0xc,%esp
80105f1e:	50                   	push   %eax
80105f1f:	e8 9c c6 ff ff       	call   801025c0 <iunlockput>
  end_op();
80105f24:	e8 57 da ff ff       	call   80103980 <end_op>
  return 0;
80105f29:	83 c4 10             	add    $0x10,%esp
80105f2c:	31 c0                	xor    %eax,%eax
}
80105f2e:	c9                   	leave  
80105f2f:	c3                   	ret    
    end_op();
80105f30:	e8 4b da ff ff       	call   80103980 <end_op>
    return -1;
80105f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f3a:	c9                   	leave  
80105f3b:	c3                   	ret    
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f40 <sys_mknod>:

int
sys_mknod(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105f46:	e8 c5 d9 ff ff       	call   80103910 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105f4b:	83 ec 08             	sub    $0x8,%esp
80105f4e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f51:	50                   	push   %eax
80105f52:	6a 00                	push   $0x0
80105f54:	e8 37 f6 ff ff       	call   80105590 <argstr>
80105f59:	83 c4 10             	add    $0x10,%esp
80105f5c:	85 c0                	test   %eax,%eax
80105f5e:	78 60                	js     80105fc0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f60:	83 ec 08             	sub    $0x8,%esp
80105f63:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f66:	50                   	push   %eax
80105f67:	6a 01                	push   $0x1
80105f69:	e8 62 f5 ff ff       	call   801054d0 <argint>
  if((argstr(0, &path)) < 0 ||
80105f6e:	83 c4 10             	add    $0x10,%esp
80105f71:	85 c0                	test   %eax,%eax
80105f73:	78 4b                	js     80105fc0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f75:	83 ec 08             	sub    $0x8,%esp
80105f78:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f7b:	50                   	push   %eax
80105f7c:	6a 02                	push   $0x2
80105f7e:	e8 4d f5 ff ff       	call   801054d0 <argint>
     argint(1, &major) < 0 ||
80105f83:	83 c4 10             	add    $0x10,%esp
80105f86:	85 c0                	test   %eax,%eax
80105f88:	78 36                	js     80105fc0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f8a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105f8e:	83 ec 0c             	sub    $0xc,%esp
80105f91:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105f95:	ba 03 00 00 00       	mov    $0x3,%edx
80105f9a:	50                   	push   %eax
80105f9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f9e:	e8 dd f6 ff ff       	call   80105680 <create>
     argint(2, &minor) < 0 ||
80105fa3:	83 c4 10             	add    $0x10,%esp
80105fa6:	85 c0                	test   %eax,%eax
80105fa8:	74 16                	je     80105fc0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105faa:	83 ec 0c             	sub    $0xc,%esp
80105fad:	50                   	push   %eax
80105fae:	e8 0d c6 ff ff       	call   801025c0 <iunlockput>
  end_op();
80105fb3:	e8 c8 d9 ff ff       	call   80103980 <end_op>
  return 0;
80105fb8:	83 c4 10             	add    $0x10,%esp
80105fbb:	31 c0                	xor    %eax,%eax
}
80105fbd:	c9                   	leave  
80105fbe:	c3                   	ret    
80105fbf:	90                   	nop
    end_op();
80105fc0:	e8 bb d9 ff ff       	call   80103980 <end_op>
    return -1;
80105fc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fca:	c9                   	leave  
80105fcb:	c3                   	ret    
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <sys_chdir>:

int
sys_chdir(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	56                   	push   %esi
80105fd4:	53                   	push   %ebx
80105fd5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105fd8:	e8 43 e5 ff ff       	call   80104520 <myproc>
80105fdd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105fdf:	e8 2c d9 ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105fe4:	83 ec 08             	sub    $0x8,%esp
80105fe7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fea:	50                   	push   %eax
80105feb:	6a 00                	push   $0x0
80105fed:	e8 9e f5 ff ff       	call   80105590 <argstr>
80105ff2:	83 c4 10             	add    $0x10,%esp
80105ff5:	85 c0                	test   %eax,%eax
80105ff7:	78 77                	js     80106070 <sys_chdir+0xa0>
80105ff9:	83 ec 0c             	sub    $0xc,%esp
80105ffc:	ff 75 f4             	push   -0xc(%ebp)
80105fff:	e8 4c cc ff ff       	call   80102c50 <namei>
80106004:	83 c4 10             	add    $0x10,%esp
80106007:	89 c3                	mov    %eax,%ebx
80106009:	85 c0                	test   %eax,%eax
8010600b:	74 63                	je     80106070 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010600d:	83 ec 0c             	sub    $0xc,%esp
80106010:	50                   	push   %eax
80106011:	e8 1a c3 ff ff       	call   80102330 <ilock>
  if(ip->type != T_DIR){
80106016:	83 c4 10             	add    $0x10,%esp
80106019:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010601e:	75 30                	jne    80106050 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106020:	83 ec 0c             	sub    $0xc,%esp
80106023:	53                   	push   %ebx
80106024:	e8 e7 c3 ff ff       	call   80102410 <iunlock>
  iput(curproc->cwd);
80106029:	58                   	pop    %eax
8010602a:	ff 76 68             	push   0x68(%esi)
8010602d:	e8 2e c4 ff ff       	call   80102460 <iput>
  end_op();
80106032:	e8 49 d9 ff ff       	call   80103980 <end_op>
  curproc->cwd = ip;
80106037:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	31 c0                	xor    %eax,%eax
}
8010603f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106042:	5b                   	pop    %ebx
80106043:	5e                   	pop    %esi
80106044:	5d                   	pop    %ebp
80106045:	c3                   	ret    
80106046:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010604d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80106050:	83 ec 0c             	sub    $0xc,%esp
80106053:	53                   	push   %ebx
80106054:	e8 67 c5 ff ff       	call   801025c0 <iunlockput>
    end_op();
80106059:	e8 22 d9 ff ff       	call   80103980 <end_op>
    return -1;
8010605e:	83 c4 10             	add    $0x10,%esp
80106061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106066:	eb d7                	jmp    8010603f <sys_chdir+0x6f>
80106068:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010606f:	90                   	nop
    end_op();
80106070:	e8 0b d9 ff ff       	call   80103980 <end_op>
    return -1;
80106075:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010607a:	eb c3                	jmp    8010603f <sys_chdir+0x6f>
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106080 <sys_exec>:

int
sys_exec(void)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106085:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010608b:	53                   	push   %ebx
8010608c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106092:	50                   	push   %eax
80106093:	6a 00                	push   $0x0
80106095:	e8 f6 f4 ff ff       	call   80105590 <argstr>
8010609a:	83 c4 10             	add    $0x10,%esp
8010609d:	85 c0                	test   %eax,%eax
8010609f:	0f 88 87 00 00 00    	js     8010612c <sys_exec+0xac>
801060a5:	83 ec 08             	sub    $0x8,%esp
801060a8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801060ae:	50                   	push   %eax
801060af:	6a 01                	push   $0x1
801060b1:	e8 1a f4 ff ff       	call   801054d0 <argint>
801060b6:	83 c4 10             	add    $0x10,%esp
801060b9:	85 c0                	test   %eax,%eax
801060bb:	78 6f                	js     8010612c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801060bd:	83 ec 04             	sub    $0x4,%esp
801060c0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801060c6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801060c8:	68 80 00 00 00       	push   $0x80
801060cd:	6a 00                	push   $0x0
801060cf:	56                   	push   %esi
801060d0:	e8 3b f1 ff ff       	call   80105210 <memset>
801060d5:	83 c4 10             	add    $0x10,%esp
801060d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060df:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060e0:	83 ec 08             	sub    $0x8,%esp
801060e3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801060e9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801060f0:	50                   	push   %eax
801060f1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801060f7:	01 f8                	add    %edi,%eax
801060f9:	50                   	push   %eax
801060fa:	e8 41 f3 ff ff       	call   80105440 <fetchint>
801060ff:	83 c4 10             	add    $0x10,%esp
80106102:	85 c0                	test   %eax,%eax
80106104:	78 26                	js     8010612c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106106:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010610c:	85 c0                	test   %eax,%eax
8010610e:	74 30                	je     80106140 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106110:	83 ec 08             	sub    $0x8,%esp
80106113:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106116:	52                   	push   %edx
80106117:	50                   	push   %eax
80106118:	e8 63 f3 ff ff       	call   80105480 <fetchstr>
8010611d:	83 c4 10             	add    $0x10,%esp
80106120:	85 c0                	test   %eax,%eax
80106122:	78 08                	js     8010612c <sys_exec+0xac>
  for(i=0;; i++){
80106124:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106127:	83 fb 20             	cmp    $0x20,%ebx
8010612a:	75 b4                	jne    801060e0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010612c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010612f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106134:	5b                   	pop    %ebx
80106135:	5e                   	pop    %esi
80106136:	5f                   	pop    %edi
80106137:	5d                   	pop    %ebp
80106138:	c3                   	ret    
80106139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106140:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106147:	00 00 00 00 
  return exec(path, argv);
8010614b:	83 ec 08             	sub    $0x8,%esp
8010614e:	56                   	push   %esi
8010614f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106155:	e8 06 b5 ff ff       	call   80101660 <exec>
8010615a:	83 c4 10             	add    $0x10,%esp
}
8010615d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106160:	5b                   	pop    %ebx
80106161:	5e                   	pop    %esi
80106162:	5f                   	pop    %edi
80106163:	5d                   	pop    %ebp
80106164:	c3                   	ret    
80106165:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010616c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106170 <sys_pipe>:

int
sys_pipe(void)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	57                   	push   %edi
80106174:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106175:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106178:	53                   	push   %ebx
80106179:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010617c:	6a 08                	push   $0x8
8010617e:	50                   	push   %eax
8010617f:	6a 00                	push   $0x0
80106181:	e8 9a f3 ff ff       	call   80105520 <argptr>
80106186:	83 c4 10             	add    $0x10,%esp
80106189:	85 c0                	test   %eax,%eax
8010618b:	78 4a                	js     801061d7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010618d:	83 ec 08             	sub    $0x8,%esp
80106190:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106193:	50                   	push   %eax
80106194:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106197:	50                   	push   %eax
80106198:	e8 43 de ff ff       	call   80103fe0 <pipealloc>
8010619d:	83 c4 10             	add    $0x10,%esp
801061a0:	85 c0                	test   %eax,%eax
801061a2:	78 33                	js     801061d7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061a4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801061a7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801061a9:	e8 72 e3 ff ff       	call   80104520 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061ae:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801061b0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061b4:	85 f6                	test   %esi,%esi
801061b6:	74 28                	je     801061e0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801061b8:	83 c3 01             	add    $0x1,%ebx
801061bb:	83 fb 10             	cmp    $0x10,%ebx
801061be:	75 f0                	jne    801061b0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801061c0:	83 ec 0c             	sub    $0xc,%esp
801061c3:	ff 75 e0             	push   -0x20(%ebp)
801061c6:	e8 d5 b8 ff ff       	call   80101aa0 <fileclose>
    fileclose(wf);
801061cb:	58                   	pop    %eax
801061cc:	ff 75 e4             	push   -0x1c(%ebp)
801061cf:	e8 cc b8 ff ff       	call   80101aa0 <fileclose>
    return -1;
801061d4:	83 c4 10             	add    $0x10,%esp
801061d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061dc:	eb 53                	jmp    80106231 <sys_pipe+0xc1>
801061de:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801061e0:	8d 73 08             	lea    0x8(%ebx),%esi
801061e3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801061ea:	e8 31 e3 ff ff       	call   80104520 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061ef:	31 d2                	xor    %edx,%edx
801061f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801061f8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801061fc:	85 c9                	test   %ecx,%ecx
801061fe:	74 20                	je     80106220 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106200:	83 c2 01             	add    $0x1,%edx
80106203:	83 fa 10             	cmp    $0x10,%edx
80106206:	75 f0                	jne    801061f8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106208:	e8 13 e3 ff ff       	call   80104520 <myproc>
8010620d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106214:	00 
80106215:	eb a9                	jmp    801061c0 <sys_pipe+0x50>
80106217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010621e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106220:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80106224:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106227:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106229:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010622c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010622f:	31 c0                	xor    %eax,%eax
}
80106231:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106234:	5b                   	pop    %ebx
80106235:	5e                   	pop    %esi
80106236:	5f                   	pop    %edi
80106237:	5d                   	pop    %ebp
80106238:	c3                   	ret    
80106239:	66 90                	xchg   %ax,%ax
8010623b:	66 90                	xchg   %ax,%ax
8010623d:	66 90                	xchg   %ax,%ax
8010623f:	90                   	nop

80106240 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106240:	e9 7b e4 ff ff       	jmp    801046c0 <fork>
80106245:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106250 <sys_exit>:
}

int
sys_exit(void)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
80106253:	83 ec 08             	sub    $0x8,%esp
  exit();
80106256:	e8 e5 e6 ff ff       	call   80104940 <exit>
  return 0;  // not reached
}
8010625b:	31 c0                	xor    %eax,%eax
8010625d:	c9                   	leave  
8010625e:	c3                   	ret    
8010625f:	90                   	nop

80106260 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106260:	e9 0b e8 ff ff       	jmp    80104a70 <wait>
80106265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106270 <sys_kill>:
}

int
sys_kill(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106276:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106279:	50                   	push   %eax
8010627a:	6a 00                	push   $0x0
8010627c:	e8 4f f2 ff ff       	call   801054d0 <argint>
80106281:	83 c4 10             	add    $0x10,%esp
80106284:	85 c0                	test   %eax,%eax
80106286:	78 18                	js     801062a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106288:	83 ec 0c             	sub    $0xc,%esp
8010628b:	ff 75 f4             	push   -0xc(%ebp)
8010628e:	e8 7d ea ff ff       	call   80104d10 <kill>
80106293:	83 c4 10             	add    $0x10,%esp
}
80106296:	c9                   	leave  
80106297:	c3                   	ret    
80106298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010629f:	90                   	nop
801062a0:	c9                   	leave  
    return -1;
801062a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062a6:	c3                   	ret    
801062a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ae:	66 90                	xchg   %ax,%ax

801062b0 <sys_getpid>:

int
sys_getpid(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801062b6:	e8 65 e2 ff ff       	call   80104520 <myproc>
801062bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801062be:	c9                   	leave  
801062bf:	c3                   	ret    

801062c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801062c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062ca:	50                   	push   %eax
801062cb:	6a 00                	push   $0x0
801062cd:	e8 fe f1 ff ff       	call   801054d0 <argint>
801062d2:	83 c4 10             	add    $0x10,%esp
801062d5:	85 c0                	test   %eax,%eax
801062d7:	78 27                	js     80106300 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801062d9:	e8 42 e2 ff ff       	call   80104520 <myproc>
  if(growproc(n) < 0)
801062de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801062e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801062e3:	ff 75 f4             	push   -0xc(%ebp)
801062e6:	e8 55 e3 ff ff       	call   80104640 <growproc>
801062eb:	83 c4 10             	add    $0x10,%esp
801062ee:	85 c0                	test   %eax,%eax
801062f0:	78 0e                	js     80106300 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801062f2:	89 d8                	mov    %ebx,%eax
801062f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062f7:	c9                   	leave  
801062f8:	c3                   	ret    
801062f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106300:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106305:	eb eb                	jmp    801062f2 <sys_sbrk+0x32>
80106307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010630e:	66 90                	xchg   %ax,%ax

80106310 <sys_sleep>:

int
sys_sleep(void)
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106314:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106317:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010631a:	50                   	push   %eax
8010631b:	6a 00                	push   $0x0
8010631d:	e8 ae f1 ff ff       	call   801054d0 <argint>
80106322:	83 c4 10             	add    $0x10,%esp
80106325:	85 c0                	test   %eax,%eax
80106327:	0f 88 8a 00 00 00    	js     801063b7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010632d:	83 ec 0c             	sub    $0xc,%esp
80106330:	68 80 58 11 80       	push   $0x80115880
80106335:	e8 16 ee ff ff       	call   80105150 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010633a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010633d:	8b 1d 60 58 11 80    	mov    0x80115860,%ebx
  while(ticks - ticks0 < n){
80106343:	83 c4 10             	add    $0x10,%esp
80106346:	85 d2                	test   %edx,%edx
80106348:	75 27                	jne    80106371 <sys_sleep+0x61>
8010634a:	eb 54                	jmp    801063a0 <sys_sleep+0x90>
8010634c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106350:	83 ec 08             	sub    $0x8,%esp
80106353:	68 80 58 11 80       	push   $0x80115880
80106358:	68 60 58 11 80       	push   $0x80115860
8010635d:	e8 8e e8 ff ff       	call   80104bf0 <sleep>
  while(ticks - ticks0 < n){
80106362:	a1 60 58 11 80       	mov    0x80115860,%eax
80106367:	83 c4 10             	add    $0x10,%esp
8010636a:	29 d8                	sub    %ebx,%eax
8010636c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010636f:	73 2f                	jae    801063a0 <sys_sleep+0x90>
    if(myproc()->killed){
80106371:	e8 aa e1 ff ff       	call   80104520 <myproc>
80106376:	8b 40 24             	mov    0x24(%eax),%eax
80106379:	85 c0                	test   %eax,%eax
8010637b:	74 d3                	je     80106350 <sys_sleep+0x40>
      release(&tickslock);
8010637d:	83 ec 0c             	sub    $0xc,%esp
80106380:	68 80 58 11 80       	push   $0x80115880
80106385:	e8 66 ed ff ff       	call   801050f0 <release>
  }
  release(&tickslock);
  return 0;
}
8010638a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010638d:	83 c4 10             	add    $0x10,%esp
80106390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106395:	c9                   	leave  
80106396:	c3                   	ret    
80106397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
801063a0:	83 ec 0c             	sub    $0xc,%esp
801063a3:	68 80 58 11 80       	push   $0x80115880
801063a8:	e8 43 ed ff ff       	call   801050f0 <release>
  return 0;
801063ad:	83 c4 10             	add    $0x10,%esp
801063b0:	31 c0                	xor    %eax,%eax
}
801063b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063b5:	c9                   	leave  
801063b6:	c3                   	ret    
    return -1;
801063b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063bc:	eb f4                	jmp    801063b2 <sys_sleep+0xa2>
801063be:	66 90                	xchg   %ax,%ax

801063c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801063c0:	55                   	push   %ebp
801063c1:	89 e5                	mov    %esp,%ebp
801063c3:	53                   	push   %ebx
801063c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801063c7:	68 80 58 11 80       	push   $0x80115880
801063cc:	e8 7f ed ff ff       	call   80105150 <acquire>
  xticks = ticks;
801063d1:	8b 1d 60 58 11 80    	mov    0x80115860,%ebx
  release(&tickslock);
801063d7:	c7 04 24 80 58 11 80 	movl   $0x80115880,(%esp)
801063de:	e8 0d ed ff ff       	call   801050f0 <release>
  return xticks;
}
801063e3:	89 d8                	mov    %ebx,%eax
801063e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063e8:	c9                   	leave  
801063e9:	c3                   	ret    

801063ea <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801063ea:	1e                   	push   %ds
  pushl %es
801063eb:	06                   	push   %es
  pushl %fs
801063ec:	0f a0                	push   %fs
  pushl %gs
801063ee:	0f a8                	push   %gs
  pushal
801063f0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801063f1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801063f5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801063f7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801063f9:	54                   	push   %esp
  call trap
801063fa:	e8 c1 00 00 00       	call   801064c0 <trap>
  addl $4, %esp
801063ff:	83 c4 04             	add    $0x4,%esp

80106402 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106402:	61                   	popa   
  popl %gs
80106403:	0f a9                	pop    %gs
  popl %fs
80106405:	0f a1                	pop    %fs
  popl %es
80106407:	07                   	pop    %es
  popl %ds
80106408:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106409:	83 c4 08             	add    $0x8,%esp
  iret
8010640c:	cf                   	iret   
8010640d:	66 90                	xchg   %ax,%ax
8010640f:	90                   	nop

80106410 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106410:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106411:	31 c0                	xor    %eax,%eax
{
80106413:	89 e5                	mov    %esp,%ebp
80106415:	83 ec 08             	sub    $0x8,%esp
80106418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010641f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106420:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106427:	c7 04 c5 c2 58 11 80 	movl   $0x8e000008,-0x7feea73e(,%eax,8)
8010642e:	08 00 00 8e 
80106432:	66 89 14 c5 c0 58 11 	mov    %dx,-0x7feea740(,%eax,8)
80106439:	80 
8010643a:	c1 ea 10             	shr    $0x10,%edx
8010643d:	66 89 14 c5 c6 58 11 	mov    %dx,-0x7feea73a(,%eax,8)
80106444:	80 
  for(i = 0; i < 256; i++)
80106445:	83 c0 01             	add    $0x1,%eax
80106448:	3d 00 01 00 00       	cmp    $0x100,%eax
8010644d:	75 d1                	jne    80106420 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010644f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106452:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106457:	c7 05 c2 5a 11 80 08 	movl   $0xef000008,0x80115ac2
8010645e:	00 00 ef 
  initlock(&tickslock, "time");
80106461:	68 b9 84 10 80       	push   $0x801084b9
80106466:	68 80 58 11 80       	push   $0x80115880
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010646b:	66 a3 c0 5a 11 80    	mov    %ax,0x80115ac0
80106471:	c1 e8 10             	shr    $0x10,%eax
80106474:	66 a3 c6 5a 11 80    	mov    %ax,0x80115ac6
  initlock(&tickslock, "time");
8010647a:	e8 01 eb ff ff       	call   80104f80 <initlock>
}
8010647f:	83 c4 10             	add    $0x10,%esp
80106482:	c9                   	leave  
80106483:	c3                   	ret    
80106484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010648b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010648f:	90                   	nop

80106490 <idtinit>:

void
idtinit(void)
{
80106490:	55                   	push   %ebp
  pd[0] = size-1;
80106491:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106496:	89 e5                	mov    %esp,%ebp
80106498:	83 ec 10             	sub    $0x10,%esp
8010649b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010649f:	b8 c0 58 11 80       	mov    $0x801158c0,%eax
801064a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064a8:	c1 e8 10             	shr    $0x10,%eax
801064ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801064b5:	c9                   	leave  
801064b6:	c3                   	ret    
801064b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064be:	66 90                	xchg   %ax,%ax

801064c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801064c0:	55                   	push   %ebp
801064c1:	89 e5                	mov    %esp,%ebp
801064c3:	57                   	push   %edi
801064c4:	56                   	push   %esi
801064c5:	53                   	push   %ebx
801064c6:	83 ec 1c             	sub    $0x1c,%esp
801064c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801064cc:	8b 43 30             	mov    0x30(%ebx),%eax
801064cf:	83 f8 40             	cmp    $0x40,%eax
801064d2:	0f 84 68 01 00 00    	je     80106640 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801064d8:	83 e8 20             	sub    $0x20,%eax
801064db:	83 f8 1f             	cmp    $0x1f,%eax
801064de:	0f 87 8c 00 00 00    	ja     80106570 <trap+0xb0>
801064e4:	ff 24 85 60 85 10 80 	jmp    *-0x7fef7aa0(,%eax,4)
801064eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064ef:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801064f0:	e8 fb c8 ff ff       	call   80102df0 <ideintr>
    lapiceoi();
801064f5:	e8 c6 cf ff ff       	call   801034c0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064fa:	e8 21 e0 ff ff       	call   80104520 <myproc>
801064ff:	85 c0                	test   %eax,%eax
80106501:	74 1d                	je     80106520 <trap+0x60>
80106503:	e8 18 e0 ff ff       	call   80104520 <myproc>
80106508:	8b 50 24             	mov    0x24(%eax),%edx
8010650b:	85 d2                	test   %edx,%edx
8010650d:	74 11                	je     80106520 <trap+0x60>
8010650f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106513:	83 e0 03             	and    $0x3,%eax
80106516:	66 83 f8 03          	cmp    $0x3,%ax
8010651a:	0f 84 e8 01 00 00    	je     80106708 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106520:	e8 fb df ff ff       	call   80104520 <myproc>
80106525:	85 c0                	test   %eax,%eax
80106527:	74 0f                	je     80106538 <trap+0x78>
80106529:	e8 f2 df ff ff       	call   80104520 <myproc>
8010652e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106532:	0f 84 b8 00 00 00    	je     801065f0 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106538:	e8 e3 df ff ff       	call   80104520 <myproc>
8010653d:	85 c0                	test   %eax,%eax
8010653f:	74 1d                	je     8010655e <trap+0x9e>
80106541:	e8 da df ff ff       	call   80104520 <myproc>
80106546:	8b 40 24             	mov    0x24(%eax),%eax
80106549:	85 c0                	test   %eax,%eax
8010654b:	74 11                	je     8010655e <trap+0x9e>
8010654d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106551:	83 e0 03             	and    $0x3,%eax
80106554:	66 83 f8 03          	cmp    $0x3,%ax
80106558:	0f 84 0f 01 00 00    	je     8010666d <trap+0x1ad>
    exit();
}
8010655e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106561:	5b                   	pop    %ebx
80106562:	5e                   	pop    %esi
80106563:	5f                   	pop    %edi
80106564:	5d                   	pop    %ebp
80106565:	c3                   	ret    
80106566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010656d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106570:	e8 ab df ff ff       	call   80104520 <myproc>
80106575:	8b 7b 38             	mov    0x38(%ebx),%edi
80106578:	85 c0                	test   %eax,%eax
8010657a:	0f 84 a2 01 00 00    	je     80106722 <trap+0x262>
80106580:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106584:	0f 84 98 01 00 00    	je     80106722 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010658a:	0f 20 d1             	mov    %cr2,%ecx
8010658d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106590:	e8 6b df ff ff       	call   80104500 <cpuid>
80106595:	8b 73 30             	mov    0x30(%ebx),%esi
80106598:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010659b:	8b 43 34             	mov    0x34(%ebx),%eax
8010659e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801065a1:	e8 7a df ff ff       	call   80104520 <myproc>
801065a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801065a9:	e8 72 df ff ff       	call   80104520 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065ae:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801065b1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801065b4:	51                   	push   %ecx
801065b5:	57                   	push   %edi
801065b6:	52                   	push   %edx
801065b7:	ff 75 e4             	push   -0x1c(%ebp)
801065ba:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801065bb:	8b 75 e0             	mov    -0x20(%ebp),%esi
801065be:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065c1:	56                   	push   %esi
801065c2:	ff 70 10             	push   0x10(%eax)
801065c5:	68 1c 85 10 80       	push   $0x8010851c
801065ca:	e8 11 a1 ff ff       	call   801006e0 <cprintf>
    myproc()->killed = 1;
801065cf:	83 c4 20             	add    $0x20,%esp
801065d2:	e8 49 df ff ff       	call   80104520 <myproc>
801065d7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065de:	e8 3d df ff ff       	call   80104520 <myproc>
801065e3:	85 c0                	test   %eax,%eax
801065e5:	0f 85 18 ff ff ff    	jne    80106503 <trap+0x43>
801065eb:	e9 30 ff ff ff       	jmp    80106520 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
801065f0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801065f4:	0f 85 3e ff ff ff    	jne    80106538 <trap+0x78>
    yield();
801065fa:	e8 a1 e5 ff ff       	call   80104ba0 <yield>
801065ff:	e9 34 ff ff ff       	jmp    80106538 <trap+0x78>
80106604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106608:	8b 7b 38             	mov    0x38(%ebx),%edi
8010660b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010660f:	e8 ec de ff ff       	call   80104500 <cpuid>
80106614:	57                   	push   %edi
80106615:	56                   	push   %esi
80106616:	50                   	push   %eax
80106617:	68 c4 84 10 80       	push   $0x801084c4
8010661c:	e8 bf a0 ff ff       	call   801006e0 <cprintf>
    lapiceoi();
80106621:	e8 9a ce ff ff       	call   801034c0 <lapiceoi>
    break;
80106626:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106629:	e8 f2 de ff ff       	call   80104520 <myproc>
8010662e:	85 c0                	test   %eax,%eax
80106630:	0f 85 cd fe ff ff    	jne    80106503 <trap+0x43>
80106636:	e9 e5 fe ff ff       	jmp    80106520 <trap+0x60>
8010663b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010663f:	90                   	nop
    if(myproc()->killed)
80106640:	e8 db de ff ff       	call   80104520 <myproc>
80106645:	8b 70 24             	mov    0x24(%eax),%esi
80106648:	85 f6                	test   %esi,%esi
8010664a:	0f 85 c8 00 00 00    	jne    80106718 <trap+0x258>
    myproc()->tf = tf;
80106650:	e8 cb de ff ff       	call   80104520 <myproc>
80106655:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106658:	e8 b3 ef ff ff       	call   80105610 <syscall>
    if(myproc()->killed)
8010665d:	e8 be de ff ff       	call   80104520 <myproc>
80106662:	8b 48 24             	mov    0x24(%eax),%ecx
80106665:	85 c9                	test   %ecx,%ecx
80106667:	0f 84 f1 fe ff ff    	je     8010655e <trap+0x9e>
}
8010666d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106670:	5b                   	pop    %ebx
80106671:	5e                   	pop    %esi
80106672:	5f                   	pop    %edi
80106673:	5d                   	pop    %ebp
      exit();
80106674:	e9 c7 e2 ff ff       	jmp    80104940 <exit>
80106679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106680:	e8 3b 02 00 00       	call   801068c0 <uartintr>
    lapiceoi();
80106685:	e8 36 ce ff ff       	call   801034c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010668a:	e8 91 de ff ff       	call   80104520 <myproc>
8010668f:	85 c0                	test   %eax,%eax
80106691:	0f 85 6c fe ff ff    	jne    80106503 <trap+0x43>
80106697:	e9 84 fe ff ff       	jmp    80106520 <trap+0x60>
8010669c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801066a0:	e8 db cc ff ff       	call   80103380 <kbdintr>
    lapiceoi();
801066a5:	e8 16 ce ff ff       	call   801034c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066aa:	e8 71 de ff ff       	call   80104520 <myproc>
801066af:	85 c0                	test   %eax,%eax
801066b1:	0f 85 4c fe ff ff    	jne    80106503 <trap+0x43>
801066b7:	e9 64 fe ff ff       	jmp    80106520 <trap+0x60>
801066bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801066c0:	e8 3b de ff ff       	call   80104500 <cpuid>
801066c5:	85 c0                	test   %eax,%eax
801066c7:	0f 85 28 fe ff ff    	jne    801064f5 <trap+0x35>
      acquire(&tickslock);
801066cd:	83 ec 0c             	sub    $0xc,%esp
801066d0:	68 80 58 11 80       	push   $0x80115880
801066d5:	e8 76 ea ff ff       	call   80105150 <acquire>
      wakeup(&ticks);
801066da:	c7 04 24 60 58 11 80 	movl   $0x80115860,(%esp)
      ticks++;
801066e1:	83 05 60 58 11 80 01 	addl   $0x1,0x80115860
      wakeup(&ticks);
801066e8:	e8 c3 e5 ff ff       	call   80104cb0 <wakeup>
      release(&tickslock);
801066ed:	c7 04 24 80 58 11 80 	movl   $0x80115880,(%esp)
801066f4:	e8 f7 e9 ff ff       	call   801050f0 <release>
801066f9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801066fc:	e9 f4 fd ff ff       	jmp    801064f5 <trap+0x35>
80106701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106708:	e8 33 e2 ff ff       	call   80104940 <exit>
8010670d:	e9 0e fe ff ff       	jmp    80106520 <trap+0x60>
80106712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106718:	e8 23 e2 ff ff       	call   80104940 <exit>
8010671d:	e9 2e ff ff ff       	jmp    80106650 <trap+0x190>
80106722:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106725:	e8 d6 dd ff ff       	call   80104500 <cpuid>
8010672a:	83 ec 0c             	sub    $0xc,%esp
8010672d:	56                   	push   %esi
8010672e:	57                   	push   %edi
8010672f:	50                   	push   %eax
80106730:	ff 73 30             	push   0x30(%ebx)
80106733:	68 e8 84 10 80       	push   $0x801084e8
80106738:	e8 a3 9f ff ff       	call   801006e0 <cprintf>
      panic("trap");
8010673d:	83 c4 14             	add    $0x14,%esp
80106740:	68 be 84 10 80       	push   $0x801084be
80106745:	e8 36 9c ff ff       	call   80100380 <panic>
8010674a:	66 90                	xchg   %ax,%ax
8010674c:	66 90                	xchg   %ax,%ax
8010674e:	66 90                	xchg   %ax,%ax

80106750 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106750:	a1 c0 60 11 80       	mov    0x801160c0,%eax
80106755:	85 c0                	test   %eax,%eax
80106757:	74 17                	je     80106770 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106759:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010675e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010675f:	a8 01                	test   $0x1,%al
80106761:	74 0d                	je     80106770 <uartgetc+0x20>
80106763:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106768:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106769:	0f b6 c0             	movzbl %al,%eax
8010676c:	c3                   	ret    
8010676d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106770:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106775:	c3                   	ret    
80106776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010677d:	8d 76 00             	lea    0x0(%esi),%esi

80106780 <uartinit>:
{
80106780:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106781:	31 c9                	xor    %ecx,%ecx
80106783:	89 c8                	mov    %ecx,%eax
80106785:	89 e5                	mov    %esp,%ebp
80106787:	57                   	push   %edi
80106788:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010678d:	56                   	push   %esi
8010678e:	89 fa                	mov    %edi,%edx
80106790:	53                   	push   %ebx
80106791:	83 ec 1c             	sub    $0x1c,%esp
80106794:	ee                   	out    %al,(%dx)
80106795:	be fb 03 00 00       	mov    $0x3fb,%esi
8010679a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010679f:	89 f2                	mov    %esi,%edx
801067a1:	ee                   	out    %al,(%dx)
801067a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801067a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067ac:	ee                   	out    %al,(%dx)
801067ad:	bb f9 03 00 00       	mov    $0x3f9,%ebx
801067b2:	89 c8                	mov    %ecx,%eax
801067b4:	89 da                	mov    %ebx,%edx
801067b6:	ee                   	out    %al,(%dx)
801067b7:	b8 03 00 00 00       	mov    $0x3,%eax
801067bc:	89 f2                	mov    %esi,%edx
801067be:	ee                   	out    %al,(%dx)
801067bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801067c4:	89 c8                	mov    %ecx,%eax
801067c6:	ee                   	out    %al,(%dx)
801067c7:	b8 01 00 00 00       	mov    $0x1,%eax
801067cc:	89 da                	mov    %ebx,%edx
801067ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067d4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801067d5:	3c ff                	cmp    $0xff,%al
801067d7:	74 78                	je     80106851 <uartinit+0xd1>
  uart = 1;
801067d9:	c7 05 c0 60 11 80 01 	movl   $0x1,0x801160c0
801067e0:	00 00 00 
801067e3:	89 fa                	mov    %edi,%edx
801067e5:	ec                   	in     (%dx),%al
801067e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067eb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801067ec:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801067ef:	bf e0 85 10 80       	mov    $0x801085e0,%edi
801067f4:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801067f9:	6a 00                	push   $0x0
801067fb:	6a 04                	push   $0x4
801067fd:	e8 2e c8 ff ff       	call   80103030 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80106802:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80106806:	83 c4 10             	add    $0x10,%esp
80106809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106810:	a1 c0 60 11 80       	mov    0x801160c0,%eax
80106815:	bb 80 00 00 00       	mov    $0x80,%ebx
8010681a:	85 c0                	test   %eax,%eax
8010681c:	75 14                	jne    80106832 <uartinit+0xb2>
8010681e:	eb 23                	jmp    80106843 <uartinit+0xc3>
    microdelay(10);
80106820:	83 ec 0c             	sub    $0xc,%esp
80106823:	6a 0a                	push   $0xa
80106825:	e8 b6 cc ff ff       	call   801034e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010682a:	83 c4 10             	add    $0x10,%esp
8010682d:	83 eb 01             	sub    $0x1,%ebx
80106830:	74 07                	je     80106839 <uartinit+0xb9>
80106832:	89 f2                	mov    %esi,%edx
80106834:	ec                   	in     (%dx),%al
80106835:	a8 20                	test   $0x20,%al
80106837:	74 e7                	je     80106820 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106839:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010683d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106842:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106843:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106847:	83 c7 01             	add    $0x1,%edi
8010684a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010684d:	84 c0                	test   %al,%al
8010684f:	75 bf                	jne    80106810 <uartinit+0x90>
}
80106851:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106854:	5b                   	pop    %ebx
80106855:	5e                   	pop    %esi
80106856:	5f                   	pop    %edi
80106857:	5d                   	pop    %ebp
80106858:	c3                   	ret    
80106859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106860 <uartputc>:
  if(!uart)
80106860:	a1 c0 60 11 80       	mov    0x801160c0,%eax
80106865:	85 c0                	test   %eax,%eax
80106867:	74 47                	je     801068b0 <uartputc+0x50>
{
80106869:	55                   	push   %ebp
8010686a:	89 e5                	mov    %esp,%ebp
8010686c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010686d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106872:	53                   	push   %ebx
80106873:	bb 80 00 00 00       	mov    $0x80,%ebx
80106878:	eb 18                	jmp    80106892 <uartputc+0x32>
8010687a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106880:	83 ec 0c             	sub    $0xc,%esp
80106883:	6a 0a                	push   $0xa
80106885:	e8 56 cc ff ff       	call   801034e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010688a:	83 c4 10             	add    $0x10,%esp
8010688d:	83 eb 01             	sub    $0x1,%ebx
80106890:	74 07                	je     80106899 <uartputc+0x39>
80106892:	89 f2                	mov    %esi,%edx
80106894:	ec                   	in     (%dx),%al
80106895:	a8 20                	test   $0x20,%al
80106897:	74 e7                	je     80106880 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106899:	8b 45 08             	mov    0x8(%ebp),%eax
8010689c:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068a1:	ee                   	out    %al,(%dx)
}
801068a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801068a5:	5b                   	pop    %ebx
801068a6:	5e                   	pop    %esi
801068a7:	5d                   	pop    %ebp
801068a8:	c3                   	ret    
801068a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068b0:	c3                   	ret    
801068b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068bf:	90                   	nop

801068c0 <uartintr>:

void
uartintr(void)
{
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801068c6:	68 50 67 10 80       	push   $0x80106750
801068cb:	e8 20 a4 ff ff       	call   80100cf0 <consoleintr>
}
801068d0:	83 c4 10             	add    $0x10,%esp
801068d3:	c9                   	leave  
801068d4:	c3                   	ret    

801068d5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801068d5:	6a 00                	push   $0x0
  pushl $0
801068d7:	6a 00                	push   $0x0
  jmp alltraps
801068d9:	e9 0c fb ff ff       	jmp    801063ea <alltraps>

801068de <vector1>:
.globl vector1
vector1:
  pushl $0
801068de:	6a 00                	push   $0x0
  pushl $1
801068e0:	6a 01                	push   $0x1
  jmp alltraps
801068e2:	e9 03 fb ff ff       	jmp    801063ea <alltraps>

801068e7 <vector2>:
.globl vector2
vector2:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $2
801068e9:	6a 02                	push   $0x2
  jmp alltraps
801068eb:	e9 fa fa ff ff       	jmp    801063ea <alltraps>

801068f0 <vector3>:
.globl vector3
vector3:
  pushl $0
801068f0:	6a 00                	push   $0x0
  pushl $3
801068f2:	6a 03                	push   $0x3
  jmp alltraps
801068f4:	e9 f1 fa ff ff       	jmp    801063ea <alltraps>

801068f9 <vector4>:
.globl vector4
vector4:
  pushl $0
801068f9:	6a 00                	push   $0x0
  pushl $4
801068fb:	6a 04                	push   $0x4
  jmp alltraps
801068fd:	e9 e8 fa ff ff       	jmp    801063ea <alltraps>

80106902 <vector5>:
.globl vector5
vector5:
  pushl $0
80106902:	6a 00                	push   $0x0
  pushl $5
80106904:	6a 05                	push   $0x5
  jmp alltraps
80106906:	e9 df fa ff ff       	jmp    801063ea <alltraps>

8010690b <vector6>:
.globl vector6
vector6:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $6
8010690d:	6a 06                	push   $0x6
  jmp alltraps
8010690f:	e9 d6 fa ff ff       	jmp    801063ea <alltraps>

80106914 <vector7>:
.globl vector7
vector7:
  pushl $0
80106914:	6a 00                	push   $0x0
  pushl $7
80106916:	6a 07                	push   $0x7
  jmp alltraps
80106918:	e9 cd fa ff ff       	jmp    801063ea <alltraps>

8010691d <vector8>:
.globl vector8
vector8:
  pushl $8
8010691d:	6a 08                	push   $0x8
  jmp alltraps
8010691f:	e9 c6 fa ff ff       	jmp    801063ea <alltraps>

80106924 <vector9>:
.globl vector9
vector9:
  pushl $0
80106924:	6a 00                	push   $0x0
  pushl $9
80106926:	6a 09                	push   $0x9
  jmp alltraps
80106928:	e9 bd fa ff ff       	jmp    801063ea <alltraps>

8010692d <vector10>:
.globl vector10
vector10:
  pushl $10
8010692d:	6a 0a                	push   $0xa
  jmp alltraps
8010692f:	e9 b6 fa ff ff       	jmp    801063ea <alltraps>

80106934 <vector11>:
.globl vector11
vector11:
  pushl $11
80106934:	6a 0b                	push   $0xb
  jmp alltraps
80106936:	e9 af fa ff ff       	jmp    801063ea <alltraps>

8010693b <vector12>:
.globl vector12
vector12:
  pushl $12
8010693b:	6a 0c                	push   $0xc
  jmp alltraps
8010693d:	e9 a8 fa ff ff       	jmp    801063ea <alltraps>

80106942 <vector13>:
.globl vector13
vector13:
  pushl $13
80106942:	6a 0d                	push   $0xd
  jmp alltraps
80106944:	e9 a1 fa ff ff       	jmp    801063ea <alltraps>

80106949 <vector14>:
.globl vector14
vector14:
  pushl $14
80106949:	6a 0e                	push   $0xe
  jmp alltraps
8010694b:	e9 9a fa ff ff       	jmp    801063ea <alltraps>

80106950 <vector15>:
.globl vector15
vector15:
  pushl $0
80106950:	6a 00                	push   $0x0
  pushl $15
80106952:	6a 0f                	push   $0xf
  jmp alltraps
80106954:	e9 91 fa ff ff       	jmp    801063ea <alltraps>

80106959 <vector16>:
.globl vector16
vector16:
  pushl $0
80106959:	6a 00                	push   $0x0
  pushl $16
8010695b:	6a 10                	push   $0x10
  jmp alltraps
8010695d:	e9 88 fa ff ff       	jmp    801063ea <alltraps>

80106962 <vector17>:
.globl vector17
vector17:
  pushl $17
80106962:	6a 11                	push   $0x11
  jmp alltraps
80106964:	e9 81 fa ff ff       	jmp    801063ea <alltraps>

80106969 <vector18>:
.globl vector18
vector18:
  pushl $0
80106969:	6a 00                	push   $0x0
  pushl $18
8010696b:	6a 12                	push   $0x12
  jmp alltraps
8010696d:	e9 78 fa ff ff       	jmp    801063ea <alltraps>

80106972 <vector19>:
.globl vector19
vector19:
  pushl $0
80106972:	6a 00                	push   $0x0
  pushl $19
80106974:	6a 13                	push   $0x13
  jmp alltraps
80106976:	e9 6f fa ff ff       	jmp    801063ea <alltraps>

8010697b <vector20>:
.globl vector20
vector20:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $20
8010697d:	6a 14                	push   $0x14
  jmp alltraps
8010697f:	e9 66 fa ff ff       	jmp    801063ea <alltraps>

80106984 <vector21>:
.globl vector21
vector21:
  pushl $0
80106984:	6a 00                	push   $0x0
  pushl $21
80106986:	6a 15                	push   $0x15
  jmp alltraps
80106988:	e9 5d fa ff ff       	jmp    801063ea <alltraps>

8010698d <vector22>:
.globl vector22
vector22:
  pushl $0
8010698d:	6a 00                	push   $0x0
  pushl $22
8010698f:	6a 16                	push   $0x16
  jmp alltraps
80106991:	e9 54 fa ff ff       	jmp    801063ea <alltraps>

80106996 <vector23>:
.globl vector23
vector23:
  pushl $0
80106996:	6a 00                	push   $0x0
  pushl $23
80106998:	6a 17                	push   $0x17
  jmp alltraps
8010699a:	e9 4b fa ff ff       	jmp    801063ea <alltraps>

8010699f <vector24>:
.globl vector24
vector24:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $24
801069a1:	6a 18                	push   $0x18
  jmp alltraps
801069a3:	e9 42 fa ff ff       	jmp    801063ea <alltraps>

801069a8 <vector25>:
.globl vector25
vector25:
  pushl $0
801069a8:	6a 00                	push   $0x0
  pushl $25
801069aa:	6a 19                	push   $0x19
  jmp alltraps
801069ac:	e9 39 fa ff ff       	jmp    801063ea <alltraps>

801069b1 <vector26>:
.globl vector26
vector26:
  pushl $0
801069b1:	6a 00                	push   $0x0
  pushl $26
801069b3:	6a 1a                	push   $0x1a
  jmp alltraps
801069b5:	e9 30 fa ff ff       	jmp    801063ea <alltraps>

801069ba <vector27>:
.globl vector27
vector27:
  pushl $0
801069ba:	6a 00                	push   $0x0
  pushl $27
801069bc:	6a 1b                	push   $0x1b
  jmp alltraps
801069be:	e9 27 fa ff ff       	jmp    801063ea <alltraps>

801069c3 <vector28>:
.globl vector28
vector28:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $28
801069c5:	6a 1c                	push   $0x1c
  jmp alltraps
801069c7:	e9 1e fa ff ff       	jmp    801063ea <alltraps>

801069cc <vector29>:
.globl vector29
vector29:
  pushl $0
801069cc:	6a 00                	push   $0x0
  pushl $29
801069ce:	6a 1d                	push   $0x1d
  jmp alltraps
801069d0:	e9 15 fa ff ff       	jmp    801063ea <alltraps>

801069d5 <vector30>:
.globl vector30
vector30:
  pushl $0
801069d5:	6a 00                	push   $0x0
  pushl $30
801069d7:	6a 1e                	push   $0x1e
  jmp alltraps
801069d9:	e9 0c fa ff ff       	jmp    801063ea <alltraps>

801069de <vector31>:
.globl vector31
vector31:
  pushl $0
801069de:	6a 00                	push   $0x0
  pushl $31
801069e0:	6a 1f                	push   $0x1f
  jmp alltraps
801069e2:	e9 03 fa ff ff       	jmp    801063ea <alltraps>

801069e7 <vector32>:
.globl vector32
vector32:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $32
801069e9:	6a 20                	push   $0x20
  jmp alltraps
801069eb:	e9 fa f9 ff ff       	jmp    801063ea <alltraps>

801069f0 <vector33>:
.globl vector33
vector33:
  pushl $0
801069f0:	6a 00                	push   $0x0
  pushl $33
801069f2:	6a 21                	push   $0x21
  jmp alltraps
801069f4:	e9 f1 f9 ff ff       	jmp    801063ea <alltraps>

801069f9 <vector34>:
.globl vector34
vector34:
  pushl $0
801069f9:	6a 00                	push   $0x0
  pushl $34
801069fb:	6a 22                	push   $0x22
  jmp alltraps
801069fd:	e9 e8 f9 ff ff       	jmp    801063ea <alltraps>

80106a02 <vector35>:
.globl vector35
vector35:
  pushl $0
80106a02:	6a 00                	push   $0x0
  pushl $35
80106a04:	6a 23                	push   $0x23
  jmp alltraps
80106a06:	e9 df f9 ff ff       	jmp    801063ea <alltraps>

80106a0b <vector36>:
.globl vector36
vector36:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $36
80106a0d:	6a 24                	push   $0x24
  jmp alltraps
80106a0f:	e9 d6 f9 ff ff       	jmp    801063ea <alltraps>

80106a14 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a14:	6a 00                	push   $0x0
  pushl $37
80106a16:	6a 25                	push   $0x25
  jmp alltraps
80106a18:	e9 cd f9 ff ff       	jmp    801063ea <alltraps>

80106a1d <vector38>:
.globl vector38
vector38:
  pushl $0
80106a1d:	6a 00                	push   $0x0
  pushl $38
80106a1f:	6a 26                	push   $0x26
  jmp alltraps
80106a21:	e9 c4 f9 ff ff       	jmp    801063ea <alltraps>

80106a26 <vector39>:
.globl vector39
vector39:
  pushl $0
80106a26:	6a 00                	push   $0x0
  pushl $39
80106a28:	6a 27                	push   $0x27
  jmp alltraps
80106a2a:	e9 bb f9 ff ff       	jmp    801063ea <alltraps>

80106a2f <vector40>:
.globl vector40
vector40:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $40
80106a31:	6a 28                	push   $0x28
  jmp alltraps
80106a33:	e9 b2 f9 ff ff       	jmp    801063ea <alltraps>

80106a38 <vector41>:
.globl vector41
vector41:
  pushl $0
80106a38:	6a 00                	push   $0x0
  pushl $41
80106a3a:	6a 29                	push   $0x29
  jmp alltraps
80106a3c:	e9 a9 f9 ff ff       	jmp    801063ea <alltraps>

80106a41 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a41:	6a 00                	push   $0x0
  pushl $42
80106a43:	6a 2a                	push   $0x2a
  jmp alltraps
80106a45:	e9 a0 f9 ff ff       	jmp    801063ea <alltraps>

80106a4a <vector43>:
.globl vector43
vector43:
  pushl $0
80106a4a:	6a 00                	push   $0x0
  pushl $43
80106a4c:	6a 2b                	push   $0x2b
  jmp alltraps
80106a4e:	e9 97 f9 ff ff       	jmp    801063ea <alltraps>

80106a53 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $44
80106a55:	6a 2c                	push   $0x2c
  jmp alltraps
80106a57:	e9 8e f9 ff ff       	jmp    801063ea <alltraps>

80106a5c <vector45>:
.globl vector45
vector45:
  pushl $0
80106a5c:	6a 00                	push   $0x0
  pushl $45
80106a5e:	6a 2d                	push   $0x2d
  jmp alltraps
80106a60:	e9 85 f9 ff ff       	jmp    801063ea <alltraps>

80106a65 <vector46>:
.globl vector46
vector46:
  pushl $0
80106a65:	6a 00                	push   $0x0
  pushl $46
80106a67:	6a 2e                	push   $0x2e
  jmp alltraps
80106a69:	e9 7c f9 ff ff       	jmp    801063ea <alltraps>

80106a6e <vector47>:
.globl vector47
vector47:
  pushl $0
80106a6e:	6a 00                	push   $0x0
  pushl $47
80106a70:	6a 2f                	push   $0x2f
  jmp alltraps
80106a72:	e9 73 f9 ff ff       	jmp    801063ea <alltraps>

80106a77 <vector48>:
.globl vector48
vector48:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $48
80106a79:	6a 30                	push   $0x30
  jmp alltraps
80106a7b:	e9 6a f9 ff ff       	jmp    801063ea <alltraps>

80106a80 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a80:	6a 00                	push   $0x0
  pushl $49
80106a82:	6a 31                	push   $0x31
  jmp alltraps
80106a84:	e9 61 f9 ff ff       	jmp    801063ea <alltraps>

80106a89 <vector50>:
.globl vector50
vector50:
  pushl $0
80106a89:	6a 00                	push   $0x0
  pushl $50
80106a8b:	6a 32                	push   $0x32
  jmp alltraps
80106a8d:	e9 58 f9 ff ff       	jmp    801063ea <alltraps>

80106a92 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a92:	6a 00                	push   $0x0
  pushl $51
80106a94:	6a 33                	push   $0x33
  jmp alltraps
80106a96:	e9 4f f9 ff ff       	jmp    801063ea <alltraps>

80106a9b <vector52>:
.globl vector52
vector52:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $52
80106a9d:	6a 34                	push   $0x34
  jmp alltraps
80106a9f:	e9 46 f9 ff ff       	jmp    801063ea <alltraps>

80106aa4 <vector53>:
.globl vector53
vector53:
  pushl $0
80106aa4:	6a 00                	push   $0x0
  pushl $53
80106aa6:	6a 35                	push   $0x35
  jmp alltraps
80106aa8:	e9 3d f9 ff ff       	jmp    801063ea <alltraps>

80106aad <vector54>:
.globl vector54
vector54:
  pushl $0
80106aad:	6a 00                	push   $0x0
  pushl $54
80106aaf:	6a 36                	push   $0x36
  jmp alltraps
80106ab1:	e9 34 f9 ff ff       	jmp    801063ea <alltraps>

80106ab6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ab6:	6a 00                	push   $0x0
  pushl $55
80106ab8:	6a 37                	push   $0x37
  jmp alltraps
80106aba:	e9 2b f9 ff ff       	jmp    801063ea <alltraps>

80106abf <vector56>:
.globl vector56
vector56:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $56
80106ac1:	6a 38                	push   $0x38
  jmp alltraps
80106ac3:	e9 22 f9 ff ff       	jmp    801063ea <alltraps>

80106ac8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ac8:	6a 00                	push   $0x0
  pushl $57
80106aca:	6a 39                	push   $0x39
  jmp alltraps
80106acc:	e9 19 f9 ff ff       	jmp    801063ea <alltraps>

80106ad1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106ad1:	6a 00                	push   $0x0
  pushl $58
80106ad3:	6a 3a                	push   $0x3a
  jmp alltraps
80106ad5:	e9 10 f9 ff ff       	jmp    801063ea <alltraps>

80106ada <vector59>:
.globl vector59
vector59:
  pushl $0
80106ada:	6a 00                	push   $0x0
  pushl $59
80106adc:	6a 3b                	push   $0x3b
  jmp alltraps
80106ade:	e9 07 f9 ff ff       	jmp    801063ea <alltraps>

80106ae3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $60
80106ae5:	6a 3c                	push   $0x3c
  jmp alltraps
80106ae7:	e9 fe f8 ff ff       	jmp    801063ea <alltraps>

80106aec <vector61>:
.globl vector61
vector61:
  pushl $0
80106aec:	6a 00                	push   $0x0
  pushl $61
80106aee:	6a 3d                	push   $0x3d
  jmp alltraps
80106af0:	e9 f5 f8 ff ff       	jmp    801063ea <alltraps>

80106af5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106af5:	6a 00                	push   $0x0
  pushl $62
80106af7:	6a 3e                	push   $0x3e
  jmp alltraps
80106af9:	e9 ec f8 ff ff       	jmp    801063ea <alltraps>

80106afe <vector63>:
.globl vector63
vector63:
  pushl $0
80106afe:	6a 00                	push   $0x0
  pushl $63
80106b00:	6a 3f                	push   $0x3f
  jmp alltraps
80106b02:	e9 e3 f8 ff ff       	jmp    801063ea <alltraps>

80106b07 <vector64>:
.globl vector64
vector64:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $64
80106b09:	6a 40                	push   $0x40
  jmp alltraps
80106b0b:	e9 da f8 ff ff       	jmp    801063ea <alltraps>

80106b10 <vector65>:
.globl vector65
vector65:
  pushl $0
80106b10:	6a 00                	push   $0x0
  pushl $65
80106b12:	6a 41                	push   $0x41
  jmp alltraps
80106b14:	e9 d1 f8 ff ff       	jmp    801063ea <alltraps>

80106b19 <vector66>:
.globl vector66
vector66:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $66
80106b1b:	6a 42                	push   $0x42
  jmp alltraps
80106b1d:	e9 c8 f8 ff ff       	jmp    801063ea <alltraps>

80106b22 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b22:	6a 00                	push   $0x0
  pushl $67
80106b24:	6a 43                	push   $0x43
  jmp alltraps
80106b26:	e9 bf f8 ff ff       	jmp    801063ea <alltraps>

80106b2b <vector68>:
.globl vector68
vector68:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $68
80106b2d:	6a 44                	push   $0x44
  jmp alltraps
80106b2f:	e9 b6 f8 ff ff       	jmp    801063ea <alltraps>

80106b34 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b34:	6a 00                	push   $0x0
  pushl $69
80106b36:	6a 45                	push   $0x45
  jmp alltraps
80106b38:	e9 ad f8 ff ff       	jmp    801063ea <alltraps>

80106b3d <vector70>:
.globl vector70
vector70:
  pushl $0
80106b3d:	6a 00                	push   $0x0
  pushl $70
80106b3f:	6a 46                	push   $0x46
  jmp alltraps
80106b41:	e9 a4 f8 ff ff       	jmp    801063ea <alltraps>

80106b46 <vector71>:
.globl vector71
vector71:
  pushl $0
80106b46:	6a 00                	push   $0x0
  pushl $71
80106b48:	6a 47                	push   $0x47
  jmp alltraps
80106b4a:	e9 9b f8 ff ff       	jmp    801063ea <alltraps>

80106b4f <vector72>:
.globl vector72
vector72:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $72
80106b51:	6a 48                	push   $0x48
  jmp alltraps
80106b53:	e9 92 f8 ff ff       	jmp    801063ea <alltraps>

80106b58 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b58:	6a 00                	push   $0x0
  pushl $73
80106b5a:	6a 49                	push   $0x49
  jmp alltraps
80106b5c:	e9 89 f8 ff ff       	jmp    801063ea <alltraps>

80106b61 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b61:	6a 00                	push   $0x0
  pushl $74
80106b63:	6a 4a                	push   $0x4a
  jmp alltraps
80106b65:	e9 80 f8 ff ff       	jmp    801063ea <alltraps>

80106b6a <vector75>:
.globl vector75
vector75:
  pushl $0
80106b6a:	6a 00                	push   $0x0
  pushl $75
80106b6c:	6a 4b                	push   $0x4b
  jmp alltraps
80106b6e:	e9 77 f8 ff ff       	jmp    801063ea <alltraps>

80106b73 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $76
80106b75:	6a 4c                	push   $0x4c
  jmp alltraps
80106b77:	e9 6e f8 ff ff       	jmp    801063ea <alltraps>

80106b7c <vector77>:
.globl vector77
vector77:
  pushl $0
80106b7c:	6a 00                	push   $0x0
  pushl $77
80106b7e:	6a 4d                	push   $0x4d
  jmp alltraps
80106b80:	e9 65 f8 ff ff       	jmp    801063ea <alltraps>

80106b85 <vector78>:
.globl vector78
vector78:
  pushl $0
80106b85:	6a 00                	push   $0x0
  pushl $78
80106b87:	6a 4e                	push   $0x4e
  jmp alltraps
80106b89:	e9 5c f8 ff ff       	jmp    801063ea <alltraps>

80106b8e <vector79>:
.globl vector79
vector79:
  pushl $0
80106b8e:	6a 00                	push   $0x0
  pushl $79
80106b90:	6a 4f                	push   $0x4f
  jmp alltraps
80106b92:	e9 53 f8 ff ff       	jmp    801063ea <alltraps>

80106b97 <vector80>:
.globl vector80
vector80:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $80
80106b99:	6a 50                	push   $0x50
  jmp alltraps
80106b9b:	e9 4a f8 ff ff       	jmp    801063ea <alltraps>

80106ba0 <vector81>:
.globl vector81
vector81:
  pushl $0
80106ba0:	6a 00                	push   $0x0
  pushl $81
80106ba2:	6a 51                	push   $0x51
  jmp alltraps
80106ba4:	e9 41 f8 ff ff       	jmp    801063ea <alltraps>

80106ba9 <vector82>:
.globl vector82
vector82:
  pushl $0
80106ba9:	6a 00                	push   $0x0
  pushl $82
80106bab:	6a 52                	push   $0x52
  jmp alltraps
80106bad:	e9 38 f8 ff ff       	jmp    801063ea <alltraps>

80106bb2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106bb2:	6a 00                	push   $0x0
  pushl $83
80106bb4:	6a 53                	push   $0x53
  jmp alltraps
80106bb6:	e9 2f f8 ff ff       	jmp    801063ea <alltraps>

80106bbb <vector84>:
.globl vector84
vector84:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $84
80106bbd:	6a 54                	push   $0x54
  jmp alltraps
80106bbf:	e9 26 f8 ff ff       	jmp    801063ea <alltraps>

80106bc4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106bc4:	6a 00                	push   $0x0
  pushl $85
80106bc6:	6a 55                	push   $0x55
  jmp alltraps
80106bc8:	e9 1d f8 ff ff       	jmp    801063ea <alltraps>

80106bcd <vector86>:
.globl vector86
vector86:
  pushl $0
80106bcd:	6a 00                	push   $0x0
  pushl $86
80106bcf:	6a 56                	push   $0x56
  jmp alltraps
80106bd1:	e9 14 f8 ff ff       	jmp    801063ea <alltraps>

80106bd6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106bd6:	6a 00                	push   $0x0
  pushl $87
80106bd8:	6a 57                	push   $0x57
  jmp alltraps
80106bda:	e9 0b f8 ff ff       	jmp    801063ea <alltraps>

80106bdf <vector88>:
.globl vector88
vector88:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $88
80106be1:	6a 58                	push   $0x58
  jmp alltraps
80106be3:	e9 02 f8 ff ff       	jmp    801063ea <alltraps>

80106be8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106be8:	6a 00                	push   $0x0
  pushl $89
80106bea:	6a 59                	push   $0x59
  jmp alltraps
80106bec:	e9 f9 f7 ff ff       	jmp    801063ea <alltraps>

80106bf1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106bf1:	6a 00                	push   $0x0
  pushl $90
80106bf3:	6a 5a                	push   $0x5a
  jmp alltraps
80106bf5:	e9 f0 f7 ff ff       	jmp    801063ea <alltraps>

80106bfa <vector91>:
.globl vector91
vector91:
  pushl $0
80106bfa:	6a 00                	push   $0x0
  pushl $91
80106bfc:	6a 5b                	push   $0x5b
  jmp alltraps
80106bfe:	e9 e7 f7 ff ff       	jmp    801063ea <alltraps>

80106c03 <vector92>:
.globl vector92
vector92:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $92
80106c05:	6a 5c                	push   $0x5c
  jmp alltraps
80106c07:	e9 de f7 ff ff       	jmp    801063ea <alltraps>

80106c0c <vector93>:
.globl vector93
vector93:
  pushl $0
80106c0c:	6a 00                	push   $0x0
  pushl $93
80106c0e:	6a 5d                	push   $0x5d
  jmp alltraps
80106c10:	e9 d5 f7 ff ff       	jmp    801063ea <alltraps>

80106c15 <vector94>:
.globl vector94
vector94:
  pushl $0
80106c15:	6a 00                	push   $0x0
  pushl $94
80106c17:	6a 5e                	push   $0x5e
  jmp alltraps
80106c19:	e9 cc f7 ff ff       	jmp    801063ea <alltraps>

80106c1e <vector95>:
.globl vector95
vector95:
  pushl $0
80106c1e:	6a 00                	push   $0x0
  pushl $95
80106c20:	6a 5f                	push   $0x5f
  jmp alltraps
80106c22:	e9 c3 f7 ff ff       	jmp    801063ea <alltraps>

80106c27 <vector96>:
.globl vector96
vector96:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $96
80106c29:	6a 60                	push   $0x60
  jmp alltraps
80106c2b:	e9 ba f7 ff ff       	jmp    801063ea <alltraps>

80106c30 <vector97>:
.globl vector97
vector97:
  pushl $0
80106c30:	6a 00                	push   $0x0
  pushl $97
80106c32:	6a 61                	push   $0x61
  jmp alltraps
80106c34:	e9 b1 f7 ff ff       	jmp    801063ea <alltraps>

80106c39 <vector98>:
.globl vector98
vector98:
  pushl $0
80106c39:	6a 00                	push   $0x0
  pushl $98
80106c3b:	6a 62                	push   $0x62
  jmp alltraps
80106c3d:	e9 a8 f7 ff ff       	jmp    801063ea <alltraps>

80106c42 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c42:	6a 00                	push   $0x0
  pushl $99
80106c44:	6a 63                	push   $0x63
  jmp alltraps
80106c46:	e9 9f f7 ff ff       	jmp    801063ea <alltraps>

80106c4b <vector100>:
.globl vector100
vector100:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $100
80106c4d:	6a 64                	push   $0x64
  jmp alltraps
80106c4f:	e9 96 f7 ff ff       	jmp    801063ea <alltraps>

80106c54 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c54:	6a 00                	push   $0x0
  pushl $101
80106c56:	6a 65                	push   $0x65
  jmp alltraps
80106c58:	e9 8d f7 ff ff       	jmp    801063ea <alltraps>

80106c5d <vector102>:
.globl vector102
vector102:
  pushl $0
80106c5d:	6a 00                	push   $0x0
  pushl $102
80106c5f:	6a 66                	push   $0x66
  jmp alltraps
80106c61:	e9 84 f7 ff ff       	jmp    801063ea <alltraps>

80106c66 <vector103>:
.globl vector103
vector103:
  pushl $0
80106c66:	6a 00                	push   $0x0
  pushl $103
80106c68:	6a 67                	push   $0x67
  jmp alltraps
80106c6a:	e9 7b f7 ff ff       	jmp    801063ea <alltraps>

80106c6f <vector104>:
.globl vector104
vector104:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $104
80106c71:	6a 68                	push   $0x68
  jmp alltraps
80106c73:	e9 72 f7 ff ff       	jmp    801063ea <alltraps>

80106c78 <vector105>:
.globl vector105
vector105:
  pushl $0
80106c78:	6a 00                	push   $0x0
  pushl $105
80106c7a:	6a 69                	push   $0x69
  jmp alltraps
80106c7c:	e9 69 f7 ff ff       	jmp    801063ea <alltraps>

80106c81 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c81:	6a 00                	push   $0x0
  pushl $106
80106c83:	6a 6a                	push   $0x6a
  jmp alltraps
80106c85:	e9 60 f7 ff ff       	jmp    801063ea <alltraps>

80106c8a <vector107>:
.globl vector107
vector107:
  pushl $0
80106c8a:	6a 00                	push   $0x0
  pushl $107
80106c8c:	6a 6b                	push   $0x6b
  jmp alltraps
80106c8e:	e9 57 f7 ff ff       	jmp    801063ea <alltraps>

80106c93 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $108
80106c95:	6a 6c                	push   $0x6c
  jmp alltraps
80106c97:	e9 4e f7 ff ff       	jmp    801063ea <alltraps>

80106c9c <vector109>:
.globl vector109
vector109:
  pushl $0
80106c9c:	6a 00                	push   $0x0
  pushl $109
80106c9e:	6a 6d                	push   $0x6d
  jmp alltraps
80106ca0:	e9 45 f7 ff ff       	jmp    801063ea <alltraps>

80106ca5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106ca5:	6a 00                	push   $0x0
  pushl $110
80106ca7:	6a 6e                	push   $0x6e
  jmp alltraps
80106ca9:	e9 3c f7 ff ff       	jmp    801063ea <alltraps>

80106cae <vector111>:
.globl vector111
vector111:
  pushl $0
80106cae:	6a 00                	push   $0x0
  pushl $111
80106cb0:	6a 6f                	push   $0x6f
  jmp alltraps
80106cb2:	e9 33 f7 ff ff       	jmp    801063ea <alltraps>

80106cb7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $112
80106cb9:	6a 70                	push   $0x70
  jmp alltraps
80106cbb:	e9 2a f7 ff ff       	jmp    801063ea <alltraps>

80106cc0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106cc0:	6a 00                	push   $0x0
  pushl $113
80106cc2:	6a 71                	push   $0x71
  jmp alltraps
80106cc4:	e9 21 f7 ff ff       	jmp    801063ea <alltraps>

80106cc9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106cc9:	6a 00                	push   $0x0
  pushl $114
80106ccb:	6a 72                	push   $0x72
  jmp alltraps
80106ccd:	e9 18 f7 ff ff       	jmp    801063ea <alltraps>

80106cd2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106cd2:	6a 00                	push   $0x0
  pushl $115
80106cd4:	6a 73                	push   $0x73
  jmp alltraps
80106cd6:	e9 0f f7 ff ff       	jmp    801063ea <alltraps>

80106cdb <vector116>:
.globl vector116
vector116:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $116
80106cdd:	6a 74                	push   $0x74
  jmp alltraps
80106cdf:	e9 06 f7 ff ff       	jmp    801063ea <alltraps>

80106ce4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ce4:	6a 00                	push   $0x0
  pushl $117
80106ce6:	6a 75                	push   $0x75
  jmp alltraps
80106ce8:	e9 fd f6 ff ff       	jmp    801063ea <alltraps>

80106ced <vector118>:
.globl vector118
vector118:
  pushl $0
80106ced:	6a 00                	push   $0x0
  pushl $118
80106cef:	6a 76                	push   $0x76
  jmp alltraps
80106cf1:	e9 f4 f6 ff ff       	jmp    801063ea <alltraps>

80106cf6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106cf6:	6a 00                	push   $0x0
  pushl $119
80106cf8:	6a 77                	push   $0x77
  jmp alltraps
80106cfa:	e9 eb f6 ff ff       	jmp    801063ea <alltraps>

80106cff <vector120>:
.globl vector120
vector120:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $120
80106d01:	6a 78                	push   $0x78
  jmp alltraps
80106d03:	e9 e2 f6 ff ff       	jmp    801063ea <alltraps>

80106d08 <vector121>:
.globl vector121
vector121:
  pushl $0
80106d08:	6a 00                	push   $0x0
  pushl $121
80106d0a:	6a 79                	push   $0x79
  jmp alltraps
80106d0c:	e9 d9 f6 ff ff       	jmp    801063ea <alltraps>

80106d11 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d11:	6a 00                	push   $0x0
  pushl $122
80106d13:	6a 7a                	push   $0x7a
  jmp alltraps
80106d15:	e9 d0 f6 ff ff       	jmp    801063ea <alltraps>

80106d1a <vector123>:
.globl vector123
vector123:
  pushl $0
80106d1a:	6a 00                	push   $0x0
  pushl $123
80106d1c:	6a 7b                	push   $0x7b
  jmp alltraps
80106d1e:	e9 c7 f6 ff ff       	jmp    801063ea <alltraps>

80106d23 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $124
80106d25:	6a 7c                	push   $0x7c
  jmp alltraps
80106d27:	e9 be f6 ff ff       	jmp    801063ea <alltraps>

80106d2c <vector125>:
.globl vector125
vector125:
  pushl $0
80106d2c:	6a 00                	push   $0x0
  pushl $125
80106d2e:	6a 7d                	push   $0x7d
  jmp alltraps
80106d30:	e9 b5 f6 ff ff       	jmp    801063ea <alltraps>

80106d35 <vector126>:
.globl vector126
vector126:
  pushl $0
80106d35:	6a 00                	push   $0x0
  pushl $126
80106d37:	6a 7e                	push   $0x7e
  jmp alltraps
80106d39:	e9 ac f6 ff ff       	jmp    801063ea <alltraps>

80106d3e <vector127>:
.globl vector127
vector127:
  pushl $0
80106d3e:	6a 00                	push   $0x0
  pushl $127
80106d40:	6a 7f                	push   $0x7f
  jmp alltraps
80106d42:	e9 a3 f6 ff ff       	jmp    801063ea <alltraps>

80106d47 <vector128>:
.globl vector128
vector128:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $128
80106d49:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d4e:	e9 97 f6 ff ff       	jmp    801063ea <alltraps>

80106d53 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $129
80106d55:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d5a:	e9 8b f6 ff ff       	jmp    801063ea <alltraps>

80106d5f <vector130>:
.globl vector130
vector130:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $130
80106d61:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d66:	e9 7f f6 ff ff       	jmp    801063ea <alltraps>

80106d6b <vector131>:
.globl vector131
vector131:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $131
80106d6d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d72:	e9 73 f6 ff ff       	jmp    801063ea <alltraps>

80106d77 <vector132>:
.globl vector132
vector132:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $132
80106d79:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d7e:	e9 67 f6 ff ff       	jmp    801063ea <alltraps>

80106d83 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $133
80106d85:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d8a:	e9 5b f6 ff ff       	jmp    801063ea <alltraps>

80106d8f <vector134>:
.globl vector134
vector134:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $134
80106d91:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d96:	e9 4f f6 ff ff       	jmp    801063ea <alltraps>

80106d9b <vector135>:
.globl vector135
vector135:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $135
80106d9d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106da2:	e9 43 f6 ff ff       	jmp    801063ea <alltraps>

80106da7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $136
80106da9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106dae:	e9 37 f6 ff ff       	jmp    801063ea <alltraps>

80106db3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $137
80106db5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106dba:	e9 2b f6 ff ff       	jmp    801063ea <alltraps>

80106dbf <vector138>:
.globl vector138
vector138:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $138
80106dc1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106dc6:	e9 1f f6 ff ff       	jmp    801063ea <alltraps>

80106dcb <vector139>:
.globl vector139
vector139:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $139
80106dcd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106dd2:	e9 13 f6 ff ff       	jmp    801063ea <alltraps>

80106dd7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $140
80106dd9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106dde:	e9 07 f6 ff ff       	jmp    801063ea <alltraps>

80106de3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $141
80106de5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106dea:	e9 fb f5 ff ff       	jmp    801063ea <alltraps>

80106def <vector142>:
.globl vector142
vector142:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $142
80106df1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106df6:	e9 ef f5 ff ff       	jmp    801063ea <alltraps>

80106dfb <vector143>:
.globl vector143
vector143:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $143
80106dfd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106e02:	e9 e3 f5 ff ff       	jmp    801063ea <alltraps>

80106e07 <vector144>:
.globl vector144
vector144:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $144
80106e09:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106e0e:	e9 d7 f5 ff ff       	jmp    801063ea <alltraps>

80106e13 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $145
80106e15:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e1a:	e9 cb f5 ff ff       	jmp    801063ea <alltraps>

80106e1f <vector146>:
.globl vector146
vector146:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $146
80106e21:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e26:	e9 bf f5 ff ff       	jmp    801063ea <alltraps>

80106e2b <vector147>:
.globl vector147
vector147:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $147
80106e2d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e32:	e9 b3 f5 ff ff       	jmp    801063ea <alltraps>

80106e37 <vector148>:
.globl vector148
vector148:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $148
80106e39:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e3e:	e9 a7 f5 ff ff       	jmp    801063ea <alltraps>

80106e43 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $149
80106e45:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e4a:	e9 9b f5 ff ff       	jmp    801063ea <alltraps>

80106e4f <vector150>:
.globl vector150
vector150:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $150
80106e51:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e56:	e9 8f f5 ff ff       	jmp    801063ea <alltraps>

80106e5b <vector151>:
.globl vector151
vector151:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $151
80106e5d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e62:	e9 83 f5 ff ff       	jmp    801063ea <alltraps>

80106e67 <vector152>:
.globl vector152
vector152:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $152
80106e69:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e6e:	e9 77 f5 ff ff       	jmp    801063ea <alltraps>

80106e73 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $153
80106e75:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e7a:	e9 6b f5 ff ff       	jmp    801063ea <alltraps>

80106e7f <vector154>:
.globl vector154
vector154:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $154
80106e81:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e86:	e9 5f f5 ff ff       	jmp    801063ea <alltraps>

80106e8b <vector155>:
.globl vector155
vector155:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $155
80106e8d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e92:	e9 53 f5 ff ff       	jmp    801063ea <alltraps>

80106e97 <vector156>:
.globl vector156
vector156:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $156
80106e99:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106e9e:	e9 47 f5 ff ff       	jmp    801063ea <alltraps>

80106ea3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $157
80106ea5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106eaa:	e9 3b f5 ff ff       	jmp    801063ea <alltraps>

80106eaf <vector158>:
.globl vector158
vector158:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $158
80106eb1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106eb6:	e9 2f f5 ff ff       	jmp    801063ea <alltraps>

80106ebb <vector159>:
.globl vector159
vector159:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $159
80106ebd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ec2:	e9 23 f5 ff ff       	jmp    801063ea <alltraps>

80106ec7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $160
80106ec9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106ece:	e9 17 f5 ff ff       	jmp    801063ea <alltraps>

80106ed3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $161
80106ed5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106eda:	e9 0b f5 ff ff       	jmp    801063ea <alltraps>

80106edf <vector162>:
.globl vector162
vector162:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $162
80106ee1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106ee6:	e9 ff f4 ff ff       	jmp    801063ea <alltraps>

80106eeb <vector163>:
.globl vector163
vector163:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $163
80106eed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ef2:	e9 f3 f4 ff ff       	jmp    801063ea <alltraps>

80106ef7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $164
80106ef9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106efe:	e9 e7 f4 ff ff       	jmp    801063ea <alltraps>

80106f03 <vector165>:
.globl vector165
vector165:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $165
80106f05:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106f0a:	e9 db f4 ff ff       	jmp    801063ea <alltraps>

80106f0f <vector166>:
.globl vector166
vector166:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $166
80106f11:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f16:	e9 cf f4 ff ff       	jmp    801063ea <alltraps>

80106f1b <vector167>:
.globl vector167
vector167:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $167
80106f1d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f22:	e9 c3 f4 ff ff       	jmp    801063ea <alltraps>

80106f27 <vector168>:
.globl vector168
vector168:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $168
80106f29:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f2e:	e9 b7 f4 ff ff       	jmp    801063ea <alltraps>

80106f33 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $169
80106f35:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f3a:	e9 ab f4 ff ff       	jmp    801063ea <alltraps>

80106f3f <vector170>:
.globl vector170
vector170:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $170
80106f41:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f46:	e9 9f f4 ff ff       	jmp    801063ea <alltraps>

80106f4b <vector171>:
.globl vector171
vector171:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $171
80106f4d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f52:	e9 93 f4 ff ff       	jmp    801063ea <alltraps>

80106f57 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $172
80106f59:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f5e:	e9 87 f4 ff ff       	jmp    801063ea <alltraps>

80106f63 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $173
80106f65:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f6a:	e9 7b f4 ff ff       	jmp    801063ea <alltraps>

80106f6f <vector174>:
.globl vector174
vector174:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $174
80106f71:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f76:	e9 6f f4 ff ff       	jmp    801063ea <alltraps>

80106f7b <vector175>:
.globl vector175
vector175:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $175
80106f7d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f82:	e9 63 f4 ff ff       	jmp    801063ea <alltraps>

80106f87 <vector176>:
.globl vector176
vector176:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $176
80106f89:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f8e:	e9 57 f4 ff ff       	jmp    801063ea <alltraps>

80106f93 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $177
80106f95:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f9a:	e9 4b f4 ff ff       	jmp    801063ea <alltraps>

80106f9f <vector178>:
.globl vector178
vector178:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $178
80106fa1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106fa6:	e9 3f f4 ff ff       	jmp    801063ea <alltraps>

80106fab <vector179>:
.globl vector179
vector179:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $179
80106fad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106fb2:	e9 33 f4 ff ff       	jmp    801063ea <alltraps>

80106fb7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $180
80106fb9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106fbe:	e9 27 f4 ff ff       	jmp    801063ea <alltraps>

80106fc3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $181
80106fc5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106fca:	e9 1b f4 ff ff       	jmp    801063ea <alltraps>

80106fcf <vector182>:
.globl vector182
vector182:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $182
80106fd1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106fd6:	e9 0f f4 ff ff       	jmp    801063ea <alltraps>

80106fdb <vector183>:
.globl vector183
vector183:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $183
80106fdd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106fe2:	e9 03 f4 ff ff       	jmp    801063ea <alltraps>

80106fe7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $184
80106fe9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106fee:	e9 f7 f3 ff ff       	jmp    801063ea <alltraps>

80106ff3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $185
80106ff5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106ffa:	e9 eb f3 ff ff       	jmp    801063ea <alltraps>

80106fff <vector186>:
.globl vector186
vector186:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $186
80107001:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107006:	e9 df f3 ff ff       	jmp    801063ea <alltraps>

8010700b <vector187>:
.globl vector187
vector187:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $187
8010700d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107012:	e9 d3 f3 ff ff       	jmp    801063ea <alltraps>

80107017 <vector188>:
.globl vector188
vector188:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $188
80107019:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010701e:	e9 c7 f3 ff ff       	jmp    801063ea <alltraps>

80107023 <vector189>:
.globl vector189
vector189:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $189
80107025:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010702a:	e9 bb f3 ff ff       	jmp    801063ea <alltraps>

8010702f <vector190>:
.globl vector190
vector190:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $190
80107031:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107036:	e9 af f3 ff ff       	jmp    801063ea <alltraps>

8010703b <vector191>:
.globl vector191
vector191:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $191
8010703d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107042:	e9 a3 f3 ff ff       	jmp    801063ea <alltraps>

80107047 <vector192>:
.globl vector192
vector192:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $192
80107049:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010704e:	e9 97 f3 ff ff       	jmp    801063ea <alltraps>

80107053 <vector193>:
.globl vector193
vector193:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $193
80107055:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010705a:	e9 8b f3 ff ff       	jmp    801063ea <alltraps>

8010705f <vector194>:
.globl vector194
vector194:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $194
80107061:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107066:	e9 7f f3 ff ff       	jmp    801063ea <alltraps>

8010706b <vector195>:
.globl vector195
vector195:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $195
8010706d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107072:	e9 73 f3 ff ff       	jmp    801063ea <alltraps>

80107077 <vector196>:
.globl vector196
vector196:
  pushl $0
80107077:	6a 00                	push   $0x0
  pushl $196
80107079:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010707e:	e9 67 f3 ff ff       	jmp    801063ea <alltraps>

80107083 <vector197>:
.globl vector197
vector197:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $197
80107085:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010708a:	e9 5b f3 ff ff       	jmp    801063ea <alltraps>

8010708f <vector198>:
.globl vector198
vector198:
  pushl $0
8010708f:	6a 00                	push   $0x0
  pushl $198
80107091:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107096:	e9 4f f3 ff ff       	jmp    801063ea <alltraps>

8010709b <vector199>:
.globl vector199
vector199:
  pushl $0
8010709b:	6a 00                	push   $0x0
  pushl $199
8010709d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801070a2:	e9 43 f3 ff ff       	jmp    801063ea <alltraps>

801070a7 <vector200>:
.globl vector200
vector200:
  pushl $0
801070a7:	6a 00                	push   $0x0
  pushl $200
801070a9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801070ae:	e9 37 f3 ff ff       	jmp    801063ea <alltraps>

801070b3 <vector201>:
.globl vector201
vector201:
  pushl $0
801070b3:	6a 00                	push   $0x0
  pushl $201
801070b5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070ba:	e9 2b f3 ff ff       	jmp    801063ea <alltraps>

801070bf <vector202>:
.globl vector202
vector202:
  pushl $0
801070bf:	6a 00                	push   $0x0
  pushl $202
801070c1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801070c6:	e9 1f f3 ff ff       	jmp    801063ea <alltraps>

801070cb <vector203>:
.globl vector203
vector203:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $203
801070cd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801070d2:	e9 13 f3 ff ff       	jmp    801063ea <alltraps>

801070d7 <vector204>:
.globl vector204
vector204:
  pushl $0
801070d7:	6a 00                	push   $0x0
  pushl $204
801070d9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801070de:	e9 07 f3 ff ff       	jmp    801063ea <alltraps>

801070e3 <vector205>:
.globl vector205
vector205:
  pushl $0
801070e3:	6a 00                	push   $0x0
  pushl $205
801070e5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801070ea:	e9 fb f2 ff ff       	jmp    801063ea <alltraps>

801070ef <vector206>:
.globl vector206
vector206:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $206
801070f1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801070f6:	e9 ef f2 ff ff       	jmp    801063ea <alltraps>

801070fb <vector207>:
.globl vector207
vector207:
  pushl $0
801070fb:	6a 00                	push   $0x0
  pushl $207
801070fd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107102:	e9 e3 f2 ff ff       	jmp    801063ea <alltraps>

80107107 <vector208>:
.globl vector208
vector208:
  pushl $0
80107107:	6a 00                	push   $0x0
  pushl $208
80107109:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010710e:	e9 d7 f2 ff ff       	jmp    801063ea <alltraps>

80107113 <vector209>:
.globl vector209
vector209:
  pushl $0
80107113:	6a 00                	push   $0x0
  pushl $209
80107115:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010711a:	e9 cb f2 ff ff       	jmp    801063ea <alltraps>

8010711f <vector210>:
.globl vector210
vector210:
  pushl $0
8010711f:	6a 00                	push   $0x0
  pushl $210
80107121:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107126:	e9 bf f2 ff ff       	jmp    801063ea <alltraps>

8010712b <vector211>:
.globl vector211
vector211:
  pushl $0
8010712b:	6a 00                	push   $0x0
  pushl $211
8010712d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107132:	e9 b3 f2 ff ff       	jmp    801063ea <alltraps>

80107137 <vector212>:
.globl vector212
vector212:
  pushl $0
80107137:	6a 00                	push   $0x0
  pushl $212
80107139:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010713e:	e9 a7 f2 ff ff       	jmp    801063ea <alltraps>

80107143 <vector213>:
.globl vector213
vector213:
  pushl $0
80107143:	6a 00                	push   $0x0
  pushl $213
80107145:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010714a:	e9 9b f2 ff ff       	jmp    801063ea <alltraps>

8010714f <vector214>:
.globl vector214
vector214:
  pushl $0
8010714f:	6a 00                	push   $0x0
  pushl $214
80107151:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107156:	e9 8f f2 ff ff       	jmp    801063ea <alltraps>

8010715b <vector215>:
.globl vector215
vector215:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $215
8010715d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107162:	e9 83 f2 ff ff       	jmp    801063ea <alltraps>

80107167 <vector216>:
.globl vector216
vector216:
  pushl $0
80107167:	6a 00                	push   $0x0
  pushl $216
80107169:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010716e:	e9 77 f2 ff ff       	jmp    801063ea <alltraps>

80107173 <vector217>:
.globl vector217
vector217:
  pushl $0
80107173:	6a 00                	push   $0x0
  pushl $217
80107175:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010717a:	e9 6b f2 ff ff       	jmp    801063ea <alltraps>

8010717f <vector218>:
.globl vector218
vector218:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $218
80107181:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107186:	e9 5f f2 ff ff       	jmp    801063ea <alltraps>

8010718b <vector219>:
.globl vector219
vector219:
  pushl $0
8010718b:	6a 00                	push   $0x0
  pushl $219
8010718d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107192:	e9 53 f2 ff ff       	jmp    801063ea <alltraps>

80107197 <vector220>:
.globl vector220
vector220:
  pushl $0
80107197:	6a 00                	push   $0x0
  pushl $220
80107199:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010719e:	e9 47 f2 ff ff       	jmp    801063ea <alltraps>

801071a3 <vector221>:
.globl vector221
vector221:
  pushl $0
801071a3:	6a 00                	push   $0x0
  pushl $221
801071a5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801071aa:	e9 3b f2 ff ff       	jmp    801063ea <alltraps>

801071af <vector222>:
.globl vector222
vector222:
  pushl $0
801071af:	6a 00                	push   $0x0
  pushl $222
801071b1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071b6:	e9 2f f2 ff ff       	jmp    801063ea <alltraps>

801071bb <vector223>:
.globl vector223
vector223:
  pushl $0
801071bb:	6a 00                	push   $0x0
  pushl $223
801071bd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801071c2:	e9 23 f2 ff ff       	jmp    801063ea <alltraps>

801071c7 <vector224>:
.globl vector224
vector224:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $224
801071c9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801071ce:	e9 17 f2 ff ff       	jmp    801063ea <alltraps>

801071d3 <vector225>:
.globl vector225
vector225:
  pushl $0
801071d3:	6a 00                	push   $0x0
  pushl $225
801071d5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801071da:	e9 0b f2 ff ff       	jmp    801063ea <alltraps>

801071df <vector226>:
.globl vector226
vector226:
  pushl $0
801071df:	6a 00                	push   $0x0
  pushl $226
801071e1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801071e6:	e9 ff f1 ff ff       	jmp    801063ea <alltraps>

801071eb <vector227>:
.globl vector227
vector227:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $227
801071ed:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801071f2:	e9 f3 f1 ff ff       	jmp    801063ea <alltraps>

801071f7 <vector228>:
.globl vector228
vector228:
  pushl $0
801071f7:	6a 00                	push   $0x0
  pushl $228
801071f9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801071fe:	e9 e7 f1 ff ff       	jmp    801063ea <alltraps>

80107203 <vector229>:
.globl vector229
vector229:
  pushl $0
80107203:	6a 00                	push   $0x0
  pushl $229
80107205:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010720a:	e9 db f1 ff ff       	jmp    801063ea <alltraps>

8010720f <vector230>:
.globl vector230
vector230:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $230
80107211:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107216:	e9 cf f1 ff ff       	jmp    801063ea <alltraps>

8010721b <vector231>:
.globl vector231
vector231:
  pushl $0
8010721b:	6a 00                	push   $0x0
  pushl $231
8010721d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107222:	e9 c3 f1 ff ff       	jmp    801063ea <alltraps>

80107227 <vector232>:
.globl vector232
vector232:
  pushl $0
80107227:	6a 00                	push   $0x0
  pushl $232
80107229:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010722e:	e9 b7 f1 ff ff       	jmp    801063ea <alltraps>

80107233 <vector233>:
.globl vector233
vector233:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $233
80107235:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010723a:	e9 ab f1 ff ff       	jmp    801063ea <alltraps>

8010723f <vector234>:
.globl vector234
vector234:
  pushl $0
8010723f:	6a 00                	push   $0x0
  pushl $234
80107241:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107246:	e9 9f f1 ff ff       	jmp    801063ea <alltraps>

8010724b <vector235>:
.globl vector235
vector235:
  pushl $0
8010724b:	6a 00                	push   $0x0
  pushl $235
8010724d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107252:	e9 93 f1 ff ff       	jmp    801063ea <alltraps>

80107257 <vector236>:
.globl vector236
vector236:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $236
80107259:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010725e:	e9 87 f1 ff ff       	jmp    801063ea <alltraps>

80107263 <vector237>:
.globl vector237
vector237:
  pushl $0
80107263:	6a 00                	push   $0x0
  pushl $237
80107265:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010726a:	e9 7b f1 ff ff       	jmp    801063ea <alltraps>

8010726f <vector238>:
.globl vector238
vector238:
  pushl $0
8010726f:	6a 00                	push   $0x0
  pushl $238
80107271:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107276:	e9 6f f1 ff ff       	jmp    801063ea <alltraps>

8010727b <vector239>:
.globl vector239
vector239:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $239
8010727d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107282:	e9 63 f1 ff ff       	jmp    801063ea <alltraps>

80107287 <vector240>:
.globl vector240
vector240:
  pushl $0
80107287:	6a 00                	push   $0x0
  pushl $240
80107289:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010728e:	e9 57 f1 ff ff       	jmp    801063ea <alltraps>

80107293 <vector241>:
.globl vector241
vector241:
  pushl $0
80107293:	6a 00                	push   $0x0
  pushl $241
80107295:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010729a:	e9 4b f1 ff ff       	jmp    801063ea <alltraps>

8010729f <vector242>:
.globl vector242
vector242:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $242
801072a1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801072a6:	e9 3f f1 ff ff       	jmp    801063ea <alltraps>

801072ab <vector243>:
.globl vector243
vector243:
  pushl $0
801072ab:	6a 00                	push   $0x0
  pushl $243
801072ad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072b2:	e9 33 f1 ff ff       	jmp    801063ea <alltraps>

801072b7 <vector244>:
.globl vector244
vector244:
  pushl $0
801072b7:	6a 00                	push   $0x0
  pushl $244
801072b9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072be:	e9 27 f1 ff ff       	jmp    801063ea <alltraps>

801072c3 <vector245>:
.globl vector245
vector245:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $245
801072c5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801072ca:	e9 1b f1 ff ff       	jmp    801063ea <alltraps>

801072cf <vector246>:
.globl vector246
vector246:
  pushl $0
801072cf:	6a 00                	push   $0x0
  pushl $246
801072d1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801072d6:	e9 0f f1 ff ff       	jmp    801063ea <alltraps>

801072db <vector247>:
.globl vector247
vector247:
  pushl $0
801072db:	6a 00                	push   $0x0
  pushl $247
801072dd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801072e2:	e9 03 f1 ff ff       	jmp    801063ea <alltraps>

801072e7 <vector248>:
.globl vector248
vector248:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $248
801072e9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801072ee:	e9 f7 f0 ff ff       	jmp    801063ea <alltraps>

801072f3 <vector249>:
.globl vector249
vector249:
  pushl $0
801072f3:	6a 00                	push   $0x0
  pushl $249
801072f5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801072fa:	e9 eb f0 ff ff       	jmp    801063ea <alltraps>

801072ff <vector250>:
.globl vector250
vector250:
  pushl $0
801072ff:	6a 00                	push   $0x0
  pushl $250
80107301:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107306:	e9 df f0 ff ff       	jmp    801063ea <alltraps>

8010730b <vector251>:
.globl vector251
vector251:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $251
8010730d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107312:	e9 d3 f0 ff ff       	jmp    801063ea <alltraps>

80107317 <vector252>:
.globl vector252
vector252:
  pushl $0
80107317:	6a 00                	push   $0x0
  pushl $252
80107319:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010731e:	e9 c7 f0 ff ff       	jmp    801063ea <alltraps>

80107323 <vector253>:
.globl vector253
vector253:
  pushl $0
80107323:	6a 00                	push   $0x0
  pushl $253
80107325:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010732a:	e9 bb f0 ff ff       	jmp    801063ea <alltraps>

8010732f <vector254>:
.globl vector254
vector254:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $254
80107331:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107336:	e9 af f0 ff ff       	jmp    801063ea <alltraps>

8010733b <vector255>:
.globl vector255
vector255:
  pushl $0
8010733b:	6a 00                	push   $0x0
  pushl $255
8010733d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107342:	e9 a3 f0 ff ff       	jmp    801063ea <alltraps>
80107347:	66 90                	xchg   %ax,%ax
80107349:	66 90                	xchg   %ax,%ax
8010734b:	66 90                	xchg   %ax,%ax
8010734d:	66 90                	xchg   %ax,%ax
8010734f:	90                   	nop

80107350 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107350:	55                   	push   %ebp
80107351:	89 e5                	mov    %esp,%ebp
80107353:	57                   	push   %edi
80107354:	56                   	push   %esi
80107355:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107356:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010735c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107362:	83 ec 1c             	sub    $0x1c,%esp
80107365:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107368:	39 d3                	cmp    %edx,%ebx
8010736a:	73 49                	jae    801073b5 <deallocuvm.part.0+0x65>
8010736c:	89 c7                	mov    %eax,%edi
8010736e:	eb 0c                	jmp    8010737c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107370:	83 c0 01             	add    $0x1,%eax
80107373:	c1 e0 16             	shl    $0x16,%eax
80107376:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107378:	39 da                	cmp    %ebx,%edx
8010737a:	76 39                	jbe    801073b5 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010737c:	89 d8                	mov    %ebx,%eax
8010737e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107381:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107384:	f6 c1 01             	test   $0x1,%cl
80107387:	74 e7                	je     80107370 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107389:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010738b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107391:	c1 ee 0a             	shr    $0xa,%esi
80107394:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010739a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
801073a1:	85 f6                	test   %esi,%esi
801073a3:	74 cb                	je     80107370 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
801073a5:	8b 06                	mov    (%esi),%eax
801073a7:	a8 01                	test   $0x1,%al
801073a9:	75 15                	jne    801073c0 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
801073ab:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801073b1:	39 da                	cmp    %ebx,%edx
801073b3:	77 c7                	ja     8010737c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801073b5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073bb:	5b                   	pop    %ebx
801073bc:	5e                   	pop    %esi
801073bd:	5f                   	pop    %edi
801073be:	5d                   	pop    %ebp
801073bf:	c3                   	ret    
      if(pa == 0)
801073c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073c5:	74 25                	je     801073ec <deallocuvm.part.0+0x9c>
      kfree(v);
801073c7:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801073ca:	05 00 00 00 80       	add    $0x80000000,%eax
801073cf:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801073d2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
801073d8:	50                   	push   %eax
801073d9:	e8 92 bc ff ff       	call   80103070 <kfree>
      *pte = 0;
801073de:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
801073e4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801073e7:	83 c4 10             	add    $0x10,%esp
801073ea:	eb 8c                	jmp    80107378 <deallocuvm.part.0+0x28>
        panic("kfree");
801073ec:	83 ec 0c             	sub    $0xc,%esp
801073ef:	68 a6 7f 10 80       	push   $0x80107fa6
801073f4:	e8 87 8f ff ff       	call   80100380 <panic>
801073f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107400 <mappages>:
{
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	57                   	push   %edi
80107404:	56                   	push   %esi
80107405:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107406:	89 d3                	mov    %edx,%ebx
80107408:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010740e:	83 ec 1c             	sub    $0x1c,%esp
80107411:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107414:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107418:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010741d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107420:	8b 45 08             	mov    0x8(%ebp),%eax
80107423:	29 d8                	sub    %ebx,%eax
80107425:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107428:	eb 3d                	jmp    80107467 <mappages+0x67>
8010742a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107430:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107432:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107437:	c1 ea 0a             	shr    $0xa,%edx
8010743a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107440:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107447:	85 c0                	test   %eax,%eax
80107449:	74 75                	je     801074c0 <mappages+0xc0>
    if(*pte & PTE_P)
8010744b:	f6 00 01             	testb  $0x1,(%eax)
8010744e:	0f 85 86 00 00 00    	jne    801074da <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107454:	0b 75 0c             	or     0xc(%ebp),%esi
80107457:	83 ce 01             	or     $0x1,%esi
8010745a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010745c:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
8010745f:	74 6f                	je     801074d0 <mappages+0xd0>
    a += PGSIZE;
80107461:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107467:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010746a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010746d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107470:	89 d8                	mov    %ebx,%eax
80107472:	c1 e8 16             	shr    $0x16,%eax
80107475:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107478:	8b 07                	mov    (%edi),%eax
8010747a:	a8 01                	test   $0x1,%al
8010747c:	75 b2                	jne    80107430 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010747e:	e8 ad bd ff ff       	call   80103230 <kalloc>
80107483:	85 c0                	test   %eax,%eax
80107485:	74 39                	je     801074c0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107487:	83 ec 04             	sub    $0x4,%esp
8010748a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010748d:	68 00 10 00 00       	push   $0x1000
80107492:	6a 00                	push   $0x0
80107494:	50                   	push   %eax
80107495:	e8 76 dd ff ff       	call   80105210 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010749a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010749d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801074a0:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801074a6:	83 c8 07             	or     $0x7,%eax
801074a9:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801074ab:	89 d8                	mov    %ebx,%eax
801074ad:	c1 e8 0a             	shr    $0xa,%eax
801074b0:	25 fc 0f 00 00       	and    $0xffc,%eax
801074b5:	01 d0                	add    %edx,%eax
801074b7:	eb 92                	jmp    8010744b <mappages+0x4b>
801074b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
801074c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801074c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801074c8:	5b                   	pop    %ebx
801074c9:	5e                   	pop    %esi
801074ca:	5f                   	pop    %edi
801074cb:	5d                   	pop    %ebp
801074cc:	c3                   	ret    
801074cd:	8d 76 00             	lea    0x0(%esi),%esi
801074d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801074d3:	31 c0                	xor    %eax,%eax
}
801074d5:	5b                   	pop    %ebx
801074d6:	5e                   	pop    %esi
801074d7:	5f                   	pop    %edi
801074d8:	5d                   	pop    %ebp
801074d9:	c3                   	ret    
      panic("remap");
801074da:	83 ec 0c             	sub    $0xc,%esp
801074dd:	68 e8 85 10 80       	push   $0x801085e8
801074e2:	e8 99 8e ff ff       	call   80100380 <panic>
801074e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074ee:	66 90                	xchg   %ax,%ax

801074f0 <seginit>:
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801074f6:	e8 05 d0 ff ff       	call   80104500 <cpuid>
  pd[0] = size-1;
801074fb:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107500:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107506:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010750a:	c7 80 18 34 11 80 ff 	movl   $0xffff,-0x7feecbe8(%eax)
80107511:	ff 00 00 
80107514:	c7 80 1c 34 11 80 00 	movl   $0xcf9a00,-0x7feecbe4(%eax)
8010751b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010751e:	c7 80 20 34 11 80 ff 	movl   $0xffff,-0x7feecbe0(%eax)
80107525:	ff 00 00 
80107528:	c7 80 24 34 11 80 00 	movl   $0xcf9200,-0x7feecbdc(%eax)
8010752f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107532:	c7 80 28 34 11 80 ff 	movl   $0xffff,-0x7feecbd8(%eax)
80107539:	ff 00 00 
8010753c:	c7 80 2c 34 11 80 00 	movl   $0xcffa00,-0x7feecbd4(%eax)
80107543:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107546:	c7 80 30 34 11 80 ff 	movl   $0xffff,-0x7feecbd0(%eax)
8010754d:	ff 00 00 
80107550:	c7 80 34 34 11 80 00 	movl   $0xcff200,-0x7feecbcc(%eax)
80107557:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010755a:	05 10 34 11 80       	add    $0x80113410,%eax
  pd[1] = (uint)p;
8010755f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107563:	c1 e8 10             	shr    $0x10,%eax
80107566:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010756a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010756d:	0f 01 10             	lgdtl  (%eax)
}
80107570:	c9                   	leave  
80107571:	c3                   	ret    
80107572:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107580 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107580:	a1 c4 60 11 80       	mov    0x801160c4,%eax
80107585:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010758a:	0f 22 d8             	mov    %eax,%cr3
}
8010758d:	c3                   	ret    
8010758e:	66 90                	xchg   %ax,%ax

80107590 <switchuvm>:
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	57                   	push   %edi
80107594:	56                   	push   %esi
80107595:	53                   	push   %ebx
80107596:	83 ec 1c             	sub    $0x1c,%esp
80107599:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010759c:	85 f6                	test   %esi,%esi
8010759e:	0f 84 cb 00 00 00    	je     8010766f <switchuvm+0xdf>
  if(p->kstack == 0)
801075a4:	8b 46 08             	mov    0x8(%esi),%eax
801075a7:	85 c0                	test   %eax,%eax
801075a9:	0f 84 da 00 00 00    	je     80107689 <switchuvm+0xf9>
  if(p->pgdir == 0)
801075af:	8b 46 04             	mov    0x4(%esi),%eax
801075b2:	85 c0                	test   %eax,%eax
801075b4:	0f 84 c2 00 00 00    	je     8010767c <switchuvm+0xec>
  pushcli();
801075ba:	e8 41 da ff ff       	call   80105000 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801075bf:	e8 dc ce ff ff       	call   801044a0 <mycpu>
801075c4:	89 c3                	mov    %eax,%ebx
801075c6:	e8 d5 ce ff ff       	call   801044a0 <mycpu>
801075cb:	89 c7                	mov    %eax,%edi
801075cd:	e8 ce ce ff ff       	call   801044a0 <mycpu>
801075d2:	83 c7 08             	add    $0x8,%edi
801075d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801075d8:	e8 c3 ce ff ff       	call   801044a0 <mycpu>
801075dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801075e0:	ba 67 00 00 00       	mov    $0x67,%edx
801075e5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801075ec:	83 c0 08             	add    $0x8,%eax
801075ef:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801075f6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801075fb:	83 c1 08             	add    $0x8,%ecx
801075fe:	c1 e8 18             	shr    $0x18,%eax
80107601:	c1 e9 10             	shr    $0x10,%ecx
80107604:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010760a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107610:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107615:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010761c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107621:	e8 7a ce ff ff       	call   801044a0 <mycpu>
80107626:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010762d:	e8 6e ce ff ff       	call   801044a0 <mycpu>
80107632:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107636:	8b 5e 08             	mov    0x8(%esi),%ebx
80107639:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010763f:	e8 5c ce ff ff       	call   801044a0 <mycpu>
80107644:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107647:	e8 54 ce ff ff       	call   801044a0 <mycpu>
8010764c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107650:	b8 28 00 00 00       	mov    $0x28,%eax
80107655:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107658:	8b 46 04             	mov    0x4(%esi),%eax
8010765b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107660:	0f 22 d8             	mov    %eax,%cr3
}
80107663:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107666:	5b                   	pop    %ebx
80107667:	5e                   	pop    %esi
80107668:	5f                   	pop    %edi
80107669:	5d                   	pop    %ebp
  popcli();
8010766a:	e9 e1 d9 ff ff       	jmp    80105050 <popcli>
    panic("switchuvm: no process");
8010766f:	83 ec 0c             	sub    $0xc,%esp
80107672:	68 ee 85 10 80       	push   $0x801085ee
80107677:	e8 04 8d ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010767c:	83 ec 0c             	sub    $0xc,%esp
8010767f:	68 19 86 10 80       	push   $0x80108619
80107684:	e8 f7 8c ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107689:	83 ec 0c             	sub    $0xc,%esp
8010768c:	68 04 86 10 80       	push   $0x80108604
80107691:	e8 ea 8c ff ff       	call   80100380 <panic>
80107696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010769d:	8d 76 00             	lea    0x0(%esi),%esi

801076a0 <inituvm>:
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	57                   	push   %edi
801076a4:	56                   	push   %esi
801076a5:	53                   	push   %ebx
801076a6:	83 ec 1c             	sub    $0x1c,%esp
801076a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801076ac:	8b 75 10             	mov    0x10(%ebp),%esi
801076af:	8b 7d 08             	mov    0x8(%ebp),%edi
801076b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801076b5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801076bb:	77 4b                	ja     80107708 <inituvm+0x68>
  mem = kalloc();
801076bd:	e8 6e bb ff ff       	call   80103230 <kalloc>
  memset(mem, 0, PGSIZE);
801076c2:	83 ec 04             	sub    $0x4,%esp
801076c5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801076ca:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801076cc:	6a 00                	push   $0x0
801076ce:	50                   	push   %eax
801076cf:	e8 3c db ff ff       	call   80105210 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801076d4:	58                   	pop    %eax
801076d5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801076db:	5a                   	pop    %edx
801076dc:	6a 06                	push   $0x6
801076de:	b9 00 10 00 00       	mov    $0x1000,%ecx
801076e3:	31 d2                	xor    %edx,%edx
801076e5:	50                   	push   %eax
801076e6:	89 f8                	mov    %edi,%eax
801076e8:	e8 13 fd ff ff       	call   80107400 <mappages>
  memmove(mem, init, sz);
801076ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801076f0:	89 75 10             	mov    %esi,0x10(%ebp)
801076f3:	83 c4 10             	add    $0x10,%esp
801076f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801076f9:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801076fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076ff:	5b                   	pop    %ebx
80107700:	5e                   	pop    %esi
80107701:	5f                   	pop    %edi
80107702:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107703:	e9 a8 db ff ff       	jmp    801052b0 <memmove>
    panic("inituvm: more than a page");
80107708:	83 ec 0c             	sub    $0xc,%esp
8010770b:	68 2d 86 10 80       	push   $0x8010862d
80107710:	e8 6b 8c ff ff       	call   80100380 <panic>
80107715:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010771c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107720 <loaduvm>:
{
80107720:	55                   	push   %ebp
80107721:	89 e5                	mov    %esp,%ebp
80107723:	57                   	push   %edi
80107724:	56                   	push   %esi
80107725:	53                   	push   %ebx
80107726:	83 ec 1c             	sub    $0x1c,%esp
80107729:	8b 45 0c             	mov    0xc(%ebp),%eax
8010772c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010772f:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107734:	0f 85 bb 00 00 00    	jne    801077f5 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
8010773a:	01 f0                	add    %esi,%eax
8010773c:	89 f3                	mov    %esi,%ebx
8010773e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107741:	8b 45 14             	mov    0x14(%ebp),%eax
80107744:	01 f0                	add    %esi,%eax
80107746:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107749:	85 f6                	test   %esi,%esi
8010774b:	0f 84 87 00 00 00    	je     801077d8 <loaduvm+0xb8>
80107751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107758:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
8010775b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010775e:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107760:	89 c2                	mov    %eax,%edx
80107762:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107765:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107768:	f6 c2 01             	test   $0x1,%dl
8010776b:	75 13                	jne    80107780 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010776d:	83 ec 0c             	sub    $0xc,%esp
80107770:	68 47 86 10 80       	push   $0x80108647
80107775:	e8 06 8c ff ff       	call   80100380 <panic>
8010777a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107780:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107783:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107789:	25 fc 0f 00 00       	and    $0xffc,%eax
8010778e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107795:	85 c0                	test   %eax,%eax
80107797:	74 d4                	je     8010776d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107799:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010779b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010779e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801077a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801077a8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801077ae:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801077b1:	29 d9                	sub    %ebx,%ecx
801077b3:	05 00 00 00 80       	add    $0x80000000,%eax
801077b8:	57                   	push   %edi
801077b9:	51                   	push   %ecx
801077ba:	50                   	push   %eax
801077bb:	ff 75 10             	push   0x10(%ebp)
801077be:	e8 7d ae ff ff       	call   80102640 <readi>
801077c3:	83 c4 10             	add    $0x10,%esp
801077c6:	39 f8                	cmp    %edi,%eax
801077c8:	75 1e                	jne    801077e8 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801077ca:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801077d0:	89 f0                	mov    %esi,%eax
801077d2:	29 d8                	sub    %ebx,%eax
801077d4:	39 c6                	cmp    %eax,%esi
801077d6:	77 80                	ja     80107758 <loaduvm+0x38>
}
801077d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801077db:	31 c0                	xor    %eax,%eax
}
801077dd:	5b                   	pop    %ebx
801077de:	5e                   	pop    %esi
801077df:	5f                   	pop    %edi
801077e0:	5d                   	pop    %ebp
801077e1:	c3                   	ret    
801077e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801077e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801077eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801077f0:	5b                   	pop    %ebx
801077f1:	5e                   	pop    %esi
801077f2:	5f                   	pop    %edi
801077f3:	5d                   	pop    %ebp
801077f4:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
801077f5:	83 ec 0c             	sub    $0xc,%esp
801077f8:	68 e8 86 10 80       	push   $0x801086e8
801077fd:	e8 7e 8b ff ff       	call   80100380 <panic>
80107802:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107810 <allocuvm>:
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107819:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010781c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010781f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107822:	85 c0                	test   %eax,%eax
80107824:	0f 88 b6 00 00 00    	js     801078e0 <allocuvm+0xd0>
  if(newsz < oldsz)
8010782a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010782d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107830:	0f 82 9a 00 00 00    	jb     801078d0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107836:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
8010783c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107842:	39 75 10             	cmp    %esi,0x10(%ebp)
80107845:	77 44                	ja     8010788b <allocuvm+0x7b>
80107847:	e9 87 00 00 00       	jmp    801078d3 <allocuvm+0xc3>
8010784c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107850:	83 ec 04             	sub    $0x4,%esp
80107853:	68 00 10 00 00       	push   $0x1000
80107858:	6a 00                	push   $0x0
8010785a:	50                   	push   %eax
8010785b:	e8 b0 d9 ff ff       	call   80105210 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107860:	58                   	pop    %eax
80107861:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107867:	5a                   	pop    %edx
80107868:	6a 06                	push   $0x6
8010786a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010786f:	89 f2                	mov    %esi,%edx
80107871:	50                   	push   %eax
80107872:	89 f8                	mov    %edi,%eax
80107874:	e8 87 fb ff ff       	call   80107400 <mappages>
80107879:	83 c4 10             	add    $0x10,%esp
8010787c:	85 c0                	test   %eax,%eax
8010787e:	78 78                	js     801078f8 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107880:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107886:	39 75 10             	cmp    %esi,0x10(%ebp)
80107889:	76 48                	jbe    801078d3 <allocuvm+0xc3>
    mem = kalloc();
8010788b:	e8 a0 b9 ff ff       	call   80103230 <kalloc>
80107890:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107892:	85 c0                	test   %eax,%eax
80107894:	75 ba                	jne    80107850 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107896:	83 ec 0c             	sub    $0xc,%esp
80107899:	68 65 86 10 80       	push   $0x80108665
8010789e:	e8 3d 8e ff ff       	call   801006e0 <cprintf>
  if(newsz >= oldsz)
801078a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801078a6:	83 c4 10             	add    $0x10,%esp
801078a9:	39 45 10             	cmp    %eax,0x10(%ebp)
801078ac:	74 32                	je     801078e0 <allocuvm+0xd0>
801078ae:	8b 55 10             	mov    0x10(%ebp),%edx
801078b1:	89 c1                	mov    %eax,%ecx
801078b3:	89 f8                	mov    %edi,%eax
801078b5:	e8 96 fa ff ff       	call   80107350 <deallocuvm.part.0>
      return 0;
801078ba:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801078c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078c7:	5b                   	pop    %ebx
801078c8:	5e                   	pop    %esi
801078c9:	5f                   	pop    %edi
801078ca:	5d                   	pop    %ebp
801078cb:	c3                   	ret    
801078cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801078d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
801078d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078d9:	5b                   	pop    %ebx
801078da:	5e                   	pop    %esi
801078db:	5f                   	pop    %edi
801078dc:	5d                   	pop    %ebp
801078dd:	c3                   	ret    
801078de:	66 90                	xchg   %ax,%ax
    return 0;
801078e0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801078e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078ed:	5b                   	pop    %ebx
801078ee:	5e                   	pop    %esi
801078ef:	5f                   	pop    %edi
801078f0:	5d                   	pop    %ebp
801078f1:	c3                   	ret    
801078f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801078f8:	83 ec 0c             	sub    $0xc,%esp
801078fb:	68 7d 86 10 80       	push   $0x8010867d
80107900:	e8 db 8d ff ff       	call   801006e0 <cprintf>
  if(newsz >= oldsz)
80107905:	8b 45 0c             	mov    0xc(%ebp),%eax
80107908:	83 c4 10             	add    $0x10,%esp
8010790b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010790e:	74 0c                	je     8010791c <allocuvm+0x10c>
80107910:	8b 55 10             	mov    0x10(%ebp),%edx
80107913:	89 c1                	mov    %eax,%ecx
80107915:	89 f8                	mov    %edi,%eax
80107917:	e8 34 fa ff ff       	call   80107350 <deallocuvm.part.0>
      kfree(mem);
8010791c:	83 ec 0c             	sub    $0xc,%esp
8010791f:	53                   	push   %ebx
80107920:	e8 4b b7 ff ff       	call   80103070 <kfree>
      return 0;
80107925:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010792c:	83 c4 10             	add    $0x10,%esp
}
8010792f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107932:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107935:	5b                   	pop    %ebx
80107936:	5e                   	pop    %esi
80107937:	5f                   	pop    %edi
80107938:	5d                   	pop    %ebp
80107939:	c3                   	ret    
8010793a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107940 <deallocuvm>:
{
80107940:	55                   	push   %ebp
80107941:	89 e5                	mov    %esp,%ebp
80107943:	8b 55 0c             	mov    0xc(%ebp),%edx
80107946:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107949:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010794c:	39 d1                	cmp    %edx,%ecx
8010794e:	73 10                	jae    80107960 <deallocuvm+0x20>
}
80107950:	5d                   	pop    %ebp
80107951:	e9 fa f9 ff ff       	jmp    80107350 <deallocuvm.part.0>
80107956:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010795d:	8d 76 00             	lea    0x0(%esi),%esi
80107960:	89 d0                	mov    %edx,%eax
80107962:	5d                   	pop    %ebp
80107963:	c3                   	ret    
80107964:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010796b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010796f:	90                   	nop

80107970 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	57                   	push   %edi
80107974:	56                   	push   %esi
80107975:	53                   	push   %ebx
80107976:	83 ec 0c             	sub    $0xc,%esp
80107979:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010797c:	85 f6                	test   %esi,%esi
8010797e:	74 59                	je     801079d9 <freevm+0x69>
  if(newsz >= oldsz)
80107980:	31 c9                	xor    %ecx,%ecx
80107982:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107987:	89 f0                	mov    %esi,%eax
80107989:	89 f3                	mov    %esi,%ebx
8010798b:	e8 c0 f9 ff ff       	call   80107350 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107990:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107996:	eb 0f                	jmp    801079a7 <freevm+0x37>
80107998:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010799f:	90                   	nop
801079a0:	83 c3 04             	add    $0x4,%ebx
801079a3:	39 df                	cmp    %ebx,%edi
801079a5:	74 23                	je     801079ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801079a7:	8b 03                	mov    (%ebx),%eax
801079a9:	a8 01                	test   $0x1,%al
801079ab:	74 f3                	je     801079a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801079b2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
801079b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801079b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801079bd:	50                   	push   %eax
801079be:	e8 ad b6 ff ff       	call   80103070 <kfree>
801079c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801079c6:	39 df                	cmp    %ebx,%edi
801079c8:	75 dd                	jne    801079a7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801079ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801079cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d0:	5b                   	pop    %ebx
801079d1:	5e                   	pop    %esi
801079d2:	5f                   	pop    %edi
801079d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801079d4:	e9 97 b6 ff ff       	jmp    80103070 <kfree>
    panic("freevm: no pgdir");
801079d9:	83 ec 0c             	sub    $0xc,%esp
801079dc:	68 99 86 10 80       	push   $0x80108699
801079e1:	e8 9a 89 ff ff       	call   80100380 <panic>
801079e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079ed:	8d 76 00             	lea    0x0(%esi),%esi

801079f0 <setupkvm>:
{
801079f0:	55                   	push   %ebp
801079f1:	89 e5                	mov    %esp,%ebp
801079f3:	56                   	push   %esi
801079f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801079f5:	e8 36 b8 ff ff       	call   80103230 <kalloc>
801079fa:	89 c6                	mov    %eax,%esi
801079fc:	85 c0                	test   %eax,%eax
801079fe:	74 42                	je     80107a42 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107a00:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a03:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107a08:	68 00 10 00 00       	push   $0x1000
80107a0d:	6a 00                	push   $0x0
80107a0f:	50                   	push   %eax
80107a10:	e8 fb d7 ff ff       	call   80105210 <memset>
80107a15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107a18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107a1b:	83 ec 08             	sub    $0x8,%esp
80107a1e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107a21:	ff 73 0c             	push   0xc(%ebx)
80107a24:	8b 13                	mov    (%ebx),%edx
80107a26:	50                   	push   %eax
80107a27:	29 c1                	sub    %eax,%ecx
80107a29:	89 f0                	mov    %esi,%eax
80107a2b:	e8 d0 f9 ff ff       	call   80107400 <mappages>
80107a30:	83 c4 10             	add    $0x10,%esp
80107a33:	85 c0                	test   %eax,%eax
80107a35:	78 19                	js     80107a50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a37:	83 c3 10             	add    $0x10,%ebx
80107a3a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107a40:	75 d6                	jne    80107a18 <setupkvm+0x28>
}
80107a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a45:	89 f0                	mov    %esi,%eax
80107a47:	5b                   	pop    %ebx
80107a48:	5e                   	pop    %esi
80107a49:	5d                   	pop    %ebp
80107a4a:	c3                   	ret    
80107a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a4f:	90                   	nop
      freevm(pgdir);
80107a50:	83 ec 0c             	sub    $0xc,%esp
80107a53:	56                   	push   %esi
      return 0;
80107a54:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107a56:	e8 15 ff ff ff       	call   80107970 <freevm>
      return 0;
80107a5b:	83 c4 10             	add    $0x10,%esp
}
80107a5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107a61:	89 f0                	mov    %esi,%eax
80107a63:	5b                   	pop    %ebx
80107a64:	5e                   	pop    %esi
80107a65:	5d                   	pop    %ebp
80107a66:	c3                   	ret    
80107a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a6e:	66 90                	xchg   %ax,%ax

80107a70 <kvmalloc>:
{
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107a76:	e8 75 ff ff ff       	call   801079f0 <setupkvm>
80107a7b:	a3 c4 60 11 80       	mov    %eax,0x801160c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a80:	05 00 00 00 80       	add    $0x80000000,%eax
80107a85:	0f 22 d8             	mov    %eax,%cr3
}
80107a88:	c9                   	leave  
80107a89:	c3                   	ret    
80107a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107a90:	55                   	push   %ebp
80107a91:	89 e5                	mov    %esp,%ebp
80107a93:	83 ec 08             	sub    $0x8,%esp
80107a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107a99:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107a9c:	89 c1                	mov    %eax,%ecx
80107a9e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107aa1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107aa4:	f6 c2 01             	test   $0x1,%dl
80107aa7:	75 17                	jne    80107ac0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107aa9:	83 ec 0c             	sub    $0xc,%esp
80107aac:	68 aa 86 10 80       	push   $0x801086aa
80107ab1:	e8 ca 88 ff ff       	call   80100380 <panic>
80107ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107abd:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107ac0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ac3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107ac9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107ace:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107ad5:	85 c0                	test   %eax,%eax
80107ad7:	74 d0                	je     80107aa9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107ad9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107adc:	c9                   	leave  
80107add:	c3                   	ret    
80107ade:	66 90                	xchg   %ax,%ax

80107ae0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	57                   	push   %edi
80107ae4:	56                   	push   %esi
80107ae5:	53                   	push   %ebx
80107ae6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107ae9:	e8 02 ff ff ff       	call   801079f0 <setupkvm>
80107aee:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107af1:	85 c0                	test   %eax,%eax
80107af3:	0f 84 bd 00 00 00    	je     80107bb6 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107af9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107afc:	85 c9                	test   %ecx,%ecx
80107afe:	0f 84 b2 00 00 00    	je     80107bb6 <copyuvm+0xd6>
80107b04:	31 f6                	xor    %esi,%esi
80107b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b0d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107b10:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107b13:	89 f0                	mov    %esi,%eax
80107b15:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107b18:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107b1b:	a8 01                	test   $0x1,%al
80107b1d:	75 11                	jne    80107b30 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107b1f:	83 ec 0c             	sub    $0xc,%esp
80107b22:	68 b4 86 10 80       	push   $0x801086b4
80107b27:	e8 54 88 ff ff       	call   80100380 <panic>
80107b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107b30:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b32:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107b37:	c1 ea 0a             	shr    $0xa,%edx
80107b3a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107b40:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107b47:	85 c0                	test   %eax,%eax
80107b49:	74 d4                	je     80107b1f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107b4b:	8b 00                	mov    (%eax),%eax
80107b4d:	a8 01                	test   $0x1,%al
80107b4f:	0f 84 9f 00 00 00    	je     80107bf4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107b55:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107b57:	25 ff 0f 00 00       	and    $0xfff,%eax
80107b5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107b5f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107b65:	e8 c6 b6 ff ff       	call   80103230 <kalloc>
80107b6a:	89 c3                	mov    %eax,%ebx
80107b6c:	85 c0                	test   %eax,%eax
80107b6e:	74 64                	je     80107bd4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107b70:	83 ec 04             	sub    $0x4,%esp
80107b73:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107b79:	68 00 10 00 00       	push   $0x1000
80107b7e:	57                   	push   %edi
80107b7f:	50                   	push   %eax
80107b80:	e8 2b d7 ff ff       	call   801052b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107b85:	58                   	pop    %eax
80107b86:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b8c:	5a                   	pop    %edx
80107b8d:	ff 75 e4             	push   -0x1c(%ebp)
80107b90:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107b95:	89 f2                	mov    %esi,%edx
80107b97:	50                   	push   %eax
80107b98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107b9b:	e8 60 f8 ff ff       	call   80107400 <mappages>
80107ba0:	83 c4 10             	add    $0x10,%esp
80107ba3:	85 c0                	test   %eax,%eax
80107ba5:	78 21                	js     80107bc8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107ba7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107bad:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107bb0:	0f 87 5a ff ff ff    	ja     80107b10 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107bb6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bbc:	5b                   	pop    %ebx
80107bbd:	5e                   	pop    %esi
80107bbe:	5f                   	pop    %edi
80107bbf:	5d                   	pop    %ebp
80107bc0:	c3                   	ret    
80107bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107bc8:	83 ec 0c             	sub    $0xc,%esp
80107bcb:	53                   	push   %ebx
80107bcc:	e8 9f b4 ff ff       	call   80103070 <kfree>
      goto bad;
80107bd1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107bd4:	83 ec 0c             	sub    $0xc,%esp
80107bd7:	ff 75 e0             	push   -0x20(%ebp)
80107bda:	e8 91 fd ff ff       	call   80107970 <freevm>
  return 0;
80107bdf:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107be6:	83 c4 10             	add    $0x10,%esp
}
80107be9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bef:	5b                   	pop    %ebx
80107bf0:	5e                   	pop    %esi
80107bf1:	5f                   	pop    %edi
80107bf2:	5d                   	pop    %ebp
80107bf3:	c3                   	ret    
      panic("copyuvm: page not present");
80107bf4:	83 ec 0c             	sub    $0xc,%esp
80107bf7:	68 ce 86 10 80       	push   $0x801086ce
80107bfc:	e8 7f 87 ff ff       	call   80100380 <panic>
80107c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c0f:	90                   	nop

80107c10 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107c16:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107c19:	89 c1                	mov    %eax,%ecx
80107c1b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107c1e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c21:	f6 c2 01             	test   $0x1,%dl
80107c24:	0f 84 00 01 00 00    	je     80107d2a <uva2ka.cold>
  return &pgtab[PTX(va)];
80107c2a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c2d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107c33:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107c34:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107c39:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107c40:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c42:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107c47:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107c4a:	05 00 00 00 80       	add    $0x80000000,%eax
80107c4f:	83 fa 05             	cmp    $0x5,%edx
80107c52:	ba 00 00 00 00       	mov    $0x0,%edx
80107c57:	0f 45 c2             	cmovne %edx,%eax
}
80107c5a:	c3                   	ret    
80107c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c5f:	90                   	nop

80107c60 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	57                   	push   %edi
80107c64:	56                   	push   %esi
80107c65:	53                   	push   %ebx
80107c66:	83 ec 0c             	sub    $0xc,%esp
80107c69:	8b 75 14             	mov    0x14(%ebp),%esi
80107c6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c6f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107c72:	85 f6                	test   %esi,%esi
80107c74:	75 51                	jne    80107cc7 <copyout+0x67>
80107c76:	e9 a5 00 00 00       	jmp    80107d20 <copyout+0xc0>
80107c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c7f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107c80:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107c86:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107c8c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107c92:	74 75                	je     80107d09 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107c94:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107c96:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107c99:	29 c3                	sub    %eax,%ebx
80107c9b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107ca1:	39 f3                	cmp    %esi,%ebx
80107ca3:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107ca6:	29 f8                	sub    %edi,%eax
80107ca8:	83 ec 04             	sub    $0x4,%esp
80107cab:	01 c1                	add    %eax,%ecx
80107cad:	53                   	push   %ebx
80107cae:	52                   	push   %edx
80107caf:	51                   	push   %ecx
80107cb0:	e8 fb d5 ff ff       	call   801052b0 <memmove>
    len -= n;
    buf += n;
80107cb5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107cb8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107cbe:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107cc1:	01 da                	add    %ebx,%edx
  while(len > 0){
80107cc3:	29 de                	sub    %ebx,%esi
80107cc5:	74 59                	je     80107d20 <copyout+0xc0>
  if(*pde & PTE_P){
80107cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107cca:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107ccc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107cce:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107cd1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107cd7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107cda:	f6 c1 01             	test   $0x1,%cl
80107cdd:	0f 84 4e 00 00 00    	je     80107d31 <copyout.cold>
  return &pgtab[PTX(va)];
80107ce3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ce5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107ceb:	c1 eb 0c             	shr    $0xc,%ebx
80107cee:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107cf4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107cfb:	89 d9                	mov    %ebx,%ecx
80107cfd:	83 e1 05             	and    $0x5,%ecx
80107d00:	83 f9 05             	cmp    $0x5,%ecx
80107d03:	0f 84 77 ff ff ff    	je     80107c80 <copyout+0x20>
  }
  return 0;
}
80107d09:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107d0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107d11:	5b                   	pop    %ebx
80107d12:	5e                   	pop    %esi
80107d13:	5f                   	pop    %edi
80107d14:	5d                   	pop    %ebp
80107d15:	c3                   	ret    
80107d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d1d:	8d 76 00             	lea    0x0(%esi),%esi
80107d20:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107d23:	31 c0                	xor    %eax,%eax
}
80107d25:	5b                   	pop    %ebx
80107d26:	5e                   	pop    %esi
80107d27:	5f                   	pop    %edi
80107d28:	5d                   	pop    %ebp
80107d29:	c3                   	ret    

80107d2a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107d2a:	a1 00 00 00 00       	mov    0x0,%eax
80107d2f:	0f 0b                	ud2    

80107d31 <copyout.cold>:
80107d31:	a1 00 00 00 00       	mov    0x0,%eax
80107d36:	0f 0b                	ud2    
