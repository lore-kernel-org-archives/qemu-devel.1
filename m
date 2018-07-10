Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwEp-0000Rb-3D
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcwEo-000450-9n
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:15:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcwEo-00044h-3C
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 13:15:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so44055415oib.9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 10:15:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-7-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-7-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 18:15:20 +0100
Message-ID: <CAFEAcA-ghbRQ0Dhw0cgN_43VVFDtpfw2jYPp1y5daEqs1vOxvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 06/20] intc/arm_gic: Add virtual
 interface register definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Add the register definitions for the virtual interface of the GICv2.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/gic_internal.h | 65 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
