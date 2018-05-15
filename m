Received: from eggs.gnu.org ([2001:4830:134:3::10]:42178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIflI-0006pi-5D
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fIflF-0006bh-G7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:37:28 -0400
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com
	([104.47.32.50]:15829
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fIflF-0006b4-8E
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:37:25 -0400
Date: Tue, 15 May 2018 21:37:11 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180515193711.vbevhhi726tqiu5n@toto>
References: <20180503214201.29082-1-frasse.iglesias@gmail.com>
	<20180503214201.29082-2-frasse.iglesias@gmail.com>
	<CAFEAcA-9Q6zRCsZ8UWgDXXRdQ1Pf5fj4_KjmtKPY1BJ6s9FXtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-9Q6zRCsZ8UWgDXXRdQ1Pf5fj4_KjmtKPY1BJ6s9FXtA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Alistair Francis <alistair23@gmail.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On Mon, May 14, 2018 at 04:51:32PM +0100, Peter Maydell wrote:
> On 3 May 2018 at 22:42, Francisco Iglesias <frasse.iglesias@gmail.com> wrote:
> > Add a model of the generic DMA found on Xilinx ZynqMP.
> >
> > Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> 
> Edgar, were you or somebody else from Xilinx planning to review
> this version of this patch?

Hi Peter, I've Rb:d it now.

Cheers,
Edgar
