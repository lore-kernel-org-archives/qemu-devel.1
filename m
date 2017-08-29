Received: from eggs.gnu.org ([2001:4830:134:3::10]:35402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmhrx-0007bY-3E
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmhrt-0002kY-93
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:51:57 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmhrt-0002kK-0e
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:51:53 -0400
Received: by mail-pg0-x22e.google.com with SMTP id r133so11453031pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 07:51:52 -0700 (PDT)
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-3-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0ad72a04-83d2-8db8-2375-0380642cbd66@linaro.org>
Date: Tue, 29 Aug 2017 07:51:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170829063313.10237-3-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 PATCH 3/5] mttcg: Add tcg target default
 memory ordering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, "open list:AArch64 target" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com

On 08/28/2017 11:33 PM, Pranith Kumar wrote:
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tcg/aarch64/tcg-target.h | 2 ++
>  tcg/arm/tcg-target.h     | 2 ++
>  tcg/ia64/tcg-target.h    | 2 ++
>  tcg/mips/tcg-target.h    | 2 ++
>  tcg/ppc/tcg-target.h     | 2 ++
>  tcg/s390/tcg-target.h    | 2 ++
>  tcg/sparc/tcg-target.h   | 2 ++
>  7 files changed, 14 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
