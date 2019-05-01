Received: from eggs.gnu.org ([209.51.188.92]:58852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqsi-0005aS-9M
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqsY-0007KX-OM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLqsT-00078n-U4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id p16so1510011wma.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:10:14 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-10-alex.bennee@linaro.org>
	<357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
Date: Wed, 01 May 2019 16:10:12 +0100
Message-ID: <87zho65hyj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/softmmu_template.h | 454 -----------------------------------
>>  1 file changed, 454 deletions(-)
>>  delete mode 100644 accel/tcg/softmmu_template.h
>
> Why is this separate from patch 7?

No particular reason, we can certainly merge them.

>
>
> r~


--
Alex Benn=C3=A9e
