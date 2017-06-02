Received: from eggs.gnu.org ([2001:4830:134:3::10]:46557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGocN-0004e1-8Y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGocM-00025e-3n
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:36:03 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGocL-00024y-Oh
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:36:02 -0400
Received: by mail-wm0-x232.google.com with SMTP id b84so28636419wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:36:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170602053249.GB2366@kentang.lan>
References: <20170602053249.GB2366@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 16:35:40 +0100
Message-ID: <CAFEAcA-cmTz=sovgMBSyDu03WB9k5sDF_xXCvZ8-1tK0CH1Acg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 06:32, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> This request contains the SPARC QOMify work which fell through the cracks during the last release.
> Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f01:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31' into staging (2017-06-01 16:39:16 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 78fb261db18d3e12f68304c0d91a85e0a3bbc757:
>
>   hw/sparc64: QOM'ify sun4u.c (2017-06-02 05:54:43 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> xiaoqiang zhao (8):
>       hw/misc: QOM'ify eccmemctl.c
>       hw/dma: QOM'ify sparc32_dma.c
>       hw/dma: QOM'ify sun4m_iommu.c
>       hw/misc: QOM'ify slavio_misc.c
>       hw/timer: QOM'ify m48txx_sysbus
>       hw/timer: QOM'ify slavio_timer
>       hw/sparc: QOM'ify sun4m.c
>       hw/sparc64: QOM'ify sun4u.c

Applied, thanks.

-- PMM
