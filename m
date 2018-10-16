Received: from eggs.gnu.org ([2001:4830:134:3::10]:53541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTAW-00030Q-AG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCTAS-00016L-AE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:30:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCTAR-00011o-LD
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:30:04 -0400
Received: by mail-pf1-x443.google.com with SMTP id f26-v6so11786818pfn.9
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 10:30:03 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<CAFEAcA9cACQa7A8VUdfuSk-FcmFeHu+4x5m7HDE1A-+LYcwvXA@mail.gmail.com>
	<20181016124648.GN3671@okra.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2dcd14ea-7fec-c2f0-09aa-017377b578cd@linaro.org>
Date: Tue, 16 Oct 2018 10:29:59 -0700
MIME-Version: 1.0
In-Reply-To: <20181016124648.GN3671@okra.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/14] More fully implement ARM PMUv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 10/16/18 5:46 AM, Aaron Lindsay wrote:
> Is anyone willing to take a glance at the final patch in this series,
> "target/arm: Send interrupts on PMU counter overflow", before my next
> iteration? I'm particularly interested in a review of the approach I
> took for detecting overflow.

I intend to finish reviewing the patch series today.


r~
