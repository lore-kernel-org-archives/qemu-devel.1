Received: from eggs.gnu.org ([2001:4830:134:3::10]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3e4-0002A9-Qb
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3du-0008QO-11
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:03:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3dt-0008Q5-Pz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:03:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id a8-v6so1753925wmf.1
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:03:17 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-23-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f74b5e1a-d135-0d1f-5c31-2cfddbcb2b3a@linaro.org>
Date: Fri, 26 Oct 2018 16:03:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-23-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 23/71] riscv: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <alistair23@gmail.com>

On 10/25/18 3:45 PM, Emilio G. Cota wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <alistair23@gmail.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
