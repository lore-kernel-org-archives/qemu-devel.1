Received: from eggs.gnu.org ([209.51.188.92]:42475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gytA0-0007KL-R6
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gytA0-0003t9-9a
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:57:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
	<87wolml3wn.fsf@zen.linaroharston>
Date: Wed, 27 Feb 2019 07:57:29 +0100
In-Reply-To: <87wolml3wn.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
	=?utf-8?Q?=C3=A9e=22's?= message of
	"Tue, 26 Feb 2019 19:56:40 +0000")
Message-ID: <87h8cpoh0m.fsf@dusky.pond.sub.org>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Alex Benn=C3=A9e posted this patch to address an XXX comment in
>> pflash_cfi01_realize() the other day:
>
> If I send you v5 will you include that in your series?

Sure!
