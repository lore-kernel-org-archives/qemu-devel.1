Received: from eggs.gnu.org ([209.51.188.92]:39701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxQc-0002TP-Oa
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxQb-0003Cy-TE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:31:10 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyxQb-000337-I8
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:31:09 -0500
Received: by mail-wm1-x341.google.com with SMTP id v26so5229019wmh.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 03:31:00 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<87wolml3wn.fsf@zen.linaroharston>
	<87h8cpoh0m.fsf@dusky.pond.sub.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87h8cpoh0m.fsf@dusky.pond.sub.org>
Date: Wed, 27 Feb 2019 11:30:58 +0000
Message-ID: <87mumhlb7x.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] pflash: Fixes and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Alex Benn=C3=A9e posted this patch to address an XXX comment in
>>> pflash_cfi01_realize() the other day:
>>
>> If I send you v5 will you include that in your series?
>
> Sure!

OK, sent:

  Subject: [PATCH v5] hw/block: better reporting on pflash backing file mis=
match
  Date: Wed, 27 Feb 2019 11:13:47 +0000
  Message-Id: <20190227111347.15063-1-alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
