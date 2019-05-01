Received: from eggs.gnu.org ([209.51.188.92]:54567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqWq-0003bl-Ly
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqWn-0002jb-JR
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqWn-0002ig-Bi
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so8384536pgv.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:48:09 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4495b23c-99e8-d9f8-d408-fcd9aefeb458@linaro.org>
Date: Wed, 1 May 2019 07:48:05 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 13/15] Makefile: fix coverage-report
 reference to BUILD_DIR
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
> Commit 337f2311f actually claimed to do this in the commit log but
> didn't actually. Oops.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
