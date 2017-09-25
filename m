Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcaO-0005Au-0l
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcaJ-0000Fl-Ml
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:47 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:52469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcaJ-0000FQ-HB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:14:43 -0400
Received: by mail-pg0-x232.google.com with SMTP id i195so4873766pgd.9
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:14:43 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19d5240f-5243-cd9d-8d69-cd4edb6ce259@linaro.org>
Date: Mon, 25 Sep 2017 16:14:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/27] s390x: introduce and use
 S390_MAX_CPUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> Will be handy in the next patches.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  target/s390x/cpu.h         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
