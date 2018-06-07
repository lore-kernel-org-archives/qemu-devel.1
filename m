Received: from eggs.gnu.org ([2001:4830:134:3::10]:45163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fQsR3-0008Ox-WE
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1fQsR2-0008D1-S9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:30 -0400
Received: from mail-yb0-x233.google.com ([2607:f8b0:4002:c09::233]:44353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1fQsR2-0008Cl-Ll
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:46:28 -0400
Received: by mail-yb0-x233.google.com with SMTP id w74-v6so3049361ybe.11
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 03:46:28 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <20180607103628.GE19032@stefanha-x1.localdomain>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAJSP0QWELqGP56Dm5qyS7zGe_xdPwB5t6CZXkqhdmX16RKM9nw@mail.gmail.com>
	<CAG7hfcJxiPYou5dNaWcL8p9uQxHUX1Qa7PDaku_z80Qx-S=yGg@mail.gmail.com>
	<CAJSP0QW4dDpifDJgyuLKo3Ar53OGwUMP16e++HnDe69NA3-Mmw@mail.gmail.com>
	<CAG7hfcLvhTgz2497-wDD0e02U7hX4eeRPuzqwaL+ugxemPSkzg@mail.gmail.com>
	<20180607103628.GE19032@stefanha-x1.localdomain>
MIME-Version: 1.0
Date: Thu, 7 Jun 2018 06:46:26 -0400
Message-ID: <CAG7hfcLE7jJgsAmmOD0TQSN42kPg8ixJ_RQnpmZk-NNJ2MuZ_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>

On 7 June 2018 at 13:36:30, Stefan Hajnoczi (stefanha@gmail.com) wrote:

> If you do want to upstream the code you linked, please let us know
> the
> details of how you want to do it and how long it might take. Maybe
> there is a way to work together on it...

yes, I considered this, but I do not have a schedule yet, probably in Q4.

I first=C2=A0plan to upgrade from 2.8 and only later to re-evaluate the
entire project, to bring it closer to the upstream version.


the main change I envision is to untangle the Cortex-M code from the
current ARM code. maybe now the status is better, but when I did my
changes I had lots of problems.


regards,

Liviu
