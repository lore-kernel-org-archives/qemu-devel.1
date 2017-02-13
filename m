Received: from eggs.gnu.org ([2001:4830:134:3::10]:45261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdCxq-00012n-7Y
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdCxp-0006Dv-7y
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:30:30 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdCxp-0006DG-1i
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:30:29 -0500
Received: by mail-wm0-x229.google.com with SMTP id 196so5152267wmm.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 01:30:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Feb 2017 09:30:04 +0000
Message-ID: <CAFEAcA_Z6mVCD2VxR=heUWuVSTmDwBNiU3fZZbqoSHw9vtG5Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/12] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 10 February 2017 at 18:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue: nothing particularly exciting here, but no
> reason to sit on them for another week.
>
> thanks
> -- PMM
>
> The following changes since commit 61eedf7aec0e2395aabd628cc055096909a3ea15:
>
>   tests/prom-env: Ease time-out problems on slow hosts (2017-02-10 15:44:53 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170210
>
> for you to fetch changes up to b4cc583f0285a2e1e78621dfba142f00ca47414a:
>
>   aspeed/smc: use a modulo to check segment limits (2017-02-10 17:40:30 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * aspeed: minor fixes
>  * virt: declare fwcfg and virtio-mmio as DMA coherent in DT & ACPI
>  * arm: enable basic TCG emulation of PMU for AArch64
>

Applied, thanks.

-- PMM
