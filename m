Received: from eggs.gnu.org ([2001:4830:134:3::10]:58344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL99n-0001xb-RO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL99m-0002qw-Sr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:24:59 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:45928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL99m-0002qm-Nr
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:24:58 -0400
Received: by mail-ot0-x233.google.com with SMTP id 15-v6so21416623otn.12
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 08:24:58 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 16:24:37 +0100
Message-ID: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU 3.0 proposed release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

I've put up a draft release schedule at:
https://wiki.qemu.org/Planning/3.0

2018-04-24      Beginning of development phase
2018-07-03      Soft feature freeze.
2018-07-10      Hard feature freeze. Tag rc0
2018-07-17      Tag rc1
2018-07-24      Tag rc2
2018-07-31      Tag rc3
2018-08-07      Release, or if necessary, tag rc4
2018-08-14      Release, if we needed rc4

It's a touch earlier than last year, so we're definitely
finished before the end of August.

Does this work for people?

thanks
-- PMM
