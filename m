Received: from eggs.gnu.org ([2001:4830:134:3::10]:56512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhsZ-0004QY-41
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhsV-00046v-5w
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:26:03 -0500
Received: from mail-it1-x12d.google.com ([2607:f8b0:4864:20::12d]:53704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhsT-000415-9W
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:25:58 -0500
Received: by mail-it1-x12d.google.com with SMTP id r12-v6so35849893ita.3
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:25:56 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<526c9ffdb23b75e96508703b9c9e3bc95cfac939.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e0cc83f2-c49b-9065-0261-803c700b365d@linaro.org>
Date: Fri, 16 Nov 2018 18:25:48 +0100
MIME-Version: 1.0
In-Reply-To: <526c9ffdb23b75e96508703b9c9e3bc95cfac939.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 19/23] riscv: tcg-target: Add the prologue
 generation
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
>  tcg/riscv/tcg-target.inc.c | 66 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
