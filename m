Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egAQu-0007cc-Mb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egAQt-0007L7-Pi
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:29:16 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:37453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egAQt-0007KV-KV
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 09:29:15 -0500
Received: by mail-ot0-x22c.google.com with SMTP id a24so6686732otd.4
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 06:29:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 14:28:54 +0000
Message-ID: <CAFEAcA_=9ZVnbnnC4=D_KyLgP-RAYbkGK1gx0p0FNm1EXP3nbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180129
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>

On 29 January 2018 at 03:28, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit e607bbee553cfe73072870cef458cfa4e78133e2:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180129
>
> for you to fetch changes up to c59704b254734182c3202e0c261589ea2ccf485e:
>
>   target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS (2018-01-29 14:24:55 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-01-29
>
> Here's another batch of patches for ppc, spapr and related things.
> Higlights:
>
>   * Implement (with a bunch of necessary infrastructure) a hypercall
>     to let guests properly apply Spectre and Meltdown workarounds.
>   * Convert a number of old devices to trace events
>   * Fix some bugs

Applied, thanks.

-- PMM
