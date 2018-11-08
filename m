Received: from eggs.gnu.org ([2001:4830:134:3::10]:59060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKo3x-0007Bh-N1
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKo3w-0006tc-Ut
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKo3w-0005pm-Nh
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:25:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id p82-v6so1684524oih.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:25:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108171716.GN12503@habkost.net>
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 17:25:13 +0000
Message-ID: <CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 8 November 2018 at 17:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Nov 08, 2018 at 03:34:22PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Reported-by: LGTM code review
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Queueing for 3.2, thanks.

Next release after 3.1 will be 4.0, by the way -- we're moving
to "bump major version every year".

thanks
-- PMM
