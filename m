Received: from eggs.gnu.org ([2001:4830:134:3::10]:38934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMLq-0006b8-Nz
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOMLp-0005B1-Uw
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:02:10 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOMLp-0005Ah-On
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:02:09 -0400
Date: Fri, 23 Jun 2017 13:01:58 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623110158.ded6z3ssylhig6cx@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170620000405.3391-12-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-12-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 11/18] target/s390x: Mark STFLE_49
 facility as available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-06-19 17:03, Richard Henderson wrote:
> This facility bit includes execution-hint, load-and-trap,
> miscellaneous-instruction-extensions and processor-assist.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu_models.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
