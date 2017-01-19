Received: from eggs.gnu.org ([2001:4830:134:3::10]:34423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCoQ-0007F7-0k
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCoM-0002JV-A8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:31:34 -0500
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:33920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUCoL-0002J0-2s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:31:30 -0500
Received: by mail-vk0-x234.google.com with SMTP id r136so29313442vke.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 05:31:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJy5ezrSHXMoiP5M3nBjP0BPqCwk898JR3zc955O91S4B+nW3w@mail.gmail.com>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9N_YXFCPo8ja-Nan3roL=gdNpFQHoLk_aw6tDixwoT3w@mail.gmail.com>
	<CAJy5ezpYPaEdWG_4JQaQTL56EZYDT-TCYLaFtrKzpZUcu9DKHg@mail.gmail.com>
	<CAFEAcA_vpCFVGF6M27E8DK-phs2EvXKXr3k+h5ZXmERayL8jhg@mail.gmail.com>
	<CAJy5ezrSHXMoiP5M3nBjP0BPqCwk898JR3zc955O91S4B+nW3w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 13:31:08 +0000
Message-ID: <CAFEAcA-+jEd7PBxRLbU5Rd-jc+O=rFJfrsVsSmYF+uD4mZWwMw@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Patch Tracking <patches@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Christoffer Dall <christoffer.dall@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 19 January 2017 at 13:02, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> Nah, if I find something we can always fix it with follow up patches...

Cool. I've applied this series to target-arm.next.

thanks
-- PMM
