Received: from eggs.gnu.org ([2001:4830:134:3::10]:51639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTcJt-0005PQ-50
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTcJs-0004QJ-8u
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:05:53 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:32972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTcJs-0004Pr-2w
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 19:05:52 -0400
Date: Sat, 8 Jul 2017 01:05:50 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707230550.pqhn42duxjudahv7@aurel32.net>
References: <20170701202600.14057-1-rth@twiddle.net>
	<20170701202600.14057-5-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170701202600.14057-5-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] target/s390x: Implement SRSTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-07-01 13:25, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/mem_helper.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   | 13 +++++++++++++
>  target/s390x/insn-data.def |  2 ++
>  4 files changed, 57 insertions(+)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
