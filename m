Received: from eggs.gnu.org ([2001:4830:134:3::10]:40716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWQ3g-0004wL-5S
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWQ3f-0008Ge-Au
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:28 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:32855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWQ3f-0008GQ-6N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:04:27 -0500
Received: by mail-vk0-x231.google.com with SMTP id k127so136360592vke.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:04:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170124211424.2828-1-rth@twiddle.net>
References: <20170124211424.2828-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 16:04:06 +0000
Message-ID: <CAFEAcA-Xsmt_30RyXXZ88VWRtPDoFVmMfzhcx-WUa-3Uq47kkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/7] Nios2 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

On 24 January 2017 at 21:14, Richard Henderson <rth@twiddle.net> wrote:
> Version 2: Use PRIx64 in patch 1 to fix a 32-bit build failure.
>
>
> r~
>
>
> The following changes since commit a678502e4f7580a6f143f680404aaee57ac3f4b5:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-24 15:39:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-nios-20170124
>
> for you to fetch changes up to e671711c9a8c1de540f035095e18458bc03968de:
>
>   nios2: Add support for Nios-II R1 (2017-01-24 13:10:36 -0800)
>
> ----------------------------------------------------------------
> nios2 target support
>

Applied, thanks.

-- PMM
