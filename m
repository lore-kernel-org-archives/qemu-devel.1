Received: from eggs.gnu.org ([209.51.188.92]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhAR-0007dF-EU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhAP-0007vK-Hh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJhAN-0007nD-IV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id 188so154063pfd.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:24:00 -0700 (PDT)
References: <mhng-f96f6f0d-cec7-477e-96c8-af5485b43bc7@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9384b35d-41d0-65b0-17ca-7291c530d13f@linaro.org>
Date: Thu, 25 Apr 2019 09:23:56 -0700
MIME-Version: 1.0
In-Reply-To: <mhng-f96f6f0d-cec7-477e-96c8-af5485b43bc7@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/8] target/riscv: decodetree
 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
> 
> Thanks!  I'm happy taking this as it stands, since all those decode issues I
> pointed out aren't regressions in this patch set.  Let me know if you want to
> fix those or if you want me to -- as you can probably tell my email queue is a
> bit long... :)

I'm happy to fix those, if you'll point me at your branch.


r~
