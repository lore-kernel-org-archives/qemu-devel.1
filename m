Received: from eggs.gnu.org ([209.51.188.92]:34608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gx8x2-0006m1-5D
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gx8wv-00075i-Ho
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:25:05 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:36101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gx8wh-0006u8-K8
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 06:24:52 -0500
Received: by mail-oi1-x236.google.com with SMTP id t206so1451142oib.3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 03:24:47 -0800 (PST)
MIME-Version: 1.0
References: <20190221185739.25362-1-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 11:24:35 +0000
Message-ID: <CAFEAcA_yUhHyNvg8=RRjB8y+etvsmgnGdr6uKheZTQM2weXBFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 21 Feb 2019 at 18:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm queue -- mostly the first slice of my Musca patches.
>
> thanks
> -- PMM
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190221
>
> for you to fetch changes up to 3733f80308d2a7f23f5e39b039e0547aba6c07f1:
>
>   hw/arm/armsse: Make 0x5... alias region work for per-CPU devices (2019-02-21 18:17:48 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Model the Arm "Musca" development boards: "musca-a" and "musca-b1"
>  * Implement the ARMv8.3-JSConv extension
>  * v8M MPU should use background region as default, not always
>  * Stop unintentional sign extension in pmu_init
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
