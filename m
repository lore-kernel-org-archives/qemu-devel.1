Received: from eggs.gnu.org ([2001:4830:134:3::10]:42021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ess5y-00049H-Li
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ess5x-0001mz-HE
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:32:10 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ess5x-0001ll-Ax
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:32:09 -0500
Received: by mail-ot0-x242.google.com with SMTP id w2so15262953otg.2
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:32:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305061237.21484-1-andrew.smirnov@gmail.com>
References: <20180305061237.21484-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 15:31:48 +0000
Message-ID: <CAFEAcA_Y3oY0w3Xmrs0BTfhXw1s7S-8pESZ-rB2HgXzZ_5Vxmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH v7 0/3] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 5 March 2018 at 06:12, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> RESEND due to botched original v7 submission (patch 1/3 broken)
>
> Hi everyone,
>
> This v7 of the patch series containing the work that I've done in
> order to enable support for i.MX7 emulation in QEMU.

Thanks; applied to target-arm.next.

By the way there were a couple of i.MX bug reports this weekend:
https://bugs.launchpad.net/qemu/+bug/1753314  (about the UART)
https://bugs.launchpad.net/qemu/+bug/1753309  (about ethernet)

Are you interested in having a look at them?

thanks
-- PMM
