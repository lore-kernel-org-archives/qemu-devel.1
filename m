Received: from eggs.gnu.org ([209.51.188.92]:36387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghL6g-0006Ow-UZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghL6f-0008En-87
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:09:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghL6f-0008EL-1t
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 16:09:45 -0500
Received: by mail-pl1-x635.google.com with SMTP id p8so4152835plo.2
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 13:09:44 -0800 (PST)
References: <20190108162154.22259-1-alex.bennee@linaro.org>
	<20190108162154.22259-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11ee4fd1-391b-91da-31d8-fa929ba649f6@linaro.org>
Date: Thu, 10 Jan 2019 08:09:38 +1100
MIME-Version: 1.0
In-Reply-To: <20190108162154.22259-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 5/6] scripts/archive-source: include
 softfloat tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org

On 1/9/19 3:21 AM, Alex Bennée wrote:
> We need these if we want to run unit/softfloat tests in our docker
> containers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  scripts/archive-source.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
