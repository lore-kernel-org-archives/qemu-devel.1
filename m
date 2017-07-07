Received: from eggs.gnu.org ([2001:4830:134:3::10]:36172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbdK-0003S0-Pm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dTbdJ-0000Ym-Th
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:21:54 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dTbdJ-0000Xw-O5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:21:53 -0400
Date: Sat, 8 Jul 2017 00:21:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170707222152.smjegmxktfqkunr5@aurel32.net>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-24-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707022111.21836-24-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 23/27] target/sh4: Introduce CHECK_SH4A
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 2017-07-06 16:21, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/sh4/translate.c | 64 +++++++++++++++++++++++---------------------------
>  1 file changed, 29 insertions(+), 35 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
