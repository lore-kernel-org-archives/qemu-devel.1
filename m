Received: from eggs.gnu.org ([2001:4830:134:3::10]:45366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPMP-0004JJ-Ce
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWPMM-000222-73
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:28:49 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWPMJ-0001wm-LB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:28:46 -0500
Received: by mail-ot1-x32a.google.com with SMTP id v23so11170174otk.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 09:28:41 -0800 (PST)
References: <cover.1544229872.git.alistair.francis@wdc.com>
	<d579b3cc437a3b81025d42fee40faaf3c0196470.1544229872.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8644f57-1a43-df55-7539-47029d8b076e@linaro.org>
Date: Mon, 10 Dec 2018 11:28:37 -0600
MIME-Version: 1.0
In-Reply-To: <d579b3cc437a3b81025d42fee40faaf3c0196470.1544229872.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 15/24] riscv: tcg-target: Add the add2 and
 sub2 instructions
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

On 12/7/18 6:48 PM, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  tcg/riscv/tcg-target.inc.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
