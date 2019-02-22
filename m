Received: from eggs.gnu.org ([209.51.188.92]:57568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIYi-0007EM-UA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxIYi-0000B6-3f
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:40 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxIYh-00005B-Tq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 16:40:40 -0500
Received: by mail-pf1-x441.google.com with SMTP id j5so1683636pfa.2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:40:37 -0800 (PST)
References: <20190222204500.24434-1-alex.bennee@linaro.org>
	<20190222204500.24434-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8cf0e0c-30bb-f772-e930-9f41c9ad3c1c@linaro.org>
Date: Fri, 22 Feb 2019 13:40:34 -0800
MIME-Version: 1.0
In-Reply-To: <20190222204500.24434-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] tests/fp: enable f128_to_ui[32/64]
 tests in float-to-uint
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
> We've just added f128_to_ui32 and we missed out the f128_to_ui64 tests
> last time.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
