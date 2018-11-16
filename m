Received: from eggs.gnu.org ([2001:4830:134:3::10]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYq6-00007Y-2I
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNYq2-0003sU-Nn
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:46:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNYq2-0003s7-AO
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:46:50 -0500
Received: by mail-wm1-x333.google.com with SMTP id f10-v6so21029755wme.3
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:46:49 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<35d983dbea36b3d8af70cc0055fc4136b476ace5.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <940d4f6d-7485-efc3-e5ad-c880548575ca@linaro.org>
Date: Fri, 16 Nov 2018 08:46:35 +0100
MIME-Version: 1.0
In-Reply-To: <35d983dbea36b3d8af70cc0055fc4136b476ace5.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 01/23] elf.h: Add the RISCV ELF magic
 numbers
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
>  include/elf.h | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
