Received: from eggs.gnu.org ([2001:4830:134:3::10]:35568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eP4GW-00024l-KA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eP4GV-0004n8-Mw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:27:52 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:32995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eP4GV-0004ma-H6
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:27:51 -0500
Received: by mail-ot0-x244.google.com with SMTP id h9so1565923oti.0
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:27:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1513104804.git.alistair.francis@xilinx.com>
References: <cover.1513104804.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 10:27:30 +0000
Message-ID: <CAFEAcA-1q0eXT4aZCSL3J3ZFMT+8feQztK=Yr3uz2T3L-WLwrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH-2.12 v3 0/3] Update the reset values of the
 Xilinx ZynqMP QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair23@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On 12 December 2017 at 18:54, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Update the reset values of the Xilinx ZynqMP QSPI device to match the
> resister spec here:
> https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html
>
> V3:
>  - Match documented name
> V2:
>  - Don't double set registers
>
> Based-on: 20171126231634.9531-14-frasse.iglesias@gmail.com



Applied to target-arm.next, thanks.

-- PMM
