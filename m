Received: from eggs.gnu.org ([2001:4830:134:3::10]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eg2dx-0001vw-KA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eg2du-0004as-Fa
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:10:13 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eg2du-0004XS-8i
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:10:10 -0500
Received: by mail-wm0-f44.google.com with SMTP id 143so11793465wma.5
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 22:10:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129033133.31288-1-famz@redhat.com>
References: <20180129033133.31288-1-famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Mon, 29 Jan 2018 14:09:37 +0800
Message-ID: <CAK1Eb9mZvjGyj-DUb42LAL9n4usb1ie0J13-x-4eL6-aD36eHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 29, 2018 at 11:31 AM, Fam Zheng <famz@redhat.com> wrote:
> +VM testing
> +==========

I should have noted that this section is not new but an md->rst
convert of ./tests/vm/README. The latter should be made a pointer to
this one once it is merged.

Fam
