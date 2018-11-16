Received: from eggs.gnu.org ([2001:4830:134:3::10]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ1Q-0007bH-Kt
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZ1O-0001Kj-MN
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:58:36 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZ1O-0001In-BE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 02:58:34 -0500
Received: by mail-wm1-x335.google.com with SMTP id q26so10143232wmf.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 23:58:29 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<a960531f6b2a08f327d3526580b24a36317b7a8c.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a644ab74-9380-7c38-707d-a43d6b359451@linaro.org>
Date: Fri, 16 Nov 2018 08:58:17 +0100
MIME-Version: 1.0
In-Reply-To: <a960531f6b2a08f327d3526580b24a36317b7a8c.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 06/23] riscv: Add the tcg target registers
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
> +
> +#define TCG_CT_CONST_ZERO  0x100
> +#define TCG_CT_CONST_S12   0x200
> +#define TCG_CT_CONST_N12   0x400

Logically this would go with patch 8.  But,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
