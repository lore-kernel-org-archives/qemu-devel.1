Received: from eggs.gnu.org ([2001:4830:134:3::10]:53486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dL6tb-0002vR-7h
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ali.saeedi56@gmail.com>) id 1dL6ta-00020q-EI
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:55:35 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:36567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ali.saeedi56@gmail.com>)
	id 1dL6ta-00020c-9j
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:55:34 -0400
Received: by mail-qk0-x22b.google.com with SMTP id g83so24736757qkb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 04:55:33 -0700 (PDT)
MIME-Version: 1.0
From: ali saeedi <ali.saeedi56@gmail.com>
Date: Wed, 14 Jun 2017 16:25:32 +0430
Message-ID: <CAGKXQyexfpUA0RhAJQ2WKwLEST6m29wfLMNvZFyGDAopZ+J=XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] NMI watchdog bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello
I run qemu on linux kernel 4.11.4 at ubuntu lts 16.04 but when booting
guest i encouner this in qemu monitor ' nmi watchdog: bug: soft lockup -
cpu#0 stuck for 23s! [swapper:0/1]'
i follow this link 'http://wiki.qemu.org/Hosts/Linux'
what is the problem
thanks a lot
