Received: from eggs.gnu.org ([2001:4830:134:3::10]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYrb-0001Ta-Ms
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYrY-0004MW-4w
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNYrX-0004JN-RQ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:48:24 -0500
Received: by mail-wm1-x332.google.com with SMTP id q26so10120992wmf.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:48:10 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<765fe28a07d96b0fbd642e5d5f01c123118db4f4.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5102fba-f56d-f541-b408-834317d7641d@linaro.org>
Date: Fri, 16 Nov 2018 08:47:01 +0100
MIME-Version: 1.0
In-Reply-To: <765fe28a07d96b0fbd642e5d5f01c123118db4f4.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 02/23] linux-user: Add host dependency for
 RISC-V 32-bit
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
>  linux-user/host/riscv32/hostdep.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 linux-user/host/riscv32/hostdep.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
