Received: from eggs.gnu.org ([2001:4830:134:3::10]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa2Lq-0008E6-6H
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa2Lp-0004i2-FN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:10:58 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa2Lp-0004hE-AL
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:10:57 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so13329353oik.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:10:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702170522.GA9885@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
	<CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
	<20180702170522.GA9885@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 18:10:36 +0100
Message-ID: <CAFEAcA97xX72WabGwn7GAQJxMcpzYzyV9yDBg1qF0zLuSDZwSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 18:05, Guenter Roeck <linux@roeck-us.net> wrote:
> I don't think I'll have more time available to spend on this
> anytime soon. If it works for you, just drop the patch. I can
> keep it local in my branch. My version of qemu is different anyway,
> after all.

I'd kind of like to fix the bug, though. I'd just like you
to provide the image you're testing with...

thanks
-- PMM
