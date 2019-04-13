Received: from eggs.gnu.org ([209.51.188.92]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6At-0003sM-74
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6As-00033p-FB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:42585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6As-00033M-4e
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id cv12so5859861plb.9
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:05:38 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <156d4c66-a764-3a6f-9005-335922cfc327@linaro.org>
Date: Fri, 12 Apr 2019 14:05:32 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 22/41] s390x/tcg: Implement VECTOR NOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
