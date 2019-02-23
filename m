Received: from eggs.gnu.org ([209.51.188.92]:44174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxUIx-00041f-Sx
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxUIx-0004iU-4w
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:13:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxUIw-0004g1-KH
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:13:11 -0500
Received: by mail-wr1-x441.google.com with SMTP id l5so4916184wrw.6
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 02:13:10 -0800 (PST)
References: <20190222204500.24434-1-alex.bennee@linaro.org>
	<20190222204500.24434-5-alex.bennee@linaro.org>
	<59f3947b-ce6f-c82d-9e77-3d6f1360ea3f@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <59f3947b-ce6f-c82d-9e77-3d6f1360ea3f@linaro.org>
Date: Sat, 23 Feb 2019 10:13:08 +0000
Message-ID: <87o972g6dn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/6] tests/fp: add wrapping for
 f128_to_ui32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/22/19 12:44 PM, Alex Benn=C3=A9e wrote:
>> Needed to test: softfloat: add float128_is_{normal,denormal}

Obviously I was reading the title of the other patch.. will fix.

>
> Eh?
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/fp/fp-test.c  | 3 ++-
>>  tests/fp/wrap.inc.c | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> But the rest of the patch matches $SUBJECT, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~


--
Alex Benn=C3=A9e
