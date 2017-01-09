Received: from eggs.gnu.org ([2001:4830:134:3::10]:33394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQaFq-0006kF-82
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQaFp-00030J-BO
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:54 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:35601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQaFo-000301-W8
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:53 -0500
Received: by mail-vk0-x234.google.com with SMTP id x75so17529265vke.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 05:44:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 13:44:31 +0000
Message-ID: <CAFEAcA-VBuWpkCwUXej3pwW3TXM-jOXBYEJXB3OYNTdC8XavKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 9 January 2017 at 11:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: nothing hugely exciting here, the
> bulk is Andrew's virt-acpi-build refactorings.
>
> thanks
> -- PMM
>
> The following changes since commit ffe22bf51065dd33022cf91f77a821d1f11c250d:
>
>   Merge remote-tracking branch 'remotes/gonglei/tags/cryptodev-next-20161224' into staging (2017-01-06 15:18:09 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170109
>
> for you to fetch changes up to 556899fc1965d82f5c4a3ba6a0be3b1193e2c4b2:
>
>   hw/ssi/imx_spi.c: Remove MSGDATA register support (2017-01-09 11:50:23 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * i2c: Allow I2C devices to NAK start events
>  * hw/char: QOM'ify exynos4210_uart.c
>  * clean up and refactor virt-acpi-build.c
>  * virt-acpi-build: Don't incorrectly claim architectural timer
>    to be edge-triggered
>  * m25p80: Don't let rogue SPI controllers cause buffer overruns
>  * imx_spi: Remove broken MSGDATA register support
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
