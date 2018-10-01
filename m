Received: from eggs.gnu.org ([2001:4830:134:3::10]:58137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6tly-0001CN-Nd
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6tly-0007bT-3p
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:41:46 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:40101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6tlx-0007aX-Mr
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:41:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id j68-v6so10483560oib.7
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:41:45 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 09:41:24 +0100
Message-ID: <CAFEAcA_ibkOPd0b2LrfrvmqpQfeWh_9vs+mwsJdumPo+SUhGJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] proposed schedule, QEMU 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Here's a draft release schedule for 3.1, created by
taking our usual setup and arranging it to be definitely
done before Christmas.

2018-10-30 Soft feature freeze.
2018-11-06 Hard feature freeze. Tag rc0
2018-11-13 Tag rc1 2018-11-20 Tag rc2
2018-11-27 Tag rc3 2018-12-04
Release; or tag rc4 if needed
2018-12-11 Release, if we needed an rc4

NB: KVM Forum is 24-26 Oct, so just before
softfreeze.

We could maybe move it a week back, but that would
mean probably releasing on the 18th. I haven't yet
figured out my Christmas holiday plans but I suspect
that would fall within them...

thanks
-- PMM
