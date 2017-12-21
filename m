Received: from eggs.gnu.org ([2001:4830:134:3::10]:41923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0fr-0001og-Fm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS0fq-0001O6-O7
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:14:11 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS0fq-0001Nd-In
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:14:10 -0500
Received: by mail-ot0-x231.google.com with SMTP id d5so22430666oti.3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 05:14:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221013600.17648-1-eblake@redhat.com>
References: <20171221013600.17648-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 13:13:49 +0000
Message-ID: <CAFEAcA8eOXRv_7Qg_K0a4=TPUZiMCN_LoN22xujuedzr=O1a7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches through 20 Dec
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

On 21 December 2017 at 01:35, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 4da5c51cac8363f86ec92dc99c38f9382d617647:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-12-20' into staging (2017-12-20 20:38:36 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-12-20
>
> for you to fetch changes up to fab45bb24a35b4791deecf3ec732d64b0b987662:
>
>   qmp: add nbd-server-remove (2017-12-20 16:55:32 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2017-12-20
>
> - Eric Blake: 0/2 Optimize sparse reads over NBD
> - Vladimir Sementsov-Ogievskiy: 0/2 add qmp nbd-server-remove
>

Not applying, as Vladimir says his patches are not the right ones.

thanks
-- PMM
