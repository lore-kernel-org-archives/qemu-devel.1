Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyDvp-0000wx-96
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyDvo-00040P-97
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:51:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyDvo-00040D-3h
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:51:48 -0400
Received: by mail-oi0-x242.google.com with SMTP id 23-v6so783210oir.11
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 02:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 09:51:26 +0000
Message-ID: <CAFEAcA_3b-z17y_kcckoFgLprs_BE19COvvHdNeMUd3meqYfRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 19 March 2018 at 18:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> Arm patch queue -- these are all bug fix patches but we might
> as well put them in to rc0...
>
> thanks
> -- PMM
>
> The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805be:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-03-19 11:44:26 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180319
>
> for you to fetch changes up to ff72cb6b46b95bb530787add5277c211af3d31c6:
>
>   hw/arm/raspi: Provide spin-loop code for AArch64 CPUs (2018-03-19 18:23:24 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fsl-imx6: Fix incorrect Ethernet interrupt defines
>  * dump: Update correct kdump phys_base field for AArch64
>  * char: i.MX: Add support for "TX complete" interrupt
>  * bcm2836/raspi: Fix various bugs resulting in panics trying
>    to boot a Debian Linux kernel on raspi3
>

Applied, thanks.

-- PMM
