Received: from eggsout.gnu.org ([209.51.188.92]:57610 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gg4TV-0003Hq-4p
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 04:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gg4TU-0001x9-H9
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 04:12:05 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gg4TU-0001vc-A0
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 04:12:04 -0500
Received: by mail-pg1-x542.google.com with SMTP id w6so19375303pgl.6
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 01:12:04 -0800 (PST)
References: <cover.1546644177.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <378cfd04-a6a6-1f00-d4a8-4f12f970277e@linaro.org>
Date: Sun, 6 Jan 2019 19:11:56 +1000
MIME-Version: 1.0
In-Reply-To: <cover.1546644177.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Upstream more RISC-V fork patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>

On 1/5/19 9:23 AM, Alistair Francis wrote:
> This is one of the big patches that the RISC-V fork has that we don't.
> After this it should be straight forward to upstream the remaining
> patches.
> 
> Michael Clark (3):
>   RISC-V: Implement modular CSR helper interface
>   RISC-V: Implement atomic mip/sip CSR updates
>   RISC-V: Implement existential predicates for CSRs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
