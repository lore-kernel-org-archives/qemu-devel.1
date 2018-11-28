Received: from eggs.gnu.org ([2001:4830:134:3::10]:52327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6kV-00044g-01
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS6kS-0003Jw-Vw
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:47:54 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:35938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS6kP-00035x-7w
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:47:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id g9so5491234plo.3
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 12:47:48 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<445bbf96c17c4bdb0857fe03707a8911d4b5fec2.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <543821d2-ddf5-9976-a823-2fa044e42dc0@linaro.org>
Date: Wed, 28 Nov 2018 12:47:45 -0800
MIME-Version: 1.0
In-Reply-To: <445bbf96c17c4bdb0857fe03707a8911d4b5fec2.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 18/24] riscv: tcg-target: Add the prologue
 generation and register the JIT
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
>  tcg/riscv/tcg-target.inc.c | 111 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 111 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
