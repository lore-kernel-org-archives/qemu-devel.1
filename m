Received: from eggs.gnu.org ([209.51.188.92]:54158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqVK-0002Vs-Sx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqVH-0001qK-Pa
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:38 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqVH-0001q2-J2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id e92so8278038plb.6
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:46:35 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
Date: Wed, 1 May 2019 07:46:31 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/15] accel/tcg: remove
 softmmu_template.h
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
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/softmmu_template.h | 454 -----------------------------------
>  1 file changed, 454 deletions(-)
>  delete mode 100644 accel/tcg/softmmu_template.h

Why is this separate from patch 7?


r~
