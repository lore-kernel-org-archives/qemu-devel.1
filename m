Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPb1-0000A4-FP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPay-0002qi-9E
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:43:55 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:45279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWPax-0002qH-Mz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:43:52 -0500
Received: by mail-oi1-x22e.google.com with SMTP id y1so7886003oie.12
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:43:51 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<1f6b3d26810eb969cf90f0ee978fe2817e6e6421.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <26af2253-8b22-5f91-cb89-ed132e93dea8@linaro.org>
Date: Mon, 10 Dec 2018 11:43:47 -0600
MIME-Version: 1.0
In-Reply-To: <1f6b3d26810eb969cf90f0ee978fe2817e6e6421.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 18/24] riscv: tcg-target: Add direct load
 and store instructions
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

On 12/7/18 6:49 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 158 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
