Received: from eggs.gnu.org ([2001:4830:134:3::10]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfm0555@gmail.com>) id 1f8q0v-0007Ql-4g
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfm0555@gmail.com>) id 1f8q0u-0006fJ-Gn
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:32:57 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:44605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jfm0555@gmail.com>) id 1f8q0u-0006ev-Ca
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:32:56 -0400
Received: by mail-qk0-x229.google.com with SMTP id h200so1829859qke.11
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 09:32:56 -0700 (PDT)
MIME-Version: 1.0
From: "J-F M." <jfm0555@gmail.com>
Date: Wed, 18 Apr 2018 12:32:54 -0400
Message-ID: <CAGn25ShCZePCkYwxQbe3WdwFTskXMZCo=QeQQyiWFuW3kQE5WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu 2.10 100% cpu with coreduo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org

Hi,
FYI
100% cpu usage  on kernel 4.15.8
coreduo 2 cores, address sizes 0 bits virtual.
no problem with qemu cpu 2.5+.

regards,
jfm
