Received: from eggs.gnu.org ([209.51.188.92]:50919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4t-0000qW-Rx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu4t-0001Bb-1z
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:35 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu4s-0001BA-Sr
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:35:34 -0400
Received: by mail-pl1-x641.google.com with SMTP id x15so8540324pln.9
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:35:34 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4fc9a25-f382-8008-5e42-09269fd39c08@linaro.org>
Date: Wed, 1 May 2019 11:35:30 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 02/15] tests/tcg/multiarch: add hello
 world system test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> This is not really i386 only, we can have the same test for all
> architectures supporting system tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/Makefile.softmmu-target       | 2 +-
>  tests/tcg/{i386 => multiarch}/system/hello.c | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tests/tcg/{i386 => multiarch}/system/hello.c (100%)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
