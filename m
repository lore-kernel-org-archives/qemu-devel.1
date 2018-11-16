Received: from eggs.gnu.org ([2001:4830:134:3::10]:56924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhuP-0005rL-W1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhuJ-0004hJ-Lk
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:27:55 -0500
Received: from mail-it1-x12a.google.com ([2607:f8b0:4864:20::12a]:37721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhuD-0004fP-BS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:27:48 -0500
Received: by mail-it1-x12a.google.com with SMTP id b5so569929iti.2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:27:43 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<9e9303670bf6210b643b05f9bddf9c52f684173b.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5e338c9-15b4-c143-453d-fb43d6686fb4@linaro.org>
Date: Fri, 16 Nov 2018 18:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <9e9303670bf6210b643b05f9bddf9c52f684173b.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 21/23] tcg: Add RISC-V cpu signal handler
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
>  accel/tcg/user-exec.c | 48 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
