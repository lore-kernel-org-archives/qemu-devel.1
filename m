Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgh8183@gmail.com>) id 1cQsn7-00071q-F8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgh8183@gmail.com>) id 1cQsn6-0000yw-LV
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:32:29 -0500
Received: from mail-it0-x22d.google.com ([2607:f8b0:4001:c0b::22d]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgh8183@gmail.com>) id 1cQsn6-0000yE-I5
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:32:28 -0500
Received: by mail-it0-x22d.google.com with SMTP id x2so83768182itf.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 01:32:28 -0800 (PST)
MIME-Version: 1.0
From: morgenlette madeBy <sgh8183@gmail.com>
Date: Tue, 10 Jan 2017 18:32:24 +0900
Message-ID: <CAE519-=0+6SLmUwyFqZF38ThRxOrj836BAyC4EVu9ijQGgt0aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Question about io mode & cache mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello.

I sent mail for question about io mode and cache mode.

When I set VM to I/O mode = native and cache mode = none,

Vm cannot boot and vm is turn off automatically.

Why cannot VM boot?
