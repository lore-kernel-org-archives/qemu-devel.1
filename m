Received: from eggs.gnu.org ([2001:4830:134:3::10]:51942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYqJ-0000Ge-PK
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYqG-0003y9-1D
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:47:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNYqF-0003xs-PE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:47:03 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t15-v6so20260466wmt.0
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:47:03 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<765fe28a07d96b0fbd642e5d5f01c123118db4f4.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a43928a-9a6b-2e9d-5559-adf4a5cc7bf6@linaro.org>
Date: Fri, 16 Nov 2018 08:46:52 +0100
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
