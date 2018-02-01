Received: from eggs.gnu.org ([2001:4830:134:3::10]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh2ib-0005EG-Bs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh2iY-00062Q-49
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:09 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eh2iX-000600-Sc
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 19:27:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id f71so2534410wmf.0
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 16:27:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180131134942.a2cupkloo4cp33bc@kamzik.brq.redhat.com>
References: <20180131032800.25578-1-famz@redhat.com>
	<20180131134942.a2cupkloo4cp33bc@kamzik.brq.redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 1 Feb 2018 08:26:33 +0800
Message-ID: <CAK1Eb9mGKb3Noorr7KfJwe9ynz_5APTKRjMyuT12hg4T6JB_MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Jan 31, 2018 at 9:49 PM, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Jan 31, 2018 at 11:28:00AM +0800, Fam Zheng wrote:
>> +On top of libqtest, a higher level library, ``libqos``, was created to
>> +encapsulate common tasks of device drivers, such as memory management and
>> +communicating with system buses or devices. Many virtual device tests use
>> +libqos instead of directly calling into libqos.
>                                            ^^ libqtest?

Yes, I've apparently made a mistake.

Fam

>
> Thanks,
> drew
