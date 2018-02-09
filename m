Received: from eggs.gnu.org ([2001:4830:134:3::10]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCvi-0001pX-34
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekCvf-0001bB-BK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:57:46 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:34868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekCvf-0001aP-5u
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:57:43 -0500
Received: by mail-pg0-x22a.google.com with SMTP id o13so4089996pgs.2
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 09:57:42 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-25-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec32c5d4-b671-76e5-2e61-a21fcffdb284@linaro.org>
Date: Fri, 9 Feb 2018 09:57:39 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 24/32] arm/translate-a64: add FP16 FRECPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> Now we have added f16 during the re-factoring we can simply call the
> helper.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate-a64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
