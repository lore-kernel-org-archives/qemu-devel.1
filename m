Received: from eggs.gnu.org ([2001:4830:134:3::10]:57394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhwW-0007ey-4j
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhwR-0005SH-Vx
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:30:08 -0500
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131]:38938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhwR-0005Rm-Pe
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:30:03 -0500
Received: by mail-it1-x131.google.com with SMTP id m15so35334349itl.4
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:30:03 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<84be65cc6caa8421b04ac381f4623e21f80ee39f.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0876b1fe-49bf-a9b2-e531-f7fcc11e162f@linaro.org>
Date: Fri, 16 Nov 2018 18:29:56 +0100
MIME-Version: 1.0
In-Reply-To: <84be65cc6caa8421b04ac381f4623e21f80ee39f.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 22/23] dias: Add RISC-V support
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

On 11/15/18 11:37 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  disas.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
