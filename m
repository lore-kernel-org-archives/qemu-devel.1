Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaij-0004Vl-PJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaig-0008E1-1Q
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:46:44 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaid-0008AI-Ea
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:46:40 -0400
Received: by mail-oi1-x244.google.com with SMTP id v198-v6so1791438oif.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:46:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181102131913.1535-1-edgar.iglesias@xilinx.com>
References: <20181102131913.1535-1-edgar.iglesias@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:46:09 +0000
Message-ID: <CAFEAcA_S0VSaPz=T4bvP=gVNh4Mw_jQ92C1n4zeovkD_KMMCJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/2] arm: Add first models of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On 2 November 2018 at 13:19, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
> This patch series adds initial support for Xilinx's Versal SoC.
> Xilinx is introducing Versal, an adaptive compute acceleration platform
> (ACAP), built on 7nm FinFET process technology. Versal ACAPs combine Scalar
> Processing Engines, Adaptable Hardware Engines, and Intelligent Engines with
> leading-edge memory and interfacing technologies to deliver powerful
> heterogeneous acceleration for any application. The Versal AI Core series has
> five devices, offering 128 to 400 AI Engines. The series includes dual-core Arm
> Cortex-A72 application processors, dual-core Arm Cortex-R5 real-time
> processors, 256KB of on-chip memory with ECC, more than 1,900 DSP engines
> optimized for high-precision floating point with low latency.
>
> More info can be found here:
> https://www.xilinx.com/news/press/2018/xilinx-unveils-versal-the-first-in-a-new-category-of-platforms-delivering-rapid-innovation-with-software-programmability-and-scalable-ai-inference.html
>
>



Applied to target-arm.next, thanks.

-- PMM
