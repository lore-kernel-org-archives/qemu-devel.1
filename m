Received: from eggs.gnu.org ([2001:4830:134:3::10]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZcq4-0008Kl-QZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZcq0-0004kb-OJ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:12 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:40315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZcq0-0004kB-HY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:24:08 -0500
Received: by mail-ot0-x22d.google.com with SMTP id d10so2058355oti.7
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 05:24:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180110225944.17920-1-eblake@redhat.com>
References: <20180110225944.17920-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:23:47 +0000
Message-ID: <CAFEAcA9yJg7eQJiFpCO2ObGjv3hLJx+34H6edcM2H9A-9nj=Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] nbd patches for 10 Jan
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

On 10 January 2018 at 22:59, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 3cee4db661ab9c0fce7937b3bbfa188a1845f31f:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-08' into staging (2018-01-09 15:22:47 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-10
>
> for you to fetch changes up to 420a4e955909788263a33d11600839e93480dfd3:
>
>   nbd: rename nbd_option and nbd_opt_reply (2018-01-10 12:11:23 -0600)
>
> Not much time elapsed since my last pull request, but my last request
> was delayed due the holiday break, and I've now got other patches that
> will be easier to post if I can do a Based-on: against this pull request,
> rather than the larger in-progress series they were extracted from.
>
> ----------------------------------------------------------------
> nbd patches for 2018-01-10
>
> - Vladimir Sementsov-Ogievskiy: nbd: rename nbd_option and nbd_opt_reply
> - Vladimir Sementsov-Ogievskiy: nbd/server: add additional assert to nbd_export_put
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
