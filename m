Received: from eggs.gnu.org ([2001:4830:134:3::10]:59376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGQft-0001B3-EL
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGQfs-0000eV-Nv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:05 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGQfs-0000eP-EY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:02:04 -0400
Received: by mail-wm0-x233.google.com with SMTP id n195so33693703wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530191553.31500-1-aurelien@aurel32.net>
References: <20170530191553.31500-1-aurelien@aurel32.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 15:01:42 +0100
Message-ID: <CAFEAcA9Wxc--OszfXS-7zfP0vu806V0MWepynqyrQE4gG8T6oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] Queued target/sh4 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 30 May 2017 at 20:15, Aurelien Jarno <aurelien@aurel32.net> wrote:
> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b04:
>
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (2017-05-30 14:15:15 +0100)
>
> are available in the git repository at:
>
>   git://git.aurel32.net/qemu.git tags/pull-target-sh4-20170530
>
> for you to fetch changes up to be53081a619443dc4512039d89345475ef7d9a46:
>
>   target/sh4: fix RTE instruction delay slot (2017-05-30 21:00:56 +0200)
>
> ----------------------------------------------------------------
> Queued target/sh4 patches
>
> ----------------------------------------------------------------
> Aurelien Jarno (5):
>       target/sh4: log unauthorized accesses using qemu_log_mask
>       target/sh4: fix reset when using a kernel and an initrd
>       target/sh4: introduce DELAY_SLOT_MASK
>       target/sh4: ignore interrupts in a delay slot
>       target/sh4: fix RTE instruction delay slot

Applied, thanks.

-- PMM
