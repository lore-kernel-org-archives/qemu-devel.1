Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5fD-0001wJ-AS
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gS5fB-0000Bg-DU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:38:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:37573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gS5f9-00005Q-EG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 14:38:19 -0500
Received: by mail-pl1-x634.google.com with SMTP id b5so17889854plr.4
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:38:14 -0800 (PST)
References: <cover.1543352682.git.alistair.francis@wdc.com>
	<6e20c8377a588dcb44a1d8ef9efc07499663f59e.1543352682.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9427a60-d06f-714a-c635-6fdb2fb48e6e@linaro.org>
Date: Wed, 28 Nov 2018 11:38:10 -0800
MIME-Version: 1.0
In-Reply-To: <6e20c8377a588dcb44a1d8ef9efc07499663f59e.1543352682.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 10/24] riscv: tcg-target: Add the
 relocation functions
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

On 11/27/18 1:08 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 51 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
