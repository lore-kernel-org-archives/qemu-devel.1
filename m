Received: from eggs.gnu.org ([209.51.188.92]:38031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtWS-0006qU-7c
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:18:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjtWR-0007s9-Jd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:18:56 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:40253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjtWR-0007pu-6X
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:18:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id u18so3677045plq.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:18:54 -0800 (PST)
References: <20190116202349.29272-1-alex.bennee@linaro.org>
	<20190116202349.29272-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <35bd7df1-89de-3d38-b911-a2fae4bea116@linaro.org>
Date: Thu, 17 Jan 2019 09:18:47 +1100
MIME-Version: 1.0
In-Reply-To: <20190116202349.29272-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] tests/Makfile: add check-softfloat
 rule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com

On 1/17/19 7:23 AM, Alex Bennée wrote:
> This adds a rule to run all of our softfloat tests. It is included as
> a pre-requisite to check-tcg and check-unit as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
