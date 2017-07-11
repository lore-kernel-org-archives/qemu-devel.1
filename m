Received: from eggs.gnu.org ([2001:4830:134:3::10]:52608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUzCo-0003SX-Q4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUzCo-0005dY-3Z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:14 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUzCn-0005bp-TD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:44:14 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so9007328wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:44:13 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 18:43:52 +0100
Message-ID: <CAFEAcA_HPtBhES_9L1KZzJTDJRpxD=0Ux-OyC3BV2UDNKZg2hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] should we update QEMU's u-boot submodule and binary?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexander Graf <agraf@suse.de>

Hi; I just noticed that our u-boot submodule is still stuck on
a commit from 2014 when it was first added to QEMU. Should we
move this forward to some more recent u-boot release?

I think we only use this for our ppc e500 rom...

thanks
-- PMM
