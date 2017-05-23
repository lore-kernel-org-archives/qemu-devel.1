Received: from eggs.gnu.org ([2001:4830:134:3::10]:55923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vinodchegu@gmail.com>) id 1dDA1D-0007cK-R3
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vinodchegu@gmail.com>) id 1dDA1D-0000WP-4U
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:38:35 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:33763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vinodchegu@gmail.com>)
	id 1dDA1D-0000WB-08
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:38:35 -0400
Received: by mail-oi0-x22b.google.com with SMTP id w10so201790247oif.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 06:38:34 -0700 (PDT)
MIME-Version: 1.0
From: Vinod Chegu <vinodchegu@gmail.com>
Date: Tue, 23 May 2017 06:38:33 -0700
Message-ID: <CACpTSGsYfv_72SkAo_kCzQoh5pS-ZT6cL259iv-hBbBO3Qgv4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Recent performance data on virtio-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Hello,

Are there any recent performance data available with virtio-scsi (i.e.
something that shows the benefits of using multiple queues and perhaps also
multiple iothreads etc) ?

If yes can you please provide a pointer to the same (and perhaps any
specific tunings).

Thanks
Vinod
