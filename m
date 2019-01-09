Received: from eggs.gnu.org ([209.51.188.92]:52011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghNMH-00017g-MR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghNMG-0000q6-LY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:34:01 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghNMG-0000m4-Eb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:34:00 -0500
Received: by mail-ot1-x329.google.com with SMTP id v23so8313084otk.9
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 15:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Jan 2019 23:33:47 +0000
Message-ID: <CAFEAcA-AK=HNBa1DOeEwKHP7D8fRxaUMB9HvBauOtiaWcKsPGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/29] ppc-for-4.0 queue 20190109
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On Tue, 8 Jan 2019 at 22:46, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190109
>
> for you to fetch changes up to 3a8eb78e6c135422017888380db091793039b6dd:
>
>   spapr: enable XIVE MMIOs at reset (2019-01-09 09:28:14 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-01-09
>
> Second main pull request for qemu-4.0.  Highlights are:
>  * Final parts of XIVE support for pseries (without KVM)
>  * Preliminary work for PHB hotplug
>  * Starting to use TCG vector operations
>
> This includes some changes in the PCI core, which Michael Tsirkin
> requested come through this tree, since they're primarily of interest
> for ppc.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
