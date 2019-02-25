Received: from eggs.gnu.org ([209.51.188.92]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyITX-0004uc-6N
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyITW-0003s9-IQ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:27 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyITW-0003qw-9o
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:47:26 -0500
Received: by mail-pf1-x443.google.com with SMTP id u9so4687666pfn.1
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:47:26 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cd1777c-01b3-cd50-cebb-334083553701@linaro.org>
Date: Mon, 25 Feb 2019 07:47:22 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] s390x/tcg: Simplify disassembler
 operands initialization
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

On 2/25/19 3:55 AM, David Hildenbrand wrote:
> Let's simply initialization to 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Modulo what ever fixed language you and Connie agree upon.  ;-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
