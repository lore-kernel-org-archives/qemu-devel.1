Received: from eggs.gnu.org ([2001:4830:134:3::10]:39994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTbw-0006jf-Oc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTbr-0006wJ-AE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:51:16 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:56275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTbr-0006vO-39
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:51:11 -0400
Received: by mail-wr0-x230.google.com with SMTP id l39so231056wrl.12
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:51:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <26b702658b5bf9984edaecb22b1190be0a9d7052.1504293917.git.alistair.francis@xilinx.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
	<26b702658b5bf9984edaecb22b1190be0a9d7052.1504293917.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 13:50:49 +0100
Message-ID: <CAFEAcA-A78rWzUeBh3M_k2SUmu3A8LwROQKCmw78D8PyE2neJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] aarch64-softmmu.mak: Use an ARM
 specific config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair23@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 1 September 2017 at 22:00, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> In preperation for having an ARM and MicroBlaze ZynqMP machine let's
> split out the current ARM specific config options.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Acked-by: Peter Maydell <peter.maydell@linaro.org>

I'm assuming this series is going be reviewed and go into
master via a microblaze tree, not the arm one...

thanks
-- PMM
