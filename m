Received: from eggs.gnu.org ([2001:4830:134:3::10]:51156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTQT-0005kS-FH
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTQN-0007d5-Ic
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:45:25 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:41305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebTQN-0007cN-7S
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:45:19 -0500
Received: by mail-ot0-x229.google.com with SMTP id 44so13083589otk.8
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:45:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 15:44:57 +0000
Message-ID: <CAFEAcA-ZoBhQgJeCL1=2f199kr9ahPmNQY8-mRjrzgie6YkONA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 13:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> More arm patches (mostly the SDHCI ones from Philippe)
>
> thanks
> -- PMM
>
> The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180116
>
> for you to fetch changes up to 60765b6ceeb4998a0d4220b3a53f1f185061da77:
>
>   sdhci: add a 'dma' property to the sysbus devices (2018-01-16 13:28:21 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * SDHCI: cleanups and minor bug fixes
>  * target/arm: minor refactor preparatory to fp16 support
>  * omap_ssd, ssi-sd, pl181, milkymist-memcard: reset the SD
>    card on controller reset (fixes migration failures)
>  * target/arm: Handle page table walk load failures correctly
>  * hw/arm/virt: Add virt-2.12 machine type
>  * get_phys_addr_pmsav7: Support AP=0b111 for v7M
>  * hw/intc/armv7m: Support byte and halfword accesses to CFSR
>

Applied, thanks.

-- PMM
