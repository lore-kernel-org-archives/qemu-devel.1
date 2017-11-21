Received: from eggs.gnu.org ([2001:4830:134:3::10]:34788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDfF-0005wQ-Nq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDfF-0001YQ-1L
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:52:57 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:34983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHDfE-0001YC-Rn
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:52:56 -0500
Received: by mail-oi0-x234.google.com with SMTP id e142so9250057oih.2
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:52:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171121184738.8502-1-quintela@redhat.com>
References: <20171121184738.8502-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:52:35 +0000
Message-ID: <CAFEAcA8nRaZRvinAqXyXVEEezynsZ+M7HEz8tS79hjA2-VMTVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 21 November 2017 at 18:47, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> THis has two fixes for migration, please apply.
>
> Later, Juan.
>
> The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:
>
>   Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20171121
>
> for you to fetch changes up to 383d8a77222c016610d626887de80e770cdd9936:
>
>   migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END (2017-11-21 19:42:26 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20171121
>
> ----------------------------------------------------------------
> Anthony PERARD (1):
>       migration, xen: Fix block image lock issue on live migration
>
> Daniel Henrique Barboza (1):
>       migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END

Missed rc2 by about half an hour :-(

thanks
-- PMM
