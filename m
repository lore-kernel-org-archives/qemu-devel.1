Received: from eggs.gnu.org ([2001:4830:134:3::10]:43954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9of-00074U-UW
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9oc-00031c-P1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:17:29 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:33840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dg9oc-00030j-IO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:17:26 -0400
Received: by mail-pf0-x22a.google.com with SMTP id o86so15855971pfj.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:17:26 -0700 (PDT)
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5f13dc7-52f0-38bb-c289-25c8bc95efe2@linaro.org>
Date: Fri, 11 Aug 2017 06:17:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/5] target/s390x: move a couple of
 functions to cpu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 08/11/2017 12:46 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h | 88 +++++++-----------------------------------------------
>  2 files changed, 90 insertions(+), 78 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
