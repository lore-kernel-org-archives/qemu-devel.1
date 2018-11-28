Received: from eggs.gnu.org ([2001:4830:134:3::10]:52610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6l8-00059Q-CC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6l4-00051a-8k
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:34 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:34398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS6l3-0004y0-SD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:30 -0500
Received: by mail-pg1-x532.google.com with SMTP id 17so10030233pgg.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 12:48:29 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<7beac896a4d4ffd873c24a74f7f7be4118ba7e5d.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8d57887-7650-ac7c-e4ae-f35acf3251ea@linaro.org>
Date: Wed, 28 Nov 2018 12:48:25 -0800
MIME-Version: 1.0
In-Reply-To: <7beac896a4d4ffd873c24a74f7f7be4118ba7e5d.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 19/24] riscv: tcg-target: Add the target
 init code
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

On 11/27/18 1:09 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
