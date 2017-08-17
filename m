Received: from eggs.gnu.org ([2001:4830:134:3::10]:36540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRAi-0005Pl-0m
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRAd-0003mx-DD
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:39 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:34824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diRAd-0003mL-7h
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:13:35 -0400
Received: by mail-pg0-x22b.google.com with SMTP id v189so49564089pgd.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:13:35 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6bfb1943-5d9f-6940-a289-86dd354ccc29@linaro.org>
Date: Thu, 17 Aug 2017 13:13:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 5/9] arm/cpu.h: align VFP registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:04 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
