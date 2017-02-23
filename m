Received: from eggs.gnu.org ([2001:4830:134:3::10]:60540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cgo5X-0005it-KC
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cgo5X-0005tH-0Y
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:45:19 -0500
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cgo5W-0005tA-TB
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:45:18 -0500
Received: by mail-qt0-x22c.google.com with SMTP id x35so22316612qtc.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 23:45:18 -0800 (PST)
MIME-Version: 1.0
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Thu, 23 Feb 2017 08:45:17 +0100
Message-ID: <CAJy91Cav17O8N++OzmOJUUeZKa7_tZyRNgQ-KZkwR-wcv1oX=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] QEMU pipe implementation for Windows(host)
 Linux(guest) interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear QEMU developers,

I am a student working on the host-guest interaction for a Windows Host and
Linux Quest. Actually, I aim to make a universal pipe implementation for
any host-guest interaction.

I am now using a serial port to redirect to a pipe. This is working with
LInux host and Linux guest by using "mkfifo" to create the pipe. However, I
don't know how to create a pipe in Windows for QEMU usage.

Any thought is greatly appreciated!

best regards,
Jiahuan
