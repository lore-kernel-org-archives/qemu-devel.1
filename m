Received: from eggs.gnu.org ([209.51.188.92]:57382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIYL-00071j-8w
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIYK-0007qz-Gg
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:17 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxIYJ-0007n4-NQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:16 -0500
Received: by mail-pf1-x441.google.com with SMTP id u9so1684927pfn.1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:40:15 -0800 (PST)
References: <20190222204500.24434-1-alex.bennee@linaro.org>
	<20190222204500.24434-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59f3947b-ce6f-c82d-9e77-3d6f1360ea3f@linaro.org>
Date: Fri, 22 Feb 2019 13:40:11 -0800
MIME-Version: 1.0
In-Reply-To: <20190222204500.24434-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] tests/fp: add wrapping for
 f128_to_ui32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

On 2/22/19 12:44 PM, Alex Bennée wrote:
> Needed to test: softfloat: add float128_is_{normal,denormal}

Eh?

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/fp/fp-test.c  | 3 ++-
>  tests/fp/wrap.inc.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

But the rest of the patch matches $SUBJECT, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
