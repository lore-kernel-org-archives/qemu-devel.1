Received: from eggs.gnu.org ([2001:4830:134:3::10]:53714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCJW-0002rc-Hc
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCJV-00018A-Ud
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:59:38 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:35394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUCJV-00017h-R2
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 07:59:37 -0500
Received: by mail-ua0-x230.google.com with SMTP id y9so32684381uae.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 04:59:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJy5ezpYPaEdWG_4JQaQTL56EZYDT-TCYLaFtrKzpZUcu9DKHg@mail.gmail.com>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
	<CAJy5ezpYPaEdWG_4JQaQTL56EZYDT-TCYLaFtrKzpZUcu9DKHg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 12:59:16 +0000
Message-ID: <CAFEAcA_vpCFVGF6M27E8DK-phs2EvXKXr3k+h5ZXmERayL8jhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/18] arm: Add
 virtualization to GICv3, and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "patches@linaro.org" <patches@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>

On 18 January 2017 at 09:17, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> Hi Peter,  I'm on holidays and won't have time to review for a couple of
> weeks at least...

Do you want me to hold off on committing the GICv3 patches
until you get back and have had a chance to review?

thanks
-- PMM
