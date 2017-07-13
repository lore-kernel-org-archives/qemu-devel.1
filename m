Received: from eggs.gnu.org ([2001:4830:134:3::10]:52177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVcbw-0000RN-Ix
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVcbv-0006CJ-SL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:48:48 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVcbv-0006C0-Ir
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:48:47 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so23125765wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:48:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
References: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 12:48:25 +0100
Message-ID: <CAFEAcA_csR70+TZKGY=DyoOKjA9dmHuxX5UXMLzX0f_45miybA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 11 July 2017 at 11:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> A surprisingly short target-arm queue, but no point in holding
> onto these waiting for more code to arrive :-)
>
> thanks
> -- PMM
>
> The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1ee:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170710a' into staging (2017-07-10 18:13:03 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170711
>
> for you to fetch changes up to 792dac309c8660306557ba058b8b5a6a75ab3c1f:
>
>   target-arm: v7M: ignore writes to CONTROL.SPSEL from Thread mode (2017-07-11 11:21:26 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * v7M: ignore writes to CONTROL.SPSEL from Thread mode
>  * KVM: Enable in-kernel timers with user space gic
>  * aspeed: Register all watchdogs
>  * hw/misc: Add Exynos4210 Pseudo Random Number Generator
>

Applied, thanks.

-- PMM
