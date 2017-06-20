Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nayan26deshmukh@gmail.com>) id 1dNM7O-0000kI-EJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nayan26deshmukh@gmail.com>) id 1dNM7N-0004V3-Tv
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:35:06 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nayan26deshmukh@gmail.com>)
	id 1dNM7N-0004Ux-Qd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:35:05 -0400
Received: by mail-qk0-x22a.google.com with SMTP id r62so62223895qkf.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 09:35:05 -0700 (PDT)
MIME-Version: 1.0
From: Nayan Deshmukh <nayan26deshmukh@gmail.com>
Date: Wed, 21 Jun 2017 01:35:04 +0900
Message-ID: <CAFd4ddwJYpLCzXViDh6MhwZyurMi_LrO-dgnSrciCNB2UDXiCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Instruction tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello!

I was wondering if its possible to get an instruction trace of the
process running on the guest OS in the VM including the instructions
executed during system calls.

Can someone please give me some pointers regarding how this could be
implemented.

Cheers,
Nayan Deshmukh
