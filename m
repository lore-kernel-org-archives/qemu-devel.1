Received: from eggs.gnu.org ([2001:4830:134:3::10]:38363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZTH-00051r-Ej
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZTG-0004C6-HS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:27:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZTG-0004BB-9j
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:27:22 -0500
Received: by mail-wm1-x32d.google.com with SMTP id q26so10213534wmf.5
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:27:22 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<94fae434261439eed18b5ecffd2e8c959f80cdc0.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b6aa808-7be5-cfc7-1ed7-6f5ad1a72e42@linaro.org>
Date: Fri, 16 Nov 2018 09:27:18 +0100
MIME-Version: 1.0
In-Reply-To: <94fae434261439eed18b5ecffd2e8c959f80cdc0.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 10/23] riscv: tcg-target: Add the
 instruction emitters
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
>  tcg/riscv/tcg-target.inc.c | 40 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
