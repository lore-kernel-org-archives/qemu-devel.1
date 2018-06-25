Received: from eggs.gnu.org ([2001:4830:134:3::10]:36923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPyc-0004gk-RH
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPyc-0007Gc-6r
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:48:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXPyc-0007GH-07
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:48:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id c6-v6so12191165oiy.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:48:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619093124.24011-4-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<20180619093124.24011-4-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 12:47:48 +0100
Message-ID: <CAFEAcA9XhPug6bdPo6Z3-t_1ALVyqQQx=AiGrgWsKfX9CMedQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] vmstate.h: Provide
 VMSTATE_UINT16_SUB_ARRAY
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

On 19 June 2018 at 10:31,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
>
> Provide a VMSTATE_UINT16_SUB_ARRAY macro to save a uint16_t sub-array in
> a VMState.
>
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
