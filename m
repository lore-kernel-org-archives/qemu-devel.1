Received: from eggs.gnu.org ([2001:4830:134:3::10]:35719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHuFo-0002Gb-VJ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHuFo-00023R-4j
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:49:17 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHuFn-00022P-T9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:49:16 -0400
Received: by mail-wm0-x22a.google.com with SMTP id x70so16112822wme.0
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 08:49:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1496672631.git.mjt@msgid.tls.msk.ru>
References: <cover.1496672631.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 16:48:54 +0100
Message-ID: <CAFEAcA80HS0qo7wHdRvvxPEbtbkGrdj3G7fQKoHtDiQzzTQvUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] Trivial patches for 2017-06-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 5 June 2017 at 15:25, Michael Tokarev <mjt@tls.msk.ru> wrote:
> This is a resend of the yesterday's trivial-patches queue, without
> an ivshmem change which broke static build (will take a look at
> that later). The rest is exactly the same, so sending only the
> cover letter.
>
> Thanks,
>
> /mjt
>
> The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47eac5:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-06-02 17:46:22 +0100)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to 03e947f9c2264356aef037e6bf9c496b5deae2d2:
>
>   hw/core: nmi.c can be compiled as common-obj nowadays (2017-06-05 17:23:36 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-06-05
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
