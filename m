Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmO3p-0004LV-W9
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmO3m-0006iJ-Rk
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:42:54 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:36579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmO3m-0006hh-MQ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:42:50 -0400
Received: by mail-io0-x234.google.com with SMTP id g33so638541ioj.3
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:42:49 -0700 (PDT)
References: <20170828035327.17146-1-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <367db2c6-86dc-288e-c020-80d99a755f51@linaro.org>
Date: Mon, 28 Aug 2017 10:42:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170828035327.17146-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/arm: Remove stale comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

On 08/27/2017 08:53 PM, Pranith Kumar wrote:
> Update the comment which is not true since MTTCG.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  target/arm/translate-a64.c | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
