Received: from eggs.gnu.org ([2001:4830:134:3::10]:40251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDXGO-0004Ni-C3
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDXFK-000718-AT
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:32:20 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:42833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDXFK-00070J-17
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:31:14 -0400
Received: by mail-ot0-x232.google.com with SMTP id l13-v6so13289483otk.9
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 08:31:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180501135547.12414-1-laurent@vivier.eu>
References: <20180501135547.12414-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 16:30:52 +0100
Message-ID: <CAFEAcA9K2QmEXzfX-Vkk+0MyhYe7s4RfgJBemSXT0Jif-OYAeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] M68k for 2.13 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>

On 1 May 2018 at 14:55, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit c2c768500f17fc8cdcfa44d169f089953bb22748:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-pull-request' into staging (2018-04-30 10:43:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.13-pull-request
>
> for you to fetch changes up to 83dc62f6ed6b4f2afce71d579a630441cca0957c:
>
>   hw/m68k/mcf5208: Fix trivial typo in board description (2018-05-01 15:37:54 +0200)
>
> ----------------------------------------------------------------
> Some fixes for m68k CPU emulation
> including the trivial one from Thomas for mcf5208 (m68k hardware)
> ----------------------------------------------------------------
>
> Laurent Vivier (2):
>   m68k: Fix floatx80_lognp1 (Coverity CID1390587)
>   m68k: remove dead code (Coverity CID1390617)
>
> Pavel Dovgalyuk (1):
>   m68k: fix subx mem, mem instruction
>
> Thomas Huth (1):
>   hw/m68k/mcf5208: Fix trivial typo in board description
>

Applied, thanks.

-- PMM
