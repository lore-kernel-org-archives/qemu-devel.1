Received: from eggs.gnu.org ([2001:4830:134:3::10]:43508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcZyj-0007tU-84
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcZyi-0001d0-G1
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:29:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcZyi-0001cn-96
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:29:36 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so37345399oie.13
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:29:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709135435.836-1-peter.maydell@linaro.org>
References: <20180709135435.836-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 18:29:15 +0100
Message-ID: <CAFEAcA8vc0TH+VRPbf6WV7=eZBLD4Y73Sy8T9k9XGo075x4Jfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 9 July 2018 at 14:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi; this target-arm pull request has a collection of generally
> fairly minor bugs to sneak in before 3.0 rc0 tomorrow...
>
> thanks
> -- PMM
>
> The following changes since commit a98ff0ec2ba3538dd766b349518ee18d03942ed8:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180709' into staging (2018-07-09 11:00:45 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180709
>
> for you to fetch changes up to 8fad0a65582c0a6e324580f45516461e9b6aa439:
>
>   hw/net/dp8393x: don't make prom region 'nomigrate' (2018-07-09 14:51:35 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/net/dp8393x: don't make prom region 'nomigrate'
>  * boards.h: Remove doc comment reference to nonexistent function
>  * hw/sd/omap_mmc: Split 'pseudo-reset' from 'power-on-reset'
>  * target/arm: Fix do_predset for large VL
>  * tcg: Restrict check_size_impl to multiples of the line size
>  * target/arm: Suppress Coverity warning for PRF
>  * hw/timer/cmsdk-apb-timer: fix minor corner-case bugs and
>    suppress spurious warnings when running Linux's timer driver
>  * hw/arm/smmu-common: Fix devfn computation in smmu_iommu_mr
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
