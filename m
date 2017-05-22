Received: from eggs.gnu.org ([2001:4830:134:3::10]:51821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCnPf-0001lu-7H
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dCnPZ-0003mJ-IX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:30:19 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:36646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dCnPZ-0003m7-Cy
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:30:13 -0400
Received: by mail-qt0-x234.google.com with SMTP id f55so101260239qta.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:30:13 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Mon, 22 May 2017 18:00:12 +0430
Message-ID: <CAGKXQyeuP6Oqar4R3Yuy2Y2O=Bg-=wM+wsxmaZGLt9=7fdSmmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi
does this code 'atomic_rcu_read(&migration_bitmap_rcu)->bmap' return bitmap
of dirty blocks or bitmap of pages?
thanks a lot
