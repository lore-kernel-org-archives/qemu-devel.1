Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lYy-00023O-EN
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e3lYt-0003pR-0j
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:14:52 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:44584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e3lYs-0003p4-Ql
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:14:46 -0400
Received: by mail-pg0-x233.google.com with SMTP id j3so4912381pga.1
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:14:46 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0362dbe5-ed7b-067b-18a7-02baab7afff5@linaro.org>
Date: Sun, 15 Oct 2017 09:14:43 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 10/30] softfloat: improve comments on
 ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> Mention the pseudo-code fragment from which this is based and correct
> the spelling of signalling.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
