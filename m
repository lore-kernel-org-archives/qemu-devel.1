Received: from eggs.gnu.org ([2001:4830:134:3::10]:59864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewq8m-0006vf-LV
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewq8h-0004cM-UI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:15:28 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:41272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewq8h-0004bT-8n
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:15:23 -0400
Received: by mail-ot0-x233.google.com with SMTP id i28-v6so5797562otf.8
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:15:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313205023.711304-1-eblake@redhat.com>
References: <20180313205023.711304-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 14:15:01 +0000
Message-ID: <CAFEAcA_+Zh6Xw3DzizqaELm7+S63cHoc+gaO1CdBEkcRkX6CBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/17] NBD patches for 2018-03-13 (2.12
 softfreeze)
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

On 13 March 2018 at 20:50, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 026aaf47c02b79036feb830206cfebb2a726510d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-request' into staging (2018-03-13 16:26:44 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-03-13-v2
>
> for you to fetch changes up to 65374c1aa6263a4e2b566d15a9fd9b2105954a1b:
>
>   iotests: new test 209 for NBD BLOCK_STATUS (2018-03-13 15:44:09 -0500)
>
> In v2: fix uninitialized variable warning [patchew]
> (only mailing patches that changed since v1)
>
> ----------------------------------------------------------------
> nbd patches for 2018-03-13
>
> - Eric Blake: iotests: Fix stuck NBD process on 33
> - Vladimir Sementsov-Ogievskiy: 0/5 nbd server fixing and refactoring before BLOCK_STATUS
> - Eric Blake: nbd/server: Honor FUA request on NBD_CMD_TRIM
> - Stefan Hajnoczi: 0/2 block: fix nbd-server-stop crash after blockdev-snapshot-sync
> - Vladimir Sementsov-Ogievskiy: nbd block status base:allocation
>

Applied, thanks.

-- PMM
