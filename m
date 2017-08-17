Received: from eggs.gnu.org ([2001:4830:134:3::10]:34986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diR2i-0000zU-7u
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diR2d-00065F-4Y
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:05:24 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:36725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diR2c-00063i-Tk
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:05:19 -0400
Received: by mail-pg0-x232.google.com with SMTP id i12so49588072pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:05:17 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a15c518-1091-cac7-77b6-b833efd745c6@linaro.org>
Date: Thu, 17 Aug 2017 13:05:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] tcg/README: listify the TCG types.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:03 AM, Alex Bennée wrote:
> Although the other types are aliases lets make it clear what TCG types
> are available.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tcg/README | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
