Received: from eggs.gnu.org ([2001:4830:134:3::10]:52099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esp2Q-0000hX-3v
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esp2L-0000kl-Uy
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:16:18 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:46731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esp2L-0000jy-Ov
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 07:16:13 -0500
Received: by mail-ot0-x22c.google.com with SMTP id g97so14662796otg.13
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 04:16:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302195143.31678-1-eblake@redhat.com>
References: <20180302195143.31678-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 12:15:52 +0000
Message-ID: <CAFEAcA-WgS9nLC3iEQXi3p5Lhb1EDK-UEpty0ahgiG9ooPtLQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 19:51, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-01-v4
>
> for you to fetch changes up to 418b1d0ae3a2cc992659f626a2a3f11944e0b259:
>
>   qapi: Don't create useless directory qapi-generated (2018-03-02 13:48:26 -0600)
>
> v4: another attempt at silencing OSX warnings on empty .o [Peter]
> (sending just the changed patches)
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-01
>
> - Markus Armbruster: Modularize generated QAPI code
>
> ----------------------------------------------------------------

This version works -- applied, thanks.

-- PMM
