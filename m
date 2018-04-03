Received: from eggs.gnu.org ([2001:4830:134:3::10]:39933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3O3y-0003zT-PR
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3O3w-0002NU-6G
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:41:34 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:52254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3O3v-0002NB-V5
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:41:32 -0400
Received: by mail-wm0-x22f.google.com with SMTP id g8so10731757wmd.2
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 08:41:31 -0700 (PDT)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180217182323.25885-1-richard.henderson@linaro.org>
Date: Tue, 03 Apr 2018 16:41:29 +0100
Message-ID: <87woxocn6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/67] target/arm: Scalable
 Vector Extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This is 99% of the instruction set.  There are a few things missing,
> notably first-fault and non-fault loads (even these are decoded, but
> simply treated as normal loads for now).

I've finished my quick pass, apart from the individual comments I think
it looks pretty good.

--
Alex Benn=C3=A9e
