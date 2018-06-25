Received: from eggs.gnu.org ([2001:4830:134:3::10]:38147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXQ1Y-00061I-4M
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXQ1X-0000Kt-Ak
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:51:12 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXQ1X-0000Jl-5f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:51:11 -0400
Received: by mail-oi0-x242.google.com with SMTP id b5-v6so3051716oiy.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:51:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619093124.24011-7-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<20180619093124.24011-7-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 12:50:50 +0100
Message-ID: <CAFEAcA-fRaddayn+RQyd-Hix4gmuhrvA8s90pRrhvE=0a3hStg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] intc/arm_gic: Improve traces
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
> Add some traces to the ARM GIC to catch register accesses (distributor,
> (v)cpu interface and virtual interface), and to take into account
> virtualization extensions (print `vcpu` instead of `cpu` when needed).
>
> Also add some virtualization extensions specific traces: LR updating
> and maintenance IRQ generation.
>
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
