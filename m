Received: from eggs.gnu.org ([2001:4830:134:3::10]:55499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXRKA-0008A6-CZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXRK9-00052R-GA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:09:58 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXRK9-00051V-7g
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:09:57 -0400
Received: by mail-wr0-x231.google.com with SMTP id 12so26440238wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 05:09:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717145556.14142-1-aurelien@aurel32.net>
References: <20170717145556.14142-1-aurelien@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 13:09:35 +0100
Message-ID: <CAFEAcA_NkWKygptqu55NTNK5HK4NamH-rmx7hbu2L45tdL8=nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] target/mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>

On 17 July 2017 at 15:55, Aurelien Jarno <aurelien@aurel32.net> wrote:
> Two additional MIPS patches that have been sent a few weeks ago and
> which got reviewed.
>
> Thanks,
> Aurelien
>
> The following changes since commit 77031ee1ce4c7e5f4b4941535c4912eb2eb3503c:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170717' into staging (2017-07-17 12:52:59 +0100)
>
> are available in the git repository at:
>
>   git://git.aurel32.net/qemu.git tags/pull-target-mips-20170717
>
> for you to fetch changes up to 06a57e5cc7ee5292a4915117ebf951e310a28264:
>
>   target/mips: optimize WSBH, DSBH and DSHD (2017-07-17 16:48:21 +0200)
>
> ----------------------------------------------------------------
> Queued target/mips patches
>
> ----------------------------------------------------------------
> Aurelien Jarno (1):
>       target/mips: optimize WSBH, DSBH and DSHD
>
> Pavel Dovgalyuk (1):
>       mips: set CP0 Debug DExcCode for SDBBP instruction
>
>  target/mips/helper.c    |  2 ++
>  target/mips/translate.c | 18 ++++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
