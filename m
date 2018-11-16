Received: from eggs.gnu.org ([2001:4830:134:3::10]:56828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ0e-0006vA-Ds
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ0N-0000ip-Mm
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZ0N-0000iI-FR
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:57:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id u5-v6so18556871wrn.9
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:57:31 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<0f62035eb86da24f03b9980f086d6df268105986.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d636617-9b92-e437-6648-28744adbf58d@linaro.org>
Date: Fri, 16 Nov 2018 08:57:27 +0100
MIME-Version: 1.0
In-Reply-To: <0f62035eb86da24f03b9980f086d6df268105986.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 03/23] linux-user: Add host dependency for
 RISC-V 64-bit
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
>  linux-user/host/riscv64/hostdep.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 linux-user/host/riscv64/hostdep.h


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
