Received: from eggs.gnu.org ([2001:4830:134:3::10]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZZqg-0000KC-2Y
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZZqf-0007Q8-AA
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:44:54 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZZqf-0007Ps-3Y
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:44:53 -0400
Received: by mail-ot0-x241.google.com with SMTP id i17-v6so14472485otl.1
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 03:44:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1530395710.git.jcd@tribudubois.net>
References: <cover.1530395710.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Jul 2018 11:44:31 +0100
Message-ID: <CAFEAcA8OPpt1ZVc7ryzeK6W=t+Prc-J3KYXqPpS5rdBJxs+zZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] i.MX: Add the i.MX6UL SOC and a
 reference board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 30 June 2018 at 22:57, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> This series adds the i.MX6UL SOC from NXP/Freescale and the reference
> evaluation board.
>
> This series as tested by booting linux 4.18 (built using imx_v6_v7_defconfig)
> on the emulated board (with the appropriate device tree).
>
> Jean-Christophe Dubois (3):
>   i.MX6UL: Add i.MX6UL specific CCM device
>   i.MX6UL: Add i.MX6UL SOC
>   i.MX6UL: Add Freescale i.MX6 UltraLite 14x14 EVK Board

Hi; thanks for this patchset. I've put it on my to-review queue,
but since it's too late to get in for softfreeze for 3.0 I'm
planning to prioritize release-related work so it may take
me a little while to get back to it.

thanks
-- PMM
