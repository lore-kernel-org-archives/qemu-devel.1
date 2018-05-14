Received: from eggs.gnu.org ([2001:4830:134:3::10]:44801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFlS-0003HH-5P
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIFlR-0004Uc-6F
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:51:54 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIFlR-0004UK-0U
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:51:53 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so14835344oth.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:51:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503214201.29082-2-frasse.iglesias@gmail.com>
References: <20180503214201.29082-1-frasse.iglesias@gmail.com>
	<20180503214201.29082-2-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 16:51:32 +0100
Message-ID: <CAFEAcA-9Q6zRCsZ8UWgDXXRdQ1Pf5fj4_KjmtKPY1BJ6s9FXtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] xlnx-zdma: Add a model of the
 Xilinx ZynqMP generic DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Alistair Francis <alistair23@gmail.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 3 May 2018 at 22:42, Francisco Iglesias <frasse.iglesias@gmail.com> wrote:
> Add a model of the generic DMA found on Xilinx ZynqMP.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---

Edgar, were you or somebody else from Xilinx planning to review
this version of this patch?

thanks
-- PMM
