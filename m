Received: from eggs.gnu.org ([2001:4830:134:3::10]:53518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmWc-0005YX-JI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKmWY-0008S7-M6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:47:18 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKmWY-0008RU-Fv
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 10:47:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id u9-v6so11427558wrr.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 07:47:14 -0800 (PST)
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
	<20181108120628.29926-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a34ca91e-8e79-21a1-bf11-a55f7836386f@linaro.org>
Date: Thu, 8 Nov 2018 16:47:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181108120628.29926-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/riscv: Fix FCLASS_D being
 treated as RV64 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, mjc@sifive.com, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 11/8/18 1:06 PM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/riscv/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
