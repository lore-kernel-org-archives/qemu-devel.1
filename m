Received: from eggs.gnu.org ([2001:4830:134:3::10]:52522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYrb-0001Tc-NJ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYrZ-0004NL-Tf
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNYrY-0004Ld-60
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id f10-v6so21033065wme.3
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:48:23 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<970c4b6a1b54c1976c8d36261f18678072dc1c54.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a85692c3-7572-1f00-067c-290255149b56@linaro.org>
Date: Fri, 16 Nov 2018 08:47:57 +0100
MIME-Version: 1.0
In-Reply-To: <970c4b6a1b54c1976c8d36261f18678072dc1c54.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 04/23] exec: Add RISC-V GCC poison macro
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

On 11/15/18 11:34 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  include/exec/poison.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
