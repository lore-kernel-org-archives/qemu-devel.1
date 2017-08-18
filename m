Received: from eggs.gnu.org ([2001:4830:134:3::10]:35769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYNG-0006DQ-JO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYND-0008Ef-JP
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:06 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:34496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diYND-0008DW-Dn
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:55:03 -0400
Received: by mail-pg0-x230.google.com with SMTP id u185so55571281pgb.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 20:55:03 -0700 (PDT)
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f49191c6-a58e-4ca8-4b39-7dee0407ebbc@linaro.org>
Date: Thu, 17 Aug 2017 20:54:59 -0700
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 03/10] target/s390x: move
 psw_key_valid() to mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 02:22 AM, David Hildenbrand wrote:
> Only used in that file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h        | 11 -----------
>  target/s390x/mem_helper.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
