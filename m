Received: from eggs.gnu.org ([209.51.188.92]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6CG-0005JF-SJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6CG-0003ob-2i
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:04 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:43620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6CF-0003kt-OP
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:07:03 -0400
Received: by mail-pg1-x535.google.com with SMTP id z9so5902310pgu.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:07:03 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-25-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73b20e0a-ffa8-552a-2345-8877fa2b9595@linaro.org>
Date: Fri, 12 Apr 2019 14:06:58 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-25-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 24/41] s390x/tcg: Implement VECTOR OR
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
> Reuse a gvec helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
