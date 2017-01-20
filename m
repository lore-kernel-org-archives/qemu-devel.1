Received: from eggs.gnu.org ([2001:4830:134:3::10]:42114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUYPc-0002If-Hc
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUYPY-0001pA-5t
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:35:24 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:36557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUYPY-0001p4-1Y
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:35:20 -0500
Received: by mail-ua0-x236.google.com with SMTP id 96so58956271uaq.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:35:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484912166-19271-1-git-send-email-peter.maydell@linaro.org>
References: <1484912166-19271-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 12:34:59 +0000
Message-ID: <CAFEAcA-LyJmOf3SpVPBp=OKuwU0kJGKz5+Hu61+7J9qcrvMhJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/36] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 11:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> Changes from v1: just squashed in
> http://patchwork.ozlabs.org/patch/717312/
> which deletes a now-unused function.
>
> thanks
> -- PMM
>
> The following changes since commit 0f6bcf68a99efdc531b209551f2b760b0bdcc554:
>
>   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-20170118' into staging (2017-01-19 18:34:13 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170120
>
> for you to fetch changes up to f29cacfb5fc0a6e93efc3f6d2900d82d625f143e:
>
>   hw/arm/virt: Add board property to enable EL2 (2017-01-20 11:15:11 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * support virtualization in GICv3
>  * enable EL2 in AArch64 CPU models
>  * allow EL2 to be enabled on 'virt' board via -machine virtualization=on
>  * aspeed: SMC improvements
>  * m25p80: support die erase command
>  * m25p80: Add Quad Page Program 4byte
>  * m25p80: Improve 1GiB Micron flash definition
>  * arm: Uniquely name imx25 I2C buses
>

Applied, thanks.

-- PMM
