Received: from eggs.gnu.org ([2001:4830:134:3::10]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e2ujg-0003ww-Db
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e2uja-0004Td-28
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:50:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:56260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e2ujZ-0004SC-SS
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 03:50:18 -0400
Received: by mail-wm0-x231.google.com with SMTP id u138so19410923wmu.4
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 00:50:16 -0700 (PDT)
References: <20170928165414.7339-1-richard.henderson@linaro.org>
	<20170928165414.7339-10-richard.henderson@linaro.org>
	<87y3otzk34.fsf@linaro.org>
	<f185d9b4-bd5d-0294-bcfa-76214caa3167@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f185d9b4-bd5d-0294-bcfa-76214caa3167@linaro.org>
Date: Fri, 13 Oct 2017 08:50:13 +0100
Message-ID: <87shena3m2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/02/2017 10:43 AM, Alex Benn=C3=A9e wrote:
>>> +    mkdir -p capstone
>>
>> Having a mkdir -p here seems a little out of place. Shouldn't the build
>> directory creation be handled by the make recipe?
>
> *shrug* We do this for the other directories at configure time.

fair enough.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>
> r~


--
Alex Benn=C3=A9e
