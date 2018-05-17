Received: from eggs.gnu.org ([2001:4830:134:3::10]:53712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPU4-0002If-UN
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPU1-00028m-Q7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:26:44 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPU1-00028W-JP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:26:41 -0400
Received: by mail-pl0-x241.google.com with SMTP id bi12-v6so3190059plb.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:26:41 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-31-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <016c5b98-6c8f-6cdf-3143-3b0dbab9829d@linaro.org>
Date: Thu, 17 May 2018 13:26:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 30/49] tests/tcg: enable building for
 AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 10:46 AM, Alex Bennée wrote:
> We only have compilers for the (default) little endian variants.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - update MAINTAINERS
> ---
>  MAINTAINERS                        | 1 +
>  tests/tcg/aarch64/Makefile.include | 8 ++++++++
>  2 files changed, 9 insertions(+)
>  create mode 100644 tests/tcg/aarch64/Makefile.include

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
