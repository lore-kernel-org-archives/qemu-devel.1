Received: from eggs.gnu.org ([2001:4830:134:3::10]:54322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddmR-0001qx-Dc
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:13:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eddmO-0001uq-90
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:13:03 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:42380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eddmO-0001uG-2L
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:13:00 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r71so4431160wmd.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:13:00 -0800 (PST)
References: <20180119045438.28582-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180119045438.28582-1-richard.henderson@linaro.org>
Date: Mon, 22 Jan 2018 15:12:57 +0000
Message-ID: <87k1waj5ae.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] target/arm: Prepatory work for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> I believe that this addresses all of the comments Peter had with
> respect to v1.  I did go ahead and add the system registers, so that
> I could figure out how they're supposed to work.
>
> This has been rebased to master so that it has no dependencies.

I've completed my review pass for this series now, looking pretty good.

--
Alex Benn=C3=A9e
