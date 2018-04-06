Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Rcu-0007fP-AV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f4Rcr-0003UZ-7Y
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:42:00 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:50514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f4Rcq-0003UI-T2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:41:57 -0400
References: <20180217203132.31780-1-richard.henderson@linaro.org>
	<20180217203132.31780-5-richard.henderson@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <7718f4e5-b63d-6a0b-35e6-037ca2542241@mail.uni-paderborn.de>
Date: Fri, 6 Apr 2018 15:41:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180217203132.31780-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/19] target/hppa: Convert remainder of
 system insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 02/17/2018 09:31 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c  | 92 ++++++++++++++++++++++--------------------------
>  target/hppa/insns.decode | 12 +++++++
>  2 files changed, 55 insertions(+), 49 deletions(-)
> 

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
