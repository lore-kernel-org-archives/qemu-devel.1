Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg6EG-00055K-J9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg6EF-0005Iu-DC
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:59:56 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:34266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg6EF-0005IF-7Z
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 04:59:55 -0500
Received: by mail-ot0-x230.google.com with SMTP id x15so5995677ote.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 01:59:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126160411.4033-1-eblake@redhat.com>
References: <20180126160411.4033-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 09:59:33 +0000
Message-ID: <CAFEAcA_g67PikH1YJ7ZEdXLXHa2hLUpgEJdqh=OQKfHM50iEJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches through 26 Jan
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

On 26 January 2018 at 16:04, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit e607bbee553cfe73072870cef458cfa4e78133e2:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-26
>
> for you to fetch changes up to 9776f0db6a19a0510e89b7aae38190b4811c95ba:
>
>   nbd: implement bdrv_get_info callback (2018-01-26 09:58:46 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2018-01-26
>
> - Vladimir Sementsov-Ogievskiy - nbd export qmp interface
> - Eric Blake - hmp: Add nbd_server_remove to mirror QMP command
> - Edgar Kaziakhmedov - nbd: implement bdrv_get_info callback

Applied, thanks.

-- PMM
