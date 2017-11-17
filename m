Received: from eggs.gnu.org ([2001:4830:134:3::10]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFlzq-0007Ry-VR
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFlzp-0003on-Ri
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:14 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:47055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFlzp-0003nj-JY
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 14:08:13 -0500
Received: by mail-wr0-x22f.google.com with SMTP id u98so2932415wrb.13
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 11:08:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171117150556.16947-1-eblake@redhat.com>
References: <20171117150556.16947-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Nov 2017 19:07:51 +0000
Message-ID: <CAFEAcA_FJ3bb8oVn9Sgx73+20-yJx9cvnduUJ7dwrEmWRQRP0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 2.11-rc2
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

On 17 November 2017 at 15:05, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit fec035a53fa15c4c8c4e62bfef56a35df4161e38:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171117-pull-request' into staging (2017-11-17 10:18:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-17
>
> for you to fetch changes up to fed5f8f82056c9f222433c41aeb9fca50c89f297:
>
>   nbd/server: Fix error reporting for bad requests (2017-11-17 08:38:38 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2017-11-17
>
> Eric Blake - nbd: Don't crash when server reports NBD_CMD_READ failure
> Eric Blake - nbd/client: Use error_prepend() correctly
> Eric Blake - nbd/client: Don't hard-disconnect on ESHUTDOWN from server
> Eric Blake - nbd/server: Fix error reporting for bad requests
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
