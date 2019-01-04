Received: from eggs.gnu.org ([208.118.235.92]:53860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfREw-0007FA-93
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfREv-0008ER-M5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:18:26 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfREv-0008Bl-H0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:18:25 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so30586909oif.2
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20190104104749.5314-1-edgar.iglesias@gmail.com>
In-Reply-To: <20190104104749.5314-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:18:14 +0000
Message-ID: <CAFEAcA-y3X2wv=pDw4ufAFRnhdFmGRDHc8KAT9B9p1F20V1hqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/1] hw/arm: versal: Fix memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Luc Michel <luc.michel@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Fri, 4 Jan 2019 at 10:47, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> This series fixes the memory leaks in versal board creation
> reported by Peter Maydell.
>
> Best regards,
> Edgar
>
> Edgar E. Iglesias (1):
>   hw/arm: versal: Plug memory leaks
>

Applied to target-arm.next, thanks (with a Fixes: line added)

-- PMM
