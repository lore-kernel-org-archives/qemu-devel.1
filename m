Received: from eggs.gnu.org ([2001:4830:134:3::10]:55341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhpZ-0002M0-MW
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhpW-0002GS-9X
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:22:57 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhpW-0002FV-1C
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:22:54 -0500
Received: by mail-oi1-x236.google.com with SMTP id t3-v6so2403866oie.7
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:22:53 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<4e25322ab80efb351d006d50672048fea2c71a03.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03f8e89c-bdc1-5194-74dd-7322b5cfbef9@linaro.org>
Date: Fri, 16 Nov 2018 18:22:46 +0100
MIME-Version: 1.0
In-Reply-To: <4e25322ab80efb351d006d50672048fea2c71a03.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 18/23] riscv: tcg-target: Add the out op
 decoder
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

On 11/15/18 11:36 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 472 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 472 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
