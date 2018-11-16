Received: from eggs.gnu.org ([2001:4830:134:3::10]:57671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhxL-0008G2-5S
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNhxG-0005xh-Ka
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:30:59 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:41050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNhxG-0005sO-BN
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 12:30:54 -0500
Received: by mail-io1-xd33.google.com with SMTP id s22so5777544ioc.8
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 09:30:53 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<b7bd19036aa7af06a54d904f5473d97bd8dcfc6e.1542321076.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <33a84c65-046f-d8ba-d177-4a2edf8ac036@linaro.org>
Date: Fri, 16 Nov 2018 18:30:45 +0100
MIME-Version: 1.0
In-Reply-To: <b7bd19036aa7af06a54d904f5473d97bd8dcfc6e.1542321076.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 23/23] configure: Add support for building
 RISC-V host
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
>  configure | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
