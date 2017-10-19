Received: from eggs.gnu.org ([2001:4830:134:3::10]:40708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5FNp-00039U-Mc
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5FNo-0000sI-T0
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:17:29 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:46381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5FNo-0000rv-M2
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:17:28 -0400
Received: by mail-wm0-x230.google.com with SMTP id m72so17694272wmc.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 11:17:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019065854.GB17401@kentang.lan>
References: <20171019065854.GB17401@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 19:17:07 +0100
Message-ID: <CAFEAcA-E7-C_DbUDDGbqpFfsPy16M+WjemkzN9noiSeGKQsVvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2017 at 07:58, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are my sun4u patches for 2.11. Note that because of the machine changes
> there is an openbios-sparc64 binary update included in the first patch to
> maintain bisectability. There will be a follow-up patch for OpenBIOS which will
> update binaries for all architectures to the latest and update the submodule
> shortly.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to bcf9e2c2f2b7a610efaafc4bd6d0bee9181c2345:
>
>   sun4u: fix assert when adding NICs which aren't the in-built model (2017-10-19 07:45:35 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (2):
>       sun4u: update PCI topology to include simba PCI bridges
>       sun4u: fix assert when adding NICs which aren't the in-built model

Applied, thanks.

-- PMM
