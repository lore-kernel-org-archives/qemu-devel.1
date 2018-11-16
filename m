Received: from eggs.gnu.org ([2001:4830:134:3::10]:51264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZvw-0006km-Ax
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZvv-0005Pr-N1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:57:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZvv-0005PW-GY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:56:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id u13-v6so20386279wmc.4
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:56:59 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<ac51f3b3a2d91ea1b08ccd89add5282d308cfe70.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a5bf32f-8559-f470-bfda-06fc575f747d@linaro.org>
Date: Fri, 16 Nov 2018 09:56:55 +0100
MIME-Version: 1.0
In-Reply-To: <ac51f3b3a2d91ea1b08ccd89add5282d308cfe70.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 13/23] riscv: tcg-target: Add the extract
 instructions
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

On 11/15/18 11:35 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
