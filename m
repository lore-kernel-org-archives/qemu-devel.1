Received: from eggs.gnu.org ([209.51.188.92]:40609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkybL-0002CH-DI
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkyb9-0003Y5-2W
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:56:18 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkyb8-0003W3-Hb
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 16:56:14 -0500
Received: by mail-pg1-x541.google.com with SMTP id m1so7707227pgq.8
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 13:56:13 -0800 (PST)
References: <20190118131456.32451-1-kbastian@mail.uni-paderborn.de>
	<20190118131456.32451-17-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd487251-91d5-b0d2-92ea-002421cbc4e6@linaro.org>
Date: Sun, 20 Jan 2019 08:56:05 +1100
MIME-Version: 1.0
In-Reply-To: <20190118131456.32451-17-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 16/35] target/riscv: Convert RV priv
 insns to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, sagark@eecs.berkeley.edu, palmer@sifive.com, Alistair.Francis@wdc.com
Cc: qemu-riscv@nongnu.org, peer.adelt@hni.uni-paderborn.de, qemu-devel@nongnu.org

On 1/19/19 12:14 AM, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Peer Adelt <peer.adelt@hni.uni-paderborn.de>
> ---
> v3 -> v4:
>     - current_cpu->env_ptr -> ctx-env

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
