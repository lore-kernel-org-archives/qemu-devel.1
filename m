Received: from eggs.gnu.org ([2001:4830:134:3::10]:37422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffR2f-0004xJ-K1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffR2e-00058J-US
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:33:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffR2e-00057f-OZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:33:28 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so2408021oiw.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180714171601.5734-1-luc.michel@greensocs.com>
References: <20180714171601.5734-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 15:33:07 +0100
Message-ID: <CAFEAcA9sZe6WM7vAKU7E1oPa_ju09sPrek35OnmW+Tz9gzx5dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/20] arm_gic: add virtualization
 extensions support
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

On 14 July 2018 at 18:15, Luc Michel <luc.michel@greensocs.com> wrote:
> v4:

I've now reviewed or commented on all the patches I think
except the xilinx board one.

You'll want to rebase on top of current master -- this version
doesn't apply (probably as a result of the for-3.0 bugfix
patches that are now in master).

thanks
-- PMM
