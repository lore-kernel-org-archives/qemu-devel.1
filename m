Received: from eggs.gnu.org ([2001:4830:134:3::10]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZguJ-0008Pn-9y
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZguI-0004Z8-DQ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:49:23 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZguI-0004XU-4w
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:49:22 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so20127880otk.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20181218142851.9477-1-laurent@vivier.eu>
In-Reply-To: <20181218142851.9477-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 18:49:07 +0000
Message-ID: <CAFEAcA8tO=9xbauigHPy2Tv2JMHntHv+fF+vn+KXJN-HPaeTng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 18 Dec 2018 at 14:53, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f6c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into staging (2018-12-17 13:04:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to b2322003b6389c7c98104c8626ffa342928ba83c:
>
>   error: Remove NULL checks on error_propagate() calls (2018-12-18 14:57:48 +0100)
>
> ----------------------------------------------------------------
> Trivial patches (2018-12-18)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
