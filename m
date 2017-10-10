Received: from eggs.gnu.org ([2001:4830:134:3::10]:42988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1vCP-00050c-MM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1vCG-0006Rg-BH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:07:57 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:49737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1vCG-0006RB-3A
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:07:48 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b189so5492834wmd.4
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:07:48 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 15:07:26 +0100
Message-ID: <CAFEAcA-zUTfLOBkOeLc4e1Ok0dnKD=hWsdeR47125MhMnwV7UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] proposed schedule for 2.11 release
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

OK, here's a strawman proposal for the 2.11 release cycle,
based on aiming for a 5 Dec release date and working backwards
with the same cadence as 2.10.

2017-10-31 Soft freeze -- all feature changes must already be in a
           pull request that's been sent to the mailing list
2017-11-07 Hard freeze, tag rc0
2017-11-14 Tag rc1
2017-11-21 Tag rc2
2017-11-28 Tag rc3
2017-12-05 Release (or rc4 if we need it)
2017-12-12 Release if we needed an rc4


That makes softfreeze in 3 weeks time. I'd rather not push
the times back any further because we end up in serious
risk of running into the christmas holiday period.

(I'm still unconvinced by the 1-week softfreeze schedule.)

thanks
-- PMM
