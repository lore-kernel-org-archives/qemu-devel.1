Received: from eggs.gnu.org ([209.51.188.92]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6AW-0003Vq-Bg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6AU-0002qQ-Fg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6AU-0002pf-0C
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:05:14 -0400
Received: by mail-pg1-x541.google.com with SMTP id g8so5925796pgf.2
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:05:13 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d46a58e-ad28-68c6-9c53-e5a3c2526f8c@linaro.org>
Date: Fri, 12 Apr 2019 14:05:09 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-22-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 21/41] s390x/tcg: Implement VECTOR NAND
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
> Part of vector enhancements facility 1, but easy to implement.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate.c        | 1 +
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  3 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
