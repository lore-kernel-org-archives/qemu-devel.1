Received: from eggs.gnu.org ([2001:4830:134:3::10]:57086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKpS9-0001HS-5E
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKpS7-00005w-OH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:18:05 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKpS7-00005Z-Fd
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:18:03 -0400
Received: by mail-wr0-x231.google.com with SMTP id q97so153156383wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 10:18:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 18:17:40 +0100
Message-ID: <CAFEAcA9=fufO4b0v468PH61mj9wXg2sdO+a6LN96U8HxPTHz9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2017 at 15:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> Target-arm queue...
>
> thanks
> -- PMM
>
> The following changes since commit 735286a4f88255e1463d42ce28d8d14181fd32d4:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170613' into staging (2017-06-13 13:51:29 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170613
>
> for you to fetch changes up to 252a7a6a968c279a4636a86b0559ba3a930a90b5:
>
>   hw/intc/arm_gicv3_its: Allow save/restore (2017-06-13 14:57:01 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * vITS: Support save/restore
>  * timer/aspeed: Fix timer enablement when reload is not set
>  * aspped: add temperature sensor device
>  * timer.h: Provide better monotonic time on ARM hosts
>  * exynos4210: various cleanups
>  * exynos4210: support system poweroff
>

Applied, thanks.

-- PMM
